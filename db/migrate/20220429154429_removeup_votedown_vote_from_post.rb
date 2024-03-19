class RemoveupVotedownVoteFromPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :upVote
    remove_column :posts, :downVote
  end
end
