class AddCommentsCountToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :comments_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE listings
           SET comments_count = (SELECT count(1)
                                   FROM comments
                                  WHERE comments.listing_id = listings.id)
    SQL
  end
end
