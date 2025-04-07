require 'rails_helper'

RSpec.describe "Tables API", type: :request do

  before(:each) do
    Table.destroy_all
  end

  let!(:tables) { create_list(:table, 5, capacity: 4, location: 'indoor') }

  describe "GET /tables" do
    it "returns all tables" do
      get '/tables'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(5)
    end

    it "filters tables by capacity" do
      get '/tables', params: { capacity: 4 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).all? { |t| t["capacity"] == 4 }).to be true
    end

    it "filters tables by location" do
      get '/tables', params: { location: 'indoor' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).all? { |t| t["location"] == 'indoor' }).to be true
    end
  end

  describe "POST /tables" do
    it "creates a new table" do
      expect {
        post '/tables', params: { table: { table_number: 101, capacity: 6, location: 'outdoor' } }
      }.to change(Table, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "returns error for invalid input" do
      post '/tables', params: { table: { table_number: nil, capacity: 4, location: 'indoor' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end  
end
