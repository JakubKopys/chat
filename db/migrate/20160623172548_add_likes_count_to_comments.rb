class AddLikesCountToComments < ActiveRecord::Migration
  def change
    add_column :comments, :likes_count, :integer, default: 0
    Comment.find_each do |comment|
      comment.update_attribute(:likes_count, comment.likes.count)
      comment.save
    end
  end
end
