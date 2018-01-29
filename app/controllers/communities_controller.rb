
class CommunitiesController < ApplicationController

  before_action :set_community, only: [:show, :edit, :update, :destroy]

  # GET /communities
  # GET /communities.json
  def index
    @communities = Community.all
  end

  def add_user
    community = Community.find(params[:id])
    unless community.users.include?(User.find(params[:user_id]))
      community.users << User.find(params[:user_id])
      community.save!
    end
    redirect_to(request.env['HTTP_REFERER'])
  end

  def remove_user
    community = Community.find(params[:id])
    community.users.delete(User.find(params[:user_id]))
    community.save!
    redirect_to(request.env['HTTP_REFERER'])
  end


  # GET /communities/1
  # GET /communities/1.json
  def show
    #@posts = @community.posts
  end

  # GET /communities/new
  def new
    @community = Community.new
  end

  # GET /communities/1/edit
  def edit
  end

  # POST /communities
  # POST /communities.json
  def create
    @community = Community.new(community_params)
    @community.user = current_user

    respond_to do |format|
      if @community.save
        format.html { redirect_to @community, notice: 'Community was successfully created.' }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    respond_to do |format|
      if @community.update(community_params)
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    @community.destroy
    respond_to do |format|
      format.html { redirect_to communities_url, notice: 'Community was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_params
      params.require(:community).permit(:name, :status_id, :banner, :avatar )
    end
    # def community_params
    #   params.require(:community).permit(:name, :status_id, image_attributes:[:banner])
    # end


end
