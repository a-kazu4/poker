module API
  class Base < Grape::API
    prefix 'api'
    format :json

    url_and_request_error = { error: [ { msg: "不正なURLです。" }, { msg: "不正なリクエストです。" } ] }
    url_error = { error: [ { msg: "不正なURLです。" } ] }

    rescue_from :all do
      error!(url_and_request_error)
    end

    route :any, '*path' do
      error!(url_error)
    end

    mount API::V1::Base
  end
end