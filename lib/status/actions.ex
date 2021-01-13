defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  def heal() do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
    end
  end

  def fetch_move(move) do
    # recuperando a informaçoes do player, pegando o movimentos dele usando o Map.get, os nomes dos movimentos é passado como primeiro parametro em find_move
    Game.player() |> Map.get(:moves) |> find_move(move)
  end

  defp find_move(moves, move) do
    # Primeiramente usamos a função find_values, onde o primeiro paremetro é para achar todos os movimentos(move_random, move_medio, move_heal)
    # Depois verificamos se tem error, depois criamos um função anonima para ir atras do movimento(key) e seu valor(value)
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end
end
