module CrushinatorHelpers
  module ViewHelpers

    def crushinate(url, options={})
      # Smooth over superfluous slashes in a URL
      url = url.gsub(/([^:])\/\/+/) do
        "#{$1}/"
      end

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

      if is_valid_domain?(url) && valid_options?(options)
        url = url.gsub(/.*\/\//, '')
        "https://tedcdnpi-a.akamaihd.net/r/#{url}?#{options.to_query}"
      else
        url
      end
    end

    def is_valid_domain?(url)
      image_hosts = [
        '.ted.com', 
        '.assets.tedcdn.com',
        '.pb-assets.tedcdn.com',
        '.assets2.tedcdn.com',
        '.tedcdnpf-a.akamaihd.net',
        '.tedcdnpa-a.akamaihd.net',
        '.tedcdnpe-a.akamaihd.net',
        '.s3.amazonaws.com',
        '.s3-us-west-2.amazonaws.com',
        '.www.filepicker.io'
      ]
      image_hosts.each do |h|
        return true if url.match(h)
      end
      return false
    end

    # Look up the validation rule from validations.yml 
    def valid_options?(options)
      true if Rails.env.production?
      validations = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../../../config/validations.yml', __FILE__))))
      options.each do |option|
        next if validations[option[0]].blank?
        if option[1].to_s.match(validations[option[0]][:validate]).present?
          next
        else
          raise validations[option[0]][:error]
        end
      end
      true
    end
  end
end
