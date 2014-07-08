require "rest-client"

require "smartcoin/version"
require "smartcoin/smart_coin_object"
require "smartcoin/api_resource"
require "smartcoin/api_operations/create"
require "smartcoin/api_operations/retrieve"
require "smartcoin/api_operations/update"
require "smartcoin/api_operations/list"
require "smartcoin/card"
require "smartcoin/token"
require "smartcoin/refund"
require "smartcoin/fee"
require "smartcoin/installment"
require "smartcoin/charge"
require "smartcoin/util"
require "smartcoin/errors/smart_coin_error"

module SmartCoin
  @@api_key = ''
  @@api_secret = ''

  def self.api_key(api_key)
    @@api_key = api_key
  end

  def self.api_secret(api_secret)
    @@api_secret = api_secret
  end

  def self.access_keys
    "#{@@api_key}:#{@@api_secret}"
  end
end
