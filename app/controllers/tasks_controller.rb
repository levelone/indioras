class TasksController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def new
    @team = Team.find_by_id(params[:team_id])
    @project = Project.find_by_id(params[:project_id])
    @task = Task.new
  end

  def create
    @team = Team.find_by_id(params[:team_id])
    @project = Project.find_by_id(params[:project_id])
    @task = Task.new(task_params)
    @task.project_id = @project.id
    @task.status = Task::STATUS[:open]

    respond_to do |format|
      if @task.valid?
        @task.save!
        @project.tasks << @task
        format.html { redirect_to team_project_path(@team, @project) }
      else
        format.html { render :new }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :duration, :start_date, :end_date)
  end
end
