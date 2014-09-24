class Api::V1::FoldersController < ApiController

  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.where("user_id = ?", params[:user_id]).reverse_order
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder = Folder.find(params[:id])
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @folder.errors.full_messages
      }, status: 422
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.json { render :show, status: :ok, location: @folder }
      else
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
    {
      title: params[:title],
      user_id: params[:user_id]
    }
  end
end
