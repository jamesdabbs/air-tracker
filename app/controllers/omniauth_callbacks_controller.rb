class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    define_method provider do
      auth = env["omniauth.auth"]
      @user = Identifier.new(auth, current_user).resolve

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = auth
        redirect_to new_user_registration_url
      end
    end
  end

  [:facebook, :github].each { |provider| provides_callback_for provider }
end
