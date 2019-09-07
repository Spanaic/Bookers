class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @books = Book.all
    # index内の変数を再定義したもの↑↑↑
    @book = Book.new(book_params)
    if @book.save
      # redirect_to book_path(book.id)
      # 今だけ一覧ページにリダイレクト中
      # if　と同じ行に条件を記述することを忘れない

      flash[:notice] = 'Book was successfully created.'

      redirect_to book_path(@book)
    else
      render action: :index
      # コントローラ内のレンダーは指定したアクションの"end"から実行されるため、変数は現在のアクション内で再定義する必要がある
      # indexアクションにとんでも,endに飛ぶため変数が定義されていないことになる。
      # createアクション内でindexアクションの変数を再定義することで,リダイレクトしなくても表示を崩すことなく同じhtmlを使用できる
      # リダイレクトはルーティングから実行されるが、レンダーは現在いるアクションの定義内容を持って、指定したアクションのendから実行される

    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)

      flash[:notice] = 'Book was successfully updated.'

    redirect_to book_path
   else
    render action: :edit 
   end
  end

  def destroy
    book = Book.find(params[:id])
    # []を｛｝と間違えない
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
    # モデル名は小文字単数系、カラムは”,”で区切る
  end
end
