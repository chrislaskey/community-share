class User < ApplicationRecord
  devise :rememberable, :timeoutable, :trackable, :omniauthable, omniauth_providers: [:facebook]
end
