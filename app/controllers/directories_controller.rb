class DirectoriesController < ApplicationController
  # GET /directories
  # GET /directories.json
  def index
    @directories = Directory.all

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
      dir = Directory.where(:path => path)
      if dir.size == 0
        modified_time = File.mtime(root_dir + path)
        directory = Directory.new(:path => path, :modified_at => modified_time)
        if directory.save

        else
          #TODO error code
        end
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
end
