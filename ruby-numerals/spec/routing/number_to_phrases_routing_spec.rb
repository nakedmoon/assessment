require "spec_helper"

describe NumberToPhrasesController do
  describe "routing" do

    it "routes to #new" do
      get("/number_to_phrases/new").should route_to("number_to_phrases#new")
    end

    it "routes to #create" do
      post("/number_to_phrases").should route_to("number_to_phrases#create")
    end


  end
end
