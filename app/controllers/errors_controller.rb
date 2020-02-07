class ErrorsController < ApplicationController
  def not_found
    @page = Page.friendly.find('404')
    render status: 404
  end
end
