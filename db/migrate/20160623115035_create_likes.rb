class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :like, :default => false
      t.references :likeable, polymorphic: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
