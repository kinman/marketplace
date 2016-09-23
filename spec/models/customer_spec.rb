describe 'Customer' do

  context "attribute validations" do
    it "should require name" do
      c = Customer.new
      expect(c.valid?).to be false
      expect(c.errors[:name]).to eq(["can't be blank"])
    end

    it "should require unique name" do
      Customer.create(name: 'kinman')

      d = Customer.new(name: 'kinman')
      d.valid?
      expect(d.errors[:name]).to eq(["has already been taken"])
    end
  end
end

