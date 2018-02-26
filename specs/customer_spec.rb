require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      cust = Grocery::Customer.new(123, "a@a.co", "123 Main", "City", "WA", "98101")

      cust.must_respond_to :id
      cust.id.must_equal 123
      cust.id.must_be_kind_of Integer

      cust.must_respond_to :email
      cust.must_respond_to :address
      cust.must_respond_to :city
      cust.must_respond_to :state
      cust.must_respond_to :zip
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      customers = Grocery::Customer.all
      customers.must_be_kind_of Array
      customers.length.must_equal 35
    end

    it "Returns accurate information about the first customer" do
      first = Grocery::Customer.all.first

      first.id.must_be_kind_of Integer
      first.id.must_equal 1
    end

    it "Returns accurate information about the last customer" do
      last = Grocery::Customer.all.last

      last.id.must_be_kind_of Integer
      last.id.must_equal 35
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      first = Grocery::Customer.find(1)

      first.must_be_kind_of Grocery::Customer
      first.id.must_equal 1
    end

    it "Can find the last customer from the CSV" do
      last = Grocery::Customer.find(35)

      last.must_be_kind_of Grocery::Customer
      last.id.must_equal 35
    end

    it "Raises an error for a customer that doesn't exist" do
      proc{ Grocery::Customer.find(53145) }.must_raise ArgumentError
    end
  end
end
