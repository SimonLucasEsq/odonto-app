require 'rails_helper'

RSpec.describe "WorkOrderItems", type: :request do
  let(:work_order) { create(:work_order) }
  let(:article) { create(:article) }
  let(:work_order_item) { create(:work_order_item, work_order: work_order, article: article) }

  describe "GET /new" do
    it "returns a successful response" do
      get new_work_order_work_order_item_path(work_order)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new WorkOrderItem" do
        expect do
          post work_order_work_order_items_path(work_order), params: { work_order_item: { article_id: article.id, quantity: 5 } }
        end.to change(work_order.work_order_items, :count).by(1)
      end

      it "redirects to the work_order show page" do
        post work_order_work_order_items_path(work_order), params: { work_order_item: { article_id: article.id, quantity: 5 } }
        expect(response).to redirect_to(work_order_url(work_order))
      end

      it "responds with turbo stream on success" do
        post work_order_work_order_items_path(work_order), params: { work_order_item: { article_id: article.id, quantity: 5 } }, as: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response.content_type).to include "text/vnd.turbo-stream.html"
        expect(response.body).to include("target=\"work_order_items\"")
        expect(response.body).to include("target=\"new_work_order_item_form\"")
      end
    end

    context "with invalid parameters" do
      it "does not create a new WorkOrderItem" do
        expect do
          post work_order_work_order_items_path(work_order), params: { work_order_item: { article_id: nil, quantity: nil } }
        end.to_not change(work_order.work_order_items, :count)
      end

      it "renders a response with 422 status (new template)" do
        post work_order_work_order_items_path(work_order), params: { work_order_item: { article_id: nil, quantity: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Agregar")
      end

      it "responds with turbo stream on failure" do
        post work_order_work_order_items_path(work_order), params: { work_order_item: { article_id: nil, quantity: nil } }, as: :turbo_stream
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include "text/vnd.turbo-stream.html"
        expect(response.body).to include("target=\"form_update\"")
      end
    end
  end

  describe "GET /edit" do
    it "returns a successful response" do
      get edit_work_order_work_order_item_path(work_order, work_order_item)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_article) { create(:article, name: "Updated Article", price: 15.0) }
      let(:new_attributes) { { article_id: new_article.id, quantity: 10 } }

      it "updates the requested work_order_item" do
        patch work_order_work_order_item_path(work_order, work_order_item), params: { work_order_item: new_attributes }
        work_order_item.reload
        expect(work_order_item.article).to eq(new_article)
        expect(work_order_item.quantity).to eq(10)
      end

      it "redirects to the work_order show page" do
        patch work_order_work_order_item_path(work_order, work_order_item), params: { work_order_item: new_attributes }
        expect(response).to redirect_to(work_order_url(work_order))
      end

      it "responds with turbo stream on success" do
        patch work_order_work_order_item_path(work_order, work_order_item), params: { work_order_item: new_attributes }, as: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response.content_type).to include "text/vnd.turbo-stream.html"
        expect(response.body).to include(dom_id(work_order_item))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (edit template)" do
        patch work_order_work_order_item_path(work_order, work_order_item), params: { work_order_item: { article_id: nil, quantity: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Editing work order item")
      end

      it "responds with turbo stream on failure" do
        patch work_order_work_order_item_path(work_order, work_order_item), params: { work_order_item: { article_id: nil, quantity: nil } }, as: :turbo_stream
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include "text/vnd.turbo-stream.html"
        expect(response.body).to include("target=\"form_update\"")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested work_order_item" do
      work_order_item # ensure work_order_item is created
      expect do
        delete work_order_work_order_item_path(work_order, work_order_item)
      end.to change(work_order.work_order_items, :count).by(-1)
    end

    it "redirects to the work_order show page" do
      delete work_order_work_order_item_path(work_order, work_order_item)
      expect(response).to redirect_to(work_order_url(work_order))
    end

    it "responds with turbo stream on success" do
      delete work_order_work_order_item_path(work_order, work_order_item), as: :turbo_stream
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include "text/vnd.turbo-stream.html"
      expect(response.body).to include("action=\"remove\"")
    end
  end
end
