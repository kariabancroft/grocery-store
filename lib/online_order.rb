module Grocery
  class OnlineOrder < Order
    attr_reader :customer, :status

    def initialize(id, products, customer, status = :pending)
      super(id, products)
      @customer = customer
      @status = status
    end

    def total
      total = super

      (total == 0 ? 0 : total + 10)
    end

    def add_product(product_name, product_price)
      if status == :pending || status == :paid
        super(product_name, product_price)
      else
        raise ArgumentError.new
      end
    end

    def self.all
      orders = []
      CSV.read("support/online_orders.csv").each do |line|
        # find the customer
        cust = Customer.find(line[2].to_i)

        # create & add the order
        orders << self.new(line[0].to_i, self.string_to_products(line[1]), line[2].to_i, line[3].to_sym )
      end
      return orders
    end

    def self.find_by_customer(customer_id)
      self.all.select{ |order| order.customer == customer_id }
    end
  end
end
