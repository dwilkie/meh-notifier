When /^an incoming text message is received(?: with: "([^\"]*)")?$/ do |request|
  request = instance_eval(request) if request
  post "/incoming_text_messages", request
end

Then /^an? (\w+) should (?:be created|exist)(?: with:? (params:? )?"([^\"]*)")?$/ do |model_name, params, fields|
  params = instance_eval(fields) if fields && params
  model_criteria = fields unless params
  model_instance = find_model!(model_name, model_criteria)
  model_instance.params.should == params if params
end

