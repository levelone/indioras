class TeamsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def new
    @team = Team.new(owner_id: current_user.id)
  end

  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.valid?
        @team.save!
        format.html { redirect_to root_path }
      else
        format.html { render :new }
      end
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
