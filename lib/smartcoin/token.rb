module Smartcoin
  class Token < SmartcoinObject
    include ApiResource

    include ApiOperations::Create
  end
end