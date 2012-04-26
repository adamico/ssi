class RegistrationMailer < ActionMailer::Base
  default :from => "contact@summerschool-immunotoxicology.org"

  def registration_confirmation(registration)
    @registration = registration
    @school = @registration.school
    @title = @registration.title_with_name
    mail(:to => registration.email,
         :subject => "Summerschool In Immunotoxicology Registration")
  end

  def registration_log(registration)
    @registration = registration
    @school = @registration.school
    @title = @registration.title_with_name
    mail(:to => "contact@summerschool-immunotoxicology.org",
         :subject => "Registration id##{registration.id}")
  end
end
