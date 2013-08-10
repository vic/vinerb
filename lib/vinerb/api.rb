require 'multi_json'
require 'rest-client'

class Vinerb::API

  VINE_SESSION_ID = 'vine-session-id'

  include Vinerb::Endpoints

  attr_accessor :key
  attr_accessor :user_id

  def api_call(request_type, url, params, clazz)
    json = MultiJson.decode rest_call(request_type, url, params)
    raise Vinerb::Error.new(json['error'], json['code']) unless json['error'].empty?
    return json['data'] if clazz.nil?
    Vinerb::Model.build clazz, json['data'], self
  end

  def rest_call(request_type, url, params)
    request_type = request_type.to_s.downcase

    headers = HEADERS.dup
    headers[VINE_SESSION_ID] = key if key

    if %w[get head delete].include?(request_type)
      body = { :params => params }
    else
      body = params
    end

   

    RestClient.send(request_type, url, body.merge(headers)) { |response|
      if [200, 400, 404].include? response.code
        response.body
      else
        raise Vinerb::Error.new(response.code, response.body)
      end
    }
  end

end

