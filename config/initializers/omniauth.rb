Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"]
  # scopes: "user_managed_groups", info_fields: "email,groups,name"
end
