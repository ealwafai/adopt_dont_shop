class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all
    @reversed_shelters = @shelters.shelters_in_reverse
    @pending = @shelters.shelters_pending_apps
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
