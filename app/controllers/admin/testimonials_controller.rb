class Admin::TestimonialsController < Admin::BaseController
  before_action :set_testimonial, only: %i[show edit update destroy]

  def index
    @testimonials = Testimonial.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @testimonial = Testimonial.new
  end

  def edit
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)

    if @testimonial.save
      redirect_to admin_testimonial_path(@testimonial), notice: "Testimonial was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @testimonial.update(testimonial_params)
      redirect_to admin_testimonial_path(@testimonial), notice: "Testimonial was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @testimonial.destroy
    redirect_to admin_testimonials_path, notice: "Testimonial was successfully deleted."
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:name, :quote, :avatar)
  end
end
