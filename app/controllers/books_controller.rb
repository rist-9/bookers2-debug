class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :check, only: [:edit,:update]

  def show
  	@book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @book = Book.new
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @users = User.all
    @user = User.find(current_user.id)
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @books = Book.all
    @book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@user = current_user
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path
  end


  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book.id), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private
      def book_params
        params.require(:book).permit(:title,:body, :profile_image_id)
      end

  def check
      book = Book.find(params[:id])
      user = User.find(book.user_id)
      redirect_to books_path unless current_user == user
  end

end
