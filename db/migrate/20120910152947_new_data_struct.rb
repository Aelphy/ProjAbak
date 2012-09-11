class NewDataStruct < ActiveRecord::Migration
  def up
	  add_column :pages, :parent_id, :integer
	  add_index(:pages, [:path], {:name => :index_pages_by_path})
	  add_index(:pages, [:name, :parent_id], {:name => :index_pages_by_path_and_parent_id})
  end

  def down
	  remove_column :pages, :parent_id
	  remove_index(:pages, :name => :index_pages_by_path)
	  remove_index(:pages, :name => :index_pages_by_path_and_parent_id)
  end
end
