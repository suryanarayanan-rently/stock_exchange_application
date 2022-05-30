require "rails_helper"
RSpec.describe StockOrdersController, :type => :controller  do
    subject {
        user = create(:user)
        create(:pan_card,username:user.username)
        user
    }
    it "render stock_form" do
        sign_in subject
        get "show_sell_stock_form"
        expect(response).to have_http_status(200)
        expect(response).to render_template(:sell_stock)
    end

    it "list_stocks page" do 
        sign_in subject 
        get "list_stocks"
        expect(response).to have_http_status(200)
        expect(response).to render_template(:list_stocks)
    end

    it "save_sell_stock_order" do 
        admin = create(:admin_user)
        stock = create(:stock,created_by:admin.email,current_price:1,no_of_shares:10)
        stock_holding = create(:stock_holding,stock_symbol:stock.symbol,no_of_shares:10,username:subject.username)
        sign_in subject 
        subject.stock_holding.reload
        puts "\nussh:#{subject.reload.stock_holding.reload.count}"
        post "save_sell_stock_order" ,params: {
            no_of_shares:1,
            unit_price:10,
            stock_symbol:stock.symbol,
        }
        expect(flash[:alert]).to be(nil)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/stocks")
    end

    it "buy_stock" do 
        admin = create(:admin_user)
        user = User.find(admin.email)
        stock = create(:stock,created_by:admin.email,current_price:1,no_of_shares:10)
        stock_order = create(:stock_order,stock:stock,sold_by:user,no_of_shares:10,unit_price:1)
        sign_in subject 
        put "buy_stock", params:{
            stockOrderId: stock_order.id
        }
        expect(response).to redirect_to("/stocks")
        expect(flash[:notice]).to_not be(nil)
    end

    
end