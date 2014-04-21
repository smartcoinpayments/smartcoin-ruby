module SmartCoin
  module ApiResource
    BASE_URL = 'https://api.smartcoin.com.br'

    def api_request(url, method, access_keys, params)
      url = "#{BASE_URL}#{url}"
      access_keys = access_keys.split(':')
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
                      content_type: :json }
          ).execute
        rescue => e
          e.response
        end
      JSON.parse(response.to_str)
    end

    def self.included(base)
      base.extend(ApiResource)
    end
  end
end
