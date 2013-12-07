Instavent::Application.routes.draw do
  
  ROOT '/#index'

  GET '/events'

  GET '/events/new'

  POST '/events'

  GET '/events/:id'

end
