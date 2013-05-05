class CorporationsController < ApplicationController
  def index
    @corporations = Corporation.all
  end

  def show
    @corporation = Corporation.find params[:id]
  end
end
