class AddFieldsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :scheduled_for, :datetime
    add_column :topics, :meetup_url, :string
    add_column :topics, :presentable, :boolean
  end
end
