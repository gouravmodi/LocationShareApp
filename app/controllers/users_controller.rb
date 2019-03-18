class UsersController < ApplicationController
  def index
    @users = User.select(:id, :name, :email, :username)
  end

  def show
    @user = User.find_by_username(params[:username])
  end

  def locations
    @user = User.find_by_id(params[:id])
    if @user
      public_locations = Location.select('latitude, longitude')
                                  .joins(:shared_locations)
                                  .where("shared_locations.shared_by_id = #{@user.id} AND shared_locations.shared_with_id IS NULL")
      render json: {success: true, locations: public_locations}
    else

    end
  end
end
