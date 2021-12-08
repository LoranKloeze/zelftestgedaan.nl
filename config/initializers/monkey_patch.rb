# To keep our promises around privacy, we have to remove
# the hostname from ExceptionNotifier, doing it here
#
# TODO: Monkey patching is like blockchain: don't every use it
#       unless you absolutely no other choice. So refactor this.
#
module ExceptionNotifier
  class SlackNotifier
    def fields(clean_message, backtrace, data)
      fields = [
        { title: 'Exception', value: clean_message }
      ]

      if backtrace
        formatted_backtrace = "```#{backtrace.first(@backtrace_lines).join("\n")}```"
        fields << { title: 'Backtrace', value: formatted_backtrace }
      end

      unless data.empty?
        deep_reject(data, @ignore_data_if) if @ignore_data_if.is_a?(Proc)
        data_string = data.map { |k, v| "#{k}: #{v}" }.join("\n")
        fields << { title: 'Data', value: "```#{data_string}```" }
      end

      fields.concat(@additional_fields) if @additional_fields

      fields
    end
  end
end