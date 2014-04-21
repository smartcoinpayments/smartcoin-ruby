require_relative '../rspec_helper'

describe SmartCoin::ApiResource do

  it 'call SmartCoin API' do
    url = "/v1/tokens"
    method = :post
    access_keys = 'pk_test_3ac0794848c339:'
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
end