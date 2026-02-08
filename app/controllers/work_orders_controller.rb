class WorkOrdersController < ApplicationController
  before_action :set_work_order, only: %i[ show edit update destroy ]

  def index
    @work_orders = WorkOrder.order(created_at: :desc)
    @work_order = WorkOrder.new(status: :draft)
  end

  def new
    @work_order = WorkOrder.new(status: :draft)
  end

  def show
    @work_order_item = @work_order.work_order_items.new
    @articles = Article.order(:name)
  end

  def create
    @work_order = WorkOrder.new(work_order_params)
    @work_orders = WorkOrder.order(created_at: :desc)

    respond_to do |format|
      if @work_order.save
        format.html { redirect_to work_order_url(@work_order), notice: "Orden creada" }
        format.turbo_stream
      else
        format.html { render :index, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @work_order.update(work_order_params)
        format.html { redirect_to work_order_url(@work_order), notice: "Orden actualizada" }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work_order.destroy!

    respond_to do |format|
      format.html { redirect_to work_orders_url, notice: "Orden eliminada" }
      format.turbo_stream
    end
  end

  private

  def set_work_order
    @work_order = WorkOrder.find(params[:id])
  end

  def work_order_params
    params.require(:work_order).permit(:status)
  end
end
