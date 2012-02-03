module Permissions
  extend self 

  class << self



    def authorized?(user, action, resource_or_resources)

      # the old authorized accepted subjects 
      raise "authorized? can only be called with a user" if user.class != User

      Array(resource_or_resources).all? do |resource|
        if resource.user == user
          true
        elsif resource.send(action) == true
          true
        elsif userpermission_disallows action, resource, user
          false
        elsif userpermission_allows action, resource, user
          true
        elsif grouppermission_allows action, resource, user
          true
        else
          false
        end
      end 

    end

    ### private

    def userpermission_disallows action, resource, user
      Userpermission.where(action => false).where(user_id: user).where(media_resource_id: resource).first
    end


    def userpermission_allows action, resource, user
      Userpermission.where(action => true).where(user_id: user).where(media_resource_id: resource).first
    end


    def grouppermission_allows action, resource, user
      Grouppermission.joins(:group => :users)
        .where(media_resource_id: resource.id)
        .where(action => true)
        .where("groups_users.user_id" => user)
        .first
    end




  end

end