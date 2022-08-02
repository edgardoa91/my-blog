defmodule Blog.Post do
  @enforce_keys [:id, :title, :body, :description, :reading_time, 
    :tags, :published_at]
  defstruct [
    :id, 
    :title,
    :body,
    :description,
    :reading_time,
    :tags,
    :published_at,
    published: true
  ]

  def build(filename, attrs, body) do
    [
      <<year::bytes-size(4), month::bytes-size(2), day::bytes-size(2)>>,
      slug
    ] = 
      filename
      |> Path.rootname()
      |> Path.split()
      |> List.last()
      |> String.split("-", parts: 2)

    struct!(
      __MODULE__,
      [
        id: slug, 
        published_at: Date.from_iso8601!("#{year}-#{month}-#{day}"),
        body: body,
        reading_time: estimate_reading_time(body),
      ] ++ Map.to_list(attrs)
    )
  end

  @avg_wpm 200
  defp estimate_reading_time(body) do
    body
    |> String.split(" ")
    |> Enum.count()
    |> then(& &1 / @avg_wpm)
    |> round()
  end
end




