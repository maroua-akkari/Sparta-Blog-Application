class PostController < Sinatra::Base

  #set route of parent directory of current file
  set :root, File.join(File.dirname(__FILE__), '..')
  #sets the views directory correctly
  set :views, Proc.new { File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end


  $posts = [{
    id: 0,
    title: "Post 1",
    body: "This is the first post"
  },
  {
    id: 1,
    title: "Post 2",
    body: "This is the second post"
  },
  {
    id: 2,
    title: "Post 3",
    body: "This is the third post"
  }]

  #index
  get "/" do

    @title = "Welcome to the blog"

    @posts = $posts

    erb :'posts/index'
  end

  #new
  get "/new" do

    @post = {
      id: "",
      title: "",
      body: ""
    }

    erb :'posts/new'

  end

  #create
  post "/" do

    new_post = {
      id: $posts.length,
      title: params[:title],
      body: params[:body]
    }

    $posts.push(new_post)

    redirect "/"

  end

  #show
  get "/:id" do
    id = params[:id].to_i

    @post = $posts[id]

    erb :'posts/show'

  end

  #edit
  get "/:id/edit" do
    id = params[:id].to_i

    @post = $posts[id]

    erb :'posts/edit'

  end

  #update
  put "/:id" do
    id = params[:id].to_i

    post = $posts[id]

    post[:title] = params[:title]
    post[:body] = params[:body]

    $posts[id] = post

    redirect "/"

  end

  #destroy
  delete "/:id" do
    id = params[:id].to_i

    $posts.delete_at(id)

    redirect "/"

  end

end
