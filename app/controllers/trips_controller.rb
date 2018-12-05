class TripsController < ApplicationController
  def search_results
    if params[:query]
      sql_query = "destination ILIKE :query"
      @trips = Trip.where(sql_query, query: "%#{params[:query][:destination]}%").order("created_at DESC").where.not(user: current_user)
      @params = search_params
    else
      @trips = Trip.all.order('created_at DESC')
    end
  end

  def new
    @trip = Trip.new
    # @trip.time = Time.now
  end

  private

  def search_params
    params.require(:query).permit(:destination, :airport, :terminal)
  end
end
