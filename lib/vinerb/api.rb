require 'multi_json'
require 'rest-client'

module Vinerb::API

  include Vinerb::Endpoints

  def api_call(request_type, url, params, clazz)
    json = MultiJson.decode rest_call(request_type, url, params)
    raise Vinerb::Error.new(json['error'], json['code']) unless json['error'].empty?
    json
  end

  def rest_call(request_type, url, params)
    request_type = request_type.to_s.downcase
    if %w[get head delete].include?(request_type)
      body = { :params => params }
    else
      body = params
    end

    RestClient.send(request_type, url, body.merge(HEADERS)) { |response|
      if [200, 400].include? response.code
        response.body
      else
        raise Vinerb::Error.new(response.code, response.body)
      end
    }
  end

end
