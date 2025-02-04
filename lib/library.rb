class Library
  attr_reader :name, :books, :authors, :checked_out_books

  def initialize(name)
    @name = name
    @books = []
    @authors = []
    @checked_out_books = []
    @archive_of_all_checked_out_books = []
  end

  def add_author(author)
    @authors << author
    author.books.each {|book| @books << book}
  end

  def publication_time_frame_for(author)
    years = (author.books.map {|book| book.publication_year.to_i}).sort

    {
      start: years[0].to_s,
    end: years[-1].to_s
    }
  end

  def checkout(book)
    if @books.include?(book) && !@checked_out_books.include?(book)
      @checked_out_books << book
      @archive_of_all_checked_out_books << book
      return true
    else
      return false
    end
  end

  def return(book)
    @checked_out_books.delete(book)
  end

  def most_popular_book
    books = @archive_of_all_checked_out_books.tally
    most_popular = books.max_by{|book, count| count}
    most_popular[0]
  end
end
