FactoryGirl.define do
  factory :row, :class => TicTacToe::Row do
    initialize_with { new(index) }

    sequence(:index, 1)
    
    factory :row_with_cells do

      after(:build) do |row|
        row.add_cell TicTacToe::Cell.new(1, 1)
        row.add_cell TicTacToe::Cell.new(1, 2)
        row.add_cell TicTacToe::Cell.new(1, 3)

        row.cells.each { |cell| cell.value = 'X' }
      end
    end
  end
end
