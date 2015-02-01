require_relative '../rspec_helper'

describe Smartcoin::Customer do
  before(:each) do
    Smartcoin.api_key('pk_test_3ac0794848c339')
    Smartcoin.api_secret('sk_test_8bec997b7a0ea1')
  end

  it 'should create a customer' do
    customer_params = {email: "test_#{SecureRandom.hex(5)}@domain.com"}
    customer = Smartcoin::Customer.create(customer_params)
    expect(customer.email).to eq(customer_params[:email])
    expect(customer.default_card).to be_nil
  end

  it 'should retrieve a customer by id' do
    customer_params = {email: "test_#{SecureRandom.hex(5)}"}
    customer = Smartcoin::Customer.create(customer_params)
    retrieved_customer = Smartcoin::Customer.retrieve(customer.id)
    expect(retrieved_customer.email).to eq(customer_params[:email])
    expect(retrieved_customer.to_s).to eq(customer.to_s)
  end

  it 'should retrieve a customer by email' do
    customer_params = {email: "test_#{SecureRandom.hex(5)}@domain.com"}
    customer = Smartcoin::Customer.create(customer_params)
    retrieved_customer = Smartcoin::Customer.retrieve(customer.email)
    expect(retrieved_customer.email).to eq(customer_params[:email])
    expect(retrieved_customer.to_s).to eq(customer.to_s)
  end

  it 'should update a customer' do
    token_params = {number:  4242424242424242,
                        exp_month: 5,
                        exp_year: 2017,
                        cvc: '011',
                        name: 'Doctor Who'
                      }
    token = Smartcoin::Token.create(token_params)

    customer_params = {email: "test_#{SecureRandom.hex(5)}@domain.com"}
    customer = Smartcoin::Customer.create(customer_params)
    customer.card = token.id
    customer.save()
    expect(customer.default_card).to eq(token.card.id)
    expect(customer.cards.data.size).to eq(1)
  end

  it 'should list existing customers' do
    skip('That API was not implemnted yet')
    customer_list = Smartcoin::Customer.list_all
    expect(customer_list.object).to eq('list')
    expect(customer_list.data.size).to be >= 1
  end

  it 'should delete a customer' do
    customer_params = {email: "test_#{SecureRandom.hex(5)}@domain.com"}
    customer = Smartcoin::Customer.create(customer_params)
    deleted_customer = customer.delete
    expect(deleted_customer['id']).to eq(customer.id)
    expect(deleted_customer['deleted']).to be_truthy
  end
end