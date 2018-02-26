require 'csv'

module Grocery
  class Customer
    attr_reader :id, :email, :address, :city, :state, :zip

    def initialize(id, email, address, city, state, zip)
      @id = id
      @email = email
      @address = address
      @city = city
      @state = state
      @zip = zip
    end

    def self.all
      customers = []

      CSV.read("support/customers.csv").each do |line|
        customers << Customer.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5])
      end

      return customers
    end

    def self.find(id)
      customer = self.all.select{|customer| customer.id == id}.first

      if customer == nil
        raise ArgumentError.new
      else
        return customer
      end
    end
  end
end
