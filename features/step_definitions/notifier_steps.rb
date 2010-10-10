Given /^the remote application is (up|down)$/ do |remote_app_status|
  if remote_app_status == "up"
    success_status = ["200", "OK"]
    register_remote_incoming_text_messages_uri(success_status)
    register_remote_paypal_ipns_uri(success_status)
    register_remote_text_message_delivery_receipts_uri(success_status)
  end
end

When /^an? (\w+) is received(?: with:)?$/ do |resource, request|
  resource = resource.pluralize
  method = (
    resource =~ /incoming_text_message/ ||
    resource =~ /text_message_delivery_receipt/
  ) ? :get : :post
  path = "/#{resource}"
  resource =~ /tropo_message/ ?
    path = path << ".json" :
    request = instance_eval(request) unless request.blank?
  begin
    send(method.to_s, path, request)
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

Then /^the response should be:$/ do |response|
  last_response.body.should == response.gsub("\n", "").gsub(/\s{2,}/, "")
end

