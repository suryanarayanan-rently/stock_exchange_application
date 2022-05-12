class CallbackActions
    def after_save(stock)
        stock_holding = StockHolding.find_by(username:stock.created_by,stock_symbol:stock.symbol)
        if stock_holding == nil
            stock_holding=StockHolding.create!(username:stock.created_by,stock_symbol: stock.symbol, no_of_shares: stock.no_of_shares)
        else
            stock_holding.update(stock_symbol: stock.symbol, no_of_shares: stock.no_of_shares)
        end
        puts stock_holding.username
        print "callback called"
    end
end

class Stock < ApplicationRecord
    has_many :stock_order, primary_key: :symbol, foreign_key: :stock_symbol, dependent: :destroy
    has_many :stock_holding, primary_key: :symbol, foreign_key: :stock_symbol, dependent: :destroy
    belongs_to :admin_user, foreign_key: :created_by, primary_key: "email"
    after_save CallbackActions.new

end

