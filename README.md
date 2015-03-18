[![Build Status](https://travis-ci.org/smartcoinpayments/smartcoin-ruby.svg?branch=master)](https://travis-ci.org/smartcoinpayments/smartcoin-ruby) [![Dependency Status](https://gemnasium.com/smartcoinpayments/smartcoin-ruby.svg)](https://gemnasium.com/smartcoinpayments/smartcoin-ruby)

Visite [Smartcoin](https://smartcoin.com.br/) para cadastrar uma conta.

#Vamos fazer
===============

Exemplos de uso:

```ruby
Smartcoin.api_key('pk_test_407d1f51a61756') #Troque as chaves do demo para as suas de test ou live
Smartcoin.api_secret('sk_test_86e4486a0078b2') #Troque as chaves do demo para as suas de test ou live

#Create Charge with card information
begin
	charge = Smartcoin::Charge.create({
		amount: 100,
		currency: 'brl',
		card: {
			number:  4242424242424242,
	    exp_month: 11,
	    exp_year: 2017,
	    cvc: '041'
	  }
	})
puts charge.to_json
rescue Smartcoin::SmartcoinError => e
	puts e.json_message
end

#Create Charge with token as card param
begin
	charge = Smartcoin::Charge.create({
		amount: 100,
		currency: 'brl',
		card: 'tok_123344555666'
	})
	puts charge.to_json
rescue Smartcoin::SmartcoinError => e
	puts e.json_message
end

#Create Bank Slip Charge
begin
	charge = Smartcoin::Charge.create({
		amount: 1000, 
		currency: 'brl', 
		type: 'bank_slip'
	})
	puts charge.to_json
rescue Smartcoin::SmartcoinError => e
	puts e.json_message
end

#Create Subscription
begin
	card = {number:  4242424242424242, exp_month: 5, exp_year: 2017, cvc: '011', name: 'Doctor Who'}
	customer = Smartcoin::Customer.create({
		email: 'test@example.com',
		card: card
	})

	sub = customer.subscriptions.create(plan: 'silver')

	puts sub.to_json
rescue Smartcoin::SmartcoinError => e
	puts e.json_message
end
```

Veja os [testes](https://github.com/smartcoinpayments/smartcoin-ruby/blob/master/test/smartcoin/charge_spec.rb) para mais opções.


#Teste
====

Para executar a suite de teste:

```
rspec ./test
```
