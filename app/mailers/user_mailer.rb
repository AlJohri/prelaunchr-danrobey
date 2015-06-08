class UserMailer < ActionMailer::Base
    default from: "Harry's <welcome@harrys.com>"

    def signup_email(user)
        @user = user
        @twitter_message = "Can't wait for @thenosacrificediet to launch.  I am going to be #losingweightwithoutsacrfice for free."

        mail(:to => user.email, :subject => "Thanks for signing up!")
    end
end
