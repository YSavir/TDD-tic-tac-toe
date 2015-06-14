FactoryGirl.define do

  factory :cell, :class => TicTacToe::Cell do
    initialize_with do
      new(0, 0)
    end

    factory :cell_with_value do
      after(:build) do |cell|
        cell.value = 'X'
      end
    end
  end
end
