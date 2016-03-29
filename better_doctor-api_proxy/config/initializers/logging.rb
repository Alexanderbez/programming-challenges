# Logging setup

# A common log format that all appenders will use
LOG_FORMAT = "[%l]-[%p]-[%d]-[%c{2}]: %m\n"

# => Color scheme for STDOUT logging only
Logging.color_scheme(
  'STDOUT_FORMAT',
  :levels => {
    :info  => :green,
    :warn  => :orange,
    :error => :red,
    :debug => :yellow
  },
  :date   => :blue,
  :logger => :cyan,
  :pid    => :white
)

# => STDOUT log appender
Logging.appenders.stdout(
  'stdout',
  :layout => Logging.layouts.pattern(
    :pattern      => LOG_FORMAT,
    :color_scheme => 'STDOUT_FORMAT'
  )
)

Logging.logger.root.add_appenders('stdout')
