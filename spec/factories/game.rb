FactoryGirl.define do
  factory :game, :class => TicTacToe::Game do

    factory :game_with_grid do
      initialize_with do
        new
      end

      after(:build) do |game|
        game.create_grid(3, 3)
      end
    end
  end

end
