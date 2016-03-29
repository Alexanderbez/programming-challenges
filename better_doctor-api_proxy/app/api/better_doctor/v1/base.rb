module BetterDoctor
  module V1
    class Base < Grape::API

      # --------------------------------------------------------------------- #
      #                              Base V1 API                              #
      # --------------------------------------------------------------------- #

      helpers BetterDoctor::V1::ApiHelpers
      version 'v1', using: :path

      before do
        verify_api_keyheader!
      end

      # Mount v1 routes
      mount BetterDoctor::V1::Doctor
    end
  end
end
