class StockOrder < ApplicationRecord
    
    include PgSearch::Model

    @sold_updated = false
    attribute :created_at, default: -> {Time.now.utc}
    attribute :sold, default: -> {false}

    pg_search_scope :kinda_spelled_like, against: :stock_symbol, using: {
        :trigram =>  {
            threshold:0.1
        }
    }
    

    validates :unit_price, presence: true, numericality: {:greater_than_or_equal_to=> 1.00}
    validates :sold_by, presence: true
    validates :no_of_shares, numericality: {greater_than_or_equal_to: 1}, presence: true
    
    validate :cannot_sell_stock_more_than_holding, on: :create
    validate :buyer_and_seller_should_not_be_same
    
    belongs_to :sold_by, class_name:"User", foreign_key: :sold_by
    belongs_to :bought_by, class_name:"User", foreign_key: :bought_by, required: false
    belongs_to :stock, foreign_key: :stock_symbol, primary_key: :symbol
    
        
    after_create :update_stock_holdings_on_create
    after_update :update_stock_holdings_on_update
    after_destroy :update_stock_holdings_on_destroy


    after_validation do |stock_order|
        stock_order.total_price = stock_order.no_of_shares * stock_order.unit_price 
        @after_update_sold = stock_order.sold
    end

    def cannot_sell_stock_more_than_holding
        stock_holding = StockHolding.find_by(username: sold_by.username, stock_symbol:stock_symbol)
        if stock_holding == nil 
            errors.add(:stock_symbol, "You can sell only the stocks you hold")
        else
            errors.add(:no_of_shares, "You can't sell more than you hold") if no_of_shares.blank? or no_of_shares > stock_holding.no_of_shares            
            errors.add(:stocks_on_hold, "All your stocks are on hold or you don't have enough stocks") if stock_holding.stocks_on_hold+no_of_shares > stock_holding.no_of_shares
            
        end
    end


    def buyer_and_seller_should_not_be_same
        errors.add(:bought_by, "You can't buy the stocks you are selling") if bought_by!=nil  and  sold_by.username == bought_by.username
    end

    def update_stock_holdings_on_create
        stock_holding = StockHolding.find_by(username:self.sold_by.username,stock_symbol:self.stock_symbol)
        stock_holding.update(stocks_on_hold:  stock_holding.stocks_on_hold + self.no_of_shares)
    end

    before_update do |so|
        @sold_updated = sold_changed?
        puts("sold_Changed? #{sold_changed?}")
    end
    def update_stock_holdings_on_update

        if @sold_updated
            seller_stock_holding = StockHolding.find_by(username:self.sold_by.username,stock:self.stock_symbol)
            buyer_stock_holding = StockHolding.find_or_initialize_by(username:self.bought_by.username,stock_symbol:self.stock_symbol)
            buyer_wallet = Wallet.find_by_username(self.bought_by)
            seller_wallet = Wallet.find_by_username(self.sold_by)
            if self.sold
                print " No of shares #{self.no_of_shares}"
                print " No of Seller shares #{seller_stock_holding.no_of_shares}"

                us = seller_stock_holding.update(stocks_on_hold:  seller_stock_holding.stocks_on_hold - self.no_of_shares,no_of_shares: seller_stock_holding.no_of_shares - self.no_of_shares)
                buyer_stock_holding.update(no_of_shares: buyer_stock_holding.no_of_shares + self.no_of_shares)
                seller_wallet.update(balance: seller_wallet.balance + self.total_price)
                buyer_wallet.update(balance: buyer_wallet.balance - self.total_price)
                PriceMovement.create(stock_symbol:self.stock_symbol,price:self.unit_price,time:DateTime.now.utc)
            else
                seller_stock_holding.update(stocks_on_hold:  seller_stock_holding.stocks_on_hold + self.no_of_shares,no_of_shares: seller_stock_holding.no_of_shares + self.no_of_shares)     
                buyer_stock_holding.update(no_of_shares: buyer_stock_holding.no_of_shares - self.no_of_shares) 
                seller_wallet.update(balance: seller_wallet.balance - self.total_price)
                buyer_wallet.update(balance: buyer_wallet.balance + self.total_price)
            end
        end
    end

    def update_stock_holdings_on_destroy
        stock_holding = StockHolding.find_by(username:self.sold_by.username,stock_symbol:self.stock_symbol)        
        if !self.sold
            stock_holding.update(stocks_on_hold: stock_holding.stocks_on_hold - self.no_of_shares)
        end

    end

    
end
