module API
  module V1
    class Base < Grape::API
      # http://localhost:3000/api/v1/
      version 'v1'
      format :json

      rescue_from ActiveRecord::RecordNotFound do |e|
        rack_response({ message: e.message, status: 404 }.to_json, 404)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response e.to_json, 400
      end

      rescue_from :all do
        if Rails.env.development?
          error!({error: [{msg: "不正なリクエストです。"}]})
        else
          error_response(message: "Internal server error", status: 500)
        end
      end

      mount API::V1::Cards
    end
  end
end
