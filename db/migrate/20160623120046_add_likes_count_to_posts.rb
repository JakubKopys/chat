class AddLikesCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :likes_count, :integer, default: 0
    Post.find_each do |post|
      post.update_attribute(:likes_count, post.likes.count)
      post.save
    end
  end
end
