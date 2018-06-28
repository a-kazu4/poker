Rails.application.routes.draw do
  root 'top#new'
  get 'top' => 'top#new'
  post 'judge' => 'top#judge'
end


