FactoryGirl.define do
  factory :game, :class => TicTacToe::Game do

    factory :game_with_grid do
      initialize_with do
        new
      end

      after(:build) do |game|
        game.create_grid(3, 3)
      end

      factory :game_with_grid_and_human_player do
        after(:build) do |game|
          game.players << TicTacToe::Player.new('X', true)
        end
      end

      factory :game_with_grid_and_computer_player do
        after(:build) do |game|
          game.players << TicTacToe::Player.new('X', false)
        end

      end

    end
  end

end
