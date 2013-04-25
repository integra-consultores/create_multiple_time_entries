# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
RedmineApp::Application.routes.draw do
  resources :projects, :only => [] do
    get 'bulk_time_entries/new', :to => "bulk_time_entries#new", :as => "new_bulk_time_entries"
    post 'bulk_time_entries', :to => "bulk_time_entries#create", :as => "bulk_time_entries"  
  end  
end