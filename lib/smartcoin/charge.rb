module Smartcoin
  class Charge < SmartcoinObject
    include ApiResource
    include ApiOperations::Create
    include ApiOperations::Retrieve
    include ApiOperations::Update
    include ApiOperations::List

    def capture(amount=nil)
      params = {amount: amount} if amount
      update(params, '/capture')
    end

    def refund(amount=nil)
      params = {amount: amount} if amount
      update(params, '/refund')
    end
  end
end