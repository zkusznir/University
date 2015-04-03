class Sudoku

  def initialize
    @board = [
      5, 0, 2, 0, 6, 0, 0, 0, 0,
      0, 0, 0, 4, 0, 0, 0, 8, 0,
      0, 0, 0, 0, 0, 2, 0, 0, 1,
      0, 0, 0, 8, 0, 0, 0, 5, 0,
      0, 0, 3, 0, 0, 0, 6, 0, 0,
      0, 7, 0, 0, 0, 9, 0, 0, 0,
      8, 0, 0, 2, 0, 0, 0, 0, 0,
      0, 4, 0, 0, 0, 1, 0, 0, 0,
      0, 0, 0, 0, 3, 0, 2, 0, 7]
  end

  def draw
    i = 0
    @board.each do |x|
      i += 1
      print "#{x} "
      puts "\n" if i%9 == 0
    end
  end

  def candidate_values(index)
    values = row_values(index, (1..9).to_a)
    values = column_values(index, values)
    values = subcube_values(index, values)
  end

  def row_values(index, values)
    current = (index/9).floor * 9
    9.times do
      values.delete(@board[current]) if @board[current] != 0
      current += 1
    end
    values
  end

  def column_values(index, values)
    current = index%9
    9.times do
      values.delete(@board[current]) if @board[current] != 0
      current += 9
    end
    values
  end

  def subcube_values(index, values)
    row = index/27 * 3
    column = index%9/3 * 3
    3.times do |i|
      3.times do |j|
        current = (row + i)*9 + column + j
        values.delete(@board[current]) if @board[current] != 0
      end
    end
    values
  end

  def first_empty_cell
    @board.index(0)
  end

  def solution
    index = first_empty_cell
    return true if index.nil?
    candidates = candidate_values(index)
    return false if candidates.empty?
    candidates.each do |c|
      @board[index] = c
      return true if solution == true
    end
    @board[index] = 0
    return false
  end
end
