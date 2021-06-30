class RoleCategoriesController < ApplicationController
  before_action :set_role_category, only: [:show, :edit, :update, :destroy]

  # GET /role_categories
  def index
    @role_categories = RoleCategory.all
  end

  # GET /role_categories/1
  def show
  end

  # GET /role_categories/new
  def new
    @role_category = RoleCategory.new
  end

  # GET /role_categories/1/edit
  def edit
  end

  # POST /role_categories
  def create
    @role_category = RoleCategory.new(role_category_params)

    if @role_category.save
      redirect_to @role_category, notice: 'Role category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /role_categories/1
  def update
    if @role_category.update(role_category_params)
      redirect_to @role_category, notice: 'Role category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /role_categories/1
  def destroy
    @role_category.destroy
    redirect_to role_categories_url, notice: 'Role category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_category
      @role_category = RoleCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_category_params
      params.require(:role_category).permit(:name, :description)
    end
end
