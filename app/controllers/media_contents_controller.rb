class MediaContentsController < ApplicationController
    def index

    end
    def create
        @media = Medium.new(file_name: params[:file])
        if @media.save!
            respond_to do |format|
                format.json{ render :json => @media }
            end
        else
            respond_to do |format|
                format.json{ render :json => @media }
            end
        end

    end
end
