class CalendarService
  def create_google_client(user)
    client = conn
    secrets = client_secrets(user)
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = 'refresh_token'
      if user.blank?
        client.authorization.refresh!
        user.update(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue
      flash[:error] = 'Your token has expired. Please login again with Google.'
      redirect_to '/'
    end
    client
  end

  def create_event(view_party, user)
    attendee = [{ email: user.email }]
    # attendees = view_party.users.map do |friend|
    #   {email: friend.email}
    # end
    Google::Apis::CalendarV3::Event.new(
      {
        summary: view_party[:movie_title],
        start: {
          date_time: view_party.start_time,
          time_zone: 'America/Denver'
        },
        end: {
          date_time: view_party.end_time,
          time_zone: 'America/Denver'
        },
        attendees: attendee,
        reminders: {
          use_default: false,
          overrides: [
            Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'popup', minutes: 10),
            Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'email', minutes: 20)
          ]
        },
        notification_settings: {
          notifications: [
            { type: 'event_creation', method: 'email' },
            { type: 'event_change', method: 'email' },
            { type: 'event_cancellation', method: 'email' },
            { type: 'event_response', method: 'email' }
          ]
        }, 'primary': true
      }
    )
  end

  private

  def conn
    Google::Apis::CalendarV3::CalendarService.new
  end

  def client_secrets(user)
    Google::APIClient::ClientSecrets.new(
      {
        'web' => {
          'access_token' => user.google_token,
          'refresh_token' => user.google_refresh_token,
          'client_id' => ENV['GOOGLE_API_KEY'],
          'client_secret' => ENV['GOOGLE_API_SECRET']
        }
      }
    )
  end
end
