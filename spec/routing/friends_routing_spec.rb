require 'rails_helper'

describe FriendsController do

    describe "routing" do
        it "routes to #new" do
            expect(get: "/friends/new").to route_to("friends#new")
        end

        it "routes to #show" do
            expect(get: "/friends/1").to route_to("friends#show", id: "1")
        end

        it "routes to #edit" do
            expect(get: "/friends/1/edit").to route_to("friends#edit", id: "1")
        end

        it "routes to #create" do
            expect(post: "/friends").to route_to("friends#create")
        end

        it "routes to #update via PUT" do
            expect(put: "/friends/1").to route_to("friends#update", id: "1")
        end

        it "routes to #update via PATCH" do
            expect(patch: "/friends/1").to route_to("friends#update", id: "1")
        end

        it "routes to #destroy" do
            expect(delete: "/friends/1").to route_to("friends#destroy", id: "1")
        end
    end
end