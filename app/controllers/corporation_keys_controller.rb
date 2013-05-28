class CorporationKeysController < ApplicationController
  def index
    @corporation_keys = CorporationKey.all
  end

  def create
    @corporation_key = CorporationKey.create prepare(params)

    flash[:notice] = "Key #{@corporation_key.id} was successfully created."
    redirect_to corporation_keys_path
  end

  def edit
    @corporation_key = CorporationKey.find params[:id]
  end

  def update
    @corporation_key = CorporationKey.find params[:id]
    @corporation_key.update_attributes! prepare(params)

    flash[:notice] = "Key #{@corporation_key.id} was successfully updated."
    redirect_to corporation_keys_path
  end

  def destroy
    @corporation_key = CorporationKey.find(params[:id])
    @corporation_key.destroy

    flash[:notice] = "Key '#{@corporation_key.id}' deleted."
    redirect_to corporation_keys_path
  end

  #HACK: it should be just CorporationKey.create(params)
  def prepare(params)
    {
      corporation_id: params[:corporation_key][:corporation_id],
      v_code: params[:corporation_key][:v_code]
    }
  end
end
