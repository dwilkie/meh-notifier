require 'appengine-rack'
require 'dm-core'
require 'meh_notifier'
require 'appengine-apis/labs/taskqueue'
require 'appengine-apis/urlfetch'

AppEngine::Rack.configure_app(
  :application => 'meh-notifier',
  :version => '0-0-1'
)

# Configure DataMapper to use the App Engine datastore
DataMapper.setup(:default, "appengine://auto")

# Exclude test files
AppEngine::Rack.app.resource_files.exclude %w(/features/** /spec/** /live_tests/**)

if(methods.member?("to_xml"))
  map '/tasks' do
    use AppEngine::Rack::AdminRequired
  end

  map '/cron' do
    use AppEngine::Rack::AdminRequired
  end
end

run MehNotifier

