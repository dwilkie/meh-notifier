class LocalResourceObserver
  include DataMapper::Observer
  observe LocalResource

  # After it's created
  # create it at the remote application
  after :create do
    AppEngine::Labs::TaskQueue.add(
      nil,
      :url => "/tasks/#{self.class.resources_name}/#{self.id}",
      :method => 'PUT'
    )
  end
end

