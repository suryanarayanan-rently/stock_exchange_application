class StockHolding < ApplicationRecord
    belongs_to :user, foreign_key: :username
    belongs_to :stock, foreign_key: :stock_symbol
end
