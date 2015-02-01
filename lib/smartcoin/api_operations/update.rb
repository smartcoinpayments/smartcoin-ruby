module Smartcoin
  module ApiOperations
    module Update
      def save
        params_to_update = {}
        self.serialize_params.each do |key|
          params_to_update[key] = @values[key.to_s] if @values
        end

        update(self.id, nil, params_to_update)
      end

      def update(smartcoin_object_id, url_sufix, params=nil)
        url = "#{self.class.get_url()}/#{smartcoin_object_id}#{url_sufix}"
        method = :post
        response = api_request(url,method,params)
        reflesh_object(response)
      end
     end
  end
end
