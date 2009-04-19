#--
# Copyright (C) 2009 Dimitrij Denissenko
# Please read LICENSE document for more information.
#++
class Admin::TasksController < AdminAreaController
  verify :params => :tasks, :only => :save

  def index
    @tasks = Retrospectiva::TaskManager::Parser.new.tasks
  end
  
  def save
    params[:tasks].each do |name, interval|
      seconds = TimeInterval.in_seconds(interval[:count], interval[:units]) rescue 0
      Retrospectiva::TaskManager::Task.create_or_update(name, seconds)
    end if params[:tasks].is_a?(Hash)
    flash[:notice] = _('Task configuration was successfully updated.')
    redirect_to admin_tasks_path
  end  

end
