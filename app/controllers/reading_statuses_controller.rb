class ReadingStatusesController < ApplicationController
  before_action :logged_in_user
  before_action :find_book
  before_action :find_status, only: :update

  def create
    @reading_status = @book.reading_statuses.create reading_status_params
    if @reading_status
      flash[:success] = t "status.success"
    else
      flash[:warning] = t "status.warning"
    end
    redirect_to @book
  end

  def update
    if @reading_status.update_attributes reading_status_params
      flash[:success] = t "status.success"
      redirect_to @book
    else
      redirect_to :edit
    end
  end

  private
  def reading_status_params
    params.require(:reading_status).permit :user_id, :book_id, :status
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "admin.book.not_find"
      redirect_to root_url
    end
  end

  def find_status
    @reading_status = ReadingStatus.find_by id: params[:id]
    unless @reading_status
      flash[:warning] = t "status.not_find"
      redirect_to @book
    end
  end
end
