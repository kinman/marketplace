describe 'V1::CustomersController' do
  before do
    @controller = V1::CustomersController.new
  end

  describe "#index" do
    before do
      Customer.create(name: 'kinman')
    end

    it "should assign @customers" do
      get :index, format: :json
      customers = assigns[:customers]
      expect(customers.count).to eq(1)
      expect(customers.first).to eq(Customer.find_by(name: 'kinman'))
    end
  end

  describe "#show" do
    before do
      @customer_id = Customer.create(name: 'kinman').id
    end

    it "should assign the right customer" do
      get :show, format: :json, id: @customer_id
      expect(assigns[:customer].name).to eq('kinman')
    end

    it "should 404 if customer not found" do
      get :show, format: :json, id: -1
      expect(response.response_code).to eq(404)
      expect(response.body).to be_empty
    end
  end

  describe "#create" do
    it "creates a customer" do
      post :create, {name: 'kinman'}.to_json

      expect(response.response_code).to eq(201)
    end

    it "responds 422 if customer parameters aren't valid" do
      Customer.create(name: 'kinman')

      expect(Customer.find(1).name).to eq('kinman')

      headers = { "Content-Type" => "application/json" }

      # duplicate of existing customer
      post :create, {name: 'kinman'}.to_json, headers

      expect(response.response_code).to eq(422)

      expect(JSON.parse(response.body)).to eq({"error_messages" => ["Name has already been taken"]})
    end
  end

  describe "#update" do
    before do
      @id = Customer.create(name: 'kinman')
    end

    it "updates a customer" do
      headers = { "Content-Type" => "application/json" }

      put :update, id: @id, {name: 'nik'}.to_json, headers
    end
  end

end