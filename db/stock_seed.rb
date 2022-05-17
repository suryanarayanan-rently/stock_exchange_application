require "csv"
def seed_stock_data
    table = CSV.parse(File.read("/home/rently/rails_project/stock_exchange_application/db/stock_data.csv"),headers:true)
    puts "Stock Seeding Started"
    table.each do |record|
        Stock.create!(symbol:record[0],name:record[1],no_of_shares:record[2].to_i,face_value:record[3].to_f,current_price:record[4].to_i,created_by:"admin@example.com")
    end
    puts "Stock Seeding Completed"
end
