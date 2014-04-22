module SmartCoin
  class Util
    OBJECT_TYPES = {
        'card' => SmartCoin::Card,
        'charge' => SmartCoin::Charge,
        'refund' => SmartCoin::Refund,
        'Token' => SmartCoin::Token,
    }

    def self.get_object_type(type)
      OBJECT_TYPES[type]
    end
  end
end
