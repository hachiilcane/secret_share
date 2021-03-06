class DirectoriesController < ApplicationController
  # GET /directories
  # GET /directories.json
  def index
    @directories = Directory.order("path").all
    @isScanning = false
    if @directories.size > 0
      @isScanning = @directories.select { |d| !d.is_ready_for_detail }.size > 0
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @directories }
    end
  end

  # GET /directories/1
  # GET /directories/1.json
  def show
    @directory = Directory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @directory }
    end
  end

  # GET /directories/new
  # GET /directories/new.json
  def new
    @directory = Directory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @directory }
    end
  end

  # GET /directories/1/edit
  def edit
    @directory = Directory.find(params[:id])
  end

  # POST /directories/scan
  def scan
    root_dir = AppConfig[:root_directory]
    root_dir += "/" unless /\/$/ =~ root_dir

    sub_dir_names = []
    Dir::glob(root_dir + "**/*.{jpg,JPG}").each do |f|
      sub_dir_names << File.dirname(f).sub(root_dir, "")
    end
    sub_dir_names.uniq!

    sub_dir_names.each do |path|
      modified_time = File.mtime(root_dir + path)
      directory = Directory.where(:path => path).first

      # has not created target model yet
      if !directory
        directory = Directory.new(:path => path, :modified_at => modified_time, :is_ready_for_detail => false)
        if !directory.save
          #TODO error code
        end
        create_photos_in_sub_directory(root_dir + path, directory.id)
        directory.delay.got_ready_for_detail # pushed this job after jobs which create photos
      end

      # update
      if modified_time != directory.modified_at
        # destroy all once!
        target_dir_photos = Photo.where(:directory_id => directory.id)
        target_dir_photos.destroy_all
        directory.update_attributes(:is_ready_for_detail => false)

        create_photos_in_sub_directory(root_dir + path, directory.id)
        directory.delay.got_ready_for_detail # pushed this job after jobs which create photos
      end
    end

    respond_to do |format|
      format.html { redirect_to directories_url }
      format.json { head :ok }
    end
  end

  # POST /directories
  # POST /directories.json
  def create
    @directory = Directory.new(params[:directory])

    respond_to do |format|
      if @directory.save
        format.html { redirect_to @directory, notice: 'Directory was successfully created.' }
        format.json { render json: @directory, status: :created, location: @directory }
      else
        format.html { render action: "new" }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /directories/1
  # PUT /directories/1.json
  def update
    @directory = Directory.find(params[:id])

    respond_to do |format|
      if @directory.update_attributes(params[:directory])
        format.html { redirect_to @directory, notice: 'Directory was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directories/1
  # DELETE /directories/1.json
  def destroy
    @directory = Directory.find(params[:id])
    @directory.destroy

    respond_to do |format|
      format.html { redirect_to directories_url }
      format.json { head :ok }
    end
  end

  private

  def create_photos_in_sub_directory(full_path, directory_id)
    Dir::glob(full_path + "/*.{jpg,JPG}").each do |f|
      photo = Photo.new(:full_name => f, :directory_id => directory_id)
      if !photo.save
        #TODO error code
      end
      photo.delay.make_additional_data
    end
  end
end
