defmodule ExMon.Game do
  alias ExMon.Player
  # importando o agent
  use Agent

  #
  def start(computer, player) do
    # setando valores do computador, do player, do turno e do status
    valor_inical = %{computer: computer, player: player, turn: :player, status: :started}
    # start atualizações do jogo
    Agent.start_link(fn -> valor_inical end, name: __MODULE__)
  end

  def info do
    # pegando informações do jogo
    Agent.get(__MODULE__, & &1)
  end

  # atualizando informações do jogo
  def update(estado) do
    Agent.update(__MODULE__, fn _ -> update_game_status(estado) end)
  end

  # funcao para atualizar o stts do jogo, caso a vida de qualquer   um chegue a 0 ira dar mudar o stts do jogo pra gamer over
  defp update_game_status(
         %{player: %Player{life: player_life}, computer: %Player{life: computer_life}} = estado
       )
       # defindo o gamer over
       when player_life == 0 or computer_life == 0,
       do: Map.put(estado, :status, :game_over)

  # defindo o stts do jogo para continuar caso ninguem morra e atualizando o turno
  defp update_game_status(estado) do
    estado |> Map.put(:status, :continue) |> update_turn
  end

  defp update_turn(%{turn: :player} = estado), do: Map.put(estado, :turn, :computer)
  defp update_turn(%{turn: :computer} = estado), do: Map.put(estado, :turn, :player)

  # pegando informações apenas do player
  def player, do: Map.get(info(), :player)

  # pegando informações do turno
  def turn, do: Map.get(info(), :turn)
  # defindo se é o player ou o computer
  def fetch_player(player), do: Map.get(info(), player)
end
