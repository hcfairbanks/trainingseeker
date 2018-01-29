class StaticPagesController < ApplicationController

  # def home
  #
  #   @courses = Course.all
  #
  #   if !params[:course_name_id].blank? && params[:course_name_id] != "All"
  #     @course_name_id, @alias_id = params[:course_name_id].split(':')
  #     @search_selection = params[:course_name_id]
  #     @courses = @courses.where(courses:{course_name_id: @course_name_id})
  #   end
  #
  #   if params[:availability].blank?
  #     @courses = @courses.where("availability > 0")
  #   else
  #     @courses = @courses.where("availability >= #{params[:availability].to_i}")
  #   end
  #
  #   @courses = @courses.where("start_date > '#{Date.current.to_s }'")
  #
  #   @courses = @courses.where(courses:{provider_id: params[:provider_id]}) if !params[:provider_id].blank? && params[:provider_id] !="ALL"
  #   @search_provider_selection = params[:provider_id]if !params[:provider_id].blank? && params[:provider_id] !="ALL"
  #
  #   params[:province] = params[:province].gsub("%20"," ") if !params[:province].blank? && params[:province] !="ALL"
  #   @courses = @courses.where(courses:{province: params[:province]}) if !params[:province].blank? && params[:province] !="ALL"
  #
  #   @start_date = Date.strptime(params[:start_date], "%m/%d/%Y") if !params[:start_date].blank?
  #   @end_date = Date.strptime(params[:end_date], "%m/%d/%Y") if !params[:end_date].blank?
  #
  #   @courses = @courses.where(courses:{start_date: @start_date}) if !params[:start_date].blank? && params[:end_date].blank?
  #   @courses = @courses.where(courses:{start_date: @start_date..@end_date }) if !params[:start_date].blank? && !params[:end_date].blank?
  #
  #   @start_date = @start_date.strftime("%m/%d/%Y") if !params[:start_date].blank?
  #   @end_date = @end_date.strftime("%m/%d/%Y") if !params[:end_date].blank?
  #
  #   @courses = @courses.where(courses:{city: params[:city]}) if !params[:city].blank? && params[:city] !="All"
  #
  #   @min_price = params[:min_price].to_f if !params[:min_price].blank?
  #   @max_price = params[:max_price].to_f if !params[:max_price].blank?
  #
  #   @courses = @courses.where(courses:{price_in_cents: (@min_price * 100)..(@max_price * 100) }) if @min_price && @max_price
  #   @courses = @courses.where(courses:{price_in_cents: 1..(@max_price * 100) }) if @min_price.nil? && @max_price
  #   @courses = @courses.where(courses:{price_in_cents: (@min_price * 100)..999999999 }) if @min_price && @max_price.nil?
  #
  #
  #   order_options = {
  #     latest: "start_date DESC",
  #     oldest: "start_date ASC",
  #     highest_price: "price_in_cents DESC",
  #     lowest_price: "price_in_cents ASC"
  #   }
  #   @courses = @courses.order(order_options[params[:order_by].to_sym]) if !params[:order_by].blank?
  #   @courses = @courses.includes(:provider, :course_name, :photos).paginate(page: params[:page], per_page: 10)
  #
  #
  #   @province_selector = "<select name='province' id=''  style='width:200px;' disabled='true'>"
  #   provinces = ['Alberta','British Columbia','Manitoba','New Brunswick','Newfoundland and Labrador','Nova Scotia','Ontario',
  #         'Prince Edward Island','Québec','Saskatchewan','Northwest Territories','Nunavut',
  #         'Yukon']
  #   options = "<option value='ALL'>All</option>"
  #   provinces.each do | province |
  #     options = options +"<option value='#{province}' #{'selected'if province == params[:province] }>#{province}</option>"
  #   end
  #   @province_selector += options + "</select>"
  #   @province = params[:province]
  #
  #   if params[:viewport]
  #     viewport = params[:viewport].split(',')
  #     viewport_floats = []
  #     viewport.each do | grid |
  #       viewport_floats.push( grid.to_f )
  #     end
  #     @courses = @courses.where(longitude: viewport_floats[1]..viewport_floats[3]) if !params[:viewport].blank? && params[:city].blank?
  #     @courses = @courses.where(latitude: viewport_floats[0]..viewport_floats[2]) if !params[:viewport].blank? && params[:city].blank?
  #     @courses = @courses.paginate(page: params[:page], per_page: 10)
  #   end
  #
  #   if params[:searched]== "true"
  #     @searched = "true";
  #     @adv_searched = "block"
  #   else
  #     @searched = "false";
  #     @adv_searched = "none"
  #   end
  #
  # end

  def aboutus
  end

  def providerfaq
  end

  def register # Devise
  end

  def login # Devise
  end

  def create_contact
    redirect_to('/contact')
  end

  def contact

    if params[:contact]
      Contact.create(contact_params)
    end
    @contact = Contact.new
  end

  def opportunity
  end

  def partner
  end

  def beta
  end

  def contact_params
    params.require(:contact).permit(:name,:company_name,:email,:phone,:comment)
  end

  def landing
  end

end
