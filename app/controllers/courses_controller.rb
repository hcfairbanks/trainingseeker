class CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :set_course, only: [:show, :buy, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    if !params[:geocomplete].blank?
      if !params[:course_name_id].blank? && params[:course_name_id] != "All"
        @course_name_id, @alias_id = params[:course_name_id].split(':')
        @search_selection = params[:course_name_id]
        @courses = @courses.where(courses:{course_name_id: @course_name_id})
      end

      if params[:availability].blank?
        @courses = @courses.where("availability > 0")
      else
        @courses = @courses.where("availability >= #{params[:availability].to_i}")
      end

      @courses = @courses.where("start_date > '#{Date.current.to_s }'")

      @courses = @courses.where(courses:{provider_id: params[:provider_id]}) if !params[:provider_id].blank? && params[:provider_id] !="ALL"
      @search_provider_selection = params[:provider_id]if !params[:provider_id].blank? && params[:provider_id] !="ALL"

      params[:province] = params[:province].gsub("%20"," ") if !params[:province].blank? && params[:province] !="ALL"
      @courses = @courses.where(courses:{province: params[:province]}) if !params[:province].blank? && params[:province] !="ALL"

      @start_date = Date.strptime(params[:start_date], "%m/%d/%Y") if !params[:start_date].blank?
      @end_date = Date.strptime(params[:end_date], "%m/%d/%Y") if !params[:end_date].blank?

      @courses = @courses.where(courses:{start_date: @start_date}) if !params[:start_date].blank? && params[:end_date].blank?
      @courses = @courses.where(courses:{start_date: @start_date..@end_date }) if !params[:start_date].blank? && !params[:end_date].blank?

      @start_date = @start_date.strftime("%m/%d/%Y") if !params[:start_date].blank?
      @end_date = @end_date.strftime("%m/%d/%Y") if !params[:end_date].blank?

      @courses = @courses.where(courses:{city: params[:city]}) if !params[:city].blank? && params[:city] !="All"

      @min_price = params[:min_price].to_f if !params[:min_price].blank?
      @max_price = params[:max_price].to_f if !params[:max_price].blank?

      @courses = @courses.where(courses:{price_in_cents: (@min_price * 100)..(@max_price * 100) }) if @min_price && @max_price
      @courses = @courses.where(courses:{price_in_cents: 1..(@max_price * 100) }) if @min_price.nil? && @max_price
      @courses = @courses.where(courses:{price_in_cents: (@min_price * 100)..999999999 }) if @min_price && @max_price.nil?


      order_options = {
        latest: "start_date DESC",
        oldest: "start_date ASC",
        highest_price: "price_in_cents DESC",
        lowest_price: "price_in_cents ASC"
      }
      @courses = @courses.order(order_options[params[:order_by].to_sym]) if !params[:order_by].blank?
      @courses = @courses.includes(:provider, :course_name, :photos).paginate(page: params[:page], per_page: 10)


      @province_selector = "<select name='province' id=''  style='width:200px;' disabled='true'>"
      provinces = ['Alberta','British Columbia','Manitoba','New Brunswick','Newfoundland and Labrador','Nova Scotia','Ontario',
            'Prince Edward Island','Québec','Saskatchewan','Northwest Territories','Nunavut',
            'Yukon']
      options = "<option value='ALL'>All</option>"
      provinces.each do | province |
        options = options +"<option value='#{province}' #{'selected'if province == params[:province] }>#{province}</option>"
      end
      @province_selector += options + "</select>"
      @province = params[:province]

      if params[:viewport]
        viewport = params[:viewport].split(',')
        viewport_floats = []
        viewport.each do | grid |
          viewport_floats.push( grid.to_f )
        end
        @courses = @courses.where(longitude: viewport_floats[1]..viewport_floats[3]) if !params[:viewport].blank? && params[:city].blank?
        @courses = @courses.where(latitude: viewport_floats[0]..viewport_floats[2]) if !params[:viewport].blank? && params[:city].blank?
      end
    else
      #TODO ZERO ALL VARIABLES
      #TODO Zero variables in the JS too

    end
    @courses = @courses.paginate(page: params[:page], per_page: 10)

      if params[:searched]== "true"
        @searched = "true";
        @adv_searched = "block"
      else
        @searched = "false";
        @adv_searched = "none"
      end


  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @purchase = Purchase.new
    @purchase.seats.build
    set_years
  end

  def buy
    @purchase = @course.purchases.new(purchase_params.merge!(user_id: current_user.id))

    respond_to do |format|
      if @purchase.save
        if @purchase.status == "succeeded"
          format.html { redirect_to @purchase, notice: 'Purchase was successfully made.' }
          format.json { render json: @purchase, status: :created }
        else
          error_msg = @purchase.full_response
          @purchase = @course.purchases.new(@purchase.attributes)
          set_years
          flash[:notice] = "Purchase error - #{error_msg}"
          format.html { render template: 'courses/show' }
          format.json { render json: @purchase, status: :created }
        end
      else
        if @purchase.seats.empty?
          @purchase.seats.build
        end
        set_years
        format.html { render template: 'courses/show' }
        format.json { render json: @purchase.errors, status: :created }
      end
    end
  end


  # GET /courses/new
  def new
    @disabled="true"

    @lat_and_lng = "<div id='test1'>46.081852761150344</div>
    <div id='test2'>-64.79354271875002</div>
    <input id='test3' type='text' value='46.081852761150344'>
    <input id='test4' type='text' value='46.081852761150344'> "


    @course = Course.new
    @province_selector = "<select name='course[province]' id='administrative_area_level_1' class='' style='width:200px;' disabled='#{@disabled}' required>"
    @province_selector += "<option value=”” disabled selected>Select a province</option>"
    @provinces = ['Alberta','British Columbia','Manitoba','New Brunswick','Newfoundland and Labrador','Nova Scotia','Ontario',
          'Prince Edward Island','Québec','Saskatchewan','Northwest Territories','Nunavut',
          'Yukon']
    options = ""
    @provinces.each do | province |
      options = options +"<option value='#{province}'>#{province}</option>"
    end
    @province_selector = @province_selector + options + "</select>"
  end

  # GET /courses/1/edit
  def edit

    @latitude = "<input id='course[latitude]' name='course[latitude]' type='text' value='#{@course.latitude}'>"
    @longitude = "<input id='course[longitude]' name='course[longitude]' type='text' value='#{@course.longitude}'>"

    @province_selector = "<select name='course[province]' id='administrative_area_level_1' class='' style='width:200px;' onchange='get_city_names(this.value)'>"
    @provinces = ['Alberta','British Columbia','Manitoba','New Brunswick','Newfoundland and Labrador','Nova Scotia','Ontario',
          'Prince Edward Island','Québec','Saskatchewan','Northwest Territories','Nunavut',
          'Yukon']
    options = ""
    @provinces.each do | province |
      options = options +"<option value='#{province}' #{'selected'if province == @course.province }>#{province}</option>"
    end
    @province_selector = @province_selector + options + "</select>"

  end

  # POST /courses
  # POST /courses.json
  def create
    if course_params[:provider_id]
      authorize! :assign_provider, @course
      @course = Course.new(course_params)
    else
      @course = Course.new(course_params.merge(provider_id: current_user.provider_id))
    end

    if course_params[:course_name_id]
      course_name = CourseName.find(course_params[:course_name_id])
    end

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    if course_params[:provider_id]
      authorize! :assign_provider, @course
    end

    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def set_years
      @years = []
      @years.push(current_year = Date.today.strftime("%y").to_i)
      (1..5).each do
        @years.push(current_year+=1)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit( :card_name,
                                       :course_id,
                                       :credit_card_number,
                                       :expiry_month,
                                       :expiry_year,
                                       :cvd,
                                       seats_attributes: [
                                         :first_name, :middle_name, :last_name, :email, :phone
                                       ])
    end

    def course_params
      params.require(:course).permit( :availability,
                                      :start_date,
                                      :end_date,
                                      :start_time,
                                      :price,
                                      :city,
                                      :province,
                                      :address_line_1,
                                      :address_line_2,
                                      :postal_code,
                                      :provider_id,
                                      :avatar,
                                      :course_name_id,
                                      :latitude,
                                      :longitude,
                                      photos_attributes:[:pic]
                                      )
    end
end

#
# @posts = create_query
#
#
# def create_query
#   communities = current_user.communities.collect(&:id)
#   friends = { posts:{ user_id: current_user.friendships.collect(&:friend_id) } }
#   post = Post.joins(:multiposts).where( multiposts: { community_id: [communities]})
#   post = search_options(post)
#   friends_data = Post.joins(:multiposts).
#                             where( multiposts: { community_id: Community::GLOBAL_COMMUNITY}).
#                             where(friends)
#   friends_data = search_options(friends_data)
#   post = post.or(friends_data).group(:id)
#   post = params[:order_by].blank? ? post.order("created_at DESC") : post.order(order_querry(params[:order_by].to_sym))
#   #post = post.limit(100). # I dont think I should have this here
#   post = post.paginate(page: params[:page], per_page: 10) # Should I have an option for this ?
# end
#
#
#
# def search_options(search_model)
#   search_model = search_model.where( posts:{ price: params[:min_price]..params[:max_price]} ) if !params[:min_price].blank? && !params[:max_price].blank?
#   search_model = search_model.where( posts:{ price: Post::MIN_PRICE..params[:max_price]} ) if params[:min_price].blank? && !params[:max_price].blank?
#   search_model = search_model.where( posts:{ price: params[:min_price]..Post::MAX_PRICE} ) if !params[:min_price].blank? && params[:max_price].blank?
#
#   end_date = DateTime.now
#   start_date = Date.today - Post::MAX_DAYS_SEARCH.days
#   if !params[:start_date].blank? && !params[:end_date].blank?
#     start_date = params[:start_date].to_date
#     end_date = params[:end_date].to_date
#   elsif !params[:start_date].blank? && params[:end_date].blank?
#     start_date = params[:start_date].to_date
#   elsif params[:start_date].blank? && !params[:end_date].blank?
#     end_date = params[:end_date].to_date
#   end
#   search_model = search_model.where( posts:{ created_at:  start_date..end_date} )
#   search_model = search_model.where( "posts.content like :querry",querry: "%#{params[:content]}%" ) if !params[:content].blank?
#   search_model = search_model.where( "posts.title like :querry",querry: "%#{params[:title]}%" ) if !params[:title].blank?
#   search_model
# end
#
# def order_querry(order_by)
#   # Not sure if this should be it's own function or not ?
#   order_options = {
#     latest: "created_at DESC",
#     oldest: "created_at ASC",
#     title: "title ASC",
#     content: "content ASC",
#     highest_price: "price DESC",
#     lowest_price: "price ASC"
#   }
#
#   order_options[order_by]
#
# end
