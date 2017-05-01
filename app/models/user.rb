class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :wikis, dependent: :destroy
  
  after_initialize :default_role
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum role: [:standard, :premium, :admin]
  
  def default_role
    self.role ||= :standard
  end
  
end
