FactoryGirl.define do
  factory :player, :class => TicTacToe::Player do

    factory :human_player do
      initialize_with do
        new('X', true)
      end
    end

    factory :computer_player do
      initialize_with do
        new('X', false)
      end
    end
  end
end
