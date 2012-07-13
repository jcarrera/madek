module GraphQueries

  def self.descendants media_set, opts=nil
    opts ||= {}

    base_query= <<-SQL   
      (
        WITH RECURSIVE pair(p,c) as
        (
            SELECT parent_id as p, child_id as c FROM media_resource_arcs 
              WHERE parent_id = #{media_set.id}
          UNION
            SELECT pair.p as p, media_resource_arcs.child_id as c from pair, media_resource_arcs
              WHERE media_resource_arcs.parent_id = c
              
        ) select c from pair
      ) 
    SQL

    MediaResource.where("media_resources.id in ( #{base_query} )")
  end

 
end

