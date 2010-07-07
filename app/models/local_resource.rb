class LocalResource
  include DataMapper::Resource
  property :id, Serial
  property :params, Yaml, :required => true
  property :created_at, DateTime

  def initialize(params)
    self.params = params
  end

  def self.resource_name
    self.to_s.underscore
  end

  def self.resources_name
    self.resource_name.pluralize
  end
end

