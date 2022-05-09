class StockOrder < ApplicationRecord
    belongs_to :sold_by, class_name:"User", foreign_key: :sold_by
    belongs_to :sold_by, class_name:"User", foreign_key: :sold_by
    belongs_to :stock, foreign_key: :stock_symbol
end
