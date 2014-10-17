require 'rspec'

describe SmartCoin::Charge do
  before(:each) do
    SmartCoin.api_key('pk_test_3ac0794848c339')
    SmartCoin.api_secret('sk_test_8bec997b7a0ea1')
  end

  it 'should create a charge' do
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: '111',
                    name: 'Arthur Granado'
                  }
    token = SmartCoin::Token.create(token_params)
    charge_params = {
        amount: 1000,
        currency: 'brl',
        card: token.id,
    }

    charge = SmartCoin::Charge.create(charge_params)
    expect(charge.id).to match(/ch_(.*)/)
    expect(charge.amount).to eq(charge_params[:amount])
    expect(charge.paid).to be_truthy
    expect(charge.captured).to be_truthy
    expect(charge.card.id).to match(/card_(.*)/)
    expect(charge.card.type).to eq('Visa')
    expect(charge.fees.size).to be >= 2
    expect(charge.fees.first.type).to eq('Smartcoin fee: flat')
    expect(charge.fees.first.class).to eq(SmartCoin::Fee)
    expect(charge.installments.size).to be >= 1
    expect(charge.installments.first.class).to eq(SmartCoin::Installment)
  end

  it 'should create a bank_slip charge types' do
    charge_params = {amount: 1000, currency: 'brl', type: 'bank_slip'}
    charge = SmartCoin::Charge.create(charge_params)
    expect(charge.id).to match(/ch_(.*)/)
    expect(charge.amount).to eq(charge_params[:amount])
    expect(charge.paid).to be_falsey
    expect(charge.card).to be_nil
    expect(charge.bank_slip).to_not be_nil
    expect(charge.bank_slip.link).to match(/https:\/\/api\.smartcoin\.com\.br\/v1\/charges\/ch_(.*)\/bank_slip\/test/)
  end

  it 'should retrieve a charge that has already created' do
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: '111',
                    name: 'Arthur Granado'
                  }
    token = SmartCoin::Token.create(token_params)
    charge_params = {
        amount: 1000,
        currency: 'brl',
        card: token.id,
    }

    charge_created = SmartCoin::Charge.create(charge_params)
    charge_retrieved = SmartCoin::Charge.retrieve(charge_created.id)
    expect(charge_retrieved.id).to eq(charge_created.id)
    expect(charge_retrieved.amount).to eq(charge_created.amount)
    expect(charge_retrieved.card.fingerprint).to eq(charge_created.card.fingerprint)
  end

  it 'should capture charge that has already created' do
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: '111',
                    name: 'Arthur Granado'
                  }
    token = SmartCoin::Token.create(token_params)
    charge_params = {
        amount: 1000,
        currency: 'brl',
        card: token.id,
        capture: false
    }

    charge_created = SmartCoin::Charge.create(charge_params)
    expect(charge_created.captured).to be_falsey
    charge_created.capture()
    expect(charge_created.captured).to be_truthy
  end

  it 'should partial capture charge that has already created' do
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: '111',
                    name: 'Arthur Granado'
                  }
    token = SmartCoin::Token.create(token_params)
    charge_params = {
        amount: 1000,
        currency: 'brl',
        card: token.id,
        capture: false
    }

    charge_created = SmartCoin::Charge.create(charge_params)
    expect(charge_created.captured).to be_falsey
    amount_captured = 300
    charge_created.capture(amount_captured)
    expect(charge_created.captured).to be_truthy
    expect(charge_created.amount).to eq(charge_params[:amount])
    expect(charge_created.amount_refunded).to eq(charge_params[:amount] - amount_captured)
  end

  it 'should refund charge that has already created' do
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: '111',
                    name: 'Arthur Granado'
                  }
    token = SmartCoin::Token.create(token_params)
    charge_params = {
        amount: 1000,
        currency: 'brl',
        card: token.id
    }

    charge_created = SmartCoin::Charge.create(charge_params)
    expect(charge_created.refunded).to be_falsey

    charge_created.refund()
    expect(charge_created.refunded).to be_truthy
    expect(charge_created.amount).to eq(charge_params[:amount])
    expect(charge_created.amount_refunded).to eq(charge_params[:amount])
    expect(charge_created.refunds.size).to eq(1)
  end

  it 'should partial refund charge that has already created' do
    token_params = {number:  4242424242424242,
                    exp_month: 11,
                    exp_year: 2017,
                    cvc: '111',
                    name: 'Arthur Granado'
                  }
    token = SmartCoin::Token.create(token_params)
    charge_params = {
        amount: 1000,
        currency: 'brl',
        card: token.id
    }

    charge_created = SmartCoin::Charge.create(charge_params)
    expect(charge_created.refunded).to be_falsey

    amount_refunded = 600
    charge_created.refund(amount_refunded)
    expect(charge_created.refunded).to be_falsey
    expect(charge_created.amount).to eq(charge_params[:amount])
    expect(charge_created.amount_refunded).to eq(amount_refunded)
    expect(charge_created.refunds.size).to eq(1)
    expect(charge_created.refunds[0].amount).to eq(amount_refunded)
  end

  it 'should list charges that have already created' do
    params = {count: 3}
    charge_list = SmartCoin::Charge.list_all(params)
    expect(charge_list.object).to eq('list')
    expect(charge_list.count).to eq(3)
    expect(charge_list.data.size).to eq(3)
    expect(charge_list.data[0].class).to eq(SmartCoin::Charge)
  end
end
