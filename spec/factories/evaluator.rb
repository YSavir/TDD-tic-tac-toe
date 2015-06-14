FactoryGirl.define do
  factory :evaluator, :class => TicTacToe::Evaluator do

    factory :evaluator_with_grid do
      grid = TicTacToe::Grid.new(3, 3)
        
      initialize_with do
        new(grid)
      end
    end
  end
end
