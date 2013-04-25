module BulkTimeEntriesHelper
  def bulk_time_entries_user_collection_for_select_options(project, selected = nil)
    collection =  project.members.map{|member| member.user }.sort
    collection.keep_if{|user| user.allowed_to?(:log_time, project)}    
    
    s = ''

    collection.sort.each do |element|
      selected_attribute = ' selected="selected"' if option_value_selected?(element, selected)
      s << %(<option value="#{element.id}"#{selected_attribute}>#{h element.name}</option>)
    end
    
    s.html_safe
  end
end