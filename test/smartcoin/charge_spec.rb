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

  it 'should capture charge that has already created' do
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

  it 'should partial capture charge that has already created' do
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
    amount_captured = 300
    charge_created.capture(access_keys,amount_captured)
    expect(charge_created.captured).to be_true
    expect(charge_created.amount).to eq(charge_params[:amount])
    expect(charge_created.amount_refunded).to eq(charge_params[:amount] - amount_captured)
  end

  it 'should refund charge that has already created' do
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
        card: token.id
    }

    charge_created = SmartCoin::Charge.create(charge_params, access_keys)
    expect(charge_created.refunded).to be_false

    charge_created.refund(access_keys)
    expect(charge_created.refunded).to be_true
    expect(charge_created.amount).to eq(charge_params[:amount])
    expect(charge_created.amount_refunded).to eq(charge_params[:amount])
    expect(charge_created.refunds).to have(1).item
  end

  it 'should partial refund charge that has already created' do
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
        card: token.id
    }

    charge_created = SmartCoin::Charge.create(charge_params, access_keys)
    expect(charge_created.refunded).to be_false

    amount_refunded = 600
    charge_created.refund(access_keys, amount_refunded)
    expect(charge_created.refunded).to be_false
    expect(charge_created.amount).to eq(charge_params[:amount])
    expect(charge_created.amount_refunded).to eq(amount_refunded)
    expect(charge_created.refunds).to have(1).item
    expect(charge_created.refunds[0].amount).to eq(amount_refunded)
  end

  it 'should list charges that have already created' do
    access_keys = 'pk_test_3ac0794848c339:sk_test_8bec997b7a0ea1'

    params = {count: 3}
    charge_list = SmartCoin::Charge.list_all(access_keys, params)
    expect(charge_list.object).to eq('list')
    expect(charge_list.count).to eq(3)
    expect(charge_list.data).to have(3).items
  end
end