class SetLastClickAtValue < ActiveRecord::Migration[5.0]
  def change
    Listing.find_each do |l|
      l.update(last_click_at: l.created_at)
    end
  end
end
