require 'spec_helper'

describe NewMoney do
  it 'has a version number' do
    expect(NewMoney::VERSION).not_to be nil
  end
  
  it 'Has desired amount' do	
    fifty_eur = Money.new(50, 'EUR')
    expect(fifty_eur.amount).to eql(50)
  end

  it 'Has desired currency' do	
    fifty_eur = Money.new(50, 'EUR')
    expect(fifty_eur.currency).to eql("EUR")
  end

  it 'Has desired output format' do	
    fifty_eur = Money.new(50, 'EUR')
    expect(STDOUT).to receive(:puts).with('50.00 EUR')
    fifty_eur.inspect()
  end

  it 'Has correct converted currency value' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    fifty_eur = Money.new(50, 'EUR')
    fifty_eur_in_usd = fifty_eur.convert_to('USD') # => 55.50 USD
    expect("%.2f" % fifty_eur_in_usd.amount).to eql("55.50")
    expect(fifty_eur_in_usd.currency).to eql("USD")
  end

  it 'Has ability to perform operations in different currencies' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    twenty_dollars = Money.new(20, 'USD')	
    expect(twenty_dollars.amount).to eql(20)
    expect(twenty_dollars.currency).to eql("USD")
    expect(STDOUT).to receive(:puts).with('20.00 USD')
    twenty_dollars.inspect()
  end

  it 'Can do arithmetic operations in different currencies - ADD' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    twenty_dollars = Money.new(20, 'USD')	
    fifty_eur = Money.new(50, 'EUR')
    expect(STDOUT).to receive(:puts).with('68.02 EUR')
    fifty_eur + twenty_dollars 	
  end

  it 'Can do arithmetic operations in different currencies - SUBTRACT' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    twenty_dollars = Money.new(20, 'USD')	
    fifty_eur = Money.new(50, 'EUR')
    expect(STDOUT).to receive(:puts).with('31.98 EUR')
    fifty_eur - twenty_dollars
  end

  it 'Can do arithmetic operations in different currencies - MULTIPLY' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    twenty_dollars = Money.new(20, 'USD')	
    expect(STDOUT).to receive(:puts).with('60.00 USD')
    twenty_dollars * 3
  end

  it 'Can do arithmetic operations in different currencies - DIVIDE' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    fifty_eur = Money.new(50, 'EUR')
    expect(STDOUT).to receive(:puts).with('25.00 EUR')
    fifty_eur / 2 
  end

  it 'Check comparisons equality' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    twenty_dollars = Money.new(20, 'USD')
    expect(twenty_dollars == Money.new(20, 'USD')).to eql(true)
    expect(twenty_dollars == Money.new(30, 'USD')).to eql(false)
  end

  it 'Check comparisons after conversion' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    fifty_eur = Money.new(50, 'EUR')
    fifty_eur_in_usd = fifty_eur.convert_to('USD')
    expect(fifty_eur_in_usd == fifty_eur).to eql(true)
  end

  it 'Check greater than and less than relation' do	
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    fifty_eur = Money.new(50, 'EUR')
    twenty_dollars = Money.new(20, 'USD')
    expect(fifty_eur > twenty_dollars).to eql(true)
    expect(twenty_dollars > fifty_eur).to eql(false)
    expect(twenty_dollars < fifty_eur).to eql(true)
  end

  it 'Has same currency hash for all instances' do
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    @instance1 = Money.new(50, 'EUR')
    @instance2 = Money.new(50, 'USD')
    #instance1.get_currencies().should == instance2.get_currencies()
    expect(@instance1.get_currencies()).to eql(@instance2.get_currencies())
  end

  it 'Must have correct conversion rates'  do
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    @instance1 = Money.new(50, 'EUR')
    expect((@instance1.get_currencies())["USD"]).to eql 1.11	
    expect((@instance1.get_currencies())["EUR"]).to eql 1	
    expect((@instance1.get_currencies())["Bitcoin"]).to eql 0.0047 	
  end

  it 'Has correct conversion for the same desired currency as the base currency' do
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    @instance1 = Money.new(50, 'EUR')
    converted = @instance1.convert_to("EUR")	
    expect(converted.amount).to eql 50 	
  end

  it 'Must print Conversion rate not available for YEN' do
    Money.conversion_rates('EUR', { 'USD'     => 1.11, 'Bitcoin' => 0.0047})
    @instance1 = Money.new(50, 'EUR')
    expect(STDOUT).to receive(:puts).with('Conversion rate not available for YEN')
    @instance1.convert_to("YEN")	
  end

end
