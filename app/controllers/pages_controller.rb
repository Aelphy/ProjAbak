class PagesController < ApplicationController
	def add
		if 	Page.find_by_path(params[:path]).nil?			 
			respond_to do |format|
			format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
			format.xml  { head :not_found }
			format.any  { head :not_found }
			end
		else
		@page=Page.new
		end
	end
	def edit
		@page = Page.find_by_path(params[:path])
	end
	def create	
		@page = Page.new(params[:page])
		@page.parent_id=Page.find_by_path(params[:path]).id
		@page.path= params[:path].to_s+'/'+@page.name.to_s
		if @page.save
			redirect_to show_path(@page.path) 
		else
			render 'add' 
		end		
	end
	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])
			redirect_to show_path(@page.path)
		else
			render 'edit'
		end
	end
	def index
		@page = Page.all		
	end
	def add_root
		@page=Page.new
	end
	def create_root
		@page = Page.new(params[:page])
		@page.path=@page.name.to_s
		if @page.save
			redirect_to show_path(@page.path)
		else
			render 'add_root'			
		end	
	end
	def show	
		if 	Page.find_by_path(params[:path]).nil?			 
			respond_to do |format|
			format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
			format.xml  { head :not_found }
			format.any  { head :not_found }
			end
			else	
				@page = Page.find_by_path(params[:path])
				@children=@page.children
				@parent=@page.parent
			end
	end
end
