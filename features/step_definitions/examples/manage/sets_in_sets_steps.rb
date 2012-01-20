# coding: UTF-8

Given /^I see some sets$/ do
  3.times do
    FactoryGirl.create :media_set, :user => @current_user
  end
  @current_user.media_sets.count.should == 3
  
  visit user_resources_path(@current_user, :type => "media_sets")
  wait_for_css_element("div.page div.item_box")
  all(".item_box").size.should == 3
end

When /^I add them to my favorites$/ do
  @current_user.favorites.count.should == 0
  @current_user.favorites << @current_user.media_sets
  @current_user.favorites.count.should == 3
end

Then /^they are in my favorites$/ do
  @current_user.favorites.reload.should == @current_user.media_sets.reload

  visit favorites_resources_path
  wait_for_css_element("div.page div.item_box")
  all(".item_box").size.should == 3
end

##########################################################################

Given /^a context$/ do
  name = "Landschaftsvisualisierung"
  @context = MetaContext.send(name)
  @context.should_not be_nil
  @context.name.should == name
  @context.to_s.should_not be_empty
  @context.to_s.should == name
end

When /^I look at a page describing this context$/ do
  visit meta_context_path(@context)
  page.should have_content(@context.to_s)
end

Then /^I see all the keys that can be used in this context$/ do
  find_link("Vokabular").click
  @context.meta_keys.for_meta_terms.each do |meta_key|
    definition = meta_key.meta_key_definitions.for_context(@context)
    label = definition.meta_field.label
    page.should have_content(label)
  end
end

Then /^I see all the values those keys can have$/ do
  @context.meta_keys.for_meta_terms.each do |meta_key|
    meta_key.meta_terms.each do |meta_term|
      page.should have_content(meta_term.to_s)
    end
  end
end

Then /^I see an abstract of the most assigned values from media entries using this context$/ do
  find_link("Auszug").click
  find("#slider")
end

##########################################################################

Given /^some sets and entries$/ do
  steps %Q{
    And a set titled "My Act Photos" created by "max" exists
    And a entry titled "Me with Nothing" created by "max" exists
    And the last entry is child of the last set
 
    And a set titled "My Private Images" created by "max" exists
    And a entry titled "Me" created by "max" exists
    And the last entry is child of the last set
    And the last set is parent of the 1st set   
      
    And a set titled "My Public Images" created by "max" exists
    And a entry titled "My Profile Pic" created by "max" exists
    And the last entry is child of the last set
    
    And a set titled "Football Pics" created by "max" exists
    And a entry titled "Me and my Balls" created by "max" exists
    And the last entry is child of the last set
    And the last set is parent of the 3rd set
    
    And a set titled "Images from School" created by "max" exists
    And a entry titled "Me with School Uniform" created by "max" exists
    And the last entry is child of the last set
  }
end

When /^I open the sets in sets tool$/ do
  
end

Then /^I see all sets I can edit$/ do
  
end

Then /^I can see the owner of each set$/ do
  
end

Then /^I can see that selected sets are already highlighted$/ do
  
end

Then /^I can choose to see additional information$/ do
  
end

Then /^I can read the first 30 characters of each set title$/ do
  
end

Then /^I can see enough information to differentiate between similar sets$/ do
  
end
      
##########################################################################

Given /^multiple resources are in my selection$/ do
   
end

Given /^they are in various different sets$/ do
   
end

When /^I open the sets in sets tool$/ do
   
end

Then /^I see the sets none of them are in$/ do
   
end

Then /^I see the sets some of them are in$/ do
   
end

Then /^I see the sets all of them are in$/ do
   
end

Then /^I can add all of them to one set$/ do
   
end

Then /^I can remove all of them from one set$/ do
   
end
