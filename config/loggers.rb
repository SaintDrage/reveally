class EveApiLogFormatter < Logger::Formatter
  def format_message(severity, time, progname, msg)
    "[%s(%d)%5s] %s\n" % [time.to_s(:short), $$, severity, msg2str(msg)]
  end
end

eveapi_log = Logger.new(Rails.root.join('log', 'eveapi.log'), 'daily', 30*1024*1024)
eveapi_log.formatter = EveApiLogFormatter.new
