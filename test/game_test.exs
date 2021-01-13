defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "start/2" do
    test "Começar o jogo" do
      player = Player.build("Morelli", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "Pegar as informaçoes do jogo" do
      player = Player.build("Morelli", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Morelli"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "Retorna o estado do jogo atual" do
      player = Player.build("Morelli", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Morelli"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Morelli"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)
      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "Retorna o player" do
      player = Player.build("Morelli", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
        name: "Morelli"
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "Retorna o turno atual do jogo" do
      player = Player.build("Morelli", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/1" do
    test "fetches the info on the player passed as a parameter" do
      player = Player.build("Morelli", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response_player = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
        name: "Morelli"
      }

      expected_response_computer = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
        name: "Robotinik"
      }

      assert Game.fetch_player(:player) == expected_response_player
      assert Game.fetch_player(:computer) == expected_response_computer
    end
  end
end
