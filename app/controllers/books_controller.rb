class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
    else
     @books = Book.all
     render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
       redirect_to books_path
    end
  end

 def destroy
   @book = Book.find(params[:id])
   @book.destroy
   redirect_to '/books'
 end

 def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
    redirect_to book_path
    else
     render :edit
    end
 end

 def new

 end


  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end

