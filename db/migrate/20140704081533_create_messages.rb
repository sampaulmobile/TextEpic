class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :number_to
      t.string :number_from
      t.string :message
      t.string :media_url
      t.string :callback
      t.integer :fail_count, default: 0

      t.timestamps
    end
  end
end
