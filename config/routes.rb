TextEpic::Application.routes.draw do

    mount Resque::Server, :at => "/resque"

    root 'messages#chillin'

    get "messages/chillin"
    get '/textepic', to: 'messages#textepic'

end
