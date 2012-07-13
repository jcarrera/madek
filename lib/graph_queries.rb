module GraphQueries

  def self.reachable_arcs media_set

    base_query= <<-SQL   
      WITH RECURSIVE pair(p,c) as
      (
          SELECT parent_id as p, child_id as c FROM media_resource_arcs 
            WHERE parent_id = #{media_set.id}
        UNION
          SELECT parent_id as p, child_id as c FROM pair, media_resource_arcs
            WHERE parent_id = pair.c
      ) 
      SELECT id FROM media_resource_arcs, pair
        WHERE media_resource_arcs.parent_id = pair.p
        AND media_resource_arcs.child_id = pair.c
    SQL

    MediaResourceArc.where(" id in ( #{base_query})")
  end

  def self.descendants media_set

    base_query= <<-SQL   
      WITH RECURSIVE pair(p,c) as
      (
          SELECT parent_id as p, child_id as c FROM media_resource_arcs 
            WHERE parent_id = #{media_set.id}
        UNION
          SELECT parent_id as p, child_id as c FROM pair, media_resource_arcs
            WHERE parent_id = pair.c
      ) 
      SELECT c FROM pair
    SQL


    MediaResource.where("media_resources.id in ( #{base_query} )")
  end

 
end

