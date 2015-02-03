module Smartcoin
  class Subscription < SmartcoinObject
    include ApiResource
    include ApiOperations::Create
    include ApiOperations::Retrieve
    include ApiOperations::Delete
    include ApiOperations::List

    def class_name
      Smartcoin::Subscription.class_name
    end

    def create_from(params)
      Smartcoin::Subscription.create_from(params)
    end

    def url
      "#{Smartcoin::Customer.url}/#{CGI.escape(self.customer)}/#{CGI.escape(class_name.downcase)}s"
    end

    def self.list_all
      method = :get
      response = api_request(url, method)
      create_from(response)
    end

    def delete
      method = :delete
      response = api_request("#{url}/#{self.id}",method)
      reflesh_object(response)
      response
    end
  end
end