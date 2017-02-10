 class Supports::BookSupport
  attr_reader :book

  def initialize book
    @book = book
  end

  def comment
    Comment.new
  end

  def reviews
    @book.reviews.order_by_time
  end

  def favorites
    @book.favorites
  end

  def check_favorite current_user
    @book.favorites.find_by user: current_user
  end

  def check_reading_status current_user
    if @book.reading_statuses.find_by(user: current_user).present?
      @book.reading_statuses.find_by user: current_user
    else
      @book.reading_statuses.build
    end
  end
end
