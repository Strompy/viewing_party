class User < ApplicationRecord
  validates :username, presence: true
  validates :email, uniqueness: true, presence: true
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :user_view_parties
  has_many :view_parties, through: :user_view_parties

  def self.from_omniauth(user_info)
    where(email: user_info.info.email).first_or_create do |user|
      user.username = user_info.info.name
      user.email = user_info.info.email
    end
  end

  def rsvp(party)
    user_view_party = user_view_parties.find_by(view_party_id: party.id)
    user_view_party.attending = true
    user_view_party.save
  end
end
