class Admin::MetaKeyDefinitionsController < Admin::AdminController

  def index
    @meta_key_definitions = MetaKeyDefinition.all
  end

end
