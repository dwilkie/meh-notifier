Given /^the remote application is (up|down)$/ do |remote_app_status|
  if remote_app_status == "up"
    success_status = ["200", "OK"]
    register_remote_incoming_text_messages_uri(success_status)
    register_remote_paypal_ipns_uri(success_status)
    register_remote_text_message_delivery_receipts_uri(success_status)
  end
end

When /^an? (\w+) is received(?: with:)?$/ do |resource, request|
  request = instance_eval(request) if request
  resource = resource.pluralize
  begin
    if resource =~ /incoming_text_message/
      get "/#{resource}", request
    elsif resource =~ /text_message_delivery_receipt/
      get "/#{resource}", request
    elsif resource =~ /paypal_ipn/
      post "/#{resource}", request
    end
  rescue
  end
end

Then /^an? (\w+) should (not )?(?:be created|exist)$/ do |name, expectation|
  expectation ? find_model(name).should(be_nil) : find_model!(name)
end

Then /^a POST request should have been made to the remote application(?: to create a new (\w+) containing:)?$/ do |resource, params|
  last_request = FakeWeb.last_request
  remote_uri = send("#{resource.pluralize}_uri")
  last_request.path.should == URI.parse(remote_uri).path
  last_request.body.should == Rack::Utils.build_nested_query(
    instance_eval(params)
  ) if FakeWeb.registered_uri?(:post, remote_uri)
end

