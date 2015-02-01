module Smartcoin
  class Customer  < SmartcoinObject
    include ApiResource
    include ApiOperations::Create
    include ApiOperations::Retrieve
    include ApiOperations::Update
    include ApiOperations::Delete
    include ApiOperations::List
  end
end