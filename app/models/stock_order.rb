class StockOrder < ApplicationRecord
    attribute :created_at, default: -> {Time.now.utc}
    validates :order_status, presence: true
    enum order_status: {
        open: 1,
        sold: 2
    }
    validates :price, presence: true, numericality: {greater_than_or_equal_to:1.00}
    belongs_to :sold_by, class_name:"User", foreign_key: :sold_by
    belongs_to :bought_by, class_name:"User", foreign_key: :bought_by, required: false
    belongs_to :stock, foreign_key: :stock_symbol
    
    accepts_nested_attributes_for :sold_by

    before_save do |stock_order|
        print stock_order.username
    end
end
