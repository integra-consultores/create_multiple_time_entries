class BulkTimeEntriesController < ApplicationController
  
  before_filter :find_project_for_new_time_entry, :only => [:new, :create]
  before_filter :authorize
  
  helper :timelog
  include TimelogHelper
  
  def new
    @bulk_time_entry ||= BulkTimeEntry.new(:project => @project, :issue => @issue, :spent_on => User.current.today)
    @bulk_time_entry.safe_attributes = params[:bulk_time_entry]
  end
  
  def create
    @bulk_time_entry ||= BulkTimeEntry.new(:project => @project)
    @bulk_time_entry.safe_attributes = params[:bulk_time_entry]
        
    if @bulk_time_entry.save
      
      flash[:notice] = l(:notice_successful_create)
      if params[:continue]
        if params[:project_id]
          redirect_to :action => 'new', :project_id => @bulk_time_entry.project, :issue_id => @bulk_time_entry.issue,
            :bulk_time_entry => {:issue_id => @bulk_time_entry.issue_id, :activity_id => @bulk_time_entry.activity_id},
            :back_url => params[:back_url]
        else
          redirect_to :action => 'new',
            :bulk_time_entry => {:project_id => @bulk_time_entry.project_id, :issue_id => @bulk_time_entry.issue_id, :activity_id => @bulk_time_entry.activity_id},
            :back_url => params[:back_url]
        end
      else
        redirect_to :controller => :projects, :action => 'view', :project_id => @bulk_time_entry.project
      end
    else
      render :action => 'new'
    end    
  end
  
  private
  
  def find_optional_project_for_new_time_entry
    if (project_id = (params[:project_id] || params[:bulk_time_entry] && params[:bulk_time_entry][:project_id])).present?
      @project = Project.find(project_id)
    end
    if (issue_id = (params[:issue_id] || params[:bulk_time_entry] && params[:bulk_time_entry][:issue_id])).present?
      @issue = Issue.find(issue_id)
      @project ||= @issue.project
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_project_for_new_time_entry
    find_optional_project_for_new_time_entry
    if @project.nil?
      render_404
    end
  end
  
  
end