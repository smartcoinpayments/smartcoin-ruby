module Smartcoin
  module ApiOperations
    module Retrieve
      def retrieve(obj_id)
        obj_id = "?email=#{obj_id}" if obj_id.include? '@'
        method = :get
        response = api_request("#{url}/#{obj_id}",method)
        create_from(response)
      end

      def self.included(base)
        base.extend(Retrieve)
      end
    end
  end
end