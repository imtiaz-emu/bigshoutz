class UserMailer < ApplicationMailer

  def new_user_email
    @user = params[:user]

    mail(to: @user.email, subject: 'Your account in Bigshoutz is created')
  end
end

# class DeviseMailer < Devise::Mailer
#
#   def confirmation_instructions(record, token, opts={})
#     mail = super
#     mail.subject = 'Your account in Bigshoutz is created'
#     mail
#   end
#
# end

