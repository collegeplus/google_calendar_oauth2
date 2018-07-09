module GoogleCalendar
  class Calendar
    attr_reader :events, :connection, :client

    def initialize(client)
      @client = client
    end

    def list
      list = client.execute(connection.calendar_list.list)
      list.data.items
    end

    def find(calendar_id)
      client.execute(connection.calendar_list.get, calendarId: calendar_id).data
    end

    def find_by_summary(summary)
      list.detect { |calendar| calendar.summary == summary }
    end

    def create(attrs)
      @client.execute(
        api_method: @connection.calendars.insert,
        body: [JSON.dump(attrs)],
        headers: {'Content-Type' => 'application/json'})
    end
  end
end
