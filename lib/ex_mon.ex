defmodule ExMon do
  # o Player vai ser o nome a parti de agora
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}
  @computer "Robotinik"
  @computer_moves [:move_avg, :move_rdn, :move_heal]
  # Função para criar o player
  def create_player(name, move_rdn, move_avg, move_heal) do
    Player.build(name, move_rdn, move_avg, move_heal)
  end

  # Função para começar o jogo
  def start_game(player) do
    # a funcao Game.start() tem dois parametros, onde o 1 é o computador que ja foi dado graças ao pipe
    @computer |> create_player(:punch, :kick, :heal) |> Game.start(player)
    # função parar exibir mensagem de start game
    Status.print_round_message(Game.info())
  end

  # fazendo o movimento
  def make_move(move) do
    Game.info() |> Map.get(:status) |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other, move) do
    move |> Actions.fetch_move() |> do_move()
    computer_move(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end

  defp computer_move(_), do: :ok

  # vericando se o movimento é valido
  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  # agora que ja verificamos o erro, vamos fazer o movimento
  defp do_move({:ok, move}) do
    case move do
      # caso o movimento seja de heal
      :move_heal -> Actions.heal()
      # caso o movimento seja de attack
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end
end

#
