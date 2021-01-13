defmodule ExMon.Game.Status do
  # funcao para exibir mensagens de inicio de jogo
  def print_round_message(%{status: :started} = info) do
    IO.puts("\n===== O jogo começou =====\n")
    # exibindo informações atuais do jogo
    IO.inspect(info)
    IO.puts("-------------------------")
  end

  # funcao para exibir mensagem do turno do player ou do o computador
  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\n===== Vez do #{player} =====\n")
    IO.inspect(info)
    IO.puts("-------------------------")
  end

  # funcao para exibir mensagem quando tiver gamer over
  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n===== GAMER  OVER =====\n")
    IO.inspect(info)
    IO.puts("-------------------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("Movimento invalido #{move}")
  end

  # quando o player atacar o computador
  def print_move_message(:computer, :attack, damage) do
    IO.puts("O jogador atacou o computador causando #{damage} de dano")
  end

  # quando o computador atacar o player
  def print_move_message(:player, :attack, damage) do
    IO.puts("O computador atacou o jogador, causando #{damage} de dano")
  end

  def print_move_message(player, :heal, life) do
    IO.puts("O #{player} se curou #{life} de life")
  end
end
