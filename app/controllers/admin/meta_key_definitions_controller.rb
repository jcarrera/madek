class Admin::MetaKeyDefinitionsController < Admin::AdminController

  def index
    @meta_key_definitions = MetaKeyDefinition.all
  end

  def edit
    @meta_key_definition = MetaKeyDefinition.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update 
    binding.pry
  end

end
