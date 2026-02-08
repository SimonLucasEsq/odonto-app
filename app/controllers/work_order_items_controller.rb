class WorkOrderItemsController < ApplicationController
  before_action :set_work_order
  before_action :set_work_order_item, only: %i[ show edit update destroy ]

  def index
    @work_order_items = @work_order.work_order_items
  end

  def show
  end

  def new
    @work_order_item = @work_order.work_order_items.new
  end

  def edit
  end

  def create
    @work_order_item = @work_order.work_order_items.new(work_order_item_params)

    respond_to do |format|
      if @work_order_item.save
        format.html { redirect_to work_order_url(@work_order), notice: "Ítem añadido" }
        format.turbo_stream { flash.now[:notice] = "Ítem añadido" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @work_order_item.update(work_order_item_params)
        format.html { redirect_to work_order_url(@work_order), notice: "Ítem actualizado" }
        format.turbo_stream { flash.now[:notice] = "Ítem actualizado" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work_order_item.destroy!

    respond_to do |format|
      format.html { redirect_to work_order_url(@work_order), notice: "Ítem eliminado" }
      format.turbo_stream { flash.now[:notice] = "Ítem eliminado" }
    end
  end

  private
    def set_work_order
      @work_order = WorkOrder.find(params[:work_order_id])
    end

    def set_work_order_item
      @work_order_item = @work_order.work_order_items.find(params[:id])
    end

    def work_order_item_params
      params.require(:work_order_item).permit(:article_id, :quantity)
    end
end
