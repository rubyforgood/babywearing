class WelcomeMailer < CustomMailer
    def welcome_email(user)
      @user = user
      mail(to: @user.email, subject: 'Babywearing Account Registration')
    end
  end