require 'rspec'

describe SmartCoin::SmartCoinObject do

  it 'should create token object from hash' do
    token_json = {id: "tok_23437598768758857",
     livemode: false,
     created: 1397755086,
     used: false,
     object: "token",
     type: "card",
     card:
      {id: "card_23437598768758814",
       object: "card",
       last4: "4242",
       type: "Visa",
       exp_month: 11,
       exp_year: 2017,
       fingerprint:
        "8535531490d032bf2268c1b4e708655c0287e07017ea19ae79e704c831b27fa6",
       country: "BR",
       name: "Arthur Granado",
       address_line1: nil,
       address_line2: nil,
       address_city: nil,
       address_state: nil,
       address_cep: nil,
       address_country: nil}
    }

    token = SmartCoin::SmartCoinObject.create_from_json(token_json)
    expect(token.id).to eq(token_json[:id])
    expect(token.object).to eq(token_json[:object])
    expect(token.card.id).to eq(token_json[:card][:id])
    expect(token.card.object).to eq(token_json[:card][:object])
    expect(token.card.fingerprint).to eq(token_json[:card][:fingerprint])
  end
end