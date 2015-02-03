require_relative '../rspec_helper'

describe Smartcoin::Subscription do
  let(:plan_params) {plan_params = { id: "plan_#{SecureRandom.hex(5)}", amount: 1000, currency: 'brl', interval:'month', name: "Smartcoin Plan" }}
  let(:customer_params) { {email: "test_#{SecureRandom.hex(5)}@domain.com", card: {number:  4242424242424242, exp_month: 5, exp_year: 2017, cvc: '011', name: 'Doctor Who'} } }

  before(:each) do
    Smartcoin.api_key('pk_test_3ac0794848c339')
    Smartcoin.api_secret('sk_test_8bec997b7a0ea1')

    @plan = Smartcoin::Plan.create(plan_params)
    @customer = Smartcoin::Customer.create(customer_params)
  end

  it 'should create a Subscription' do
    customer = Smartcoin::Customer.retrieve(@customer.id)
    sub = customer.subscriptions.create({plan: @plan.id})
    expect(sub.plan.id).to eq(@plan.id)
    expect(sub.customer).to eq(@customer.id)
    expect(sub.status).to eq('active')
  end

  it 'should retrieve a subscription' do
    customer = Smartcoin::Customer.retrieve(@customer.id)
    sub = customer.subscriptions.create({plan: @plan.id})
    retrieved_sub = customer.subscriptions.retrieve(sub.id)
    expect(retrieved_sub.id).to eq(sub.id)
  end

  it 'should delete a subscription' do
    customer = Smartcoin::Customer.retrieve(@customer.id)
    sub = customer.subscriptions.create({plan: @plan.id})
    sub.delete
    expect(sub.status).to eq('canceled')
  end

  it 'should update a subscription plan'

  it 'should list customer subscriptions' do
    customer = Smartcoin::Customer.retrieve(@customer.id)
    customer.subscriptions.create({plan: @plan.id})
    list = customer.subscriptions.list_all
    expect(list.object).to eq('list')
    expect(list.data.size).to eq(1)
  end

  it 'should list all account subscriptions' do
    list = Smartcoin::Subscription.list_all
    expect(list.object).to eq('list')
    expect(list.data.size).to be >= 1
  end
end