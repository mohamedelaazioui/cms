class Admin::ServicesController < Admin::BaseController
  before_action :set_service, only: %i[show edit update destroy]

  def index
    @services = Service.all.order(position: :asc)
  end

  def show
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to admin_service_path(@service), notice: "Service was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      redirect_to admin_service_path(@service), notice: "Service was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    redirect_to admin_services_path, notice: "Service was successfully deleted."
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title, :description, :position, :icon)
  end
end
