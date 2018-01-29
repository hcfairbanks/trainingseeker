class PurchasesController < ApplicationController
  load_and_authorize_resource
  before_action :set_purchase, only: [:show]

  def index
    @purchases = scope.all.includes(course: [:course_name])
  end

  def show
    @purchase = scope.find(params[:id])
  end

  private

  def scope
    if current_user.is_site_admin?
      Purchase
    else
      current_user.purchases
    end
  end

  def set_purchase
    @purchase = scope.find(params[:id])
  end
end
