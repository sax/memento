defmodule Memento.Error.MnesiaException do
  defexception [:message, :data]
  @moduledoc false



  # Re-raise Mnesia exits as Exceptions
  defmacro raise(data) do
    quote do
      data = Memento.Error.MnesiaException.fetch(unquote(data))

      raise Memento.Error.MnesiaException,
        message: "Mnesia Operation failed with: #{inspect(data)}",
        data: data
    end
  end


  # Parse the data returned from an Mnesia Exit Exception
  def fetch({:aborted, data}), do: data
  def fetch({:error, data}),   do: data
  def fetch(data),             do: data

end