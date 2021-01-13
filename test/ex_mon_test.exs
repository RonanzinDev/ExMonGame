defmodule ExMonTest do
  use ExUnit.Case
  alias ExMon.Player
  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "Criar jogador" do
      expected_response = %Player{
        life: 100,
        moves: %{
          move_avg: :soco,
          move_heal: :cura,
          move_rdn: :chute
        },
        name: "Morelli"
      }

      assert expected_response == ExMon.create_player("Morelli", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "Começa o jogo" do
      player = Player.build("Morelli", :chute, :soco, :cura)
      message = capture_io(fn -> assert ExMon.start_game(player) == :ok end)
      assert message =~ "O jogo começou"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Morelli", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "Quando o movimento é valido" do
      message = capture_io(fn -> ExMon.make_move(:chute) end)

      assert message =~ "O jogador atacou o computador"
    end

    test "Quando o movimento é invalido" do
      message = capture_io(fn -> ExMon.make_move(:invalid) end)
      assert message =~ "Movimento invalido"
    end
  end
end
