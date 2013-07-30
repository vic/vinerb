require "bundler/gem_tasks"

endpoints = file(File.expand_path('../lib/vinerb/endpoints.json', __FILE__))

endpoints_rb = file(File.expand_path('../lib/vinerb/endpoints.rb', __FILE__) => endpoints) do 

  require 'multi_json'
  json = File.read(endpoints.to_s)
  json = MultiJson.decode json

  code = ["\n"]

  json['endpoints'].each_pair do |method_name, meta|
    params    = meta['url_params'] + meta['required_params'] + [" optionals = {} "]

    optionals = meta['optional_params'].map { |o| "#{o} = optionals[#{o.inspect}] || optionals[:#{o}]" }
    defaults  = (meta['default_params'] || {}).map do |name, value|
      "#{name} = #{value.inspect} if #{name}.nil?"
    end

    req_params = (meta['optional_params'] + meta['required_params']).map { |p|
      " #{p.inspect} => #{p} "
    }.join(', ')

    code << <<-CODE

      def #{method_name}(#{params.join(', ')})
        #{optionals.join('; ')}
        #{defaults.join("; ")}
        url = (API_URL + #{meta['endpoint'].inspect}) % [#{meta['url_params'].join(', ')}]
        params = { #{req_params} }.reject { |k, v| v.nil? }
        api_call #{meta['request_type'].inspect}, url, params, #{meta['model'].inspect}
      end

    CODE
  end

  code = <<-CODE
  module Vinerb::Endpoints

    API_URL = #{json['api_url'].inspect}
    MEDIA_URL = #{json['media_url'].inspect}
    HEADERS = #{json['headers'].inspect}

    #{code.join}
  end
  CODE

  File.open(endpoints_rb.to_s, 'wb') { |f| f.print code }
end


desc 'Generate vine endpoints for ruby'
task :endpoints => endpoints_rb

