# encoding: utf-8
class Page < ActiveRecord::Base
	
has_many  :children, :class_name => "Page" , :foreign_key => "parent_id"
belongs_to :parent, :class_name => "Page"

attr_accessible :name, :path, :text, :title, :parent_id
  
validates :name, :presence => true,
			:format => { :with => /^[a-z\/A-Z\/0-9]+$/}
validates :path, :uniqueness => true

end
