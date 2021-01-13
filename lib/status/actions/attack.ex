defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  alias ExMon.Game.Status

  # definindo quando cada attack pode dar de dano
  @move_medio_power 18..25
  @move_random_power 10..35

  # funcao para atacar
  def attack_opponent(opponent, move) do
    damage = calculate_power(move)
    # pegando o vida do opponet, pode ser tanto o oponente ou o player
    opponent
    |> Game.fetch_player()
    # pegando o life que veio do Game.fetch_player()
    |> Map.get(:life)
    # funcao para calcular a vida total depois de sofre o dano, lembrando que a vida é passada como primeiro parametro
    |> calculate_total_life(damage)
    # funcao para atualizar a vida
    |> update_opponent_life(opponent, damage)
  end

  # funcoes para calcularo o dano, usando a funcao Enum.random()
  defp calculate_power(:move_avg), do: Enum.random(@move_medio_power)
  defp calculate_power(:move_rdn), do: Enum.random(@move_random_power)
  # calculando o totoal de vida
  defp calculate_total_life(life, damage) when life - damage < 0, do: 0
  defp calculate_total_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(opponent, damage)
  end

  defp update_game(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end
end
