module CommentsHelper
  def children_count(comment)
    comment.children.count
  end
end
