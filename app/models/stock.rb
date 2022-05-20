class CallbackActions
    
end

class Stock < ApplicationRecord

    validates :symbol, presence: true
    validates :name, presence: true, length: {minimum:3}
    validates :no_of_shares, presence: true, numericality: {only_integer: true, greater_than:  1} 
    validates :face_value, presence: true, numericality: {greater_than_or_equal_to: 1.00}
    validates :current_price, presence: true,numericality: {greater_than_or_equal_to: 1.00}

    has_many :stock_order, primary_key: :symbol, foreign_key: :stock_symbol, dependent: :destroy
    has_many :stock_holding, primary_key: :symbol, foreign_key: :stock_symbol
    has_many :price_movements, primary_key: :symbol, foreign_key: :stock_symbol, dependent: :destroy
    belongs_to :admin_user, foreign_key: :created_by, primary_key: "email"
    
    after_create :update_or_create_stock_holding

    before_destroy :after_destroy_update_wallet

    def update_or_create_stock_holding
        stock_holding = StockHolding.find_by(username:self.created_by,stock_symbol:self.symbol)
        if stock_holding == nil
            stock_holding=StockHolding.create!(username:self.created_by,stock_symbol: self.symbol, no_of_shares: self.no_of_shares)
        else
            stock_holding.update(stock_symbol: self.symbol, no_of_shares: self.no_of_shares)
        end
    end

    def after_destroy_update_wallet
        # users who own this stock
        stock_holding_users = StockHolding.where(stock_symbol:self).to_a.map {|sh| sh.username}
        puts "Stock holding users: #{stock_holding_users}"
        # Wallet.where(username:stock_holding_users).update_all(["balance = balance + (select no_of_shares FROM stock_holdings WHERE stock_symbol = ? AND stock_holdings.username = username) * ?",self.symbol,self.current_price])
        sql = "UPDATE wallets SET  balance = balance + (select no_of_shares FROM stock_holdings WHERE stock_symbol = '#{self.symbol}' AND stock_holdings.username = wallets.username) * (select current_price from stocks where symbol='#{self.symbol}') WHERE wallets.username IN (SELECT username FROM stock_holdings WHERE stock_symbol = '#{self.symbol}');"
        results = ActiveRecord::Base.connection.execute(sql)

        if results.present?
            print results
        else
            print "Query Execution Failed"
        end
        
        stock_order = StockOrder.where(stock_symbol:self.symbol).delete_all
        stock_holding = StockHolding.where(stock_symbol:self.symbol).delete_all
    end



end

