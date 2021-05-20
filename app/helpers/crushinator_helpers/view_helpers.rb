module CrushinatorHelpers
  module ViewHelpers
    def crushinate(url, options={})

      return url if url.blank?  # give back what was given

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
          options = Rack::Utils.parse_nested_query(match_data[3]).symbolize_keys.merge(options.symbolize_keys)
          url = "#{match_data[1]}//#{match_data[2]}"
        end

        # This is for possible new hardcoded Akamai url's. To keep from double crushing
        if url.match(/pi.tedcdn.com\/r\//)
          match_data = /(.+)?\/\/pi.tedcdn.com\/r\/([^?]+)\??(.*)/.match(url)
          options = Rack::Utils.parse_nested_query(match_data[3]).symbolize_keys.merge(options.symbolize_keys)
          url = "#{match_data[1]}//#{match_data[2]}"
        end

        if is_valid_domain?(url) && is_valid_extension?(url) && valid_options?(options)
          url = url.gsub(/.*\/\//, '')
          "https://pi.tedcdn.com/r/#{url}?#{options.to_query}"
        else
          url
        end

      end
    end

    def is_valid_domain?(url)
      image_hosts = [
        "ted.com",
        "tedcdn.com",
        "tedcdnpf-a.akamaihd.net",
        "tedcdnpa-a.akamaihd.net",
        "tedcdnpe-a.akamaihd.net",
        "tedconfblog.files.wordpress.com",
        "tedideas.files.wordpress.com",
        "s3.amazonaws.com",
        "s3-us-west-2.amazonaws.com",
        "userdata.amara.org",
        "www.filepicker.io"
      ]

      image_hosts.any? { |host| url.match(host) }
    end

    def is_valid_extension?(url)
      File.extname(URI(url).path) != '.svg'
    end

    # Look up the validation rule from validations.yml
    def valid_options?(options)
      validations = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../../../config/validations.yml', __FILE__))))
      options.each do |option|
        next if validations[option[0]].blank? || validations[option[0]][:validation].blank?
        if option[1].to_s.match(validations[option[0]][:validation]).present?
          next
        else
          raise validations[option[0]][:error]
        end
      end
      true
    end
  end
end
