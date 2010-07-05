Given /^the remote application is( up| down)$/ do |remote_app_status|
  if remote_app_status =~ /up/
    success_status = ["200", "OK"]
    register_remote_incoming_text_messages_uri(success_status)
    register_remote_paypal_ipns_uri(success_status)
  else
    internal_error_status = ["500", "Internal Error"]
    register_remote_incoming_text_messages_uri(internal_error_status)
    register_remote_paypal_ipns_uri(internal_error_status)
  end
end

When /^an? (\w+) is received(?: with: "([^\"]*)")?$/ do |resource, request|
  request = instance_eval(request) if request
  resource = resource.pluralize
  if resource =~ /incoming_text_message/
    get "/#{resource}", request
  elsif resource =~ /paypal_ipn/
    post "/#{resource}", request
  end
end

Then /^an? (\w+) should (not )?(?:be created|exist)(?: with:? (params:? )?"([^\"]*)")?$/ do |model_name, no_model, params, fields|
  no_model ||= ""
  no_model = "_not" unless no_model.blank?
  params = instance_eval(fields) if fields && params
  model_criteria = fields unless params
  if no_model.blank?
    model_instance = find_model!(model_name, model_criteria)
    model_instance.params.should == params if params
  else
    find_model(model_name, model_criteria).should be_nil
  end
end

Then /^a POST request should have been made to the remote application(?: to create a new (.+) containing: "([^\"]*)")?$/ do |resource, params|
  if resource =~ /incoming text message/
    request_key = "POST #{incoming_text_messages_uri}"
  elsif resource =~ /paypal ipn/
    request_key = "POST #{paypal_ipns_uri}"
  end
  AppEngine::URLFetch.requests.should include(request_key)
  AppEngine::URLFetch.requests[request_key][:payload].should include(
    instance_eval(params).to_query)
end

