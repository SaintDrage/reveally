module LoggersHelper
  class CustomLogFormatter < Logger::Formatter
    def format_message(severity, time, progname, msg)
      "[%s(%d)%5s] %s\n" % [time.to_s(:short), $$, severity, msg2str(msg)]
    end
  end

  def eve_api_log
    log = Logger.new(Rails.root.join('log', 'eveapi.log'), 'daily', 30*1024*1024)
    log.formatter = CustomLogFormatter.new
    log
  end

end
