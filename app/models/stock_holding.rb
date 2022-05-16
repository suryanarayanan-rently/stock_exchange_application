class StockHolding < ApplicationRecord
    belongs_to :user, foreign_key: :username
    belongs_to :stock, foreign_key: :stock_symbol
    attribute :no_of_shares, default: 0
end
