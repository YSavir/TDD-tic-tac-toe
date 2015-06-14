FactoryGirl.define do
  factory :grid, :class => TicTacToe::Grid do

    initialize_with do
      new(3, 3)
    end
  end
end
