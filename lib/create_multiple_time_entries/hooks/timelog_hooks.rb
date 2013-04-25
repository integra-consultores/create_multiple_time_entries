module CreateMultipleTimeEntries
  module Hooks
    class TimelogHooks < Redmine::Hook::ViewListener
      
      def view_timelog_edit_form_bottom(context = {})
        time_entry = context[:time_entry]
        form = context[:form]
        
        link_options = {
            :controller => :bulk_time_entries, 
            :action => :new,
            :project_id => time_entry.project,
            :issue_id => time_entry.issue,
            :only_path => true}
        time_entry.new_record? && time_entry.project && User.current.allowed_to?(link_options, time_entry.project) ?
          content_tag("p",link_to(l(:label_create_multiple_time_entries), link_options)) :
          ""
      end
    end
  end
end
