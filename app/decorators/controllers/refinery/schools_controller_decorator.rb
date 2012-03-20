Refinery::Schools::SchoolsController.class_eval do
  before_filter :find_previous_schools, only: [:index]

  protected

  def find_previous_schools
    @schools = Refinery::Schools::School.previous.page(params[:page]).order("starts_at DESC")
  end
end
