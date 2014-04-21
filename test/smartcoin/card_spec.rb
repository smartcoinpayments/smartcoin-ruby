require_relative '../rspec_helper'

describe SmartCoin::Card do

  it 'should create a card object from hash' do
    card_json = {
      id: "card_23437598768758814",
      object: "card",
      last4: "4242",
      type: "Visa",
      exp_month: 11,
      exp_year: 2017,
      fingerprint: "8535531490d032bf2268c1b4e708655c0287e07017ea19ae79e704c831b27fa6",
      country: "BR",
      name: "Arthur Granado",
      address_line1: nil,
      address_line2: nil,
      address_city: nil,
      address_state: nil,
      address_cep: nil,
      address_country: nil
    }
    
    card = SmartCoin::Card.create_from(card_json)
    expect(card.id).to eq(card_json[:id])
    expect(card.object).to eq(card_json[:object])
    expect(card.last4).to eq(card_json[:last4])
    expect(card.exp_month).to eq(card_json[:exp_month])
    expect(card.exp_year).to eq(card_json[:exp_year])
    expect(card.fingerprint).to eq(card_json[:fingerprint])
    expect(card.name).to eq(card_json[:name])
  end
end