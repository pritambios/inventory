class DocumentsController < ApplicationController
  def destroy
    @document = Document.find(params[:id])
    if @document.destroy
      respond_to do |format|
        format.js   { render layout: false }
      end
    end
  end
end
