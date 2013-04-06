class PickingsController < ApplicationController
  def create
    @picking = Picking.new(:photo_id => params[:photo_id], :basket_id => params[:basket_id])

    respond_to do |format|
      if @picking.save
#        format.html { redirect_to @picking, notice: 'Picking was successfully created.' }
        format.json { render json: @picking, status: :created }
      else
#        format.html { render action: "new" }
        format.json { render json: @picking.errors, status: :unprocessable_entity }
      end
    end
  end

end
