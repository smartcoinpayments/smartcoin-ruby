[![Build Status](https://travis-ci.org/smartcoinpayments/smartcoin-ruby.svg?branch=master)](https://travis-ci.org/smartcoinpayments/smartcoin-ruby) [![Dependency Status](https://gemnasium.com/smartcoinpayments/smartcoin-ruby.svg)](https://gemnasium.com/smartcoinpayments/smartcoin-ruby)

Visite <a href="https://smartcoin.com.br/" target="_blank">Smartcoin</a> para cadastrar uma conta.

#Vamos fazer
===============

Exemplos de uso:

```ruby
SmartCoin.api_key('pk_test_407d1f51a61756') #Troque as chaves do demo para as suas de test ou live
SmartCoin.api_secret('sk_test_86e4486a0078b2') #Troque as chaves do demo para as suas de test ou live

charge_params = { amount: 100, currency: 'brl', card: token.id, }
charge = SmartCoin::Charge.create({
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

#Bank Slip Charge
charge = SmartCoin::Charge.create({
	amount: 1000, 
	currency: 'brl', 
	type: 'bank_slip'
})
puts charge.to_json
```

Veja os <a href="https://github.com/smartcoinpayments/smartcoin-ruby/blob/master/test/smartcoin/charge_spec.rb" target="_blank">testes</a> para mais opções.

#Teste
====

Para executar a suite de teste:

```
rspec ./test
```
