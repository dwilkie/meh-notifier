class TropoMessage < IncomingTextMessage

  def initialize(raw_json)
    self.params = Tropo::Generator.parse(raw_json).to_hash.stringify
  end

  def self.resource_name
    self.superclass.to_s.underscore
  end

end

