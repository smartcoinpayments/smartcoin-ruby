require_relative '../rspec_helper'

describe Smartcoin::ApiResource do
  before(:each) do
    Smartcoin.api_key('pk_test_3ac0794848c339')
  end

  it 'call SmartCoin API' do
    url = "/v1/tokens"
    method = :post

    params = {number:  4242424242424242,
                    exp_month: 5,
                    exp_year: 2017,
                    cvc: 111,
                    name: 'Doctor Who'
                  }
    response = Smartcoin::Token.api_request(url, method, params)
    expect(response['id']).to match(/tok_(.*)/)
    expect(response['object']).to eq('token')
    expect(response['card']['last4']).to eq('4242')
    expect(response['card']['exp_month']).to eq(5)
    expect(response['card']['exp_year']).to eq(2017)
    expect(response['card']['name']).to eq('Doctor Who')
  end

  it 'should throw error' do
    url = "/v1/tokens"
    method = :post

    params = {exp_month: 5,
              exp_year: 2017,
              cvc: '021',
              name: 'Doctor Who'
    }

    expect{ Smartcoin::Token.api_request(url, method, params) }.to raise_error Smartcoin::SmartcoinError

  end

  it 'should create SmartCoinError with error message and http code' do
    http_code = 400
    json_message = {error: {type: '', message: ''}}
    http_message = ''
    message = ''
    smartcoin_error = Smartcoin::SmartcoinError.new(http_code, json_message, http_message, message)
    expect(smartcoin_error.http_status).to eq(http_code)
    expect(smartcoin_error.json_message).to eq(json_message)
    expect(smartcoin_error.http_message).to eq(http_message)
    expect(smartcoin_error.message).to eq(message)
  end
end
