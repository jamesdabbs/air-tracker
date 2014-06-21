class AddCreatedByToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :created_by, :integer
  end
end
