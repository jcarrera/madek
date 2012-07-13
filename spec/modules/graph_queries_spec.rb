require 'spec_helper'

describe GraphQueries do

  before :all do
    @top_set1 = FactoryGirl.create :media_set

    @child_11 = FactoryGirl.create :media_set
    @top_set1.children << @child_11

    @child_111 = FactoryGirl.create :media_set
    @top_set1.children << @child_111


    @child_12 = FactoryGirl.create :media_set
    @top_set1.children << @child_12


    @top_set2 = FactoryGirl.create :media_set

    @child_21 = FactoryGirl.create :media_set
    @top_set2.children << @child_21

  end

  describe "Computing all the descendants of " do
    describe "top_set1" do
      it "should have 3 children" do
        GraphQueries.descendants(@top_set1).size.should == 3
      end
    end
  end

end

