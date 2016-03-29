module BetterDoctor
  module V1
    class Doctor < Grape::API

      LOG = Logging.logger[self]

      # --------------------------------------------------------------------- #
      #                          Doctors v1 Resource                          #
      # --------------------------------------------------------------------- #

      resource :doctors do

        desc 'Proxy doctor search endpoint'
        params do
          optional :name,
            type: String,
            desc: "The doctor's name; searches"\
            " in both first and last names. Partial (type-ahead) "\
            "characters/names are accepted."
          optional :location,
            type: String,
            default: '37.773,-122.413,100',
            desc: "Search area - Either "\
            "Circular (lat,lon,range (miles)) or Bounding box "\
            "(top-right, bottom-left) (lat,lon,lat,lon)."
          optional :user_location,
            type: String,
            default: '37.773,-122.413',
            desc: "User's current "\
            "location. (lat, lon). This impacts ordering of practices in "\
            "results, and determines each value of [practice].distance."
          optional :skip,
            type: Integer,
            default: 0,
            desc: "For paginated list operations; specifies the zero-based "\
            "start index of the first item to retrieve."
          optional :limit,
            type: Integer,
            default: 10,
            desc: "For paginated list operations; specifies the maximum "\
            "number of items to retrieve. Maximum value of limit is 100. "\
            "Values greater than maximum value get converted to the "\
            "maximum value."
        end
        get '/search' do
          # Get query params and add user key param
          query_params = permitted_params
          query_params.user_key = api_key

          # Build path
          query = query_params.to_query
          path  = "/doctors?#{query}"

          # Proxy request
          proxy_request {
            LOG.info "Proxing request to: #{rest_resource[path]}"

            JSON.parse(rest_resource[path].get)
          }
        end
      end

    end
  end
end
