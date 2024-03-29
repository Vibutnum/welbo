class CommentController < ApplicationController
	def create
		@micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to micropost_path(@micropost)
		
	end

	def destroy
	@micropost = Micropost.find(params[:micropost_id])
	@comment = @micropost.comments.find(params[:id])
	@comment.destroy
	redirect_to(micropost_path(@micropost))
  end


  private
    def comment_params
      params.require(:comment).permit(:body)
    	
    end
end
