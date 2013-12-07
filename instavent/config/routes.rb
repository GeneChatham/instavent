Instavent::Application.routes.draw do
  
  get "photos/index"
  get "photos/new"
  get "photos/create"
  get "photos/show"
  get "photos/edit"
  get "photos/update"
  get "photos/destroy"
  root 'events#index'

  resources :events

#     Prefix Verb   URI Pattern                Controller#Action
#       root GET    /                          events#index
#     events GET    /events(.:format)          events#index
#            POST   /events(.:format)          events#create
#  new_event GET    /events/new(.:format)      events#new
# edit_event GET    /events/:id/edit(.:format) events#edit
#      event GET    /events/:id(.:format)      events#show
#            PATCH  /events/:id(.:format)      events#update
#            PUT    /events/:id(.:format)      events#update
#            DELETE /events/:id(.:format)      events#destroy

end
