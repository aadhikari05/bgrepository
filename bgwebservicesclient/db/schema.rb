# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091112202738) do

  create_table "alternate_names", :force => true do |t|
    t.integer "feature_id", :limit => 11
    t.string  "name"
  end

  add_index "alternate_names", ["feature_id"], :name => "index_alternate_names_on_feature_id"
  add_index "alternate_names", ["name"], :name => "index_alternate_names_on_name"

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id",   :limit => 11
    t.string   "auditable_type"
    t.integer  "user_id",        :limit => 11
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "changes"
    t.integer  "version",        :limit => 11, :default => 0
    t.datetime "created_at"
  end

  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"

  create_table "bgfips", :primary_key => "newid", :force => true do |t|
    t.string  "ID",               :limit => 10
    t.string  "Feature_id",       :limit => 10
    t.string  "FIPS_st_cd",       :limit => 10
    t.string  "FIPS_place_cd",    :limit => 10
    t.string  "Feat_class",       :limit => 25
    t.string  "FIPS_class",       :limit => 25
    t.string  "Feat_name",        :limit => 100
    t.string  "Alt_Feat_name",    :limit => 100
    t.string  "State_alpha",      :limit => 4
    t.string  "State_name",       :limit => 25
    t.integer "County_seq",       :limit => 11
    t.string  "FIPS_county_cd",   :limit => 10
    t.string  "County_name_full", :limit => 100
    t.string  "County_name",      :limit => 100
    t.float   "Primary_lat"
    t.float   "Primary_lon"
    t.string  "URL_Local",        :limit => 200
    t.string  "URL_County",       :limit => 200
  end

  add_index "bgfips", ["Feat_name", "State_name"], :name => "featandstate"
  add_index "bgfips", ["State_name"], :name => "stateonly"
  add_index "bgfips", ["State_alpha"], :name => "statealpha"
  add_index "bgfips", ["ID"], :name => "bgfips_id"
  add_index "bgfips", ["County_name"], :name => "bgfips_county"
  add_index "bgfips", ["County_name_full"], :name => "bgfips_county_full"

  create_table "business_categories", :force => true do |t|
    t.string "name"
  end

  create_table "feature_recommended_site", :id => false, :force => true do |t|
    t.integer "feature_recommended_site_id", :limit => 11
    t.integer "feature_id",                  :limit => 11
  end

  add_index "feature_recommended_site", ["feature_id"], :name => "index_feature_recommended_sites_on_fid"

  create_table "feature_recommended_site_keywords", :force => true do |t|
    t.integer "feature_recommended_site_id", :limit => 11
    t.string  "keywords",                    :limit => 250
  end

  add_index "feature_recommended_site_keywords", ["id"], :name => "index_frs_on_id"
  add_index "feature_recommended_site_keywords", ["keywords"], :name => "index_frs_keywords"

  create_table "feature_recommended_sites", :force => true do |t|
    t.string  "title",       :limit => 550
    t.string  "description", :limit => 700
    t.integer "category_id", :limit => 10
    t.string  "master_term", :limit => 700
    t.integer "orders",      :limit => 10
    t.string  "url",         :limit => 500
  end

  create_table "features", :force => true do |t|
    t.integer "state_id",         :limit => 11
    t.string  "fips_id"
    t.string  "fips_feat_id"
    t.string  "fips_st_cd"
    t.string  "fips_place_cd"
    t.string  "feat_class"
    t.string  "fips_class"
    t.string  "feat_name"
    t.integer "county_seq",       :limit => 11
    t.string  "fips_county_cd"
    t.string  "county_name_full"
    t.string  "county_name"
    t.float   "primary_lat"
    t.float   "primary_lon"
    t.boolean "majorfeature",                   :default => false
  end

  add_index "features", ["state_id"], :name => "index_features_on_state_id"
  add_index "features", ["fips_place_cd"], :name => "features_fips_place"
  add_index "features", ["fips_st_cd"], :name => "features_fips_st"
  add_index "features", ["id"], :name => "featureid"
  add_index "features", ["feat_name"], :name => "index_feature_featname"
  add_index "features", ["feat_name", "fips_class", "county_seq"], :name => "feat_name_general"

  create_table "grant_loan_state", :id => false, :force => true do |t|
    t.integer "grant_loan_id", :limit => 10, :null => false
    t.integer "state_id",      :limit => 10, :null => false
  end

  create_table "grant_loans", :force => true do |t|
    t.string  "gov_type",           :limit => 50
    t.integer "state_id",           :limit => 10
    t.string  "state_name",         :limit => 50
    t.string  "loan_type",          :limit => 45
    t.string  "agency",             :limit => 200
    t.string  "url",                :limit => 600, :null => false
    t.string  "title",              :limit => 400, :null => false
    t.string  "description",        :limit => 600, :null => false
    t.string  "business_type",      :limit => 150
    t.integer "is_general_purpose", :limit => 10
    t.integer "is_development",     :limit => 10
    t.integer "is_exporting",       :limit => 10
    t.integer "is_contractor",      :limit => 10
    t.integer "is_green",           :limit => 10
    t.integer "is_military",        :limit => 10
    t.integer "is_minority",        :limit => 10
    t.integer "is_woman",           :limit => 10
    t.integer "is_disabled",        :limit => 10
    t.integer "is_rural",           :limit => 10
    t.integer "is_disaster",        :limit => 10
  end

  add_index "grant_loans", ["url"], :name => "index_grant_loans_on_url"
  add_index "grant_loans", ["title"], :name => "index_grant_loans_on_title"
  add_index "grant_loans", ["description"], :name => "index_grant_loans_on_description"

  create_table "grant_loans_industry", :id => false, :force => true do |t|
    t.string "industry_id",    :limit => 50
    t.string "grant_loans_id", :limit => 50
  end

  create_table "industries", :force => true do |t|
    t.string "name", :limit => 45
  end

  create_table "keyword_recommended_site_keywords", :force => true do |t|
    t.integer "keyword_recommended_site_id", :limit => 11
    t.string  "keywords",                    :limit => 250
  end

  add_index "keyword_recommended_site_keywords", ["id"], :name => "index_krs_on_id"
  add_index "keyword_recommended_site_keywords", ["keywords"], :name => "index_krs_keywords"

  create_table "keyword_recommended_sites", :force => true do |t|
    t.string  "title",       :limit => 550
    t.string  "description", :limit => 700
    t.integer "category_id", :limit => 10
    t.string  "master_term", :limit => 700
    t.integer "orders",      :limit => 11
    t.string  "url",         :limit => 500
  end

  create_table "keywords", :force => true do |t|
    t.string  "name"
    t.integer "business_category_id", :limit => 11
  end

  add_index "keywords", ["business_category_id"], :name => "index_keywords_on_business_category_id"

  create_table "oldzips2", :id => false, :force => true do |t|
    t.string  "zip",          :limit => 5
    t.string  "city",         :limit => 25
    t.integer "seq",          :limit => 11
    t.string  "usps_primary", :limit => 1
    t.integer "fips_state",   :limit => 2
    t.integer "fipscity",     :limit => 2
  end

  add_index "oldzips2", ["fips_state", "fipscity"], :name => "oldzip2_codes"

  create_table "parsed_files", :force => true do |t|
    t.string   "file_name",  :limit => 100
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permitme_categories", :force => true do |t|
    t.string "name", :limit => 50
  end

  create_table "permitme_resource_groups", :force => true do |t|
    t.text    "description"
    t.integer "state_id",                :limit => 11
    t.integer "permitme_category_id",    :limit => 11
    t.integer "permitme_subcategory_id", :limit => 11
    t.integer "permitme_section_id",     :limit => 11
    t.integer "old_id",                  :limit => 11
  end

  add_index "permitme_resource_groups", ["state_id"], :name => "pmrg_state_id"

  create_table "permitme_resources", :force => true do |t|
    t.integer "permitme_resource_group_id", :limit => 11
    t.integer "old_id",                     :limit => 11
    t.string  "URL",                        :limit => 200
    t.string  "Link_Title",                 :limit => 200
    t.text    "Link_Description"
  end

  add_index "permitme_resources", ["permitme_resource_group_id"], :name => "pmr_group_id"

  create_table "permitme_sections", :force => true do |t|
    t.string "name", :limit => 50
  end

  create_table "permitme_sites", :force => true do |t|
    t.string  "description", :limit => 250
    t.string  "name"
    t.string  "url"
    t.integer "feature_id",  :limit => 11
  end

  add_index "permitme_sites", ["feature_id"], :name => "index_site_filters_on_feature_id"

  create_table "permitme_subcategories", :force => true do |t|
    t.string  "name",        :limit => 50
    t.boolean "isExclusive"
    t.boolean "isActive"
  end

  add_index "permitme_subcategories", ["isExclusive"], :name => "pmsubcat_exclusive"

  create_table "query_cases", :force => true do |t|
    t.string  "query"
    t.integer "state_id",             :limit => 11
    t.string  "county"
    t.string  "city"
    t.integer "business_category_id", :limit => 11
  end

  add_index "query_cases", ["state_id"], :name => "index_query_cases_on_state_id"
  add_index "query_cases", ["business_category_id"], :name => "index_query_cases_on_business_category_id"

  create_table "recommended_site", :primary_key => "recommended_id", :force => true do |t|
    t.string "title",       :limit => 550
    t.string "description", :limit => 700
    t.string "keywords",    :limit => 700
    t.string "category",    :limit => 700
    t.string "master_term", :limit => 700
    t.string "locations",   :limit => 700
  end

  add_index "recommended_site", ["keywords"], :name => "index_recommended_site_on_keywords"

  create_table "recommended_site_categories", :force => true do |t|
    t.string "name", :limit => 45, :null => false
  end

  create_table "recommended_site_features", :force => true do |t|
    t.integer "recommended_site_id", :limit => 10
    t.integer "feature_id",          :limit => 10
  end

  create_table "recommended_site_states", :force => true do |t|
    t.integer "recommended_site_id", :limit => 10
    t.integer "state_id",            :limit => 10
  end

  create_table "recommended_site_url", :force => true do |t|
    t.integer "recommended_site_id", :limit => 10,  :null => false
    t.integer "orders",              :limit => 10
    t.string  "url",                 :limit => 500, :null => false
  end

  add_index "recommended_site_url", ["url"], :name => "index_recommended_site_url_on_url"

  create_table "site_filters", :force => true do |t|
    t.string  "description", :limit => 250
    t.string  "name"
    t.string  "url"
    t.integer "feature_id",  :limit => 11
  end

  add_index "site_filters", ["feature_id"], :name => "index_site_filters_on_feature_id"

  create_table "sites", :force => true do |t|
    t.string  "description", :limit => 250
    t.string  "name"
    t.string  "url"
    t.integer "feature_id",  :limit => 11
    t.boolean "is_primary"
  end

  add_index "sites", ["feature_id"], :name => "index_site_filters_on_feature_id"

  create_table "state_recommended_site_keywords", :force => true do |t|
    t.integer "state_recommended_site_id", :limit => 11
    t.string  "keywords",                  :limit => 250
  end

  add_index "state_recommended_site_keywords", ["id"], :name => "index_srs_on_id"
  add_index "state_recommended_site_keywords", ["keywords"], :name => "index_srs_keywords"

  create_table "state_recommended_sites", :force => true do |t|
    t.string  "title",       :limit => 550
    t.string  "description", :limit => 700
    t.integer "category_id", :limit => 10
    t.string  "master_term", :limit => 700
    t.integer "state_id",    :limit => 10
    t.integer "orders",      :limit => 11
    t.string  "url",         :limit => 500
  end

  add_index "state_recommended_sites", ["title"], :name => "states_ids"

  create_table "states", :force => true do |t|
    t.string "name",           :limit => 25
    t.string "alpha",          :limit => 2
    t.string "csbe",           :limit => 40
    t.string "alt_state_name"
  end

  add_index "states", ["alpha"], :name => "index_states_on_alpha", :unique => true
  add_index "states", ["name"], :name => "index_states_on_name", :unique => true
  add_index "states", ["alt_state_name"], :name => "index_states_on_alt_name"

  create_table "temp_duplicate_county_urls", :force => true do |t|
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "zipcodes", :force => true do |t|
    t.string  "zip",          :limit => 5
    t.integer "sequence",     :limit => 11
    t.string  "usps_primary", :limit => 1
    t.integer "feature_id",   :limit => 11
  end

  add_index "zipcodes", ["feature_id"], :name => "index_zipcodes_on_feature_id"
  add_index "zipcodes", ["zip"], :name => "newzipsindex"
  add_index "zipcodes", ["sequence"], :name => "zipcodesseq"

  create_table "zipcodes2", :force => true do |t|
    t.string  "zip",          :limit => 5
    t.integer "sequence",     :limit => 11
    t.string  "usps_primary", :limit => 1
    t.integer "feature_id",   :limit => 11
  end

  create_table "zips2", :force => true do |t|
    t.string  "zip",          :limit => 5
    t.integer "seq",          :limit => 11
    t.string  "city",         :limit => 25
    t.string  "feat_name"
    t.string  "usps_primary", :limit => 1
  end

end
