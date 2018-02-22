class TasksController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @team = Team.find_by_id(params[:team_id])
    @project = Project.find_by_id(params[:project_id])
    @tasks = @project.tasks.order(:id)
  end

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
    @task.owner_id = current_user.id

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

  def edit
    @team = Team.find_by_id(params[:team_id])
    @project = Project.find_by_id(params[:project_id])
    @task = Task.find_by_id(params[:id])
  end

  def update
    @team = Team.find_by_id(params[:team_id])
    @project = Project.find_by_id(params[:project_id])
    @task = Task.find_by_id(params[:id])
    @task.assign_attributes(task_params)

    respond_to do |format|
      if @task.valid?
        @task.save!
        format.html { redirect_to team_project_path(@team, @project) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    task = Task.find_by_id(params[:id])
    task.destroy
    redirect_to team_project_path(params[:team_id], params[:project_id])
  end

  def assign
    team = Team.find_by_id(params[:team_id])
    project = Project.find_by_id(params[:project_id])
    task = Task.find_by_id(params[:id])
    task.update_attributes!(assignee: current_user)
    redirect_to team_project_path(team, project)
  end

  def unassign
    team = Team.find_by_id(params[:team_id])
    project = Project.find_by_id(params[:project_id])
    task = Task.find_by_id(params[:id])
    task.update_attributes!(assignee: nil)
    redirect_to team_project_path(team, project)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :duration, :start_date, :end_date)
  end
end
