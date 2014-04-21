module SmartCoin
  class Token < SmartCoinObject
    def self.create(params, access_keys)
      base_url = 'https://api.smartcoin.com.br'
      url = "#{base_url}/v1/tokens"
      method = :post
      response = request(url,method,access_keys,params)
      create_from_json(response)
    end

    def self.request(url, method, access_keys, params)
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
  end
end