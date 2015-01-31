module Smartcoin
  class Shipping
    BASE_SHIPPING_URL = 'https://shipping.smartcoin.com.br'
    SSL_BUNDLE_PATH = File.dirname(__FILE__) + '/../data/shipping-ssl-bundle.crt'

    def self.calculator(params)
      method = :get
      url = BASE_SHIPPING_URL + '/shipping_calculator/'

      begin
        response = RestClient::Request.new(
          method: method,
          url: url,
          payload: params,
          headers: { accept: :json,
                    content_type: :json },
          verify_ssl: OpenSSL::SSL::VERIFY_PEER,
          ssl_ca_file: SSL_BUNDLE_PATH
        ).execute
      rescue RestClient::ExceptionWithResponse => e
        if rcode = e.http_code and rbody = e.http_body
          rbody = JSON.parse(rbody)
          rbody = Util.symbolize_names(rbody)

          raise SmartcoinError.new(rcode, rbody, rbody[:error], rbody[:error][:message])
        else
          raise e
        end
      rescue RestClient::Exception => e
        raise e
      end
      JSON.parse(response.to_str).inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end
  end
end