# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 18 Part 2
# https://adventofcode.com/2020/day/18#part2
# Answer is: 8952864356993

# rubocop:disable Metrics/ClassLength
class RPNExpression
  # Set up the table of known operators
  Operator = Struct.new(:precedence, :associativity, :eng, :ruby_operator)
  class Operator
    def left_associative?
      associativity == :left
    end

    def <(other)
      if left_associative?
        precedence <= other.precedence
      else
        precedence < other.precedence
      end
    end
  end

  OPERATORS = {
    '+' => Operator.new(3, :left, 'ADD', '+'),
    '*' => Operator.new(2, :left, 'MUL', '*')
  }.freeze

  # create a new object
  def initialize(str)
    @expression = str
    @infix_tree = nil
    @value = nil
  end
  attr_reader :expression

  # convert an infix expression into RPN
  def self.from_infix(expression)
    debug "\nfor Infix expression: #{expression}\nTerm\tAction\tOutput\tStack"
    rpn_expr = []
    op_stack = []
    tokens = expression.split
    until tokens.empty?
      term = tokens.shift

      if OPERATORS.key?(term)
        op2 = op_stack.last
        if OPERATORS.key?(op2) && OPERATORS[term] < OPERATORS[op2]
          rpn_expr << op_stack.pop
          debug "#{term}\t#{OPERATORS[op2].eng}\t#{rpn_expr}\t#{op_stack}\t#{op2} has higher precedence than #{term}"
        end
        op_stack << term
        debug "#{term}\tPUSH OP\t#{rpn_expr}\t#{op_stack}"

      elsif term == '('
        op_stack << term
        debug "#{term}\tOPEN_P\t#{rpn_expr}\t#{op_stack}"

      elsif term == ')'
        until op_stack.last == '('
          rpn_expr << op_stack.pop
          debug "#{term}\t#{OPERATORS[rpn_expr.last].eng}\t#{rpn_expr}\t#{op_stack}\tunwinding parenthesis"
        end
        op_stack.pop
        debug "#{term}\tCLOSE_P\t#{rpn_expr}\t#{op_stack}"

      else
        rpn_expr << term
        debug "#{term}\tPUSH V\t#{rpn_expr}\t#{op_stack}"
      end
    end
    rpn_expr << op_stack.pop until op_stack.empty?
    obj = new(rpn_expr.join(' '))
    debug "RPN = #{obj}"
    obj
  end

  # calculate the value of an RPN expression
  def eval
    return @value unless @value.nil?

    debug "\nfor RPN expression: #{expression}\nTerm\tAction\tStack"
    stack = []
    expression.split.each do |term|
      if OPERATORS.key?(term)
        a, b = stack.pop(2)
        raise ArgumentError, 'not enough operands on the stack' if b.nil?

        op = term
        stack.push(a.method(op).call(b))
        debug "#{term}\t#{OPERATORS[term].eng}\t#{stack}"
      else
        begin
          number = Integer(term)
        rescue ArgumentError
          raise ArgumentError, "cannot handle term: #{term}"
        end
        stack.push(number)
        debug "#{number}\tPUSH\t#{stack}"
      end
    end
    @value = stack.pop
    debug "Value = #{@value}"
    @value
  end

  private

  # convert an RPN expression into an AST
  def to_infix_tree
    return @infix_tree unless @infix_tree.nil?

    debug "\nfor RPN expression: #{expression}\nTerm\tAction\tStack"
    stack = []
    expression.split.each do |term|
      if OPERATORS.key?(term)
        a, b = stack.pop(2)
        raise ArgumentError, 'not enough operands on the stack' if b.nil?

        op = InfixNode.new(term)
        op.left = a
        op.right = b
        stack.push(op)
        debug "#{term}\t#{OPERATORS[term].eng}\t#{stack.inspect}"
      else
        begin
          Integer(term)
        rescue ArgumentError
          raise ArgumentError, "cannot handle term: #{term}"
        end
        stack.push(InfixNode.new(term))
        debug "#{term}\tPUSH\t#{stack.inspect}"
      end
    end
    @infix_tree = stack.pop
  end

  public

  # express the AST as a string
  def to_infix
    expr = to_infix_tree.to_s
    debug "Infix = #{expr}"
    expr
  end

  # express the AST as a string, but in a form that allows Ruby to evaluate it
  def to_ruby
    expr = to_infix_tree.to_ruby
    debug "Ruby = #{expr}"
    expr
  end

  def to_s
    expression
  end

  class InfixNode
    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end
    attr_reader :value
    attr_accessor :left, :right

    def leaf?
      left.nil? and right.nil?
    end

    def to_s
      to_string(false)
    end

    def to_ruby
      to_string(true)
    end

    def to_string(to_ruby)
      result = []
      result << display_child(left, to_ruby)
      result << (to_ruby ? OPERATORS[value].ruby_operator : value)
      result << display_child(right, to_ruby)
      result.join(' ')
    end

    def display_child(child, to_ruby)
      if child.leaf?
        child.value
      elsif OPERATORS[child.value].precedence < OPERATORS[value].precedence
        "( #{child.to_string(to_ruby)} )"
      else
        child.to_string(to_ruby)
      end
    end

    def inspect
      str = "node[#{value}]"
      str << "<left=#{left.inspect}, right=#{right.inspect}>" unless leaf?
      str
    end
  end
end
# rubocop:enable Metrics/ClassLength

def debug(msg)
  puts msg if $DEBUG
end

# input = '1 + 2 * 3 + 4 * 5 + 6' # 71
# input = '1 + (2 * 3) + (4 * (5 + 6))' # 51
# input = '2 * 3 + (4 * 5)' # 26
# input = '5 + (8 * 3 + 9 + 3 * 4 * 3)' # 437
# input = '5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))' # 12240
# input = '((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2' # 13632
input = File.readlines('../1 Input/day18.input').map(&:strip)

sum = 0
input.each do |inp|
  it = inp.gsub('(', ' ( ').gsub(')', ' )').gsub('  ', ' ')
  rpn = RPNExpression.from_infix(it)
  sum += rpn.eval
end
puts sum
