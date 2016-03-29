module BetterDoctor
  module ApiHelpers
    extend Grape::API::Helpers

    LOG = Logging.logger[self]

    # ----------------------------------------------------------------------- #
    #                               API Helpers                               #
    # ----------------------------------------------------------------------- #

    # Returns the request parameters that are filtered against the allowed
    # request parameters.
    #
    # @param options [Hash]
    # @return [Hashie::Mash]
    def permitted_params(options = {})
      options = {
        include_missing: false
      }.merge(options)

      declared(params, options)
    end

    # Fetches the BetterDoctor public API key from the headers.
    #
    # @return [Object]
    def api_key
      headers['X-Api-Key']
    end

    # Verifies the presence of an API key header value. If no header is passed,
    # then a 401 unauthorized response is returned.
    #
    # @return [Object]
    def verify_api_keyheader!
      if api_key.blank?
        LOG.warn 'Invalid API key passed'
        error!('Unauthorized', 401, 'X-Error-Detail' => 'Invalid API key.')
      end
    end

    # Proxies a request from the client to the BetterDoctor public API. Any
    # failed request is handled by returning the proxied request HTTP status
    # code and message. A successful response will simply have the body
    # returned.
    #
    # @yield
    def proxy_request(&block)
      begin
        yield
      rescue RestClient::Exception => ex
        LOG.error 'Failed to proxy request'

        response    = JSON.parse(ex.response)
        status_code = response['meta']['http_status_code']

        LOG.error "Status: #{status_code}"
        LOG.error "response: #{response}"

        error!(response, status_code)
      end
    end

  end
end
