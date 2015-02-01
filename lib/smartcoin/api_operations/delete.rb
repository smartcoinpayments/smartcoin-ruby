module Smartcoin
  module ApiOperations
    module Delete
      def delete
        url = "#{self.class.get_url()}/#{self.id}"
        method = :delete
        response = api_request(url,method)
        reflesh_object(response)
        response
      end
    end
  end
end