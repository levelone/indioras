class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :projects, foreign_key: :owner_id
  has_many :tasks, foreign_key: :assignee_id
  has_secure_password

  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  PASSWORD_FORMAT = /\A
    (?=.*\d)    # Must contain a digit
    (?=.*[a-z]) # Must contain a lower case character
    (?=.*[A-Z]) # Must contain an upper case character
  /x

  validates_confirmation_of :password

  validates :username,
    presence: true,
    length: 2..16

  validates :email,
    presence: true,
    format: { with: EMAIL_FORMAT },
    uniqueness: { case_sensitive: false }

  validates :password, 
    presence: true, 
    length: { minimum: 8 },
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :create 

  validates :password, 
    allow_nil: true, 
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :update

  def is_owner_or_collaborator_of(team, project, task)
    is_team_collaborator?(team) ||
      is_team_owner?(team) ||
      is_project_owner?(project) ||
      is_task_owner?(task)
  end

  def is_team_collaborator?(team)
    team.users.find_by_id(id).present?
  end

  def is_team_owner?(team)
    team.owner_id == id
  end

  def is_project_owner?(project)
    project.owner_id == id
  end

  def is_task_owner?(task)
    task.owner_id == id
  end
end
