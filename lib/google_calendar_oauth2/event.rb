module GoogleCalendar
  class Event
    attr_reader :client, :connection

    def initialize(client)
      @client = client
      @connection = client.discovered_api('calendar', 'v3')
    end

    def list(calendar_id, params = {})
      params = params.merge(calendarId: calendar_id)
      list = @client.execute(api_method: @connection.events.list, parameters: params)
      list.data.items
    end

    def find_by_name(calendar_id, query)
      list(calendar_id).each do |event|
        if event.summary == query
          return @event = event
        end
      end
      @event
    end

    def find_by_id(calendar_id, event_id)
      @client.execute(
        api_method: @connection.events.get,
        parameters: {
          'calendarId' => calendar_id, 'eventId' => event_id
        }).data
    end

    def create(calendar_id, event)
      @client.execute(
        api_method: @connection.events.insert,
        parameters: { 'calendarId' => calendar_id },
        body_object: event,
        headers: {'Content-Type' => 'application/json'}
      )
    end

    def update(calendar_id, event)
      sequence = event.sequence
      event.sequence = sequence.nil? ? 1 : sequence + 1
      @client.execute(
        api_method: @connection.events.update,
        parameters: { 'calendarId' => calendar_id, 'eventId' => event.id },
        body_object: event,
        headers: {'Content-Type' => 'application/json'}
      )
    end

    def delete(calendar_id, event_id)
      @client.execute(
        api_method: @connection.events.delete,
        parameters: {
          'calendarId' => calendar_id,
          'eventId' => event_id
        })
    end
  end
end
