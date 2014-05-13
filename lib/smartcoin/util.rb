module SmartCoin
  class Util
    OBJECT_TYPES = {
        'card' => SmartCoin::Card,
        'charge' => SmartCoin::Charge,
        'refund' => SmartCoin::Refund,
        'fee' => SmartCoin::Fee,
        'Token' => SmartCoin::Token,
    }

    def self.get_object_type(type)
      object_type = SmartCoin::SmartCoinObject
      object_type = OBJECT_TYPES[type] if OBJECT_TYPES[type]
      object_type
    end
  end
end
