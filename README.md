Visit [Smartcoin](https://smartcoin.com.br/) to request an account.

Getting Started
===============

Sample usage:

```ruby
SmartCoin.api_key('pk_live_e73e1d46a263fe')
SmartCoin.api_secret('sk_live_6bef1b7867ecbf')

#Credit Card Charge
card_params = {number:  4242424242424242,
	              exp_month: 11,
	              exp_year: 2017,
	              cvc: '111',
	              name: 'Arthur Granado'
	            }

token = SmartCoin::Token.create(token_params)
charge_params = { amount: 100, currency: 'brl', card: token.id, }
charge = SmartCoin::Charge.create(charge_params)
puts charge.to_json

#Bank Slip Charge
charge_params = {amount: 1000, currency: 'brl', type: 'bank_slip'}
charge = SmartCoin::Charge.create(charge_params)
puts charge.to_json
```

Test
====

To run test the suite:

```
rspec ./test
```
