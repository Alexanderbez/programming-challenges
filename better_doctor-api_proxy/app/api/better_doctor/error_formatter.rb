module BetterDoctor
  module ErrorFormatter

    # ----------------------------------------------------------------------- #
    #                             Error Formatter                             #
    # ----------------------------------------------------------------------- #

    def self.call(message, backtrace, options, env)
      err = {
        :response_type => 'error',
        :response => message
      }

      err[:backtrace] = backtrace if Rails.env.development?

      err.to_json
    end

  end
end
