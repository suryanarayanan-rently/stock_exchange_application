class Stock < ApplicationRecord
    has_many :stock_order, primary_key: :symbol, foreign_key: :stock_symbol
end
