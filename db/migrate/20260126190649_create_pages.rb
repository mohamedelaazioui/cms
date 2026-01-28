class CreatePages < ActiveRecord::Migration[8.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.boolean :published
      t.string :locale

      t.timestamps
    end
  end
end
