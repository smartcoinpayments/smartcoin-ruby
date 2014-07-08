module SmartCoin
  module ApiOperations
    module Retrieve
      def retrieve(charge_id)
        url = get_url
        method = :get
        response = api_request("#{url}/#{charge_id}",method)
        create_from(response)
      end

      def self.included(base)
        base.extend(Retrieve)
      end
    end
  end
end