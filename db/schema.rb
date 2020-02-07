# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200120171334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "level",                  default: 0
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "banners", force: :cascade do |t|
    t.text     "banner_top"
    t.text     "banner_left_sidebar"
    t.text     "banner_right_sidebar_long"
    t.text     "banner_right_sidebar_short"
    t.text     "banner_bottom"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "banner_header_top"
  end

  create_table "blog_categories", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.string   "status"
    t.integer  "blog_post_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["blog_post_id"], name: "index_blog_comments_on_blog_post_id", using: :btree
    t.index ["user_id"], name: "index_blog_comments_on_user_id", using: :btree
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "cover_photo"
    t.string   "author"
    t.string   "author_photo"
    t.string   "bio"
    t.text     "tag"
    t.boolean  "featured"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "slug"
    t.integer  "blog_subcategory_id"
    t.string   "status"
    t.string   "script_tags"
    t.index ["blog_subcategory_id"], name: "index_blog_posts_on_blog_subcategory_id", using: :btree
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true, using: :btree
  end

  create_table "blog_subcategories", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "blog_category_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["blog_category_id"], name: "index_blog_subcategories_on_blog_category_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "slug"
    t.string   "title"
    t.string   "keywords"
    t.text     "description"
    t.text     "content"
    t.integer  "serial_number"
    t.boolean  "payable",       default: true
    t.index ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string  "name"
    t.string  "title"
    t.string  "keywords"
    t.text    "content"
    t.text    "description"
    t.integer "region_id"
    t.index ["name"], name: "index_cities_on_name", using: :btree
    t.index ["region_id"], name: "index_cities_on_region_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "comment_replies", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.integer  "listing_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "comment_id"
    t.index ["comment_id"], name: "index_comment_replies_on_comment_id", using: :btree
    t.index ["listing_id"], name: "index_comment_replies_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_comment_replies_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.string   "rating"
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.integer  "type"
    t.index ["listing_id"], name: "index_comments_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "continents", force: :cascade do |t|
    t.string "name",        null: false
    t.string "title"
    t.string "keywords"
    t.text   "content"
    t.text   "description"
    t.string "slug"
    t.index ["slug"], name: "index_continents_on_slug", unique: true, using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string  "name"
    t.string  "title"
    t.string  "keywords"
    t.text    "content"
    t.text    "description"
    t.integer "continent_id"
    t.string  "slug"
    t.index ["continent_id"], name: "index_countries_on_continent_id", using: :btree
    t.index ["name"], name: "index_countries_on_name", using: :btree
    t.index ["slug"], name: "index_countries_on_slug", unique: true, using: :btree
  end

  create_table "coupon_codes", force: :cascade do |t|
    t.string   "name",            limit: 20, null: false
    t.float    "discount",                   null: false
    t.date     "expiration_date",            null: false
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id", "name"], name: "index_coupon_codes_on_user_id_and_name", using: :btree
    t.index ["user_id"], name: "index_coupon_codes_on_user_id", using: :btree
  end

  create_table "email_templates", force: :cascade do |t|
    t.text     "user_confirmation"
    t.text     "user_password_change"
    t.text     "user_reset_password"
    t.text     "user_unlock"
    t.text     "listing_new_admin"
    t.text     "listing_new_payment_admin"
    t.text     "contact_form_admin"
    t.text     "feedback_admin"
    t.text     "listing_message_user"
    t.text     "listing_job_user"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "email_global_header"
    t.text     "email_global_footer"
    t.text     "listing_new_payment_user"
    t.text     "report_ad"
    t.text     "listing_new_user"
    t.text     "review_alert"
    t.text     "user_close_account"
    t.text     "expiration_notice"
    t.text     "approval_notice"
    t.text     "deny_notice"
    t.text     "review_reply_alert"
    t.text     "user_message_user"
    t.text     "new_payment_request"
    t.text     "new_offer"
    t.text     "payment_request_accepted"
    t.text     "offer_accepted"
    t.text     "payment_request_rejected"
    t.text     "offer_rejected"
    t.text     "new_coupon_code"
    t.text     "trial_period_expiring"
    t.text     "new_subscription"
  end

  create_table "favorite_listings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_favorite_listings_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_favorite_listings_on_user_id", using: :btree
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "image"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "position"
    t.string   "country"
    t.text     "content"
    t.boolean  "published",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "published",                                          default: 1
    t.string   "name"
    t.string   "brand"
    t.string   "condition"
    t.string   "location"
    t.text     "description"
    t.string   "delivery_time"
    t.string   "delivery_cost"
    t.string   "pick_up_only"
    t.decimal  "price",                     precision: 10, scale: 2
    t.string   "price_open_to_offers"
    t.string   "price_per"
    t.string   "salary_per"
    t.string   "price_per_property"
    t.string   "car_make"
    t.string   "car_model"
    t.integer  "car_reg_year"
    t.string   "car_gearbox"
    t.integer  "car_mileage"
    t.float    "car_engine_size"
    t.string   "car_fuel_type"
    t.string   "car_body_type"
    t.string   "car_color"
    t.string   "job_type"
    t.string   "property_type"
    t.string   "property_size_rooms"
    t.string   "property_size_meters"
    t.string   "property_size_feets"
    t.string   "property_date_available"
    t.string   "video_url"
    t.string   "pet_type"
    t.integer  "featured_home"
    t.datetime "featured_home_date"
    t.integer  "featured_cat"
    t.datetime "featured_cat_date"
    t.integer  "urgent"
    t.datetime "urgent_date"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "wholesale_price"
    t.integer  "retail_price"
    t.string   "wholesale_moq"
    t.string   "company_country"
    t.string   "company_phone"
    t.string   "company_website"
    t.string   "company_facebook"
    t.string   "company_twitter"
    t.string   "company_googleplus"
    t.string   "company_instagram"
    t.string   "company_linkedin"
    t.integer  "company_displayed"
    t.datetime "company_display_time"
    t.decimal  "total_amount_cents"
    t.datetime "purchased_at"
    t.integer  "sale_price"
    t.string   "company_youtube"
    t.decimal  "amount_to_pay",             precision: 5,  scale: 2
    t.string   "amount_to_pay_currency"
    t.text     "key_features",                                       default: [],                 array: true
    t.text     "keywords",                                           default: [],                 array: true
    t.text     "cancellations_and_returns"
    t.text     "warranty"
    t.boolean  "paused",                                             default: false, null: false
    t.string   "seo_keywords"
    t.text     "seo_description"
    t.integer  "comments_count",                                     default: 0,     null: false
    t.integer  "city_id"
    t.string   "seo_title"
    t.string   "slug"
    t.text     "opening_hours",                                      default: [],                 array: true
    t.string   "payment_methods",                                    default: [],                 array: true
    t.string   "company_tags",                                       default: [],                 array: true
    t.datetime "subscribed_until"
    t.integer  "subscription_plan_id"
    t.text     "subscription_stripe_id"
    t.string   "paypal_id"
    t.integer  "clicks",                                             default: 0
    t.datetime "last_click_at"
    t.string   "tags",                                               default: [],                 array: true
    t.string   "deal_url"
    t.datetime "deal_expire_time"
    t.string   "deal_coupon"
    t.index ["category_id"], name: "index_listings_on_category_id", using: :btree
    t.index ["city_id"], name: "index_listings_on_city_id", using: :btree
    t.index ["slug"], name: "index_listings_on_slug", unique: true, using: :btree
    t.index ["subcategory_id"], name: "index_listings_on_subcategory_id", using: :btree
    t.index ["subscription_plan_id"], name: "index_listings_on_subscription_plan_id", using: :btree
    t.index ["user_id"], name: "index_listings_on_user_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "ip"
    t.string   "express_token"
    t.string   "express_payer_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["listing_id"], name: "index_orders_on_listing_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "text"
    t.text     "slider"
    t.string   "slug"
    t.string   "title"
    t.string   "keywords"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["slug"], name: "index_pages_on_slug", unique: true, using: :btree
  end

  create_table "payment_requests", force: :cascade do |t|
    t.integer  "request_type",                            null: false
    t.integer  "state",                                   null: false
    t.decimal  "price",          precision: 10, scale: 2
    t.decimal  "delivery_cost",  precision: 10, scale: 2
    t.string   "payment_method",                          null: false
    t.string   "discount_code"
    t.text     "message"
    t.text     "reply_message"
    t.text     "details"
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["listing_id"], name: "index_payment_requests_on_listing_id", using: :btree
    t.index ["request_type"], name: "index_payment_requests_on_request_type", using: :btree
    t.index ["state"], name: "index_payment_requests_on_state", using: :btree
    t.index ["user_id"], name: "index_payment_requests_on_user_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "last4"
    t.decimal  "amount"
    t.boolean  "success"
    t.string   "authorization_code"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_photos_on_listing_id", using: :btree
  end

  create_table "podcast_episodes", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "small_description"
    t.string   "content"
    t.string   "embedded_podcast"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "preview_podcast"
  end

  create_table "podcast_hosts", force: :cascade do |t|
    t.string   "profile_picture_1"
    t.string   "profile_picture_2"
    t.string   "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "podcast_resources", force: :cascade do |t|
    t.string   "cover_image"
    t.string   "url"
    t.integer  "podcast_episode_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["podcast_episode_id"], name: "index_podcast_resources_on_podcast_episode_id", using: :btree
  end

  create_table "podcast_subscribers", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.string   "featured_home_price"
    t.string   "featured_cat_price"
    t.string   "urgent_price"
    t.string   "company_displayed_30_price"
    t.string   "company_displayed_90_price"
    t.string   "company_displayed_180_price"
    t.string   "company_displayed_365_price"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "currency"
  end

  create_table "regions", force: :cascade do |t|
    t.string  "name"
    t.string  "title"
    t.string  "keywords"
    t.text    "content"
    t.text    "description"
    t.integer "country_id"
    t.index ["country_id"], name: "index_regions_on_country_id", using: :btree
    t.index ["name"], name: "index_regions_on_name", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.string   "keywords"
    t.integer  "category_id"
    t.decimal  "min_price"
    t.decimal  "max_price"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "main_category"
    t.string   "distance"
    t.string   "showonly"
    t.string   "sortby"
    t.string   "car_make"
    t.string   "car_model"
    t.string   "car_age"
    t.string   "car_mileage"
    t.string   "car_engine_size"
    t.string   "property_type"
    t.decimal  "wholesale_min"
    t.decimal  "wholesale_max"
    t.decimal  "retail_min"
    t.decimal  "retail_max"
    t.decimal  "salary_min"
    t.decimal  "salary_max"
    t.float    "longitude"
    t.float    "latitude"
    t.decimal  "sale_min"
    t.decimal  "sale_max"
    t.string   "location"
    t.string   "condition"
    t.integer  "continent_id"
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "city_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "slider_texts", force: :cascade do |t|
    t.string "header"
    t.string "slogan"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.string   "title"
    t.string   "keywords"
    t.text     "description"
    t.text     "content"
    t.index ["category_id"], name: "index_subcategories_on_category_id", using: :btree
    t.index ["slug"], name: "index_subcategories_on_slug", unique: true, using: :btree
  end

  create_table "subscription_coupons", force: :cascade do |t|
    t.string  "name",      null: false
    t.string  "stripe_id"
    t.integer "state",     null: false
    t.float   "discount",  null: false
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string   "period"
    t.decimal  "price",      default: "0.0", null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "stripe_id"
  end

  create_table "support_articles", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "support_topic_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "slug"
    t.string   "title"
    t.string   "keywords"
    t.text     "description"
    t.index ["slug"], name: "index_support_articles_on_slug", unique: true, using: :btree
  end

  create_table "support_topics", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.string   "title"
    t.string   "keywords"
    t.text     "description"
    t.index ["slug"], name: "index_support_topics_on_slug", unique: true, using: :btree
  end

  create_table "templates", force: :cascade do |t|
    t.string   "facebook_link"
    t.string   "twitter_link"
    t.string   "googleplus_link"
    t.string   "youtube_link"
    t.text     "mainpage_slider"
    t.text     "about_slider"
    t.text     "about_text"
    t.text     "contact_details"
    t.text     "feedback_slider"
    t.text     "feedback_text"
    t.text     "support_slider"
    t.text     "footer_text"
    t.text     "safety_text"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "mainpage_benefits"
    t.text     "mainpage_options"
    t.text     "mainpage_featured_in"
    t.text     "global_footer"
    t.text     "how_it_works_text"
    t.text     "trust_and_safety_text"
    t.text     "terms"
    t.text     "privacy"
    t.text     "page_description"
    t.text     "start_selling"
    t.string   "page_title"
    t.string   "page_keywords"
    t.string   "podcast_header_image"
    t.string   "podcast_header_text"
    t.string   "podcast_contact_info"
    t.string   "podcast_newsletter"
    t.string   "podcast_header_menu"
    t.string   "blog_header_menu"
    t.string   "podcast_subscribe_images"
    t.string   "blog_footer"
    t.string   "podcast_footer"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "language"
    t.string   "location"
    t.string   "profile_photo"
    t.string   "cover_photo"
    t.datetime "last_active"
    t.text     "description"
    t.boolean  "receive_new_companies",  default: true
    t.boolean  "receive_new_ads",        default: true
    t.boolean  "receive_updates",        default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "last_seen"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "nomoderation"
    t.string   "cv"
    t.string   "title"
    t.string   "keywords"
    t.string   "slug"
    t.integer  "company_free_available", default: 1
    t.integer  "new_requests_count",     default: 0
    t.integer  "new_replies_count",      default: 0
    t.string   "stripe_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "blog_comments", "blog_posts"
  add_foreign_key "blog_comments", "users"
  add_foreign_key "blog_posts", "blog_subcategories"
  add_foreign_key "cities", "regions"
  add_foreign_key "comments", "users"
  add_foreign_key "countries", "continents"
  add_foreign_key "coupon_codes", "users"
  add_foreign_key "favorite_listings", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "listings", "cities"
  add_foreign_key "listings", "subscription_plans"
  add_foreign_key "listings", "users"
  add_foreign_key "orders", "listings"
  add_foreign_key "payment_requests", "listings"
  add_foreign_key "payment_requests", "users"
  add_foreign_key "photos", "listings"
  add_foreign_key "podcast_resources", "podcast_episodes"
  add_foreign_key "regions", "countries"
  add_foreign_key "subcategories", "categories"
end
