defmodule BlogWeb.BlogLive do
  use BlogWeb, :live_view

  def render(assigns) do
    Phoenix.View.render(BlogWeb.PageView, "blog.html", assigns)
  end

  def mount(%{"id" => id, "preview" => "true"}, _session, socket) do
    id
    |> Blog.Blogs.get_post_preview_by_id!()
    |> show(socket)
  end

  def mount(%{"id" => id}, _session, socket) do
    id
    |> Blog.Blogs.get_post_by_id!()
    |> show(socket)
  end

  def mount(_params, _session, socket) do
    posts = Blog.Blogs.published_posts()

    # IO.inspect(posts)
    {:ok, socket
    |> assign(:posts, posts)
    |> assign(:page_title, "Blog"), temporary_assigns: [posts: []]}
  end

  def handle_params(_params, _session, socket) do
    {:noreply, socket}
  end

  def show(post, socket) do
    {:ok, socket
    |> assign(:post, post)
    |> assign(:page_title, post.title), temporary_assigns: [post: nil]}
  end
end
