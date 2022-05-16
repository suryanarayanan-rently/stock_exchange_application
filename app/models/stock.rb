class CallbackActions
    
end

class Stock < ApplicationRecord
    has_many :stock_order, primary_key: :symbol, foreign_key: :stock_symbol, dependent: :destroy
    has_many :stock_holding, primary_key: :symbol, foreign_key: :stock_symbol, dependent: :destroy
    has_many :price_movements, primary_key: :symbol, foreign_key: :stock_symbol, dependent: :destroy
    belongs_to :admin_user, foreign_key: :created_by, primary_key: "email"
    
    after_save :update_or_create_stock_holding

    def update_or_create_stock_holding
        stock_holding = StockHolding.find_by(username:self.created_by,stock_symbol:self.symbol)
        if stock_holding == nil
            stock_holding=StockHolding.create!(username:self.created_by,stock_symbol: self.symbol, no_of_shares: self.no_of_shares)
        else
            stock_holding.update(stock_symbol: self.symbol, no_of_shares: self.no_of_shares)
        end
    end

end

