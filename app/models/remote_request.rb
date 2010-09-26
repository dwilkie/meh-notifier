class RemoteRequest
  def initialize(remote_application_uri)
    @remote_application_uri = remote_application_uri
  end

  def create(local_resource)
    uri = URI.join(
      @remote_application_uri,
      local_resource.class.resources_name
    )

    params = {local_resource.class.resource_name => local_resource.params}

    AppEngine::URLFetch.fetch(
      uri.to_s,
      :payload => Rack::Utils.build_nested_query(params),
      :method => 'POST',
      :follow_redirects => false,
      :headers => {"Content-Type" => "application/x-www-form-urlencoded"}
    )
    local_resource.destroy
  end
end

