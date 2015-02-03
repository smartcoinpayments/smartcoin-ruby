module Smartcoin
  module ApiOperations
    module Create
      def create(params)
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
