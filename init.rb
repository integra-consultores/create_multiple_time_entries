ActionDispatch::Callbacks.to_prepare do
    # use require_dependency if you plan to utilize development mode
    require 'create_multiple_time_entries/hooks/timelog_hooks'
end

Redmine::Plugin.register :create_multiples_time_entries do
  name 'Create Multiples Time Entries plugin'
  author 'Integra Consultores'
  description 'This plugin allows an authorized user to log time for multiple users simultaneously'
  version '0.0.1'
  url 'https://github.com/integra-consultores/create_multiple_time_entries'
  author_url 'https://github.com/integra-consultores'
  
  permission :create_multiples_time_entries, { :bulk_time_entries => [:new, :create]}, :require => :member
end
