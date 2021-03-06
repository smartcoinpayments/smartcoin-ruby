module Smartcoin
  module ApiResource
    BASE_URL = 'https://api.smartcoin.com.br'
    SSL_BUNDLE_PATH = File.dirname(__FILE__) + '/../data/ssl-bundle.crt'

    def url_encode(key)
      URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def encode(params)
      params.map { |k,v| "#{k}=#{url_encode(v)}" }.join('&')
    end

    def api_request(url, method, params=nil)
      url = "#{BASE_URL}#{url}"
      if method == :get && params
        params_encoded = encode(params)
        url = "#{url}?#{params_encoded}"
        params = nil
      end

      access_keys = Smartcoin.access_keys.split(':')
      api_key = access_keys[0]
      api_secret = access_keys[1]
        begin
          response = RestClient::Request.new(
            method: method,
            url: url,
            user: api_key,
            password: api_secret,
            payload: params,
            headers: { accept: :json,
                      content_type: :json },
            verify_ssl: OpenSSL::SSL::VERIFY_PEER,
            ssl_ca_file: SSL_BUNDLE_PATH
          ).execute
        rescue RestClient::ExceptionWithResponse => e
          if rcode = e.http_code and rbody = e.http_body
            rbody = JSON.parse(rbody)
            rbody = Util.symbolize_names(rbody)

            raise SmartcoinError.new(rcode, rbody, rbody[:error], rbody[:error][:message])
          else
            raise e
          end
        rescue RestClient::Exception => e
          raise e
        end
      JSON.parse(response.to_str)
    end

    def self.included(base)
      base.extend(ApiResource)
    end
  end
end
