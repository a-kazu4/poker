module API
  class Base < Grape::API
    prefix 'api'
    format :json

    error = {error: [{msg: "不正なURLです。"}]}
    route :any, '*path' do
      error!(error)
    end

    mount API::V1::Base
  end
end