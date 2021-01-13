defmodule ExMon.Player do
  @required_keys [:life, :moves, :name]

  # defindo life como 100
  @max_life 100

  # @enforce_keys força eu ter todos os campos
  @enforce_keys @required_keys

  # fazendo o struct
  defstruct @required_keys

  # funcao para criação do player, passando como parametro nome, e movimentos
  def build(name, move_rdn, move_avg, move_heal) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_rdn: move_rdn
      },
      name: name
    }
  end
end
