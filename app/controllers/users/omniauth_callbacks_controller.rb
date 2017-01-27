class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # => {
  #   "provider"=>"facebook",
  #   "uid"=>"10104656357015027",
  #   "info"=>
  #     {"email"=>"john.smith@gmail.com",
  #     "name"=>"John Smith",
  #     "image"=>"http://graph.facebook.com/v2.6/10104656357015027/picture"},
  #   "credentials"=>
  #     {"token"=>
  #       "EAATaxja6SJMBAMC5wKaju89VvyO2YO06n3tZA7dhs4H2hkZANcIWwDZCdJ0M9KDFgm7Jpp1N9hwxVYynZCjegTZB3TwlW9GVp5UpLpT0eqWJUZAVwj0dHtHDTAZBZCitNvoJJr3nFpFNFT2JwnzP77JZAQixqXdpelLxKeTcwZAWp5MuJhx5XdJLMa",
  #     "expires_at"=>1490410872,
  #     "expires"=>true},
  #   "extra"=>{"raw_info"=>{"name"=>"John Smith", "email"=>"john.smith@gmail.com", "id"=>"10104656357015027"}}}

  def facebook
    binding.pry
    # @user = User.find_by(uid: user_data.uid)

    # session["devise.facebook_data"] = user_data

    if @user.persisted?
      flash[:success] = "Successfully logged in with Facebook" if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = ["An error occured while trying to log in with Facebook"]
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def user_data
    @user_data ||= request.env["omniauth.auth"]
  end

end
