module SmartCoin
  class Charge < SmartCoinObject
    include ApiResource
    include ApiOperations::Create
  end
end