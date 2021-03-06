require 'spec_helper'

describe MediaSetsController do
  render_views
  
  before :all do
    FactoryGirl.create :usage_term
    @user = FactoryGirl.create :user
    @media_set = FactoryGirl.create :media_set, :user => @user
    3.times { @media_set.children << FactoryGirl.create(:media_entry, :user => @user) }
  end
  
  let :session do
    {:user_id => @user.id}
  end
  
  context "fetch a media set with children" do
  
    # done for the splash screen image slideshow
    it "should return a media set with its children with nested images as base64"  do
      get :show, {:format => :json, :id => @media_set.id, :with => {:children => {:type => "media_entries",
                                                                                  :with => {:image => {:as => "base64"}}},
                                                                    :image => {:as => "base64", :size => "small"}}}, session
      json = JSON.parse(response.body)
      json["id"].should == @media_set.id
      json["children"].keys.sort.should == ["media_resources", "pagination"]
      json["children"]["pagination"].keys.sort.should == ["page", "per_page", "total", "total_media_entries", "total_media_sets", "total_pages"]
      json["children"]["media_resources"].each do |child|
        child["id"].blank?.should be_false
        child["image"].blank?.should be_false
      end
    end
  end
end
