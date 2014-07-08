require 'google/api_client'
require 'socket'

module GoogleCalendar
  class Client
    attr_reader :headers, :calendars, :events
    attr_accessor :connection
    HEADERS = {'Content-Type' => 'application/json', 'GData-Version' => '3.0'}

    def initialize(client_id, client_secret, redirect_uri, app_name, app_version)
      @client = Google::APIClient.new(
        application_name: app_name,
        application_version: app_version
      )
      @client.authorization.client_id = client_id
      @client.authorization.client_secret = client_secret
      @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
      @client.authorization.redirect_uri = redirect_uri
      @connection = @client
    end

    def authorization_uri
      @client.authorization.authorization_uri.to_s
    end

    def redirect_to
      warn 'WARNING: Client#redirect_to has been deprecated. Please use Client#authorization_uri'
      authorization_uri
    end

    def calendars
      @calendars = Calendar.new(@connection)
    end

    def events
      Event.new(@connection)
    end
  end
end
