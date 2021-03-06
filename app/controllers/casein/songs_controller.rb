# Scaffolding generated by Casein v5.1.1.5

module Casein
  class SongsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Songs'
  		@songs = Song.order(sort_order(:name)).paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View song'
      @song = Song.find params[:id]
    end
  
    def new
      @casein_page_title = 'Add a new song'
    	@song = Song.new
    end

    def create
      @song = Song.new song_params
    
      if @song.save
        flash[:notice] = 'Song created'
        redirect_to casein_songs_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new song'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update song'
      
      @song = Song.find params[:id]
    
      if @song.update_attributes song_params
        flash[:notice] = 'Song has been updated'
        redirect_to casein_songs_path
      else
        flash.now[:warning] = 'There were problems when trying to update this song'
        render :action => :show
      end
    end
 
    def destroy
      @song = Song.find params[:id]

      @song.destroy
      flash[:notice] = 'Song has been deleted'
      redirect_to casein_songs_path
    end
  
    private
      
      def song_params
        params.require(:song).permit(:name, :lyrics, :spotify, :itunes, :release, :downloadable)
      end

  end
end