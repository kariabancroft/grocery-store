require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = @products.values.inject(0, :+)
      tax = subtotal * 0.075

      return (subtotal + tax).round(2)
    end

    def add_product(product_name, product_price)
      if @product[product_name] == nil
        @product[product_name] = product_price
        return true
      else
        return false
      end
    end

    def self.string_to_products(csv_input)
      products = {}
      product_pairs = csv_input.split(";")

      product_pairs.each do |pair|
        key, value = pair.split(":")
        # Take each individual string and make it into a hash
        products[key] = value
      end

      return products
    end

    def self.all
      orders = []

      CSV.read("support/orders.csv", "r").each do |line|
          products = self.string_to_products(line[1])

          new_order = Order.new(line[0].to_i, products)
          orders << new_order
        end

      return orders
    end

    def self.find(id)
      order = self.all.select { |order| order.id == id }.first
      if order == nil
        raise ArgumentError.new
      else
        return order
      end
    end
  end
end
