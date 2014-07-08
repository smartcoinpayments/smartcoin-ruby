module SmartCoin
  module ApiOperations
    module Create
      def create(params)
        url = get_url
        method = :post
        response = api_request(url,method,params)
        create_from(response)
      end

      def self.included(base)
        base.extend(Create)
      end
    end
  end
end
