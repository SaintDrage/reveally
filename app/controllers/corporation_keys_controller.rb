class CorporationKeysController < ApplicationController
  def index
    @corporation_keys = CorporationKey.all
  end

  def new
    @corporation_key = CorporationKey.new
  end

  def create
    @corporation_key = CorporationKey.create params.permit![:corporation_key]

    flash[:notice] = "Key #{@corporation_key.id} was successfully created."
    redirect_to corporation_keys_path
  end

  def edit
    @corporation_key = CorporationKey.find params[:id]
  end

  def update
    @corporation_key = CorporationKey.find params[:id]
    key_params = params.require(:corporation_key).permit(:v_code, :corporation_id)

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

    flash[:notice] = "Key '#{@corporation_key.id}' deleted."
    redirect_to corporation_keys_path
  end
end
