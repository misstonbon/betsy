Rails.application.routes.draw do
  get 'reviews/index'

  get 'reviews/create'

  get 'reviews/destroy'

  get 'reviews/edit'

  get 'reviews/new'

  get 'reviews/show'

  get 'reviews/update'

  get 'users/index'

  get 'users/show'

  get 'sessions/login_form'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
