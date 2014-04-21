module SmartCoin
  module ApiOperations
    module Create
      def create(params, access_keys)
        url = get_url
        method = :post
        response = api_request(url,method,access_keys,params)
        create_from_json(response)
      end

      def self.included(base)
        base.extend(Create)
      end
    end
  end
end
