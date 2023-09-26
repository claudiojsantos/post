class CreatePostagens < ActiveRecord::Migration[7.0]
  def change
    create_table :postagens do |t|
      t.string :titulo
      t.text :texto
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
