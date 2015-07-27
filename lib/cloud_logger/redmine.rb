module CloudLogger
  require 'excon'
  require 'json'

  class Redmine
    attr_accessor :body, :headers, :url
    Excon.defaults[:ssl_verify_peer] = false
    Excon.defaults[:ssl_version] = :SSLv23

    def initialize(url:)
      @url = url
      @headers = {'Content-Type' => 'application/json'}
      @body = nil
    end

    def log_hours(body:nil, custom_headers:{})
      self.headers = custom_headers
      self.body = body
      Excon.post(@url, headers: self.headers, body: self.body.to_json)
    end

    def headers=(custom_headers={})
      @headers.merge!(custom_headers.to_hash)
    end
  end
end
