require "rails_helper"

RSpec.describe TvShowsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tv_shows").to route_to("tv_shows#index")
    end

    it "routes to #new" do
      expect(get: "/tv_shows/new").to route_to("tv_shows#new")
    end

    it "routes to #show" do
      expect(get: "/tv_shows/1").to route_to("tv_shows#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/tv_shows/1/edit").to route_to("tv_shows#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/tv_shows").to route_to("tv_shows#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tv_shows/1").to route_to("tv_shows#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tv_shows/1").to route_to("tv_shows#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tv_shows/1").to route_to("tv_shows#destroy", id: "1")
    end
  end
end
