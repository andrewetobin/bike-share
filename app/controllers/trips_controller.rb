class TripsController < ApplicationController

  def index
    @trips = Trip.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    require_user
    @trips = Trip.all
    @ride_durations = Trip.duration_info
    @station_info = Trip.station_info
    @rides_per_month = Trip.rides_per_month
    @rides_per_year = Trip.rides_per_year
    @bike_info = Trip.bike_info
    @subscription_type_info = Trip.subscription_type_info
    @ride_info = Trip.date_info
  end
end
