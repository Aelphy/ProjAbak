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
		@page = Page.create(params[:page])
		@page1=(Page.find_by_path(params[:path]))
		@page.path= params[:path].to_s+'/'+@page.name.to_s
		@page.parent_id=@page1.id
		@page.lft=@page1.rgt
		@page.rgt=@page1.rgt+1
		new_subchild(@page1)
		
		
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
		@page.lft = 1
		@page.rgt = 2
		@page.path=@page.name.to_s
		@page.parent_id=0
		if @page.save
			@parent=@page
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
				@subpage=@page
				@children=Array.new
				while @subpage.parent_id!=0
					@children.unshift(@subpage)
					@subpage=Page.find(@subpage.parent_id)
				end

			end
	end
		
	def new_subchild(page)
		right=page.rgt
		predok=rootpredok(page.id)
		Page.where("lft > ?", right).each {|pag|
			if (rootpredok(pag.id)==predok)
				pag.lft=pag.lft+2
				pag.rgt=pag.rgt+2
				pag.save
			end
		}
		Page.where("rgt >=? AND lft <? ", right, right).each {|pag|
			if (rootpredok(pag.id)==predok)
				pag.rgt=pag.rgt+2
				pag.save
			end
		}	
	end
	
	def rootpredok(page2)
		page007=Page.find(page2)
		while (page007.parent_id != 0)
			page007=Page.find(page007.parent_id)
		end	
		return page007.id	
	end 	
	
end
