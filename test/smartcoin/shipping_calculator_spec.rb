require 'rspec'

describe Smartcoin::Shipping do

  it 'should calculate a shipping cost (destination_cep 36.600-000)' do
    weight = 0.2 # Kg
    origin_cep = 22280100 #RJ - Rio de Janeiro - Botafogo
    destination_cep = 36600000 #MG - Bicas
    expect_shipping_cost = 1650 #the current value that correios charge for PAC service without deal

    shipping_info = Smartcoin::Shipping.calculator(weight: weight, origin_cep: origin_cep, destination_cep: destination_cep)
    expect(shipping_info[:amount]).to eq(expect_shipping_cost)
  end

  it 'should calculate a shipping cost with different destination_cep (24.230-153)' do
    weight = 0.2 # Kg
    origin_cep = 22280100 #RJ - Rio de Janeiro - Botafogo
    destination_cep = 24230153 #RJ - Niterói - Icaraí
    expect_shipping_cost = 1370 #the current value that correios charge for PAC service without deal

    shipping_info = Smartcoin::Shipping.calculator(weight: weight, origin_cep: origin_cep, destination_cep: destination_cep)
    expect(shipping_info[:amount]).to eq(expect_shipping_cost)
  end
end