class AddLocaleToTestimonials < ActiveRecord::Migration[8.0]
  def change
    add_column :testimonials, :locale, :string, default: 'en'
    add_index :testimonials, :locale
  end
end
