module API
  module V1
    class Base < Grape::API
      # http://localhost:3000/api/v1/
      version 'v1'
      format :json

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response e.to_json, 400
      end

      rescue_from :all do
        error!( { error: [ { msg: "不正なリクエストです。"} ] } )
      end

      mount API::V1::Cards
    end
  end
end
