module ExceptionNotifier
  # To keep our promises around privacy, we have to remove
  # the hostname from ExceptionNotifier, doing it here
  class SlackCustomNotifier < SlackNotifier
    def fields(clean_message, backtrace, data)
      super(clean_message, backtrace, data).filter { |entry| entry[:title] != 'Hostname' }
    end
  end
end
