class ViewParty < ApplicationRecord
  validates :movie_title, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :runtime, presence: true

  has_many :user_view_parties
  has_many :users, through: :user_view_parties

  def start_time
    year, month, day = date.split('-').map(&:to_i)
    hour, minute = time.split(':').map(&:to_i)
    DateTime.new(year, month, day, hour, minute, 0, '-06:00')
  end

  def end_time
    hours = runtime.to_i / 60
    minutes = runtime.to_i % 60
    start_time.advance(hours: hours, minutes: minutes)
  end

  def attending?(current_user)
    user_view_party = user_view_parties.find_by(user_id: current_user.id)
    user_view_party.attending
  end
end
