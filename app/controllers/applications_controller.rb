class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.create(application_params)
    if @application.save
      flash[:notice] = "Application was completed successfully!"
      redirect_to "/applications/#{@application.id}"
    else
      render 'new'
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
