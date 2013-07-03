class CorporationKeysController < ApplicationController
  def index
    @corporation_keys = CorporationKey.all
  end

  def new
    @corporation_key = CorporationKey.new
  end

  def create
    @corporation_key = CorporationKey.new(key_params)
    @corporation_key.save

    redirect_to corporation_keys_path, notice: 'Created!'
  end

  def edit
    @corporation_key = CorporationKey.find params[:id]
  end

  def update
    @corporation_key = CorporationKey.find params[:id]

    if @corporation_key.update(key_params)
      flash[:notice] = "Key #{@corporation_key.id} was successfully updated."
      redirect_to corporation_keys_path
    else
      render action: 'edit'
    end
  end

  def destroy
    @corporation_key = CorporationKey.find(params[:id])
    @corporation_key.destroy

    redirect_to corporation_keys_path, notice: 'Updated!'
  end

  private
    def key_params
      params.require(:corporation_key).permit(:id, :v_code, :corporation_id)
    end
end
