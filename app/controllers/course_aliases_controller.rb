class CourseAliasesController < ApplicationController
  load_and_authorize_resource
  before_action :set_course_alias, only: [:show, :edit, :update, :destroy]

  # GET /course_aliases
  # GET /course_aliases.json
  def index
    @course_aliases = CourseAlias.all
  end

  # GET /course_aliases/1
  # GET /course_aliases/1.json
  def show
  end

  # GET /course_aliases/new
  def new
    @course_alias = CourseAlias.new
  end

  # GET /course_aliases/1/edit
  def edit
  end

  # POST /course_aliases
  # POST /course_aliases.json
  def create
    @course_alias = CourseAlias.new(course_alias_params)

    respond_to do |format|
      if @course_alias.save
        format.html { redirect_to @course_alias, notice: 'Course alias was successfully created.' }
        format.json { render :show, status: :created, location: @course_alias }
      else
        format.html { render :new }
        format.json { render json: @course_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_aliases/1
  # PATCH/PUT /course_aliases/1.json
  def update
    respond_to do |format|
      if @course_alias.update(course_alias_params)
        format.html { redirect_to @course_alias, notice: 'Course alias was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_alias }
      else
        format.html { render :edit }
        format.json { render json: @course_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_aliases/1
  # DELETE /course_aliases/1.json
  def destroy
    @course_alias.destroy
    respond_to do |format|
      format.html { redirect_to course_aliases_url, notice: 'Course alias was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_alias
      @course_alias = CourseAlias.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_alias_params
      params.require(:course_alias).permit(:course_alias, :course_name_id)
    end
end
