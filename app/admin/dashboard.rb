ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Last 10 Listings" do
          ul do
            Listing.last(10).map do |listing|
              li link_to(listing.name, admin_listing_path(listing))
            end
          end
        end
      end

      column do
        panel "Listings for moderation" do
          ul do
            Listing.where(published: 1).last(50).map do |listing|
              li link_to(listing.name, admin_listing_path(listing))
            end
          end
        end
      end

      column do
        panel "Statistic" do
          para "Total listings " + "#{Listing.count}"
          para "Total number of users: " + "#{User.count}"
          para "Pending Ads: " + "#{Listing.where(published: 1).count}" 
          para "Pending Company Listings:" + "#{Listing.where(category_id: 1,published: 1).count}" 
          para "Published Ads: " + "#{Listing.where(published: 2).count}" 
          para "Published Company Listings:" "#{Listing.where(category_id: 1,published: 2).count}" 
        end
      end
    end

  end # content
end
