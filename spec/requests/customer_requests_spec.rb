describe "Customer requests" do
  before do
    @customer = Customer.create!(name: "kinman")
  end

  describe "index" do
    it "lists customers" do
      get "/v1/customers.json"

      expected = [{"id"=>1, "name"=>"kinman", "orders"=>0}]
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to eq(expected)
    end
  end

  describe "show" do
    it "shows the requested customer" do
      get "/v1/customers/#{@customer.id}.json"

      expected = {"id"=>1, "name"=>"kinman"}
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to eq(expected)
    end

    it "responds 404 if the customer isn't found" do
      get "/v1/customers/-1.json"

      expect(response.response_code).to eq(404)
      expect(response.body).to be_empty
    end
  end

  describe "create" do
    it "creates a customer" do
      headers = { "Content-Type" => "application/json" }

      post "/v1/customers", {name: "nik"}.to_json, headers

      expect(response.response_code).to eq(201)
    end

    it "responds 422 if parameters aren't valid" do
      headers = { "Content-Type" => "application/json" }

      # duplicate of existing customer
      post "/v1/customers", {name: "kinman"}.to_json, headers

      expect(response.response_code).to eq(422)

      expect(JSON.parse(response.body)).to eq({"error_messages" => ["Name has already been taken"]})
    end
  end

  describe "update" do
    it "modifies the customer" do
      headers = { "Content-Type" => "application/json" }

      put "/v1/customers/#{@customer.id}.json", {name: "nik"}.to_json, headers

      expected = {"id"=>1, "name"=>"nik"}
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to eq(expected)
    end

    it "responds 404 if the customer isn't found" do
      headers = { "Content-Type" => "application/json" }

      put "/v1/customers/-1.json", {name: "kinman"}.to_json, headers

      expect(response.response_code).to eq(404)
    end
  end

  describe "destroy" do
    it "deletes the customer" do
      delete "/v1/customers/#{@customer.id}"

      expect(response.response_code).to eq(204)
    end

    it "responds 422 if the customer cannot be deleted (has orders)" do
      Order.create(customer_id: @customer.id, item_name: "book")

      delete "/v1/customers/#{@customer.id}"

      expect(response.response_code).to eq(422)
      expect(JSON.parse(response.body)).to eq( {"error_messages"=>["Customer has placed orders, cannot be deleted."]})
    end

    it "responds 404 if the customer cannot be found" do
      delete "/v1/customers/-1"

      expect(response.response_code).to eq(404)
    end
  end
end
