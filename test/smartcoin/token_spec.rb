require_relative '../rspec_helper'

describe SmartCoin::Token do
  it 'call SmartCoin API' do
    base_url = 'https://api.smartcoin.com.br'
    url = "#{base_url}/v1/tokens"
    method = :post
    access_keys = 'pk_test_3ac0794848c339:sk_test_8bec997b7a0ea1'
    params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: 111,
                    name: 'Arthur Granado'
                  }
    response = SmartCoin::Token.request(url, method, access_keys, params)
    expect(response['id']).to match(/tok_(.*)/)
    expect(response['object']).to eq('token')
    expect(response['card']['last4']).to eq('4242')
    expect(response['card']['exp_month']).to eq(11)
    expect(response['card']['exp_year']).to eq(2017)
    expect(response['card']['name']).to eq('Arthur Granado')
  end

  it 'should call API to create a Token' do
    access_keys = 'pk_test_3ac0794848c339:sk_test_8bec997b7a0ea1'
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: 111,
                    name: 'Arthur Granado'
                  }

    token = SmartCoin::Token.create(token_params, access_keys)
    expect(token.id).to match(/tok_(.)/)
    expect(token.object).to eq('token')
    expect(token.card.exp_month).to eq(11)
    expect(token.card.exp_year).to eq(2017)
    expect(token.card.name).to eq('Arthur Granado')
  end
end