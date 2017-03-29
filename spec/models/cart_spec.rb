require_relative '../spec_helper'

describe Cart do

  it 'is created with a default status of pending' do
    cart = Cart.create

    expect(cart.status).to eq('pending')
  end


  describe 'associations' do
    let(:cart) {Cart.create}
    let(:item) {Item.create(name: 'Pencil', inventory: 20, cost: 2)}
    let(:item2) {Item.create(name: 'Pen', inventory: 30, cost: 3)}
    let(:user) {User.new(first_name: 'Cernan', last_name: 'Bernardo', email: 'cernan@flatironschool.com')}

    it 'belongs to a user' do
      cart.user = user
      #can do this because we set our variables above

      expect(cart.user).to eq(user)
    end

    it 'has many items' do
      cart.items << item
      cart.items << item2

      expect(cart.items.count).to eq(2)
    end
  end

  describe 'total' do
    let(:cart) {Cart.create}
    let(:item) {Item.create(name: 'Pencil', inventory: 20, cost: 2)}
    let(:item2) {Item.create(name: 'Pen', inventory: 30, cost: 3)}

    it 'calculates the total of the items in the cart' do
      cart.items << item
      cart.items << item2

      expect(cart.total).to eq(5)
    end
  end

  describe 'checkout' do
    let(:cart) {Cart.create}
    let(:item) {Item.create(name: 'Pencil', inventory: 20, cost: 2)}
    let(:item2) {Item.create(name: 'Pen', inventory: 30, cost: 3)}

    it 'changes the status of cart to complete' do
      cart.items << item
      cart.items << item2
      cart.checkout

      expect(cart.status).to eq('complete')
    end

    it 'removes 1 item from the inventory of all items in cart' do
      cart.items << item
      cart.items << item2
      cart.checkout

      expect(item.inventory).to eq(19)
      expect(item2.inventory).to eq (29)
    end

    it 'returns the total cost of the cart' do
      cart.items << item
      cart.items << item2
      expect(cart.checkout).to eq(5)
    end
  end
end
