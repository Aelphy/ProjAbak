class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :path
      t.string :name
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end