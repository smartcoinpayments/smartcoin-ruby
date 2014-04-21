require 'rspec'

describe SmartCoin::Charge do

  it 'should create a charge' do
    access_keys = 'pk_test_3ac0794848c339:sk_test_8bec997b7a0ea1'
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: 111,
                    name: 'Arthur Granado'
                  }
    token = SmartCoin::Token.create(token_params, access_keys)
    charge_params = {
        amount: 1000,
        currency: 'brl',
        card: token.id,
    }

    charge = SmartCoin::Charge.create(charge_params, access_keys)
    expect(charge.id).to match(/ch_(.*)/)
    expect(charge.amount).to eq(charge_params[:amount])
    expect(charge.paid).to be_true
    expect(charge.captured).to be_true
    expect(charge.card.id).to match(/card_(.*)/)
    expect(charge.card.type).to eq('Visa')
  end
end