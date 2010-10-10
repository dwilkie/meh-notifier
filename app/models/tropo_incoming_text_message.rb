class TropoIncomingTextMessage < IncomingTextMessage

  def initialize(tropo_params)
    self.params = tropo_params.to_hash.stringify
  end

  def self.resource_name
    self.superclass.to_s.underscore
  end

end

