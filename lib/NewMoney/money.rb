class Money
	@@base_currency = ""
	@@other_currencies = {}

	attr_reader :amount, :currency
		
	# constructor
	# initialization of amount and currency
	
	def initialize(amount, currency)
		@amount = amount
		@currency = currency
	end
	
	# Function to declare the different rates for currencies
	def self.conversion_rates(base_currency, other_currencies)
		@@base_currency = base_currency
		@@other_currencies = other_currencies
		@@other_currencies.merge!(@@base_currency => 1)	
	end
	
	# Function to format money
	def format(value, currency)
		sprintf('%.2f', value) + " " + currency 
	end

	# Custom inspect function as required for
        # fifty_eur.inspect  # => "50.00 EUR"

	def inspect
		puts self.format(@amount, @currency) 
	end
	
	# Function to convert to different currencies
	# Basic idea is if the desired currency is different from the base 
	# currency then find the conversion factor and multiply it with the 
	# amount 
	
	def get_converted_value(desired_currency)
		if desired_currency == @currency
			@amount	
		else
		    # compute the conversion rate
		    if @@other_currencies.has_key?(desired_currency)
			conversion_factor = (@@other_currencies[desired_currency]/@@other_currencies[@currency])
			conversion_factor * @amount
		    else
			"Conversion rate not available for " + desired_currency
		    end
		end	

	end
	
	# Function that prints the converted amount with currency
	
	def convert_to(desired_currency)
		value =  self.get_converted_value(desired_currency)
		if value.is_a? String
			puts value 
		else
			result = self.format(value, desired_currency)
			Money.new(value, desired_currency)
		end
	end
	
	def get_currencies
		@@other_currencies
	end
	
	# Arithmetic operators overloading
        # Addition
	
	def +(value)
		if value.amount != nil  and value.currency != nil
			added_value = @amount + value.get_converted_value(@currency)
			puts self.format(added_value, @currency) 
		else
			puts "Inappropriate input"
		end
	end

        # Subtraction 
	
	def -(value)
		if value.amount != nil  and value.currency != nil
			subtracted_value = @amount - value.get_converted_value(@currency)
			puts self.format(subtracted_value, @currency) 
		else
			puts "Inappropriate input"
		end
	end

        # Multiplication 
	
	def *(value)
		if value.is_a? Numeric
			product = @amount * value 
			puts self.format(product, @currency) 
		else
			puts "Inappropriate input"
		end
	end

        # Division 
	
	def /(value)
		if value.is_a? Numeric
			dividend = @amount / value 
			puts self.format(dividend, @currency) 
		else
			puts "Inappropriate input"
		end
	end

	# Comparison operator
	def ==(value)
		if value.amount != nil  and value.currency != nil
			if @amount == value.get_converted_value(@currency)
				true
			else
				false
			end
		else
			puts "Inappropriate input"
		end
	end
	
	# Greater than operator
	def >(value)
		if value.amount != nil  and value.currency != nil
			if @amount > value.get_converted_value(@currency)
				true
			else
				false
			end
		else
			puts "Inappropriate input"
		end
	end

	# Less than operator
	def <(value)
		if value.amount != nil  and value.currency != nil
			if @amount < value.get_converted_value(@currency)
				true
			else
				false
			end
		else
			puts "Inappropriate input"
		end
	end
end
