module CrushinatorHelpers
  module ViewHelpers

    def crushinate(url, options={})
      # Smooth over superfluous slashes in a URL
      url = url.gsub(/([^:])\/\/+/) do
        "#{$1}/"
      end

      #blacklist hack.
      if !url.match(/geo-assets\.tedcdn/)

        url = asset_path(url, digest: false, protocol: :request) if url

        # This is for old possibly hardcoded Level3 urls. To keep from double crushing.
        if url.match(/img(?:-ssl)?\.tedcdn\.com\/r\//)
          match_data = /(.+)?\/\/img(?:-ssl)?\.tedcdn\.com\/r\/([^?]+)\??(.*)/.match(url)
          options = Rack::Utils.parse_nested_query(match_data[3]).symbolize_keys.merge(options.symbolize_keys)
          url = "#{match_data[1]}//#{match_data[2]}"
        end

        # This is for possible new hardcoded Akamai url's. To keep from double crushing
        if url.match(/tedcdnpi-a.akamaihd.net\/r\//)
          match_data = /(.+)?\/\/tedcdnpi-a.akamaihd.net\/r\/([^?]+)\??(.*)/.match(url)
<<<<<<< Updated upstream
=======
          options = Rack::Utils.parse_nested_query(match_data[3]).symbolize_keys.merge(options.symbolize_keys)
          url = "#{match_data[1]}//#{match_data[2]}"
        end

        # This is for possible new hardcoded Edgecast url's. To keep from double crushing
        if url.match(/pi.tedcdn.com\/r\//)
          match_data = /(.+)?\/\/pi.tedcdn.com\/r\/([^?]+)\??(.*)/.match(url)
>>>>>>> Stashed changes
          options = Rack::Utils.parse_nested_query(match_data[3]).symbolize_keys.merge(options.symbolize_keys)
          url = "#{match_data[1]}//#{match_data[2]}"
        end

        if url.match(/(filepicker|tedcdn|(images|storage|tedlive|tedlive-staging|ted2017|ted2017-staging|tedwomen2016|tedwomen2016-staging|tedcdnp(e|f)-a)\.ted|(s3|s3-us-west-2)\.amazonaws|\.akamaihd)\.(io|com|net)/)
          url = url.gsub(/.*\/\//, '')
          "https://tedcdnpi-a.akamaihd.net/r/#{url}?#{options.to_query}"
        else
          url
        end
      else 
        url
      end

    end
  end
end
