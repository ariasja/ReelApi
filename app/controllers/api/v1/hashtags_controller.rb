class Api::V1::HashtagsController < ApiController

  def index
    temp = Hashtag.where("tagging_user_id = ?", params[:tagging_user_id]).reverse_order
    usedTags = []
    @hashtags = []
    for hashtag in temp do
      if !usedTags.include? hashtag[:tag]
        @hashtags.push hashtag
        usedTags.push hashtag[:tag]
      end
    end
  end

  def show
    @hashtag = Hashtag.find(params[:id])
  end

  def create
   @hashtag = Hashtag.new(hashtag_params)
    if @hashtag.save
      render json: {
        id: @hashtag.id,
        tag: @hashtag.tag,
        post_id: @hashtag.post_id,
        tagging_user_id: @hashtag.tagging_user_id,
      }, status: 200
    else
      render json: {
        message: 'Create Hashtag Failed',
        errors: @hashtag.errors.full_messages
      }, status: 422
    end
  end

  def destroy
    @hashtag.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def hashtag_params
        {
          id: params[:id],
          tag: params[:tag],
          post_id: params[:post_id],
          tagging_user_id: params[:tagging_user_id],
        }
    end

end