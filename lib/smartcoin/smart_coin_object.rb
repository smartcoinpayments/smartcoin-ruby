module SmartCoin
  class SmartCoinObject
    @values

    def metaclass
      class << self; self; end
    end

    def self.create_from(params)
      obj = self.new
      obj.reflesh_object(params)
    end

    def reflesh_object(params)
      create_fields(params)
      set_properties(params)
      self
    end

    def create_fields(params)
      instance_eval do
        metaclass.instance_eval do
          params.keys.each do |key|
            define_method(key) { @values[key] }

            define_method("#{key}=") do |value|
              @values[key] = value
            end
          end
        end
      end
    end

    def set_properties(params)
      instance_eval do
        params.each do |key, value|
          if value.class == Hash
            @values[key] = SmartCoin::Card.create_from(value)
          elsif value.class == Array
            @values[key] = value.map{ |v| SmartCoin::Refund.create_from(v) }
          else
            @values[key] = value
          end
        end
      end
    end

    def self.get_url
      "/v1/#{CGI.escape(class_name.downcase)}s"
    end

    def self.class_name
      self.name.split('::')[-1]
    end

    def initialize()
      @values = {}
    end
  end
end