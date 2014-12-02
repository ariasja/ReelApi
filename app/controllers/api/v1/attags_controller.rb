class Api::V1::AttagsController < ApiController
  
 def index_tagging_user
    @attags = Attag.where("tagging_user_id = ?", params[:tagging_user_id]).reverse_order
  end

  def index_tagged_user
    @attags = Attag.where("tagged_user_id = ?", params[:tagged_user_id]).reverse_order
  end

  def show
    @attag = Attag.find(params[:id])
  end

  def create
   @attag = Attag.new(attag_params)
   puts "Success"
    if @attag.save
      render json: {
        id: @attag.id,
        post_id: @attag.post_id,
        tagging_user_id: @attag.tagging_user_id,
        tagged_user_id: @attag.tagged_user_id
      }, status: 200
    else
      render json: {
        message: 'Create Attag Failed',
        errors: @attag.errors.full_messages
      }, status: 422
    end
  end

  def destroy
    @attag.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def attag_params
        {
          id: params[:id],
          post_id: params[:post_id],
          tagging_user_id: params[:tagging_user_id],
          tagged_user_id: params[:tagged_user_id]
        }
    end
end
