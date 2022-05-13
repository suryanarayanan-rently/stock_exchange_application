class StockOrder < ApplicationRecord
    stock_holding = nil
    attribute :created_at, default: -> {Time.now.utc}
    validate :cannot_sell_stock_more_than_holding, :buyer_and_seller_should_not_be_same
    # validates :order_status, presence: true
    # validates :price, presence: true, numericality: {greater_than_or_equal_to:1.00}
    belongs_to :sold_by, class_name:"User", foreign_key: :sold_by
    belongs_to :bought_by, class_name:"User", foreign_key: :bought_by, required: false
    belongs_to :stock, foreign_key: :stock_symbol
    
    accepts_nested_attributes_for :sold_by

    paginates_per 2

    def cannot_sell_stock_more_than_holding
        stock_holding = StockHolding.find_by(username: sold_by.username, stock_symbol:stock_symbol)
        if stock_holding == nil 
            errors.add(:stock_symbol, "You can sell only the stocks you hold")
        else
            errors.add(:no_of_shares, "You can't sell more than you hold") if no_of_shares.blank? or no_of_shares > stock_holding.no_of_shares
                
            errors.add(:stocks_on_hold, "All your stocks are on hold or you don't have enough stocks") if stock_holding.stocks_on_hold+no_of_shares > stock_holding.no_of_shares
        end
    end

    after_validation do |stock_order|
        stock_order.total_price = stock_order.no_of_shares * stock_order.unit_price 
    end

    after_create :update_stock_holdings_on_create

    after_destroy :update_stock_holdings_on_delete

    def buyer_and_seller_should_not_be_same
        errors.add(:bought_by, "You can't buy the stocks you are selling") if bought_by!=nil  and  sold_by.username == bought_by.username
    end

    def update_stock_holdings_on_create
        stock_holding = StockHolding.find_by(username:self.sold_by.username,stock_symbol:self.stock_symbol)
        stock_holding.update(stocks_on_hold:  stock_holding.stocks_on_hold + self.no_of_shares)
    end

    def update_stock_holdings_on_update
        stock_holding = StockHolding.find_by(username:self.sold_by.username,stock_symbol:self.stock_symbol)
        if self.sold
            stock_holding.update_all(stocks_on_hold:  stock_holding.stocks_on_hold - self.no_of_shares,no_of_shares: stock_holding.no_of_shares - self.no_of_shares)
        else
            stock_holding.update_all(stocks_on_hold:  stock_holding.stocks_on_hold + self.no_of_shares,no_of_shares: stock_holding.no_of_shares + self.no_of_shares)
        end
    end

    def update_stock_holdings_on_delete
        stock_holding = StockHolding.find_by(username:self.sold_by.username,stock_symbol:self.stock_symbol)
        
        if !self.sold
            stock_holding.update(stocks_on_hold: stock_holding.stocks_on_hold - self.no_of_shares)
        end

    end
end
