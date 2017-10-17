Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  get 'sessions/login_form'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
