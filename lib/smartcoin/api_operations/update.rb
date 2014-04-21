module SmartCoin
  module ApiOperations
    module Update
      def update(smartcoin_object_id, access_keys, url_sufix, params=nil)
        url = "#{self.class.get_url()}/#{smartcoin_object_id}#{url_sufix}"
        method = :post
        response = api_request(url,method,access_keys,params)
        reflesh_object(response)
      end
     end
  end
end
