module Smartcoin
  class Plan  < SmartcoinObject
    include ApiResource
    include ApiOperations::Create
    include ApiOperations::Retrieve
    include ApiOperations::Update
    include ApiOperations::Delete
    include ApiOperations::List

    def serialize_params
      [:name]
    end
  end
end