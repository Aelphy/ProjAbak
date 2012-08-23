# encoding: utf-8
class Page < ActiveRecord::Base
  attr_accessible :name, :path, :text, :title
validates :name, :presence => true,
			:format => { :with => /^[a-z\/A-Z\/0-9]+$/}
validates :path, :uniqueness => true
end
