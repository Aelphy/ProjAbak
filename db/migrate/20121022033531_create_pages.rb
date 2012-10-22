class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :name
      t.text :text
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string :path

      t.timestamps
    end
  end
end
