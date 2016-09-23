# marketplace
A simple ecommerce API built on Ruby on Rails

# Requirements
* Ruby 2.2.4
* Rails 4.2.7
* PostgreSQL

.ruby-version and .ruby-gemset are checked in, so you can use rvm and Bundler if you like. Make sure to run `rvm gemset create marketplace` before installing any gems.

## API 

#### GET /v1/customers
Returns a list of customers in the database.

`curl localhost:3000/v1/customers.json`

#### GET /v1/customers/{id}
Returns the customer with the given id. If the customer doesn't exist, the repsonse is a 404.

`curl localhost:3000/v1/customers/1.json`

#### POST /api/v1/customers
Creates a new customer. 

`curl -H "Content-Type: application/json" localhost:3000/v1/customers -d '{"name":"kinman"}'`

### PUT /v1/customers/{id}.json
Updates the given customer, or returns a 404 if not found. Returns a 422 if the customer cannot be updated.

`curl -H "Content-Type: application/json" localhost:3000/v1/customers/1.json -d '{"name":"foo"}'`

### DELETE /v1/customer/{id}
Deletes the given customer if found; otherwise returns a 404. Returns a 422 if the customer has orders on file.


## ORDERS API Endpoints
An order must belong to a customer, and you cannot retrieve orders outside the scope of a customer. In a more realistic situation, the customer would be identified by API key or token, and orders operations would be scoped to that customer. There would also be an admin API for authorized users to retrieve orders across the customer base.


### GET /v1/orders?customer_id=
Returns the orders for a given customer. 

`curl localhost:3000/v1/orders.json?customer_id=1`

### GET /v1/orders/{:id}.json?customer_id=
Returns the requested order if it exists and belongs to the given customer. 

`curl localhost:3000/v1/orders.json?customer_id=1`

### POST /v1/orders
Requires a valid customer_id in the request body.

`curl -v -H "Content-Type: application/json" localhost:3000/v1/orders -d '{"customer_id":1, "item_name":"book"}'`

### PUT /v1/orders
Returns a 403. In this example, you aren't allowed to update orders.

`curl -X PUT -H "Content-Type: application/json" -v localhost:3000/v1/orders/1 -d '{"customer_id":1, "item_name":"foo"}'`

### DELETE /v1/orders/{:id}?customer_id=
Deletes the requested order if it belongs to the requested customer.
 
`curl -v -X DELETE http://localhost:3000/v1/orders/1?customer_id=1
`