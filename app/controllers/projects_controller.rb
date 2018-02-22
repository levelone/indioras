class ProjectsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @team = Team.find_by_id(params[:team_id])
    @projects = @team.projects.order(:created_at)
  end

  def new
    @team = Team.find_by_id(params[:team_id])
    @project = Project.new
  end

  def create
    @team = Team.find_by_id(params[:team_id])
    @project = Project.new(project_params)
    @project.owner_id = current_user.id
    @project.team_id = @team.id

    respond_to do |format|
      if @project.valid?
        @project.save!
        @team.projects << @project
        format.html { redirect_to team_path(@team) }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:id])
    @tasks = @project.tasks.order(:id)

    owner_or_collaborator =
      current_user.is_team_owner?(@team) ||
      current_user.is_team_collaborator?(@team)

    redirect_to :back unless owner_or_collaborator
  end

  def edit
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:id])
  end

  def update
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:id])
    @project.assign_attributes(project_params)

    respond_to do |format|
      if @project.valid?
        @project.save!
        format.html { redirect_to team_path(@team) }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
