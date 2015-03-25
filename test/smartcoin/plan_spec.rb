require_relative '../rspec_helper'

describe Smartcoin::Plan do
  before(:each) do
    Smartcoin.api_key('pk_test_407d1f51a61756')
    Smartcoin.api_secret('sk_test_86e4486a0078b2')
  end

  let(:plan_params) {plan_params = { id: "plan_#{SecureRandom.hex(5)}", amount: 1000, currency: 'brl', interval:'month', name: "Smartcoin Plan" }}

  it 'should create a plan' do
    plan = Smartcoin::Plan.create(plan_params)
    expect(plan.id).to eq(plan_params[:id])
    expect(plan.amount).to eq(plan_params[:amount])
    expect(plan.currency).to eq(plan_params[:currency])
    expect(plan.interval).to eq(plan_params[:interval])
    expect(plan.name).to eq(plan_params[:name])
  end

  it 'should retrieve an existing plan' do
    Smartcoin::Plan.create(plan_params)
    plan = Smartcoin::Plan.retrieve(plan_params[:id])
    expect(plan.id).to eq(plan_params[:id])
    expect(plan.amount).to eq(plan_params[:amount])
    expect(plan.currency).to eq(plan_params[:currency])
    expect(plan.interval).to eq(plan_params[:interval])
    expect(plan.name).to eq(plan_params[:name])
  end

  it 'should update a existing plan' do
    Smartcoin::Plan.create(plan_params)
    expect(Smartcoin::Plan.new.serialize_params).to eq([:name])

    plan = Smartcoin::Plan.retrieve(plan_params[:id])
    plan.name = "New Smartcoin plan name"
    plan.save
    plan_updated = Smartcoin::Plan.retrieve(plan_params[:id])
    expect(plan.name).to eq(plan_updated.name)
    expect(plan.name).to eq("New Smartcoin plan name")
    expect(plan_updated.name).to eq("New Smartcoin plan name")
  end

  it 'should list existing plans' do
    plan_list = Smartcoin::Plan.list_all
    expect(plan_list.object).to eq('list')
    expect(plan_list.data.size).to be >= 1
  end

  it 'should delete existing plan' do
    plan = Smartcoin::Plan.create(plan_params)
    deleted_plan = plan.delete
    expect(deleted_plan['id']).to eq(plan.id)
    expect(deleted_plan['deleted']).to be_truthy
  end
end