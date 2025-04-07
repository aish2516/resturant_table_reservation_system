class TablesController < ApplicationController
  def create
    table = Table.new(table_params)
    if table.save
      render json: table, status: :created
    else
      render json: { errors: table.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    tables = Table.all
    tables = tables.where(location: params[:location]) if params[:location].present?
    tables = tables.where('capacity >= ?', params[:capacity]) if params[:capacity].present?
    render json: tables
  end

  private

  def table_params
    params.require(:table).permit(:table_number, :capacity, :location)
  end
end
