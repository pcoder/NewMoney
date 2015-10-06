class Money
	
	# a class variable to store all available currencies
	# shared amongst all the objects
	@@currencies = {}

	# read attibute accessor for amount and currency data
	attr_reader :amount, :currency
		
	# constructor
	# initialization of amount and currency
	
	def initialize(amount, currency)
		@amount = amount
		@currency = currency
	end
	
	# Function to declare the different currencies and their rates 
	def self.conversion_rates(base_currency, other_currencies)
		bc = base_currency
		@@currencies = other_currencies
		@@currencies.merge!(bc => 1)	
	end
	
	# Function to format money
	# We need the money represented to two decimal points with the corresponding currency
	# Example 50.00 EUR
 
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
	# If it is the same, we don't need a conversion

	# Returns the converted value in the desired_currency
	# If the desired_currency does not exist; returns a String
		
	def get_converted_value(desired_currency)
		if desired_currency == @currency
			@amount	
		else
		    # compute the conversion rate
		    if @@currencies.has_key?(desired_currency)
			conversion_factor = (@@currencies[desired_currency]/@@currencies[@currency])
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

	# Function that returns the existing hash of currencies and their corresponding rates
		
	def get_currencies
		@@currencies
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
