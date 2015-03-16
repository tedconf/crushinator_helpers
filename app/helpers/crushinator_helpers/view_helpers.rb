module CrushinatorHelpers
  module ViewHelpers

    def crushinate(url, options={})
      url = asset_path(url, digest: false, protocol: :request) if url

      if url.match(/img(?:-ssl)?\.tedcdn\.com\/r\//)
        match_data = /(.+)?\/\/img(?:-ssl)?\.tedcdn\.com\/r\/([^?]+)\??(.*)/.match(url)
        options = Rack::Utils.parse_nested_query(match_data[3]).symbolize_keys.merge(options.symbolize_keys)
        url = "#{match_data[1]}//#{match_data[2]}"
      end

      if url.match(/(tedcdn|(images|storage|tedlive|tedlive-staging)\.ted|(s3|s3-us-west-2)\.amazonaws)\.com/)
        ssl_protocol_suffix = request.ssl? ? 's' : ''
        ssl_subdomain = request.ssl? ? 'img-ssl' : 'img'
        url = url.gsub(/.*\/\//, '')
        "http#{ssl_protocol_suffix}://#{ssl_subdomain}.tedcdn.com/r/#{url}?#{options.to_query}"
      else
        url
      end
    end

  end
end
