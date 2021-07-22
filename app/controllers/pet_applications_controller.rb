class PetApplicationsController < ApplicationController

  def update
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet_application = PetApplication.find_apps(params[:pet_id], application.id)
    pet_application.update!(status: params[:status])
    redirect_to "/admin/applications/#{application.id}"
  end
end
