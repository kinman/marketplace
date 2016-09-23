describe 'Order' do

  context "attribute validations" do
    it "should require item_name" do
      o = Order.new
      expect(o.valid?).to be false
      expect(o.errors[:item_name]).to eq(["can't be blank"])
    end
  end
end

