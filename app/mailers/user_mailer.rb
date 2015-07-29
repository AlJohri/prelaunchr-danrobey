class UserMailer < ActionMailer::Base
    default from: "The No Sacrifice Diet <welcome@thenosacrificediet.com>"

    def signup_email(user)
        @user = user
        @twitter_message = "Can't wait for @nosacrificediet to launch. I am going to be #losingweightwithoutsacrfice for free."

        mail(:to => user.email, :subject => "Thanks for signing up!")
    end
end
