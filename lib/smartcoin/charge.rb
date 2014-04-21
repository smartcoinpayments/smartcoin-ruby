module SmartCoin
  class Charge < SmartCoinObject
    include ApiResource
    include ApiOperations::Create
    include ApiOperations::Retrieve
    include ApiOperations::Update

    def capture(access_keys)
      url_sufix = '/capture'
      update(self.id,access_keys, url_sufix)
    end
  end
end