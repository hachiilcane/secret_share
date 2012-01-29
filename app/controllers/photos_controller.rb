class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.json
  def index
    if params[:directory_id]
      @directory = Directory.find(params[:directory_id])
      @list_name = @directory.path
      @photos = @directory.photos.order("date_time_original").all
    else
      @list_name = ""
      @photos = Photo.order("date_time_original").all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :ok }
    end
  end

  def inline_thumbnail
    @photo = Photo.find(params[:id])

    @photo.make_additional_data
    @photo.save if @photo.changed?

    send_data(@photo.thumbnail_medium, :type => 'image/jpeg', :disposition => 'inline')
  end

  def inline_image
    @photo = Photo.find(params[:id])

    img = Magick::ImageList.new(@photo.full_name)
    scale = img.columns > 1024.0 ? 1024.0 / img.columns : 1.0
    out_img = img.auto_orient.resize(scale)

    send_data(out_img.to_blob, :type => 'image/jpeg', :disposition => 'inline')
  end

  def original_image
    @photo = Photo.find(params[:id])
    send_file(@photo.full_name, :type => 'image/jpeg', :disposition => 'inline')
  end
end
