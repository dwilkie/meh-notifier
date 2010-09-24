require 'appengine-rack'
require 'dm-core'
require 'meh_notifier'
require 'appengine-apis/labs/taskqueue'
require 'appengine-apis/urlfetch'

# Configure DataMapper to use the App Engine datastore
DataMapper.setup(:default, "appengine://auto")

run MehNotifier

