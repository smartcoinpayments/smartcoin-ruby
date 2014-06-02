require_relative '../rspec_helper'

describe SmartCoin::ApiResource do

  it 'call SmartCoin API' do
    url = "/v1/tokens"
    method = :post
    access_keys = 'pk_test_31242ce3126aaf:'
    params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: 111,
                    name: 'Arthur Granado'
                  }
    response = SmartCoin::Token.api_request(url, method, access_keys, params)
    expect(response['id']).to match(/tok_(.*)/)
    expect(response['object']).to eq('token')
    expect(response['card']['last4']).to eq('4242')
    expect(response['card']['exp_month']).to eq(11)
    expect(response['card']['exp_year']).to eq(2017)
    expect(response['card']['name']).to eq('Arthur Granado')
  end

  it 'should throw error' do
    url = "/v1/tokens"
    method = :post
    access_keys = 'pk_test_31242ce3126aaf:'
    params = {exp_month: 11,
              exp_year: 2017,
              cvc: 111,
              name: 'Arthur Granado'
    }

    expect{ SmartCoin::Token.api_request(url, method, access_keys, params) }.to raise_error SmartCoin::SmartCoinError

  end

  it 'should create SmartCoinError with error message and http code' do
    http_code = 400
    json_message = {error: {type: '', message: ''}}
    http_message = ''
    message = ''
    smartcoin_error = SmartCoin::SmartCoinError.new(http_code, json_message, http_message, message)
    expect(smartcoin_error.http_status).to eq(http_code)
    expect(smartcoin_error.json_message).to eq(json_message)
    expect(smartcoin_error.http_message).to eq(http_message)
    expect(smartcoin_error.message).to eq(message)
  end
end