require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:article) { create(:article) }

  describe "GET /index" do
    it "returns http success" do
      get articles_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(article.name)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get article_path(article)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(article.name)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_article_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_article_path(article)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates and redirects" do
      expect {
        post articles_path, params: { article: { name: "Nuevo", price: 12.5 } }
      }.to change(Article, :count).by(1)
      expect(response).to redirect_to(articles_path)
    end

    it "responds turbo stream" do
      post articles_path, params: { article: { name: "Nuevo", price: 12.5 } }, as: :turbo_stream
      expect(response).to have_http_status(:success)
      expect(response.body).to include("turbo-stream")
    end
  end

  describe "PATCH /update" do
    it "updates and redirects" do
      patch article_path(article), params: { article: { name: "Editado" } }
      expect(response).to redirect_to(articles_path)
      expect(article.reload.name).to eq("Editado")
    end
  end

  describe "DELETE /destroy" do
    it "deletes and redirects" do
      expect {
        delete article_path(article)
      }.to change(Article, :count).by(-1)
      expect(response).to redirect_to(articles_path)
    end
  end
end
