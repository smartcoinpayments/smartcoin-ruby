module SmartCoin
  class Charge < SmartCoinObject
    include ApiResource
    include ApiOperations::Create
    include ApiOperations::Retrieve
    include ApiOperations::Update
    include ApiOperations::List

    def capture(access_keys, amount=nil)
      url_sufix = '/capture'
      params = {amount: amount} if amount
      update(self.id,access_keys, url_sufix, params)
    end

    def refund(access_keys, amount=nil)
      url_sufix = '/refund'
      params = {amount: amount} if amount
      update(self.id,access_keys, url_sufix, params)
    end
  end
end