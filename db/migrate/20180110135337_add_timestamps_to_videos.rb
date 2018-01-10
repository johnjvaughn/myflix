class AddTimestampsToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :created_at, :datetime
    add_column :videos, :updated_at, :datetime
  end
end
