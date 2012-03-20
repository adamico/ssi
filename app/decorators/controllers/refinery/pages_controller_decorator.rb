Refinery::PagesController.class_eval do
  before_filter :find_next_school, only: [:home]

  protected

  def find_next_school
    @school = Refinery::Schools::School.last
  end
end
