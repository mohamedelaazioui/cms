class Admin::SocialLinksController < Admin::BaseController
  before_action :set_social_link, only: %i[show edit update destroy]

  def index
    @social_links = SocialLink.all.order(name: :asc)
  end

  def show
  end

  def new
    @social_link = SocialLink.new
  end

  def edit
  end

  def create
    @social_link = SocialLink.new(social_link_params)

    if @social_link.save
      redirect_to admin_social_link_path(@social_link), notice: 'Social link was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @social_link.update(social_link_params)
      redirect_to admin_social_link_path(@social_link), notice: 'Social link was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @social_link.destroy
    redirect_to admin_social_links_path, notice: 'Social link was successfully deleted.'
    end

  private

  def set_social_link
    @social_link = SocialLink.find(params[:id])
  end

  def social_link_params
    params.require(:social_link).permit(:name, :url)
  end
end
