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
  
  def downgrade_wikis
      wikis = Wiki.where("user_id <= ? AND private <= ?", self.id, true)
      
      wikis.each do |w|
          puts "Editing #{w}"
         w.update_attributes(private: false)
      end
  end
  
end
