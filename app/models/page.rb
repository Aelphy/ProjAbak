class Page < ActiveRecord::Base
  attr_accessible :lft, :name, :parent_id, :path, :rgt, :text, :title
  validates :name, :presence => true,
			:format => { :with => /^[a-z\/A-Z\/0-9]+$/}
  validates :path, :uniqueness => true
  
end
