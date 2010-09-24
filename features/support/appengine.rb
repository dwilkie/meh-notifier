require 'rack/test'
module AppEngine
  class URLFetch
    def self.fetch(url, options={})
      options[:method] ||= 'GET'
      uri = URI.parse(url)

      http_server =  Net::HTTP.new(uri.host, uri.port)
      http_server.use_ssl = (uri.port == 443)

      case options[:method]

      when 'HEAD'
        http_server.start do |http|
          http.head(uri.request_uri)
        end

      when 'POST'
        http_server.start do |http|
          http.post(uri.request_uri, options[:payload], options[:headers])
        end

      when 'PUT'
        http_server.start do |http|
          http.put(uri.request_uri, options[:payload], options[:headers])
        end
      end
    end
  end

  class Users
    def self.create_logout_url(url)
      '/logout'
    end
  end

  module Labs
    class TaskQueue
      def self.add(payload, options)
        task = Task.new
        options[:method] ||= 'POST'
        payload ||= options[:params]

        case options[:method]

        when 'POST'
          task.post options[:url], payload

        when 'PUT'
          task.put options[:url], payload
        end

        env = task.last_request.env
        error = env["sinatra.error"].to_s
        unless error.blank?
          error << " in " << env["PATH_INFO"]
          raise Exception, error
        end
      end
    end
    class Task
      include Rack::Test::Methods
      def app
        MehNotifier
      end
    end
  end
end

