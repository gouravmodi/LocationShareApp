class LocationsController < ApplicationController
  def index                                  
  end

  def public_locations
    locations_shared_by_me = current_user.locations.select(:latitude, :longitude).distinct
    locations_shared_with_me = Location.select(:latitude, :longitude).joins(:shared_locations)
                                       .where('shared_locations.shared_with_id = ?', current_user.id)
    render json: {
      success: true, 
      locations_shared_by_me: locations_shared_by_me,
      locations_shared_with_me: locations_shared_with_me
    }
  end

  def create
    @location = Location.new(location_params)
    user_ids = params[:user_ids] || [nil]
    if @location.save
      if params[:user_ids]
        params[:user_ids].each do |user_id|
          SharedLocation.create(
            shared_by_id: current_user.id,
            shared_with_id: user_id,
            location_id: @location.id
          )
        end
      else
        SharedLocation.create(
          shared_by_id: current_user.id,
          location_id: @location.id
        )
      end
    end
    redirect_to locations_path
  rescue Exception => e
    render json: {success: false, message: e.message}
  end

  protected

  def location_params
    params.permit(:latitude, :longitude)
  end
end
