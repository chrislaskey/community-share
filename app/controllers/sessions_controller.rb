class SessionsController < ApplicationController

  def create
    request.env["omniauth.auth"]
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
      #   "extra"=>{"raw_info"=>{"name"=>"John Smith", "email"=>"john.smith@gmail.com", "id"=>"10104656357015020"}}}
  end

end
