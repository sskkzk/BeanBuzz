class Public::PostsController < ApplicationController
  # ログインしていないユーザーがindexとshow以外のアクションにアクセスしようとした場合は、ログイン画面へリダイレクト
  before_action :authenticate_user!, except: [:index, :show]

  # edit, update, destroyのアクションの前に、投稿者が現在のユーザーか確認する
  before_action :correct_user, only: [:edit, :update, :destroy]

  # show, edit, update, destroyの前に投稿データを取得する
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # 投稿一覧の表示。検索結果やソートに対応し、ページネーションで10件ずつ表示
  def index
    @posts = if params[:search_header]
       Post.search(params[:search_header]).page(params[:page]).per(10)
     else
       sorted_posts(Post.page(params[:page]).per(10))
     end
  end

  # 投稿の詳細ページ。投稿に関連するコメントも取得して表示
  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  # 新規投稿のフォームを表示
  def new
    @post = Post.new
  end

  # 投稿の作成処理。現在のユーザーに紐づけて投稿を作成し、保存
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: '投稿が正常に作成されました。'
    else
      render :new
    end
  end

  # 投稿の編集フォームを表示
  def edit
  end

  # 投稿の更新処理。成功時は詳細ページへリダイレクト、失敗時は再度編集ページを表示
  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が正常に更新されました。'
    else
      render :edit
    end
  end

  # 投稿の削除処理。削除後は投稿一覧にリダイレクト
  def destroy
    @post.destroy
    redirect_to posts_url, notice: '投稿が正常に削除されました。'
  end

  private

  # Strong Parametersを使用して、許可されたパラメータのみを受け取る
  def post_params
    params.require(:post).permit(:bean_origin, :bean_roast, :bean_acidity, :bean_bitter, :bean_extraction, :bean_title, :bean_body, :bean_image)
  end

  # 現在のユーザーがその投稿の所有者であるかを確認。所有者でない場合は投稿一覧にリダイレクト
  def correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to(posts_path, alert: '他のユーザーの投稿を編集することはできません。')
    end
  end

  # 投稿IDを基に投稿を取得し、@postにセット
  def set_post
    @post = Post.find(params[:id])
  end

  # 投稿を指定の条件でソートする（新しい順、ローストの高さ順など）
  def sorted_posts(posts)
    case params[:sort]
    when 'newest'
      posts.order(created_at: :desc)
    when 'oldest'
      posts.order(created_at: :asc)
    when 'roast_high'
      posts.order(bean_roast: :desc)
    when 'roast_low'
      posts.order(bean_roast: :asc)
    when 'bitter_high'
      posts.order(bean_bitter: :desc)
    when 'bitter_low'
      posts.order(bean_bitter: :asc)
    when 'acidity_high'
      posts.order(bean_acidity: :desc)
    when 'acidity_low'
      posts.order(bean_acidity: :asc)
    else
      posts
    end
  end
end
