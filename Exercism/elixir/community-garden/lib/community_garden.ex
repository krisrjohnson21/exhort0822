# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start() do
    Agent.start(fn -> %{plot_id: 0, plots: []} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn %{plots: plots} -> plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plot_id: id, plots: plots} ->
      id = id + 1
      plot = %Plot{plot_id: id, registered_to: register_to}

      {plot, %{plot_id: id, plots: [plot | plots]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.cast(pid, fn %{plots: plots} = state ->
      plots = Enum.filter(plots, fn %{plot_id: id} -> id != plot_id end)

      %{state | plots: plots}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      plots
      |> Enum.find({:not_found, "plot is unregistered"}, fn %{plot_id: id} -> id === plot_id end)
    end)
  end
end
