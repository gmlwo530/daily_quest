class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :name
      t.text :content
      t.text :description
      t.string :category

      t.timestamps null: false
    end
  end
end
