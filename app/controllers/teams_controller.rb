class TeamsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new(owner_id: current_user.id)
  end

  def create
    @team = Team.new(team_params)
    @team.owner_id = current_user.id

    respond_to do |format|
      if @team.valid?
        @team.save!
        current_user.teams << @team
        format.html { redirect_to root_path }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @team = Team.find_by_id(params[:id])
    @projects = @team.projects
  end

  def destroy
    @team = Team.find_by_id(params[:id])
    @team.destroy
    redirect_to teams_path
  end

  def collaborate
    collaborator = TeamsUser.new(user_id: current_user.id, team_id: params[:id])
    collaborator.save!
    redirect_to teams_path
  end

  def stop_collaboration
    team = Team.find_by_id(params[:id])
    current_user.teams.destroy(team)
    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :team_type)
  end
end
