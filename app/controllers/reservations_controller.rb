class ReservationsController < ApplicationController

  def index
    reservations = Reservation.includes(:table).all
    render json: reservations.as_json(include: :table)
  end

  def create
    customer = Customer.find_or_create_by!(customer_params)
    table = if params[:smart_assign]
              find_best_table(params[:guest_count].to_i, params[:reserved_date], params[:time_slot_id])
            else
              Table.find(params[:table_id])
            end

    return render json: { error: 'No suitable table available' }, status: :unprocessable_entity unless table

    reservation = Reservation.new(
      customer: customer,
      table: table,
      time_slot_id: params[:time_slot_id],
      reserved_date: params[:reserved_date],
      guest_count: params[:guest_count],
      special_request: params[:special_request]
    )

    if reservation.save
      render json: reservation, status: :created
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    reservation = Reservation.find(params[:id])
    render json: reservation, include: [:table, :customer, :time_slot]
  end

  def update
    reservation = Reservation.find(params[:id])
    if reservation.update(reservation_params)
      render json: reservation
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    slot_time = Time.zone.parse("#{reservation.reserved_date} #{reservation.time_slot.start_time}")
    if Time.current > slot_time - 1.hour
      render json: { error: "Cannot cancel less than 1 hour before reservation" }, status: :forbidden
    else
      reservation.destroy
      render json: { message: "Reservation cancelled successfully" }
    end
  end

  private

  def reservation_params
    params.permit(:reserved_date, :time_slot_id, :guest_count, :special_request)
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone)
  end

  def find_best_table(guest_count, reserved_date, time_slot_id)
    Table.where('capacity >= ?', guest_count)
         .left_joins(:reservations)
         .where.not(
           reservations: {
             reserved_date: reserved_date,
             time_slot_id: time_slot_id
           }
         )
         .order(:capacity)
         .first
  end
end
