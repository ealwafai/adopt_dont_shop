class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @found_pets = Pet.find_by_name(params[:search])
    elsif params[:pet_id].present?
      @application.pets << Pet.find(params[:pet_id])
    end
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      flash[:notice] = "Application was completed successfully!"
      redirect_to "/applications/#{@application.id}"
    else
      render 'new'
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update!(description: params[:description], status: :pending)
    redirect_to "/applications/#{@application.id}?submit=true"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
