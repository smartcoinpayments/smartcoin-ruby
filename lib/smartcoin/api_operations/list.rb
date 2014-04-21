module SmartCoin
  module ApiOperations
    module List
      def list_all(access_keys, params)
        url = get_url
        method = :get
        response = api_request(url, method, access_keys, params)
        create_from(response)
      end

      def self.included(base)
        base.extend(List)
      end
    end
  end
end