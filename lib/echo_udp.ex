defmodule EchoUdp.Service do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, addr} = :inet.getaddr('fly-global-services', :inet)

    {:ok, socket} = :gen_udp.open(5002, [:binary, {:active, true}, {:ip, addr}])

    {:ok, socket}
  end

  def handle_info({:udp, socket, addr, port, data}, state) do
    :gen_udp.send(socket, addr, port, "Received: #{inspect(data)}")

    {:noreply, state}
  end
end
