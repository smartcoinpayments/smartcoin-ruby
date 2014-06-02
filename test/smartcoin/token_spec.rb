require_relative '../rspec_helper'

describe SmartCoin::Token do

  it 'should call API to create a Token' do
    access_keys = 'pk_test_31242ce3126aaf:'
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: '111',
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