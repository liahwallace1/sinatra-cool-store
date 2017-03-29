class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def total
    items.inject(0) {|sum, item| sum += item.cost }
  end

  def checkout
    self.status = "complete"
    self.items.each do |item|
      item.inventory -= 1
    end
    self.total
  end
end
