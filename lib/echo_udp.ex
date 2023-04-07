defmodule EchoUdp.Service do
  use GenServer
  require Logger


  def start_link(opts) do
    Logger.info("Starting service")
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    Logger.info("Initializing service")

    addr =
      case :inet.getaddr(~c'fly-global-services', :inet) do
        {:ok, _} ->
          {:ok, fly_global_ip} = :inet.getaddr(~c"fly-global-services", :inet)
          Logger.info("fly-global-services given by #{:inet.ntoa(fly_global_ip)}")
          fly_global_ip

        {:error, reason} ->
          Logger.error("Error while getting the address, #{inspect(reason)}")
          {0, 0, 0, 0}
      end

    case :gen_udp.open(5002, [:binary, {:active, false}, {:ip, addr}]) do
      {:ok, socket} ->
        Logger.info("Started UDP server on #{:inet.ntoa(addr)}:5002")
        {:ok, %{socket: socket}, {:continue, :recv}}

      {:error, reason} ->
        {:stop, reason}
    end
  end

  @impl true
  def handle_continue(:recv, %{socket: socket} = state) do
    case :gen_udp.recv(socket, 0) do
      {:ok, {address, port, packet}} ->
        Logger.debug(
          "Received UDP packet from #{inspect(address)}:#{inspect(port)}: #{inspect(packet)}"
        )

        :gen_udp.send(state.socket, address, port, "ACK: #{inspect(packet)}")

        {:noreply, state, {:continue, :recv}}

      {:error, reason} ->
        Logger.error("Error #{inspect(reason)}")
        {:stop, reason}
    end
  end
end
