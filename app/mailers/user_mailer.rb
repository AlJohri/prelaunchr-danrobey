class UserMailer < ActionMailer::Base
    default from: "The No Sacrifice Diet <welcome@thenosacrificediet.com>"

    def signup_email(user)
        @user = user
        @twitter_message = "Can't wait for @nosacrifice to launch. Lose weight with no sacrifices ...for Free!"

        mail(
        	:to => user.email,
        	:subject => "Thanks for signing up!",
        	:template_path => "user_mailer",
        	:template_name => "signup_email"
        )
    end
end
