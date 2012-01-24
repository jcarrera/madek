module Media
end

class Media::FeaturedSet < MediaSet
end

class DropFeaturedSet < ActiveRecord::Migration
  def up
    
    if(featured_set = Media::FeaturedSet.first)
      MediaSet.featured_set = featured_set
      featured_set.type = "Media::Set"
      featured_set.save
    end

  end

  def down
  end
end
