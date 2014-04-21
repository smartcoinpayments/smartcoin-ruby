module SmartCoin
  class Token < SmartCoinObject
    include ApiResource

    include ApiOperations::Create
  end
end