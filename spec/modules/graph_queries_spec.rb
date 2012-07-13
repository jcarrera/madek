require 'spec_helper'

describe GraphQueries do

  before :all do

    #
    #
    # 1 -> 11 -> 111
    #   -> 12 -> 121 
    #
    # 1 -> 21
    #

    @owner = FactoryGirl.create :user
    @viewer = FactoryGirl.create :user

    @top_set1 = FactoryGirl.create :media_set, user: @owner
    @top_set1.children << (@child_11 = FactoryGirl.create :media_set, user: @owner)
    @top_set1.children << (@child_12 = FactoryGirl.create :media_set, user: @owner)

    @child_11.children << (@child_111 = FactoryGirl.create :media_set, user: @owner)
    @child_12.children << (@child_121 = FactoryGirl.create :media_resource, user: @owner)

    @top_set2 = FactoryGirl.create :media_set, user: @owner
    @top_set2.children << (@child_21 = FactoryGirl.create :media_set, user: @owner)

  end

  describe "Computing all the descendants of " do
    describe "top_set1" do
      it "should have 4 children" do
        GraphQueries.descendants(@top_set1).size.should == 4
      end
    end
  end

end

