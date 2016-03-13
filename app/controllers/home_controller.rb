class HomeController < ApplicationController
  skip_authorization_check
  add_breadcrumb 'Home', :root_path

  def index
    @blog = Page.category('Blog')
    # authorize! :read, @blog

    # add_breadcrumb 'Blog'
    collection = @blog.children.order('created_at DESC')
    # @page = collection.first # (Page.where(title: 'Home').first or Page.roots.public.first)

    if collection.first
      add_breadcrumb collection.first.title
    end

    @pages = collection.paginate(page: params[:page], per_page: 10)

  end

end
