class StockHolding < ApplicationRecord
    
    attribute :no_of_shares, default:0

    validates :no_of_shares, numericality: {only_integer: true,greater_than_or_equal_to: 0}

    belongs_to :user, foreign_key: :username
    belongs_to :stock, foreign_key: :stock_symbol
end
