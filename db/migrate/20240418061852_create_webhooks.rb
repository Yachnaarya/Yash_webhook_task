class CreateWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks do |t|
      t.string :source
      t.jsonb :data
      t.string :message
      t.string :event

      t.timestamps
    end
  end
end
