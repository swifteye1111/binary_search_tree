# frozen_string_literal: true

# Node
class Node
  include Comparable
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data = 0)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    data <=> other.data
  end
end
