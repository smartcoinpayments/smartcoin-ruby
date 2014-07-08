require_relative '../rspec_helper'

describe SmartCoin do

  it 'should set api key' do
    SmartCoin.api_key('pk_test_1234')
    expect(SmartCoin.access_keys).to eq('pk_test_1234:')
  end

  it 'should set api secret' do
    SmartCoin.api_key('')
    SmartCoin.api_secret('sk_test_1234')
    expect(SmartCoin.access_keys).to eq(':sk_test_1234')
  end

  it 'should get empty access keys' do
    SmartCoin.api_key('')
    SmartCoin.api_secret('')
    expect(SmartCoin.access_keys).to eq(":")
  end

  describe SmartCoin::SmartCoinObject do
    it 'should convert to hash' do
      params_2 = {a: 1, b: 'b'}
      params = {a: 'a', b: 'b', c: 1, d: SmartCoin::SmartCoinObject.create_from(params_2), e:[a: 'a', b: 1, c: SmartCoin::SmartCoinObject.create_from(params_2)]}
      obj = SmartCoin::SmartCoinObject.create_from(params)
      expect(obj.to_hash).to eq(params.merge({d: params_2, e: [a: 'a', b: 1, c: params_2]}))
    end

    it 'should convert to json' do
      params_2 = {a: 1, b: 'b'}
      params = {a: 'a', b: 'b', c: 1, d: SmartCoin::SmartCoinObject.create_from(params_2), e:[a: 'a', b: 1, c: SmartCoin::SmartCoinObject.create_from(params_2)]}
      obj = SmartCoin::SmartCoinObject.create_from(params)
      expect(obj.to_json).to eq(params.to_json)
    end

    it 'should convert to stirng' do
      params_2 = {a: 1, b: 'b'}
      params = {a: 'a', b: 'b', c: 1, d: SmartCoin::SmartCoinObject.create_from(params_2), e:[a: 'a', b: 1, c: SmartCoin::SmartCoinObject.create_from(params_2)]}
      obj = SmartCoin::SmartCoinObject.create_from(params)
      expect(obj.to_s).to eq(params.to_json.to_s)
    end
  end
end