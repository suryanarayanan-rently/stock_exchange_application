class PriceMovement < ApplicationRecord

    validates :price, presence: true, numericality: {greater_than_or_equal_to: 1.00}
    validates :time, presence: true
    belongs_to :stock, foreign_key: :stock_symbol

    validate :check_are_date_and_time_in_future
    after_save :update_current_price
    

    def update_current_price
        stock = Stock.find(stock_symbol)
        stock.update(current_price:self.price)
    end

    def check_are_date_and_time_in_future
        if time.nil? or time.future?
            errors.add(:time,"Date and Time cannot be in future") 
        end
    end
end
