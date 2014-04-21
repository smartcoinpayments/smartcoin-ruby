module SmartCoin
  class SmartCoinObject
    @values

    def metaclass
      class << self; self; end
    end

    def self.create_from_json(json)
      token = self.new
      token.create_fields(json)
      token.set_properties(json)

      token
    end

    def create_fields(json)
      instance_eval do
        metaclass.instance_eval do
          json.keys.each do |key|
            define_method(key) { @values[key] }

            define_method("#{key}=") do |value|
              @values[key] = value
            end
          end
        end
      end
    end

    def set_properties(json)
      instance_eval do
        json.each do |key, value|
          if value.class == Hash
            @values[key] = SmartCoin::Card.create_from_json(value)
          else
            @values[key] = value
          end
        end
      end
    end

    def initialize()
      @values = {}
    end
  end
end