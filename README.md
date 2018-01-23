# Grocery Store

Let's simulate a grocery store system! We want to be able to keep track of the orders that folks make, both online and physically in our grocery store.

This project will allow you to explore object-oriented design as well as a few other new topics. This is an individual, [stage 1](https://github.com/Ada-Developers-Academy/pedagogy/blob/master/rule-of-three.md) project.

## Learning Goals
You should demonstrate an ability to:
- Practice Test-Driven-Development
- Use instance variables and methods
- Reading from a CSV file
- Write DRY code by reusing methods
- Use inheritance effectively

## Baseline Setup

1. Fork the project master.
1. Clone the forked repo: `$ git clone [YOUR FORKED REPO URL]`
1. `cd` into the dir created `$ cd grocery-store`
1. Run `git remote -v` to verify the folder you are in corresponds to the fork you have created.  
  If it is **correct** it will include your username
  If it is **incorrect** it will include "AdaGold" or "Ada-C8" 
1. Run `gem install minitest-skip` to install an extra gem for testing (more on what this actually does later).

### Testing

This is our first project with real tests! Following the instructions from the [TDD lecture](https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/00-programming-fundamentals/intro-to-automated-tests.md), there are three things in our project directory:

```
Rakefile
lib/
specs/
```

Each class you write (there will only be one until wave 3) should get its own file, `lib/class_name.rb`. The specs for that class will be in `specs/class_name_spec.rb`, and you can run all specs using the `rake` command from your terminal.


## Wave 1

### Learning Goals
- Create a **class** inside of a **module**
- Create **methods** inside the **class** to perform actions
- Learn how Ruby does error handling
- Verify code correctness by **testing**

### Testing
For Wave 1, all tests have been provided for you. For each piece of functionality that you build, you should run the tests from the command line using the `rake` command. To focus on only one test at a time, change all `it` methods to `xit` except for the **one test** you'd like to run. All tests provided should be passing at the end of your work on Wave 1.

### Requirements

Create a `Grocery` module which will contain an `Order` class and any future grocery store logic.

Create an `Order` class which should have the following functionality:
- A new order should be created with:
  - an ID, read-only
  - a collection of products and their cost
    - zero products is permitted
    - you can assume that there is **only one** of each product
- A `total` method which will calculate the total cost of the order by:
  - summing up the products
  - adding a 7.5% tax
  - ensure the result is rounded to two decimal places
- An `add_product` method which will take in two parameters, product name and price, and add the data to the product collection
  - It should return `true` if the item was successfully added and `false` if it was not


### Optional:
Make sure to write tests for any optionals you implement!

- Add a `remove_product` method to the `Order` class which will take in one parameter, a product name, and remove the product from the collection
    - It should return `true` if the item was successfully remove and `false` if it was not

## Wave 2

### Learning Goals
- Create and use class methods
- Use a CSV file for loading data
- Create your own tests to verify method correctness.

### Testing
You enter Wave 2 with all tests from Wave 1 passing. In Wave 2, you will fill in the test stubs that have already been provided for you in the `order_spec.rb` file and add the code which will get these tests to pass. You should run the tests regularly alongside the code you are writing in the `Order` class itself.

### Requirements
- Update the `Order` class to be able to handle all of the fields from the CSV file used as input
  - To try it out, manually choose the data from the first line of the CSV file and ensure you can create a new instance of your `Order` using that data
- Add the following **class** methods to your existing `Order` class
  - `self.all` - returns a collection of `Order` instances, representing all of the Orders described in the CSV. See below for the CSV file specifications
    - Determine if the data structure you used in Wave 1 will still work for these new requirements
    - Note that to parse the product string from the CSV file you will need to use the `split` method
  - `self.find(id)` - returns an instance of `Order` where the value of the id field in the CSV matches the passed parameter.


#### Error Handling
- What should your program do if `Order.find` is called with an ID that doesn't exist?

#### CSV Data File

The data, in order in the CSV, consists of:  

| Field    | Type     | Description
|----------|----------|------------
| ID       | Integer  | A unique identifier for that Order
| Products  | String  | The list of products in the following format: `name:price;nextname:nextprice`


## Wave 3
### Learning Goals
- Use inheritance to share some behavior across classes
- Enhance functionality built in Wave 1
- Add tests for all new classes and inherited functionality

### Testing
You enter Wave 3 with all of your `Order` tests passing from Waves 1 & 2. In Wave 3 you will take the test stubs that are already written for you and fill in the test code that will get the tests to pass. You will continue running these test alongside the code you write to ensure you are going in the right direction.

### Requirements

For wave 3, you will create two new classes: `Customer` and `OnlineOrder`.

 The `OnlineOrder` class will inherit behavior from the `Order` class and include additional data to track the customer and order status. An **instance** of the `Customer` class will be used _within_ each **instance** of the `OnlineOrder` class.

Each class should get its own file under the `lib/` directory, and each already has a spec file with stub tests.

#### Customer
Create a `Customer` class within the `Grocery` module.

Each new Customer should include the following attributes:
- ID
- email address
- delivery address information

- The Customer should also have the following **class** methods:
  - `self.all` - returns a collection of `Customer` instances, representing all of the Customer described in the CSV. See below for the CSV file specifications
  - `self.find(id)` - returns an instance of `Customer` where the value of the id field in the CSV matches the passed parameter.


#### CSV Data File
The data for the customer CSV file consists of:

| Field          | Type    | Description
|----------------|---------|------------
| Customer ID | Integer | A unique identifier corresponding to the Customer
| Email   | String | The customer's e-mail address
| Address 1 | String | The customer's street address
| City |  String | The customer's city
| State | String | The customer's state
| Zip Code | String | The customer's zip code


#### OnlineOrder
Create an `OnlineOrder` class which will inherit behavior from the `Order` class.

Each new OnlineOrder should include all attributes from the `Order` class as well as the following **additional** attributes:
- A customer object
- A fulfillment status (stored as a **Symbol**)
  - pending, paid, processing, shipped or complete
  - If no status is provided, it should set to pending as the default

The OnlineOrder should include the following updated functionality:
- The `total` method should be the same, except it will add a $10 shipping fee
- The `add_product` method should be updated to permit a new product to be added **ONLY** if the status is either pending or paid (no other statuses permitted)
  - Otherwise, it should raise an `ArgumentError` (Google this!)

The OnlineOrder should also have the following **class** methods:
  - `self.all` - returns a collection of `OnlineOrder` instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
    - **Question** Ask yourself, what is different about this `all` method versus the `Order.all` method? What is the same?
  - `self.find(id)` - returns an instance of `OnlineOrder` where the value of the id field in the CSV matches the passed parameter.
    -**Question** Ask yourself, what is different about this `find` method versus the `Order.find` method?
  - `self.find_by_customer(customer_id)` - returns a **list** of `OnlineOrder` instances where the value of the customer's ID matches the passed parameter.


#### CSV Data File
The data for the online order CSV file consists of:

| Field          | Type    | Description
|----------------|---------|------------
| ID | Integer | A unique identifier for that Online Order
| Products  | String  | The list of products in the following format: `name:price;nextname:nextprice`
| Customer ID | Integer | A unique identifier corresponding to a Customer
| Status | String | A string representing the order's current status

## What We Are Looking For
Check out the [feedback template](feedback.md) to see what instructors will be looking for.
