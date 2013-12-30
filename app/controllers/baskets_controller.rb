class BasketsController < ApplicationController
  # GET /baskets/1/download
  def download
    @basket = Basket.find(params[:id])

    zip_tempfile = Tempfile.new([@basket.name, '.zip'])

    begin
      logger.debug("Zipfile name: " + zip_tempfile.path)
      input_filenames = @basket.photos.map { |p| p.full_name }
      input_filenames.uniq!
      Zip::OutputStream.open(zip_tempfile) {|zos|}
      Zip::File.open(zip_tempfile.path, Zip::File::CREATE) do |zipfile|
        input_filenames.each do |filename|
          zipfile.add(File.basename(filename), filename)
        end
      end
      zip_data = File.read(zip_tempfile.path)
      send_data(zip_data, :type => 'application/zip', :filename => File.basename(zip_tempfile.path))
    ensure
      zip_tempfile.close
      zip_tempfile.unlink
    end
  end

  # GET /baskets
  # GET /baskets.json
  def index
    @baskets = Basket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @baskets }
    end
  end

  # GET /baskets/1
  # GET /baskets/1.json
  def show
    @basket = Basket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @basket }
    end
  end

  # GET /baskets/new
  # GET /baskets/new.json
  def new
    @basket = Basket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @basket }
    end
  end

  # GET /baskets/1/edit
  def edit
    @basket = Basket.find(params[:id])
  end

  # POST /baskets
  # POST /baskets.json
  def create
    @basket = Basket.new(params[:basket])

    respond_to do |format|
      if @basket.save
        format.html { redirect_to @basket, notice: 'Basket was successfully created.' }
        format.json { render json: @basket, status: :created, location: @basket }
      else
        format.html { render action: "new" }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /baskets/1
  # PUT /baskets/1.json
  def update
    @basket = Basket.find(params[:id])

    respond_to do |format|
      if @basket.update_attributes(params[:basket])
        format.html { redirect_to @basket, notice: 'Basket was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baskets/1
  # DELETE /baskets/1.json
  def destroy
    @basket = Basket.find(params[:id])
    @basket.destroy

    respond_to do |format|
      format.html { redirect_to baskets_url }
      format.json { head :ok }
    end
  end
end
