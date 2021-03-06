require 'spec_helper'

describe ApplicationHelper do
  describe :titleation do 
    it "should return title format from things" do 
      @title = "About"
      helper.titleation.should eq("About - Bike Index")
    end
  end
  
  describe :nav_link do 
    it "should return the link active if it ought to be" do 
      view.stub(:current_page?).and_return(true)
      generated = '<a href="http://bikeindex.org" class="active">Bike Index blog</a>'
      helper.nav_link("Bike Index blog", "http://bikeindex.org").should eq(generated)
    end
  end

  describe :admin_nav_link do 
    it "should return link, active if it ought to be" do 
      view.stub(:controller_name).and_return("bike_token_invitations")
      generated = '<a href="/invitations" class="">Invitations</a>'
      helper.nav_link("Invitations", "/invitations").should eq(generated)
    end
  end

  describe :content_nav_class do 
    it "Should return active if the section is the active_section" do 
      @active_section = "resources"
      helper.content_nav_class("resources").should eq("active-menu")
    end
  end

end
