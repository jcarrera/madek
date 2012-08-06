class GraphController < ApplicationController
  respond_to 'html', 'json'

  def data
    binding.pry
    respond_with {}
  end
  
end
