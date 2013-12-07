Instavent::Application.routes.draw do
  
  root 'events#index'

  # get 'events'

  # get 'events/new'

  # post 'events'

  # get 'events/:id'


# Original routes created by Controller generation

  get "events/index"
  get "events/new"
  get "events/create"
  get "events/show"
  get "events/edit"
  get "events/update"
  get "events/destroy"

end
