class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    find_user
    update_user

    session["devise.facebook_data"] = user_data

    if @user.persisted?
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

  def find_user
    @user = User.find_or_initialize_by(
      uid: user_data.uid,
      provider: user_data.provider
    )
  end

  def update_user
    @user.update_attributes(
      email: user_data.info.email,
      image: user_data.info.image,
      name: user_data.info.name,
      token: user_data.credentials.token
    )
  end

end
