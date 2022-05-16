class PriceMovement < ApplicationRecord
    belongs_to :stock, foreign_key: :stock_symbol

    after_save :update_current_price

    def update_current_price
        stock = Stock.find(stock_symbol)
        stock.update(current_price:self.price)
    end
end
