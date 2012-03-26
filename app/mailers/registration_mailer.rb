class RegistrationMailer < ActionMailer::Base
  default :from => "contact@summerschool-immunotoxicology.org"

  def registration_confirmation(registration)
    @registration = registration
    @school = @registration.school
    @title = @registration.title_with_name
    mail(:to => registration.email, :subject => "Summerschool In Immunotoxicology Registration")
  end
end
