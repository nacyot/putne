class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  rolify

  has_many :projects, dependent: :destroy
  has_one :secret_key, dependent: :destroy

  def commits
    Commit.where(repository_id: repository_ids).order("committed_at desc")
  end

  def repository_ids
    projects.map do |project|
      project.repository.id
    end
  end
end
