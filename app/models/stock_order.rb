class StockOrder < ApplicationRecord
    validates :price, presence: true, numericality: {greater_than:0.00}
    belongs_to :sold_by, class_name:"User", foreign_key: :sold_by
    belongs_to :sold_by, class_name:"User", foreign_key: :sold_by
    belongs_to :stock, foreign_key: :stock_symbol
end
