class DocumentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @document = Document.create!(document_params)
    render json: { id: @document.id }
  end

  def document_params
    params.require(:document).permit(:file)
  end
end
