ActiveAdmin.register Banner do

  permit_params :banner_header_top, :banner_top, :banner_left_sidebar, :banner_right_sidebar_long, :banner_right_sidebar_short, :banner_bottom

  form do |f|
    f.inputs do
      f.input :banner_header_top, as: :text
      f.input :banner_top, as: :text
      f.input :banner_left_sidebar, as: :text
      f.input :banner_right_sidebar_long, as: :text
      f.input :banner_right_sidebar_short, as: :text
      f.input :banner_bottom, as: :text
    end
    f.actions
  end

  controller do
    def update
      update! do |format|
        format.html do
          $banner.reload
          redirect_to :back
        end
      end
    end
  end
end
