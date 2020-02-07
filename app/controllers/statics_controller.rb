class StaticsController < ApplicationController
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  include Blog::SetHeaderValues

  def index
    @job_ads = Listing.active.not_hidden.where(category_id: 5, published: 2).
      order('GREATEST(urgent_date, featured_home_date) DESC NULLS LAST, created_at DESC').limit(5)
    @company_ads = Listing.active.not_hidden.where(category_id: 1, published: 2).
      order('GREATEST(urgent_date, featured_home_date) DESC NULLS LAST, created_at DESC').limit(5)
    @service_ads = Listing.active.not_hidden.where(category_id: 4, published: 2).
      order('GREATEST(urgent_date, featured_home_date) DESC NULLS LAST, created_at DESC').limit(12)

    other_cat_ids = $all_cats.pluck(:id).reject { |id| [1, 4, 5, 25].include?(id) }
    @other_ads = Listing.active.not_hidden.where(published: 2).where(category_id: other_cat_ids).
      order('GREATEST(urgent_date, featured_home_date) DESC NULLS LAST, created_at DESC').limit(16)
    @sliders = SliderText.order(:id)
    session[:redirect_to] = params[:to]
  end

  def contact
    @page = find_page('contact')
    @message_hash = {
      first_name: '',
      email: '',
      c_email: '',
      phone: '',
      message: '',
      subject: ''
    }
  end

  def contact_form
    @page = find_page('contact')
    @message_hash = {
      first_name: params[:first_name],
      email: params[:email],
      c_email: params[:c_email],
      phone: params[:phone],
      message: params[:message],
      subject: params[:subject]
    }

    if params[:email].length > 5 && params[:first_name].length > 3 && verify_recaptcha
      SendMessageMailer.contact_form_email(@message_hash, params[:attachment]).deliver # send email to admin
      redirect_to contact_path, notice: 'Your enquiry has been received. Thank you.'
    else
      flash[:error] = 'There was an error while processing your enquiry.'
      render :contact
    end
  end

  def sitemap
    respond_to do |format|
      format.xml { render file: 'public/sitemap.xml' }
      format.html do
        @page = find_page('sitemap')
        @sitemap = Sitemap.new
        @sitemap.count_members
      end
    end
  end

  def subscribe
    username = subscription_params[:name]
    email = subscription_params[:email]

    unless email_is_valid?(email)
      redirect_to root_path, alert: 'Invalid email'
      return
    end

    sendy = Cindy.new(ENV['SENDY_URL'])
    if sendy.subscribe(ENV['SENDY_LIST_ID'], email, username)
      redirect_to :back, notice: 'You were subscribed to our newsletter. Thank you.'
    else
      redirect_to :back, alert: 'Something went wrong during subscription process. Try again or contact us by the form.'
    end
  end

  def support
  end

  def about
    @page = find_page('about')
  end

  def terms
    @page = find_page('terms')
  end

  def privacy
    @page = find_page('privacy')
  end

  def how_it_works
    @page = find_page('how-it-works')
  end

  def trust_and_safety
    @page = find_page('trust-and-safety')
  end

  def unsubscribe
    category = Category.friendly.find('stuff-for-sale')
    flash[:notice] = 'Your email subscription has been cancelled. Thank you!'

    if category.nil?
      redirect_to root_path
    else
      redirect_to slugged_category_path(category.slug)
    end
  end

  def start_selling
    @page = find_page('start-selling')
    @template = $template
  end

  def preview
    @page = find_page(params[:page_slug])
  end

  def blog
    @featured_blogs = collection_serialize(BlogPost.published.where(featured: true).order(created_at: :desc).limit(7), BlogPostSerializer)
    @blogs = {}
    all_blog_posts = BlogPost.joins(:blog_subcategory,).published.where(featured: false).group('blog_posts.id, blog_subcategories.blog_category_id').having("count(*) <= 7")
    BlogCategory.all.each do |category|
      filtered_blogs = all_blog_posts.where(blog_subcategory_id: category.blog_subcategories.ids)
      @blogs[category.title] = collection_serialize(filtered_blogs, BlogPostSerializer)
    end
    set_blog_header_values
  end

  private

  def email_is_valid?(email)
    VALID_EMAIL_REGEX === email
  end

  def find_page(slug)
    Page.friendly.find(slug)
  end

  def subscription_params
    params.require(:subscription).permit(:name, :email)
  end

end
