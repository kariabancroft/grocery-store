require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/order'
require_relative '../lib/online_order'
require_relative '../lib/customer'

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      online_order = Grocery::OnlineOrder.new(1, {}, 15677)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      cust = Grocery::Customer.new(11, "q@q.co", "street", "city", "state", "zip")
      online_order = Grocery::OnlineOrder.new(1, {}, cust)
      online_order.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.new(1, {}, 15677, :paid)
      online_order.must_respond_to :status
      online_order.status.must_equal :paid
    end

    it "Can set the default online order status" do
      online_order = Grocery::OnlineOrder.new(1, {}, 15677)
      online_order.must_respond_to :status
      online_order.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      cost = 5.5
      online_order = Grocery::OnlineOrder.new(1, {"ham": cost}, 15677)
      expected_total = cost + (cost * 0.075).round(2) + 10
      online_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = Grocery::OnlineOrder.new(1, {}, 15677)
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      online_order = Grocery::OnlineOrder.new(1, {}, 15677, :shipped)
      proc{ online_order.add_product({"ham": 5.5})}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      online_order = Grocery::OnlineOrder.new(1, {}, 15677, :paid)
      online_order.add_product("ham", 5.5).must_equal true
      online_order.products.length.must_equal 1
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      orders = Grocery::OnlineOrder.all
      orders.must_be_kind_of Array
      orders.length.must_equal 100
    end

    it "Returns accurate information about the first online order" do
      first = Grocery::OnlineOrder.all.first
      first.must_be_kind_of Grocery::OnlineOrder
      first.id.must_equal 1
    end

    it "Returns accurate information about the last online order" do
      last = Grocery::OnlineOrder.all.last
      last.must_be_kind_of Grocery::OnlineOrder
      last.id.must_equal 100
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      order = Grocery::OnlineOrder.find(1)
      order.must_be_kind_of Grocery::OnlineOrder
    end

    it "Raises an error for an online order that doesn't exist" do
      proc { Grocery::OnlineOrder.find(9182) }.must_raise ArgumentError
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      orders_by_cust = Grocery::OnlineOrder.find_by_customer(25)
      orders_by_cust.must_be_kind_of Array
      orders_by_cust.length.must_equal 6
    end

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      orders_by_cust = Grocery::OnlineOrder.find_by_customer(255555)
      orders_by_cust.must_be_kind_of Array
      orders_by_cust.length.must_equal 0
    end
  end
end
