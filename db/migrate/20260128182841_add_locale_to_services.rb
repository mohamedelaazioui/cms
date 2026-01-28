class AddLocaleToServices < ActiveRecord::Migration[8.0]
  def change
    add_column :services, :locale, :string, default: 'en'
    add_index :services, :locale
  end
end
