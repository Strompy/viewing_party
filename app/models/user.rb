class User < ApplicationRecord

  def self.from_omniauth(user_info)
    user = where(email: user_info.info.email).first_or_create do |user|
      user.username = user_info.info.name
      user.email = user_info.info.email
    end
  end
end
