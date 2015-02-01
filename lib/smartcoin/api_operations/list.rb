module Smartcoin
  module ApiOperations
    module List
      def list_all(params=nil)
        url = get_url
        method = :get
        response = api_request(url, method, params)
        create_from(response)
      end

      def self.included(base)
        base.extend(List)
      end
    end
  end
end