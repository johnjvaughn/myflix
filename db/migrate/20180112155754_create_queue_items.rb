class CreateQueueItems < ActiveRecord::Migration[5.1]
  def change
    create_table :queue_items do |t|
      t.integer :sort_order
      t.integer :user_id, foreign_key: true
      t.integer :video_id, foreign_key: true
      t.timestamps
    end
  end
end
