class User < ActiveRecord::Base
    belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
    has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"

    attr_accessible :email

    validates :email, :uniqueness => true, :format => { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, :message => "Invalid email format." }
    validates :referral_code, :uniqueness => true

    before_create :create_referral_code
    after_create :process_user

    REFERRAL_STEPS = [
        {
            'count' => 5,
            "html" => "Basic Package",
            "class" => "two",
            "image" =>  ActionController::Base.helpers.asset_path("refer/basic.jpg"),
            "description" => "<ul>
                                <li>No Sacrifice Diet Book</li>
                                <li>Smart Phone App Instant Access</li>
                              </ul>"
        },
        {
            'count' => 10,
            "html" => "Silver Package",
            "class" => "three",
            "image" => ActionController::Base.helpers.asset_path("refer/silver.jpg"),
            "description" => "<ul>
                                <li>No Sacrifice Diet Book</li>
                                <li>Smart Phone App Instant Access</li>
                                <li>Fast Track One Hour Instruction Video</li>
                              </ul>"
        },
        {
            'count' => 25,
            "html" => "Gold Package",
            "class" => "four",
            "image" => ActionController::Base.helpers.asset_path("refer/silver.jpg"),
            "description" => '<ul>
                                <li>No Sacrifice Diet Book</li>
                                <li>Smart Phone App Instant Access</li>
                                <li>Fast Track One Hour Video</li>
                              </ul>
                              <p>Your name featured in the Introduction of the "No Sacrifice Diet Book" as an official contributor.</p>'
        },
        {
            'count' => 50,
            "html" => "Platinum Package",
            "class" => "five",
            "image" => ActionController::Base.helpers.asset_path("refer/platinum.jpg"),
            "description" => '<ul>
                                <li>No Sacrifice Diet Book</li>
                                <li>Smart Phone App Instant Access (Apple Watch Version)</li>
                                <li>Fast Track One Hour Video </li>
                                <li>Limited Edition Author Autographed PDF Version Of
The No Sacrifice Diet Book</li>
                              </ul>
                              <p>Your name featured in the Introduction of the "No Sacrifice Diet Book" as an official contributor, and featured on the company website.</p>'
        }
    ]

    def process_user
        UserMailer.delay.signup_email(self)
        self.delay.add_to_aweber
    end

    # for consumer key and consumer secret:
    # "https://labs.aweber.com/apps"
    # for access token and access secret:
    # "https://auth.aweber.com/1.0/oauth/authorize_app/" + ENV['AWEBER_APP_ID']
    # split on pipe?
    def add_to_aweber
      oauth = AWeber::OAuth.new(ENV['AWEBER_APP_CONSUMER_KEY'], ENV['AWEBER_APP_CONSUMER_SECRET'])
      oauth.authorize_with_access(ENV['AWEBER_APP_ACCESS_TOKEN'], ENV['AWEBER_APP_ACCESS_SECRET'])
      aweber = AWeber::Base.new(oauth)
      list_id = 3870558
      new_subscriber = {"email" => self.email}
      aweber.account.lists[list_id].subscribers.create(new_subscriber)
    end

    private

    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = User.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = User.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

end
