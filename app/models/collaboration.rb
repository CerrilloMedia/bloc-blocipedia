class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  
  validates :wiki, uniqueness: { scope: :user }
  validates :user, uniqueness: { scope: :wiki }
  
end
