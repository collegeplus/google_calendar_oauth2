module GoogleCalendar
  class Event
    attr_reader :client, :connection

    def initialize(client)
      @client = client
      @connection = client.discovered_api('calendar', 'v3')
    end

    def list(calendar_id)
      list = @client.execute(api_method: @connection.events.list, parameters: { 'calendarId' => calendar_id })
      list.data.items
    end

    def find_by_name(calendar, query)
      list(calendar).each do |event|
        if event.summary == query
          return @event = event
        end
      end
      @event
    end

    def find_by_id(calendar_id, id)
      @client.execute(
        api_method: @connection.events.get,
        parameters: {
          'calendarId' => calendar_id, 'eventId' => id
        }).data
    end

    def create(calendar, event)
      @client.execute(
        api_method: @connection.events.insert,
        parameters: {
          'calendarId' => calendar.id
        },
        body_object: event,
        headers: {'Content-Type' => 'application/json'})
    end

    def update(calendar_id, event_id, event)
      sequence = self.find_by_id(calendar, event_id).sequence
      sequence = sequence.nil? ? 1 : sequence + 1
      @client.execute(
        api_method: @connection.events.update,
        parameters: {
          'calendarId' => calendar_id, 'eventId' => event_id
        },
        body_object: event,
        headers: {'Content-Type' => 'application/json'})
    end

    def delete(calendar, event_id)
      @client.execute(
        api_method: @connection.events.delete,
        parameters: {
          'calendarId' => calendar.id,
          'eventId' => event_id
        })
    end
  end
end
