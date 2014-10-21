require_relative '../rspec_helper'

describe SmartCoin::Token do

  it 'should call API to create a Token' do
    SmartCoin.api_key('pk_test_3ac0794848c339')
    token_params = {number:  4242424242424242,
                    exp_month: 5,
                    exp_year: 2017,
                    cvc: '011',
                    name: 'Doctor Who'
                  }

    token = SmartCoin::Token.create(token_params)
    expect(token.id).to match(/tok_(.)/)
    expect(token.object).to eq('token')
    expect(token.card.exp_month).to eq(5)
    expect(token.card.exp_year).to eq(2017)
    expect(token.card.name).to eq('Doctor Who')
  end
end
