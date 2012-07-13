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
            SELECT parent_id as p, child_id as c FROM pair, media_resource_arcs
              WHERE parent_id = pair.c
        ) select c from pair
      ) 
    SQL

    MediaResource.where("media_resources.id in ( #{base_query} )")
  end

 
end

