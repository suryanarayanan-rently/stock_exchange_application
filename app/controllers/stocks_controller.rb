require_relative 'utils.rb'
class StocksController < ApplicationController 
    before_action :require_login,:check_pan_card
end
