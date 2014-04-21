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

  it 'should retrieve a charge that has already created' do
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

    charge_created = SmartCoin::Charge.create(charge_params, access_keys)
    charge_retrieved = SmartCoin::Charge.retrieve(charge_created.id, access_keys)
    expect(charge_retrieved.id).to eq(charge_created.id)
    expect(charge_retrieved.amount).to eq(charge_created.amount)
    expect(charge_retrieved.card.fingerprint).to eq(charge_created.card.fingerprint)
  end

  it 'should create a charge without capture' do
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
        capture: false
    }

    charge_created = SmartCoin::Charge.create(charge_params, access_keys)
    expect(charge_created.captured).to be_false
    charge_created.capture(access_keys)
    expect(charge_created.captured).to be_true
  end
end