require 'date'
require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class Dashboard::ViewingPartiesController < Dashboard::BaseController
  def new
    title = params[:title]
    runtime = params[:runtime]
    @movie_details = ViewPartyMovie.new(title, runtime)
  end

  def create
    friends = User.where(id: params[:user][:friends])
    party = current_user.view_parties.create(
      date: params[:date],
      time: params[:start_time],
      movie_title: params[:title],
      runtime: params[:runtime],
      host: current_user.username
    )
    friends.each do |friend|
      party.users << friend
      friend.email_user(party, current_user)
    end
    client = CalendarService.new.create_google_client(current_user)
    event = CalendarService.new.create_event(party, current_user)
    client.insert_event('primary', event)
    current_user.rsvp(party)
    flash[:success] = 'Party was successfully scheduled.'
    redirect_to '/dashboard'
  end
end
