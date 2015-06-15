FactoryGirl.define do
  factory :evaluator, :class => TicTacToe::Evaluator do

    factory :evaluator_with_grid do
        
      initialize_with do
        new(TicTacToe::Grid.new(3, 3))
      end
    end
  end
end
