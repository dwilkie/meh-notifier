class TropoIncomingTextMessage < IncomingTextMessage

  def initialize(options)
    session_object = options[:session_object].to_hash.stringify
    tropo_params = options[:request_params][:tropo]
    session_object.merge!(tropo_params) if tropo_params
    self.params = session_object
  end

  def self.resource_name
    self.superclass.to_s.underscore
  end

end

