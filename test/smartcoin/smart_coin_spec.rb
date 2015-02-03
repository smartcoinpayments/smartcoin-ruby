require_relative '../rspec_helper'

describe Smartcoin do

  it 'should set api key' do
    Smartcoin.api_key('pk_test_1234')
    Smartcoin.api_secret('')
    expect(Smartcoin.access_keys).to eq('pk_test_1234:')
  end

  it 'should set api secret' do
    Smartcoin.api_key('')
    Smartcoin.api_secret('sk_test_1234')
    expect(Smartcoin.access_keys).to eq(':sk_test_1234')
  end

  it 'should get empty access keys' do
    Smartcoin.api_key('')
    Smartcoin.api_secret('')
    expect(Smartcoin.access_keys).to eq(":")
  end

  describe Smartcoin::SmartcoinObject do
    it 'should convert to hash' do
      params_2 = {a: 1, b: 'b'}
      params = {a: 'a', b: 'b', c: 1, d: Smartcoin::SmartcoinObject.create_from(params_2), e:[a: 'a', b: 1, c: Smartcoin::SmartcoinObject.create_from(params_2)]}
      obj = Smartcoin::SmartcoinObject.create_from(params)
      expect(obj.to_hash).to eq(params.merge({d: params_2, e: [a: 'a', b: 1, c: params_2]}))
    end

    it 'should convert to json' do
      params_2 = {a: 1, b: 'b'}
      params = {a: 'a', b: 'b', c: 1, d: Smartcoin::SmartcoinObject.create_from(params_2), e:[a: 'a', b: 1, c: Smartcoin::SmartcoinObject.create_from(params_2)]}
      obj = Smartcoin::SmartcoinObject.create_from(params)
      expect(obj.to_json).to eq(params.to_json)
    end

    it 'should convert to stirng' do
      params_2 = {a: 1, b: 'b'}
      params = {a: 'a', b: 'b', c: 1, d: Smartcoin::SmartcoinObject.create_from(params_2), e:[a: 'a', b: 1, c: Smartcoin::SmartcoinObject.create_from(params_2)]}
      obj = Smartcoin::SmartcoinObject.create_from(params)
      expect(obj.to_s).to eq(params.to_json.to_s)
    end
  end
end