class CorporationsController < ApplicationController
  def index
    @corporations = Corporation.all
  end

  def show
  end
end
