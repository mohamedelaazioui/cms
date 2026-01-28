class CreateGdprConsents < ActiveRecord::Migration[8.0]
  def change
    create_table :gdpr_consents do |t|
      t.string :ip
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
