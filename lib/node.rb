# frozen_string_literal: true

# Node
class Node
  attr_reader :data
  attr_accessor :left :right

  def initialize (data)
    @data = data
    @left = null
    @right = null
  end
end