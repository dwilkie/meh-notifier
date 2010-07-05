Given /^the remote application is( up| down)$/ do |remote_app_status|
  if remote_app_status =~ /up/
    register_remote_incoming_text_messages_uri(["200", "OK"])
  else
    register_remote_incoming_text_messages_uri(["500", "Internal Error"])
  end
end

When /^an incoming text message is received(?: with: "([^\"]*)")?$/ do |request|
  request = instance_eval(request) if request
  get "/incoming_text_messages", request
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

Then /^a POST request should (not )?have been made to the remote application(?: containing: "([^\"]*)")?$/ do |no_request, params|
  no_request ||= ""
  no_request = "_not" unless no_request.blank?
  request_key = "POST #{incoming_text_messages_uri}"
  AppEngine::URLFetch.requests.send("should#{no_request}", include(request_key))
  AppEngine::URLFetch.requests[request_key][:payload].should include(
    instance_eval(params).to_query) if no_request.blank?
end

