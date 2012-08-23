# encoding: utf-8
ProjAbak::Application.routes.draw do
#отслеживаем пути
 get "add" => "pages#add_root", :as => :add_root
 post "/" => "pages#create_root"
 get "*path/add" => "pages#add"
 post "*path" => "pages#create"
 get "*path/edit" => "pages#edit"
 put "*path" => "pages#update"
 match '*path' => 'pages#show', :via => :get, :as => :show
 root :to => 'pages#index'
end
