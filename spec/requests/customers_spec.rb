describe "Customer requests" do

  describe "#create" do
    it "creates a customer" do
      headers = { "Content-Type" => "application/json" }

      post "/v1/customers", {name: 'kinman'}.to_json, headers

      expect(response.response_code).to eq(201)
    end

    it "responds 422 if customer parameters aren't valid" do
      Customer.create(name: 'kinman')

      expect(Customer.find(1).name).to eq('kinman')

      headers = { "Content-Type" => "application/json" }

      # duplicate of existing customer
      post "/v1/customers", {name: 'kinman'}.to_json, headers

      expect(response.response_code).to eq(422)

      expect(JSON.parse(response.body)).to eq({"error_messages" => ["Name has already been taken"]})
    end
  end
end
