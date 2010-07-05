class PaypalIpn
  include DataMapper::Resource
  property :id, Serial
  property :params, Yaml, :required => true
  property :created_at, DateTime

  def initialize(params)
    self.params = params
  end
end

