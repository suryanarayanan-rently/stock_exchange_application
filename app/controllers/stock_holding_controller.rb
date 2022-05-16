require_relative "utils.rb"
class StockHoldingController < ApplicationController
    before_action :require_login
    def show_stocks
        @user = User.find(current_user.username)
        @stock_holdings = @user.stock_holding
    end
end
