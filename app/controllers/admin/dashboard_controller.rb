class Admin::DashboardController < Admin::BaseController
  def index
    @pages_count = Page.count
    @services_count = Service.count
    @testimonials_count = Testimonial.count
    @contact_messages_count = ContactMessage.count
  end
end
