class RPNExpression

    # Set up the table of known operators
    Operator = Struct.new(:precedence, :associativity, :english, :ruby_operator)
    class Operator
      def left_associative?; associativity == :left; end
      def <(other)
        if left_associative?
          precedence <= other.precedence
        else
          precedence < other.precedence
        end
      end
    end

    Operators = {
      "+" => Operator.new(3, :left, "ADD", "+"),
      "*" => Operator.new(2, :left, "MUL", "*")
    }

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

        if Operators.has_key?(term)
          op2 = op_stack.last
          if Operators.has_key?(op2) and Operators[term] < Operators[op2]
            rpn_expr << op_stack.pop
            debug "#{term}\t#{Operators[op2].english}\t#{rpn_expr}\t#{op_stack}\t#{op2} has higher precedence than #{term}"
          end
          op_stack << term
          debug "#{term}\tPUSH OP\t#{rpn_expr}\t#{op_stack}"

        elsif term == "("
          op_stack << term
          debug "#{term}\tOPEN_P\t#{rpn_expr}\t#{op_stack}"

        elsif term == ")"
          until op_stack.last == "("
            rpn_expr << op_stack.pop
            debug "#{term}\t#{Operators[rpn_expr.last].english}\t#{rpn_expr}\t#{op_stack}\tunwinding parenthesis"
          end
          op_stack.pop
          debug "#{term}\tCLOSE_P\t#{rpn_expr}\t#{op_stack}"

        else
          rpn_expr << term
          debug "#{term}\tPUSH V\t#{rpn_expr}\t#{op_stack}"
        end
      end
      until op_stack.empty?
        rpn_expr << op_stack.pop
      end
      obj = self.new(rpn_expr.join(" "))
      debug "RPN = #{obj.to_s}"
      obj
    end

    # calculate the value of an RPN expression
    def eval
      return @value unless @value.nil?

      debug "\nfor RPN expression: #{expression}\nTerm\tAction\tStack"
      stack = []
      expression.split.each do |term|
        if Operators.has_key?(term)
          a, b = stack.pop(2)
          raise ArgumentError, "not enough operands on the stack" if b.nil?
          op = (term == "^" ? "**" : term)
          stack.push(a.method(op).call(b))
          debug "#{term}\t#{Operators[term].english}\t#{stack}"
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
      debug "Value = #@value"
      @value
    end

    private
    # convert an RPN expression into an AST
    def to_infix_tree
      return @infix_tree unless @infix_tree.nil?

      debug "\nfor RPN expression: #{expression}\nTerm\tAction\tStack"
      stack = []
      expression.split.each do |term|
        if Operators.has_key?(term)
          a, b = stack.pop(2)
          raise ArgumentError, "not enough operands on the stack" if b.nil?
          op = InfixNode.new(term)
          op.left = a
          op.right = b
          stack.push(op)
          debug "#{term}\t#{Operators[term].english}\t#{stack.inspect}"
        else
          begin
            Integer(term) rescue Float(term)
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

    private
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
   
      def to_s;    to_string(false); end
      def to_ruby; to_string(true);  end 
   
      def to_string(to_ruby)
        result = []
        result << display_child(left, to_ruby, (to_ruby and value == "/"))
        result << (to_ruby ? Operators[value].ruby_operator : value)
        result << display_child(right, to_ruby)
        result.join(" ")
      end
   
      def display_child(child, to_ruby, need_float = false)
        result = if child.leaf?
                   child.value
                 elsif Operators[child.value].precedence < Operators[value].precedence
                   "( #{child.to_string(to_ruby)} )"
                 else
                   child.to_string(to_ruby)
                 end
        result += ".to_f" if need_float
        result
      end
   
      def inspect
        str = "node[#{value}]"
        str << "<left=#{left.inspect}, right=#{right.inspect}>" unless leaf?
        str
      end
    end
end

def debug(msg)
    puts msg if $DEBUG
end

# input = ["1 + 2 * 3 + 4 * 5 + 6"] # 231
# input = "1 + (2 * 3) + (4 * (5 + 6))" # 51
# input = "2 * 3 + (4 * 5)" # 26
# input = "5 + (8 * 3 + 9 + 3 * 4 * 3)" # 437
# input = "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))" # 12240
# input = "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2" # 13632
input = ["(2 + 6) * 2 + 2 + 4","6 * 2 * 6 + (8 + 8 * (5 + 4 * 7 + 6 + 6 + 3)) * 8","2 * 7 * 3 * 6 + 2","(2 * 4 + 2 + 8) * 4 + 7 + 6 * 7","7 * ((7 + 4) + 7 * (3 + 4 * 8 + 7 * 8) * 2 * (4 + 3 + 9 * 5)) + (9 * 6) + 8","7 + 3 * (9 * (3 * 7 + 8 * 4) + (4 * 5 + 7)) * 9","9 + 9 + 3 + 7 * 3","(4 + 9) + 8 + 4 * 9 * (6 + 4 * 4 * 3 + 9 + 4)","5 * (6 * 4 * (8 * 4 * 4 * 9) + 6) * 7 + (8 + 3 + (8 * 3 * 6) * 5 * 5)","6 * 6 * (6 + 6 + 6 * (8 * 4 * 2 + 8 * 6) + 4) + 3","5 * 4 + 3 + (2 + 6) * 8 * 4","(8 + (3 * 7 * 4 + 4) * 2) + (8 * 8 * 4 + 6 * (8 + 9 + 7 + 9 + 5 + 3) * 4) * 5 * 4 * 3","9 * 7 + 6 * 9 + (3 * (7 * 5 * 6 * 3 + 3 * 8)) * 7","5 * 8 * 7 * 9 + 5 + (9 * (4 + 4 * 2 + 9 * 7) * 3)","(6 * 3 + 9 + (2 * 4 + 4 * 3) + 3) + (9 + (5 + 4) + 8) + 6 * 9","6 * (8 * (2 + 3 * 6 + 6 + 9) + (7 + 6 + 2) * 9 * 9)","(7 * (8 + 3 * 8 + 5 + 2 + 2) * (9 * 9 * 3 + 4 + 5) + 5 + 6 + 8) * 5 * (5 + (6 + 3 + 4 * 3 + 6) * 3) * 8 * 3","9 * 8","7 + ((6 * 7 + 5 + 8) * (5 * 9 + 9))","3 * 8 + 7 + 7 + (3 * 5 + (9 + 3))","(2 + (5 * 2 + 5 + 8) * 8 * (7 * 7) + (7 + 4 * 2 * 6 * 8 * 2) + (9 * 3)) + (2 * 2 * 6 * 6) + 5 * (5 + 5 + 6 + (6 * 3 + 8)) * 7","7 * (7 + 7 * 8 + (9 + 9) + (5 + 5 * 8)) + 4","8 + ((5 * 4 + 5 * 9) * 2 * (9 * 6 + 9 + 3) * 5) * 2 * (5 * 6 + (2 * 2 + 2 * 5 + 3 * 7) + 7 + 8)","(8 + 9 * 6 * 6 + 4 * 6) * 9 * 4 * (9 * 7 + 2 + 5 * 3 + (2 * 3 + 8 + 5 * 7 * 8)) + 2 * 9","(4 * 9 * 9) * (2 * 9 * 2) * 3 + 6 * (2 + 6 * 4 * 7 + 8 + (6 * 7 + 6 + 4)) + 6","(5 + 2 * (7 * 2 + 6 * 8 + 4 * 5) * 2 + 8) + 8","3 * 6 * 8 + 2 + ((3 + 7 + 4 + 2) + 9 * (2 + 5 * 4 + 4 + 6) + (7 + 8 + 3 * 4 * 2)) * 9","(2 + 7 * 7) * (7 * 8 * 9) * ((5 * 4 + 5 + 2 + 6 + 7) * 7)","(6 + 2 + (9 * 2 + 2) * 7 * 7) * 2","7 + ((8 * 3 + 3 * 2 * 6 * 5) + 7) * 8 + 4 + (6 + 5 + (2 * 2 + 5 * 3) + 5 * (5 * 6 + 4 + 7 * 3)) + 8","7 * 7 * 8","7 + 7 * 4 + ((6 + 9 + 5) + 3 * 5 * 7 + 7)","2 * 3 + (8 + 5 * 3 + 8 + 7 * 2) + (2 * (5 + 2 + 5 * 6 * 2 * 7) + (6 + 8 + 7 * 5)) + 9 * 4","5 * 5 + 6 * 6 + 7 * (5 * (2 + 6 + 6) * (5 * 9 + 8) + 7 * (9 * 5 * 8 + 2 * 4))","((7 * 6) + 8 * 9 + 8 + 9) * 8 + 7","4 + 5 + (8 * 7 + 8) + (3 + (2 * 2) * 9 + (7 + 7 * 9 + 8))","(7 * (4 * 5 * 9 + 4 + 8 * 7) + (8 * 7 + 9 + 9)) + 2","9 * 4 * (2 * (6 * 9) + 3)","((7 + 4 * 6 + 4 + 6 * 4) * 6 + 3) * 2 * 2 + 5 * 7","((6 * 5 * 9 + 7 + 9 + 4) + (7 + 2 + 7 * 3) * 9 + 9 + (7 + 7 * 9 * 5 * 3 + 6)) + 7","4 * ((6 + 2 * 9 + 6 + 3 * 3) * (6 * 8 * 7 + 5 * 4)) + 8 * 8 + 7","(5 * 3) + 3 + 4 * (5 + 8 + 2)","6 + 3 + 5 + 4 + 4 * 4","2 * (3 + (8 * 9 * 3 * 3 + 8) + (9 + 7) * 7 * 2) + (5 + 4 * 7 * 2 * 3 * 6) + 7 * (7 * 4) * (4 * 5 + 6 + (6 * 3) + 6 * 5)","3 + 7 + 8 * 3 + (3 * 2 * 4) * 9","9 + (2 + 2 * 6 + (9 * 9 + 6 + 8 + 5) + 4) + 2 * ((7 + 2 + 6 + 7 + 3 + 4) + 2 + 8 * 3 * 3) + 9","3 + ((6 + 5 + 6 + 7 + 9 * 4) * 9 * (2 * 6 * 6) * 6 + (9 * 9 + 8 * 9) * 2) * 6 + 3","(2 + 8) * 7 * 3 + 9 * (7 + 6 * 7 * 4)","(5 + 2 + 2 * (3 + 5 + 5 * 9 + 2) + 5 * (9 + 8 + 2 + 2 * 4)) + 6 + 6 * 3","3 * 5 + 6 * (8 * 3 * (7 + 8 + 6 + 4 + 9) * 7) * 7","2 * 9 * 8 * (6 + 5 + (3 * 9 + 6) + 3 * 4 * 4) + 2","3 + 8 * (4 + (3 * 5 + 6 * 2 * 7) * 2 * 2 + 2 * 5) + 2","((6 + 9) + 3 * 3) + 9 + 3 * (8 * 2 * 6 * 5) + 2","7 + 5 + (7 + (2 * 3 * 4) + 2 * (5 + 8 * 2 + 4 * 4 + 7))","2 + (4 * 9 + 7 + 8 * 4 + 4) * 9 + 5 * 5 * 8","5 + 5 * (3 * (2 + 5 * 3 + 7 + 5 + 3) + 6 * 9 * 7 + 6) + (7 * 8 * (9 * 9 * 9) * 2 * 9 + 2)","9 + (9 + (8 * 7 * 7 + 6) + 9 + 6 + 4) + 9 + 5 * 2","4 + (6 * 9 + (8 * 7 + 8 * 6) + (6 + 8)) + 2 + (4 * 3 + 6)","8 + 5 + 3 * (9 + 7 + 2 + 7 * 4) * 6","(3 * (9 + 9) + 7) + (6 * 8) * ((7 + 7 + 4 + 5 + 6 + 6) + 8 * 7) * 8 + (2 + 7 + 4 + 5 + 9)","(5 * (8 + 9 * 2) * (3 + 5 * 7 + 9) * 6 + (8 + 3 + 5) * (9 * 9)) + 6 * 5 + 6","((6 + 5 * 9 + 3 * 6) + (3 + 4 + 8) * (5 * 4 + 4 + 6) * 2 + 9) + 6 * 5 * 4 * 4 * 5","5 + (7 * 9 + 9 + (9 * 4 + 5 * 9 + 5) + 5) * 7","5 + (3 * 3 + 6 * 9 * 5 * (7 + 5 + 2)) + (8 * (4 * 2)) + 9 * (7 * 6 + 8 + 5 + 9 + 6) + ((6 + 2 + 5) + (4 + 3 + 3 + 2 * 3 + 4) * 3 * 9 * 3)","7 * (2 + 2 + 6 + 7 * 7) * 2 * 7 + (8 * 7) + 5","2 + (7 * 6 + (4 * 2 * 9 + 3) + (2 + 5)) + 8 * (2 * 2 * (8 * 3 * 3 * 6 + 2) + 7) * (8 + (7 + 4 * 6 + 5 * 9) + 4)","((6 * 3 * 6 + 3) * (3 + 4 + 9 * 6 + 6) + 4 + 2 * (9 * 9 + 4) * 3) + 4 + 6","8 + ((5 + 7 * 5 * 8 + 9) + 4 + 8 * 4 * 5) + ((3 + 4) + 3 * 7 + 9) + (6 + 2 * 9 + 5) + 9","(9 + (8 * 5 * 7 * 4 * 2 * 7) + 8) + 8 * 7","9 * (4 * 7) + 8","3 * 6 * (5 + (5 * 5 + 6) + 2 * 5 + (8 + 2 * 4 + 9 + 4)) + 8 + 7","((6 + 8 * 2) * 2 + (4 + 2 + 5 + 9) + 9) + 2 * (8 * (2 + 9 + 5 + 4)) + 9 + 4 * 2","4 * 5 * 4 * (3 * 4 + 4 * (5 + 3 + 8 * 2 * 7 * 5) * (6 * 4 * 8 + 5 * 9 * 8) * 9) + 7 + 2","8 * 6 * 9 + 3 + (6 * 7 * (6 * 7 + 6 * 6) + (9 + 3) * (7 * 7 + 9))","3 * (9 + 7 + (5 * 9 + 4))","5 * (2 * (5 + 4 * 2 * 6) * 4 + (5 + 3))","7 * ((3 + 8 + 8 + 2 * 2) * 5 * 6) * (7 * 2 + (6 * 4 * 9 * 5 * 9)) * 7","(5 * 5 + (3 + 3 * 8 * 4) + 8 * 4) * (5 * 9 + 4) * 9 * 7 + 5 * ((2 + 7) * 9 + 5 * 4 + 3)","9 * 4 + ((3 + 9 * 3 * 2 + 9) + 4 + 6 * 2)","2 * (6 + 6 + (7 + 6) * 2 * 2 + 4) + ((2 + 3 + 5) * (2 + 9 * 9 + 7) * 4 * (2 + 4 + 6 * 3 * 9 * 3)) + 3 * 4","(8 * 7 + 6 * 6 * 7 + 9) * 8","9 + 8 * ((2 * 9 + 9 + 5 * 2 + 5) + (8 * 3 + 7 * 5 + 7) + 9 + 2 + 8) * 8 * (5 + 4 + 8 + 4 * 6) * 8","6 + 6 * 2 + (6 * 9 * 5 + 6) * 3 + (5 * 4 + 8 * 6 + 9)","5 * 6 + 7 + (7 * 4 * 4 * 8 * 8)","(6 + 5 * 3 + 3) * ((9 + 7 + 6) * 4 * 6 * 6 + 4)","5 * (2 + 7 + 5 + 2) + 6 * 5","7 + 5 + ((7 * 3) + 5 + 9 * 8) * (3 + 2 * 7 + 7 * 5 * 8) * 7","3 * 9 + (5 + 8 * (6 + 8 * 6) * 4 + 3 * 4) * (2 + 6 * 5 * 3) * 8 * 7","9 + 8 + 2","(3 + 4 + 6 + (5 * 6 * 8 + 4 + 5 + 7) + 6) * 9","4 * 3 + 9 + 3 * (5 * 4 + (7 + 4 * 2 + 8 + 2 + 6))","7 * (2 * 6 + (3 * 5 * 7 + 4 + 6)) * 5 + 9 * 4 + 6","((7 + 4 * 5) + (5 + 5 * 5 + 7 * 6 * 9) * (9 * 3 + 9 * 3) * (6 * 6 * 2 + 5 * 7) * 3) + 6 * 4","((9 * 7) * 8 + 4 * 8 + 5 + 5) + ((2 + 4 * 3 + 4) * 9 + 2 * 5) + 6 + (4 * 6 + 2 * 9)","(4 * 3 * 3 * (9 + 9 + 9 + 3 + 6 + 9)) + 9","((6 + 2) + 9 * 4) * (2 * 7 + 5)","2 + (4 * 8 * 8 + 8 * 9 * 9)","((2 + 6 * 4 * 8 + 5) + 2 + 7) * 9 * ((3 * 8 * 7) + 3 * 9)","((4 + 9 * 5 + 7 + 8 * 8) * 6 + 6 + (5 + 8) + 4) * 8 * (5 + 4 + (5 * 3) * 5 * 6 * 4) + 8 + (2 + 9 * 7 * (5 * 8 + 4 + 2 * 8 + 5))","5 + (8 * 6 + (2 + 5 + 9 * 8 + 9) * (9 * 2 * 4 + 6 * 5 + 2) * (3 * 8 * 7) + 9)","2 + 8 + 7 + 6 * (3 + 4 + (6 + 7 * 2 + 9) * 7) * 7","7 * 8 + 7 + 4 * (5 + 6) * 3","7 + 5","(2 + (6 * 3 * 3) + 2) * 5 + 7 + 8 * 6","(6 + 6) * 3 + (2 * 4 + 3 + (3 + 9) * 9)","(5 * 4 + 3 * 8 * 9 + 4) + 5 + (6 + 9 + 3) + (9 + 8 * 3)","5 + 4 * (6 + 5) + (3 + 9 + 4)","4 * 5 + 5 + 7 * 5 + (6 + (4 * 6 * 8 + 7 * 4 * 6) * 9 + 2 + 3)","7 * 9 + 6 * (8 * (8 + 6 * 4) * 4) * (7 * 2) + 6","(3 + 5 * 9 * 8 * 4 + 2) * 3 * 6 * 3","3 + 8 * 3 + (3 + 3) * 3","2 * 8 * 8 * (2 * 7 * 9 * 4)","(5 + 7 + 9 + 7 + 4) + (5 * 9) * 3","8 * 9 * 5 * 4 * 3 + ((6 + 9 * 5 * 7 * 2) + 5 * 4)","(7 + 3 * (8 + 2 * 3 * 9 + 2 + 9) * 6 * 9 * 2) * (4 * 4) * (2 * (4 * 8 * 5) + 3) * 2 + 4 * 9","7 + 8 * 6 * (9 + (4 + 8 * 5) * 2 * 3 * 7) + 6 + 8","(7 + 7 + 7 * 9) * 2 * 4 + 5 + 5 * 6","(2 * (3 * 8)) + (5 + 4 * 4 * 3)","(5 * 7 * (5 * 7 * 9 + 3 * 3) + 7) + 3","9 + 9 + 8 + 8 * ((3 + 3 * 6 + 4 * 4) + 2 * 3) + 6","(2 + (2 * 2) + 9 + 7) + (5 + (8 + 4) * 3 * 3) + 4 * 5 + 4 + 3","6 + (5 * 3 * 7) * 6 + ((5 + 6 * 4 + 3 * 5 * 9) * 4 + 8 + 2) + (8 * 6 + 5 + 2 * 2)","9 * (5 + 7 + 9 + 9) + 7 * 3 + 4","(6 * 8 + 5 + 8) * 2 + 2 * (4 * 2 + 8 + 5) + 7 + ((5 * 5 * 3 + 6 * 5 * 8) + 6 * 3 + 2 * 7)","(3 + (6 + 4 * 6 * 7 * 4) + 5 + 2 * 6) + 5 + 6 + 3","6 + (8 + 9 + 5 * 5 + 5 * 2) * 6 * 8","(5 + 2 + 2 * 3 * (4 * 2)) + 8 * 5 + 6 + 3","7 * (8 * 3) + (7 + 5) + 2 + 8","5 * 4 + 8 * ((9 * 9 * 3 + 3 + 9 * 8) + 2 + 5 + (7 + 3)) * (3 + (7 * 3 * 6 * 5) * 8 * (6 * 6 + 2 + 9 + 5) * 2 + 5) + (2 + 4 + 5 * 8 * 7 * 6)","5 + (8 * 6 + (7 * 2 + 9 + 6) * 8 * 2) + 3 * (9 * (5 * 2 * 3) * 5)","(2 * 8 + 4 * (7 * 8 + 2 + 5 + 3) * 4 * 3) + (7 + 5) + 9 * 9 * 2","((3 + 7 + 9) + (8 + 8) + 6 + 4) + 4 + 8 + 7 * (4 * 3 * 6 + 7 + 8 * 2)","9 * (4 * 3 * 8 + 8) * 3 + (4 * 8 + 6)","7 * ((4 * 3) * 6 + 6) + 5 * 3 * 3 + 9","4 * (5 * 4 * 3 * (2 + 5 + 6 + 2 * 2 + 6) * (5 * 6 * 2 * 7 * 7) * 6) * 2","7 * 7 + (8 + (7 * 6 + 7) + 2 + (4 + 5 + 6 + 4) + 2 + 9) + 3 + 3","8 + ((4 * 6 + 2 + 7 + 9 + 5) * 3)","3 * 7","(5 * 7 * 4 + (7 * 6) * 9 + 4) + 5","(2 * 5 * 9 * 6 * 5 + 7) + (3 + (3 * 6 * 7 + 5 + 2) + 4 + 5) * 6","9 + ((8 + 9) * 5) + (3 * (7 * 7) * (7 + 8)) * ((8 + 3 * 5 * 8) * 9 * 9 * (6 * 8) + 7) + 8 * 3","7 + (7 + 9 + 9 + 3 + (8 * 2 * 9 * 6 * 7 * 4) * 6) * 7 + 9","(9 * 5) + 3 * (2 + 6 * 4 * 6 + 4) + (2 + 5 * 3 + (3 * 7 + 6 + 8)) + 6","(8 * 2 + 8 * 6 * (4 + 3 + 2 * 3 * 4)) + (7 * 4)","(2 + 3) + 7","3 + 3 * 8 + 9 + (9 + (6 * 5 + 7 + 6 + 9 * 6) * 8) + 5","2 + (6 + 8) * 3 * 3 + 2 + 3","5 * ((4 + 8) + 2 + 7)","(3 * 8 * 9 + (9 * 3 + 8 + 2) + 2 * 5) + 7","4 + 9 * 3 * (4 + 2 + 4)","5 * 6 * (6 + (7 * 2 * 4 * 5 * 4) + 6 + 5 + (6 + 9 + 7 + 8 * 3) + 3) + 2 * 2 + ((6 + 5 * 9 * 8 * 3 + 4) * 4)","6 + 8 * 9 + 6 + (5 * 9 + 9 + 7)","(6 * 6 + (8 + 5 * 5 * 9) * 9) + 2 * 4 + (9 * 4) * 8 * 7","((5 * 3 * 8 + 6) + (2 * 8 * 4 * 6) + (6 + 8 + 5 + 4 * 5)) * 7","9 * ((4 * 4 * 6 + 3 * 2) + 3 * 6) + 5 + 7 + 7 + 3","6 * 3 * 6 * 9","6 * 7 + 9","3 * (6 * 8 + 3 + 7 + 8) * (3 + (3 + 2 * 3) * 6 * 8) * 8 * 8","3 * (9 + 6 + 7 + 9)","6 * (5 + 6) * 5 + (8 + 5) * 3 * 7","6 + 2 * ((7 * 2) * (7 * 9 + 8 + 2 * 3 + 5) + 6 + 3)","5 * 3 * 2 + 7 + (6 * (3 + 3 + 3) * 5 + 6)","5 * (2 + 7 * 7) * 3 + 3 * 9","7 + 4 * 9 * ((8 * 5) * 8 * 4 * 4 * 4)","(5 + 4 + 9 * 9) * (4 * 3 + 2) + 2 * 9 * 7","8 + (6 * 3 * 8 * 7 + 8) * 2 + 5 * 5 + 3","4 + 8 * 8 + (4 + (8 * 5 * 6 * 2))","((3 + 2) * 4 + (7 * 5) + (8 + 5) * (5 + 6 + 5 * 7 + 9)) + 4 + 6","(6 + 2) + (8 * 4 + 3 * 4 * 7) + 5 * 2 * ((4 + 9 * 6 + 8 * 8) + 6 * 9 + 2)","7 * 9 * 9 + (6 * (3 * 8 + 3) + 6 + 5 * (4 * 9 * 7 * 9 + 4 + 3)) + 9 * 5","5 * 9 * 3 * 9","(6 + (7 * 8 + 4 + 9 * 7) + 8) + 6 * (2 + 7 * (6 * 3 * 9 + 2 * 3)) + 7 * 5","9 + (5 * 4) * 6 * (8 * 8)","2 + (8 + 8 * (9 * 6 * 6 * 8) * 2 * 5) + 9 * 9 + 8","((9 + 3 + 9 * 3) + 9) * 9","6 * 7 + (2 + 5 * (6 + 6 * 4 * 5) * 3 * 7 * 5)","6 + (5 + (2 * 4 * 2 + 7) * (3 * 7 * 9 * 5 * 4 + 7)) + 6","2 * (9 + 7 + (5 * 4) + 3 + 9)","8 * 9 * (6 * 6 * 9 * 5 * 5 * 9) * 4","(7 * 2 + 4 + 2) + 9 + ((9 * 7 + 4) + 6 * 5) * (5 * 8 + 8 + 2 + 2) * 3","7 * (8 * (6 + 7) * (7 * 9 * 2) + 2 + (8 * 6 + 9 * 5 * 3 + 8) * 2)","((8 + 7) * 9 * 5 * (3 * 2)) + 4","7 * 7 + 3 + 8 * (3 * (7 + 8 + 9) + 8 + 3 * 3 + 8)","(4 + 5 * 7 * 3) + (2 * 4)","9 * (3 * 7 * 6) * (5 + 8 + 3 * 2 + 5) * 2","7 * (6 * (8 + 5 * 9 * 3 + 8 * 4) * 9 + (8 + 9 + 5)) * (8 * 6) * (7 * 3 * 8 * 9) + 9","8 + 6 * 5 * 6 + 3","2 * 7 * 9 + 6","(2 * 8 + 2) + 4 + 8 + 9 + 7 * 4","(7 + 3 * 8 + 4) + (4 + 8 * 6) * 8 * ((6 + 5 + 2 * 6) + 3) * 2","((4 + 2 + 8 + 9) + 3 * 8 + (2 + 5 + 8 + 3 * 6)) + (8 + 7 * 9 + 6 + 9) + 9 + 5","(6 + 7 + 9 * 8) * 4","(2 + 7 * 7 + 8) * (7 * 2) + 9","(8 * 5 + 3 + 5 + 8) * 5 * (2 + 9 + 4 * 8 + 8) * (3 * 6 * 6 * (4 * 4 + 5)) * 6","5 + ((3 * 5 * 7 * 3) + (5 * 2 * 8 + 6 * 9)) + 4 + (2 * (9 * 9 + 5))","4 + 3 * 2 + 2 + 8 + 4","(8 + 2 * 8 + 5 + 5 + 9) + 4 + 5 * 9 + 6","5 + 9 + 7 + 6 + 6 + (4 * 3 * 7 + 5)","9 + 3 + 4 * (2 * 6 + 8 * 3) * (4 + 6 * 7 * 3 + 6) * 4","8 + 9 + 2 + (9 + 9 * 3 + 4) * (3 * 8 + 9 + 3 * (3 * 2)) * (3 * (3 + 9 + 4 + 2 * 4 * 6) + 6 * 8 * 9)","6 * (7 * 8 * 8 + 5 * (2 + 6 + 9 + 4 * 9))","9 * (7 + 5 + 9) + (5 * (7 + 7 + 5 * 3 * 7 * 4) * (6 * 9) + 4 * (6 + 4 + 6 * 7 * 9)) * 4 + 6 + 6","(4 + (7 * 7) * 2 + 4 * 3) + 8 + (3 * 9 * 8 + (5 * 6 * 2) * (7 * 6) * (5 + 4 + 2)) * 9","((2 * 6) * 7 * (4 + 7 + 9 + 3) * 6 + 6) + 4 * 8 + 6 * 8","(6 * 2) * (4 * 5 * (9 + 9) + 7) * 6","7 * 2 * 4 + 4 + 5 + (9 + 3 + 7 * 8 + 5)","8 * (9 + 7) + 5 + 9 * (4 + 5)","8 + 7 * (5 + (6 + 6 + 3 + 5 * 8 * 7) + 3) * (8 + 5 * 4 + 9 * 2) * 2 + 7","3 + (5 * 2) + 5 * 4 + (5 * 5 + (9 * 2 + 8 * 8) * 6 * 8 + 4) + 6","8 + 9 * ((2 * 8 * 9) * 3 + 9)","6 * (5 + 5) * 5 * 4 * 3","(6 + 2 + 3 * 5 + 6) + 8 + 9 * (3 + (9 + 5 + 4 + 9 + 4)) * 2 + (3 * 5 * 2 + 2 * 2 + 3)","(8 + (5 + 4 + 9) + 8) + (9 + 5 * 2 + 7 * 8 * 7) * 6 + 9 * (2 + 7 * 6)","2 + 6 * 5 * (6 * 6 * 7 + 4 + 4 + (7 + 6 * 2 * 5)) + (2 + 5 * 8 + 4) * (5 + (2 * 2) + 9 * 2 * 6)","(8 + (9 + 8 * 5 * 3 * 8) * 7 + 4 + 7 + (7 + 3 + 9 * 7 + 3)) + (4 * 6 * (9 + 9 * 4 + 5) * 6) * (5 * 8 * (5 * 7 + 4 + 7 * 5)) + 9 * 6","2 * 4 * 3 * 6 * (8 * 9 * (5 * 8 * 6)) * 7","4 + (4 * (7 * 6 + 2 * 8 + 2)) * 7","(4 + 8 * 8 * (3 + 8 * 7) * 3 + 8) * 7","8 + 5 + (7 * 3 + 5 * 4) * 6 + 9","7 + (5 + (3 * 6 * 8 * 9) * 6 + 7 + (4 * 5 + 8 + 4 + 7 + 5)) + 3 + 6","(9 * 6 + 2 + 6 + 6) * (8 + 7 * 3) + ((4 * 4 + 3 + 6 * 9 + 5) + 4 * 3 + 5) * 3 * 6 + 4","8 * 3 * 2 * ((4 * 4 + 5 * 4) + 9 * 6 + 5 * (7 * 7)) * 2 + 7","8 * 7 * (6 + 6) + (3 * (4 + 8) + 4 * (2 * 4 * 5 + 9 + 7 + 9) + 6) + 4","4 + (5 + 6 + 4 * 8 + 7 + 9) + ((5 + 7 * 5 * 5) + 4) * 4 * 2","5 + 9 + 4 + ((4 + 4 * 5 * 2 * 5 * 5) + 5 * 5 * (5 * 3 * 8 + 6 + 4) * 8)","7 * 2 + 4 * ((9 + 9 + 9 + 4 + 6 + 5) + 7 + (5 * 5 + 6 * 8 + 8) * (5 + 6 + 7 * 6 * 4 * 6) * 9 + (3 * 6 + 7 * 4)) + 9","(4 + 9 + 5) + (7 * 2 * 7 * 5 + 5) * 8 * 6 * 2","(4 + (3 * 9 * 5) + 8 + 7) * 9 + (3 * 8 + (5 + 7) + 8 * 3)","(4 + 9 * 8 * 2 + 3 + (7 * 3)) + 6","8 + 4 + 5 * 2 * (2 * 9 * (4 + 5) * 3 * (7 + 3 + 6 * 5 * 6 + 2))","8 * 5 + 8 + 8 + (4 * 6)","4 + 2 * 9 + (3 + 8 * (7 * 2 + 5 + 4 * 8 * 5)) * ((5 + 6 * 7 * 4) * 7 * 8)","3 + 4 + 3 * 4 + 6","(5 * 5 + 2 * (7 + 5 + 4 * 7 + 8 + 6)) * ((5 + 5 + 3 * 4 * 5) * 2 + 2 + 4 + 4 * 5) * 9 + 6","(3 * 9 + (5 * 6 + 5) + 4) + 2","(7 + 6 * 8 + 7 + (8 + 5 * 4 * 6)) * 2 + 4","5 * ((4 * 9 + 9 + 5 * 6 * 4) + 4) + (4 * (3 + 4))","5 * (4 + 2 + 2 + 9 * 8 * (4 + 7)) + 9 + 7","8 * (5 + (5 + 8 + 5) + 2) * (9 * 4 * 5 * 7)","(4 * (2 + 8 + 7 + 9 + 6 * 7)) * 5 * 8 * 6 * 2","(2 * 4 * (2 * 5) + (9 + 2 + 4 + 6) + 4) + (2 * 3 + (7 + 9 + 7 + 2) * 7) + 5 + 9 + 2","2 * (8 + 3 + 9)","4 * 3 * 7 + 4 + (7 + 8 + 2 + 7 * 8)","3 + 3 + (8 * 7)","6 + 7 * 3 + 6 * 2 + 4","(9 * 3 * 5 * 9 * 3) * 6 * ((2 * 5 + 2) * 5) * 8","(2 * 6) * 2 * (8 + 5 * (2 + 4 * 6 * 6 + 2 + 4) * (9 * 5 * 8) + (8 + 7 + 6 + 6) + 5) + 6 + (5 * 3 * 3 * 7 * (6 * 2) + (9 + 4 * 7 * 2 + 5 * 6))","(2 * 5 + 4) * 6 + 8","5 * 4 + (9 * 6 * 3 + 7 * 6) + (9 * 2 + 7 * 5) + 8 + 3","8 + (6 + (9 * 2 + 9 * 4 + 2 * 9) + (7 + 7 + 2 + 8) + 7 * 8) + 7 * 7","(3 * 2 + 8 * 9 + (3 * 2 * 6 * 6 + 3)) * 9 + 9 * 8 * 5","(3 + 4 + 6 + (7 * 6 * 7 + 2 + 6)) * 2 + 5 * 9","6 + 9 + (8 * 4 * 8)","9 + 7 * (5 * 5 * 8) + 7","2 + 8 + (4 * 7 * 4 * (7 + 2) + 2 * 7) * 8 * 9 * (5 * 8 + 8 + 6 + 4 + 5)","3 * 3 * ((9 * 6 + 2) + 7 + 9 * 5 + 2) * 7 + 9 + 9","(4 * 6 + 7 * 6 * 4 * 8) + 4 + (2 + 6) * 9 * (2 * 3 * 5 + 7) * 2","6 + (4 + (2 * 9 + 9 * 5 * 6 * 3)) * 6 * 8","(8 * 2) * (7 + 7 + (4 * 2 * 2)) * 8 + 4 + 7 * (2 * 2 * (2 + 6))","4 + 7 + 9 * (3 + 6 * 8 + 3 * 4 + 2) + 9","8 * 8 * 7 * 5 * 3 * 6","8 * (2 + 6) * (8 * 7 + (7 * 5 + 5 * 4) * 5 + 5 + 5) + ((7 * 8 + 2 * 3) + 8 + 4 * 4 + 3) * 9","(2 + 7 * 4 + 9 * (6 + 9) * 9) + 2 * 4 * 8","(6 * 5 * 6 + 3) * 4 * 3 * 3","3 * (3 * (3 * 3 + 5 + 4 + 7 + 8) + 9 * 9) * 4 + 4 * (9 * 8)","7 + 5","((6 * 7) * 8 * 5 + 3) + 8 * 8 * 6 * 7 * 8","(9 + 4) * 4 * (7 + 6 * 2 * 7) * 9 * 2","6 + 5 + (5 * 5) + (3 + 3)","5 + 6 + (9 + 3 * (3 + 9 * 4 * 2 * 9)) * 2 + (9 + 7 + 8) * 4","8 + 2 + (7 * 4 + 8 + (3 + 2 + 2 * 4 * 9) * 4)","6 + ((8 * 6 + 5) * 8 + 9 * 3 + 5) * 6 + 9","(5 * (8 * 6 * 3 + 8 * 7) * 2 + 2 + 2) + (6 * 5) * 7 * 5 + 8","(7 + 9 * 6 * 5 * 2 * 3) + 9 * (2 * 2 + 6 * 5 * 5 + 8) + 8 * 8 * 4","5 * 9 * (6 * 4 * 3 * 7) * 5 + 9 + 5","7 + 7 + (6 * (8 + 2 * 7 * 9 + 4) + (8 + 9 * 5 + 3 + 9 * 4) + 4) * 9 + 8 * (5 + 5 + 9)","((9 * 2 * 5 * 7 + 8 + 7) * (6 * 8 + 3 + 5 * 6 + 4) + (3 + 2 * 6 + 7 * 7 * 9) * 5) + (6 + 4)","7 + 2 + 8 + (6 * 8 + 7) * 2","9 + (3 * 6) + (3 + 8)","3 * 3","4 + (2 + 4)","2 + 8 * 4","4 * 5 * (5 * 7 * 6 * (3 + 5 + 6 + 5)) * (8 + 7 + 5 * (2 * 6 + 9 * 5) * 2 + 8)","6 + 6 * 2 + ((9 + 6 + 2 + 5 + 7) * 8 + 2 + 2 + 3) * 4","3 + 6 * 8","5 * 3 + 6 + 8 * ((6 * 4) + 4 * 6 + (4 + 5 + 4) + 3 + (7 + 2 * 8)) * (6 + 2 * 4)","3 + 3 * 2 * 2 * 2 * ((5 * 5 * 9 + 5 * 3) + 4 + 5 * 9 * 6)","(7 * 6 + 6) * (5 + 4 * 6 * 8)","4 + 7 + (4 + 5 + 7 * 6) * 3","8 * ((5 * 6 * 5 + 9 + 3) + 6 + (4 * 8 + 7 + 5 + 7) + 6 * 5 + (4 + 9 * 5 + 2))","(9 + 5 + 6 * 7 * 4) + 8 * 3 + 4 * 7","(2 * 2 * 4 + 4 * 4 * 5) * 3 + 6 * 3 * 4 + ((8 + 2) + 4 + 6 * 2)","(9 + 4 + 9) + 7 * 9 * 6","7 * 3 + (9 * 2 + (2 * 6 * 8 + 3 * 2) * 5 * 5 + 7)","8 + 7 * 6 + 3 * ((6 * 6 + 3) * 3 + 5 * 5 * 8) * 7","3 + 6 + ((2 + 5 + 7) + 5 * 2 + 9) * 7 * 2","2 + 3 * 3 * ((9 + 3 * 3) + 7 * (3 * 4 * 7) * 8 * 9) * 3","8 + 7 * 2 * 2 * 3 * (8 * 5 + 8 * 2 * (7 + 2 + 3) * 7)","8 + 4 + 8 + ((3 + 7) * (5 + 9 + 9 + 5 + 7) + 6 * 4 * 7)","((7 + 8 + 3 * 9) * 9 * 4 * 4 + 8 * 8) + 2 * 6 * 6 + ((8 * 9) + 2 + 9)","5 + ((8 * 2 * 5 + 4 + 8) * 9 + 6) + (2 * 5 + 3 * 9 * (2 * 5 * 5)) + 2 * 5","2 * ((2 * 5 * 8 + 9 * 6 * 4) * 5 + 5 * 6 * 2) * (9 + 6 + 9) * (5 + 3 + 5 + (8 + 9) * (6 + 3 + 2 * 6 * 3)) * 9","5 + 5 + (4 * 5) + ((3 * 8 + 8 * 6 * 2 * 4) + 3 + 9 + 5 + 2) * 2","(9 + 9 + (3 * 6 + 6 * 2) * 9 + 4) * (7 * 4 + 3) * 4 + 3 + 9","4 + (7 * 2 + (5 * 3 + 9 * 7) + 8 * 9 * 7)","6 + ((7 * 9) * 9 * 3 * 6 + (7 * 8 * 7)) + (9 * 9 * 5) * ((6 + 6 + 4) + 4 + 5 * 7) + ((2 * 9 * 9 * 9 + 3 + 5) * (6 + 2) * (6 + 5 + 9) + 2) * 6","7 * 9 + 2 + ((2 + 5 + 5) * 4) * 9 + 3","9 + 5 + 5 * (8 + 7 * 7) + (7 + 8 * 9 + 4 + (8 + 8)) * (3 + (2 + 4 + 5) * (3 + 7 * 5 + 7 + 2 * 6))","4 * 2 * (7 * 6) + 3","(3 * (6 + 4 * 6 * 8) + (2 + 4 + 8 * 5) + 3 * 4) * 6 + 8 + 3","8 * 4 + 9 + 7 * 4","5 * 3 * 9 * 9 * 5 * (6 + 2 + 4 + 5 * 9 * 7)","3 * 9 * 3 + 9","5 * (6 * (4 + 5 + 5 + 9) * 3) + (9 + 2 * 5 + (8 + 3 * 2 + 9) + 2) * 3","3 * (5 * (2 + 3 + 6 * 3) + 6) + 2","7 + ((7 * 3 * 4 * 5 * 3 + 2) + (6 * 3 + 7 + 6 + 9) * 3) * (7 + 7 * 3 + 8 + 2 + (3 * 5 + 5)) + (7 * 5 + (5 * 3) + 7 + 2 + 8) * 5","4 * 4 * 6 + 4","8 * (5 + 4 + 7 + (9 + 9 + 5)) * 3 * 7 + 2","4 * (7 + (6 * 4 * 4 + 6 * 8 + 5) + (3 * 5 + 8 * 6 + 5) + 4) * 7 * 4 * 7","2 + (5 * 6) + (5 + 4) * 8","9 * ((6 * 2 + 5) + 8 + 6 * 8 * 8 * 6) + 8 * 5 * 9 + 4","3 + ((5 + 3) + 7 * (3 + 5 * 3 + 9 + 5) * 6 * 6) + 2 + 5 * 9","4 * (8 + 4 + 2 * 8 + 6) + 9","(5 * 9 * 6 * 6) * 8 * 4","(9 * 7 + 8 * 3 * 8) + 9","8 * 9 + 4 + 2 * 9 * 2","5 * (2 + 7 + (2 + 7 * 5 + 2) * (3 * 5 + 5 * 7 * 8))","6 + (4 * 6 * (9 * 5 + 9 + 7) * 6 + 4) * 4 * 6","8 + 9 * 8 + (2 + 8 * (5 * 7 * 7 * 9 + 8 + 4) + (6 * 4 * 9 * 8 * 4 * 9)) * 7 * (3 * 9 + 8 + 2 * 4 * 8)","(9 * 7 * 4 + 5 * 8 * 7) + 2 + 4 + 3 + (5 + 5 + 8 * (4 + 2 * 7 * 8) + (7 + 2 + 6 * 5 + 2 + 5) * (4 + 3 * 8))","6 * 2 * 5 * 2 + (6 * 8) * (2 + 8 + 3 + 7 * 6)","(7 * 9) + 4 * 7 + (5 * 9 + 7 * 3 + (2 * 4 * 9 * 9 * 6)) + 8","6 * 4 + (5 * 6) * 7 + 6 * 7","(4 + 7 + 8 * 9 + (6 * 9 + 8) * (8 * 9 * 5 + 4 * 9 + 3)) * 2 * 3 + 6","6 + 5 + 9 * (6 + (8 + 8)) * 4 + 2","9 + (2 * (7 * 9 + 2 + 9) + 2) * 3 * 8 * ((4 + 6 + 9 + 5) * (5 + 2 + 9 + 3 + 5 * 9) + (8 * 2) * 3) + 9","(9 + (3 + 8 + 7 * 2) * 6 + 6 * 8 + 7) * 3","((4 * 4 * 9) * (3 * 6) * 3 * (8 * 4 * 5) * 5) + 2 + (9 * 5 + 8 * (7 * 4 + 9 + 3 * 3 + 2) + (3 * 4 * 9)) * 7 + 9","2 + 3 * (3 * 4 + 4 * 3 + 2 + 7) * 8 * 9","((6 * 7) + 3 + 7 + 3) + 4","(5 + 3) + 2 * (8 + 4) * 3 + 7 + 9","(8 + 5 + 5) * 6 + 6 * (5 + (7 * 6 + 7 * 6 + 3) + 2 + 5 * 6 + 6) * 3","9 + 2 * 5 + (8 + (8 + 6)) + 8 + (4 * 2)","(5 * 5 + 5) * (4 * 5 + 2 * 3 + 4) + 9","5 + (9 + (8 + 9 * 2 * 9 + 8) * 5 + (4 + 4 + 4 * 6) + 4) * ((3 + 9 * 7 + 8 * 2 * 7) + 3 + 6 + (3 * 3 * 7 * 2 + 3) + 2) * 5","2 + 6 + 5 + (6 * 3 * 9) + 2 * 9","8 * 7 + 9 * 2 + (3 + 7 * 6)","7 * 6 * (7 + 8 * (2 * 5)) * 2","9 * 6 * (8 * 8 * 4) + 6 * 6 * 5","9 * 5 * 9 + ((2 * 7 + 8) + (2 + 4 * 2 + 9 * 3 * 6) * (9 + 8)) + 8","2 * ((7 * 6 + 9 + 5 + 2 + 3) + 6 * (8 + 3 + 9) * 2 * 3 + 7) * 3 * (6 * 9 * 2 * 4) + 5 * 6","4 * (7 * 4 * 4 * (4 * 2)) + 4 + (3 * 9 * (5 + 2 * 7 + 8 + 8) + 5 + 6 + 5)","3 * 7 + 7 + (7 + 7) * 4 * ((8 + 4 * 3 + 7 + 3) * (2 * 3 + 4) + (2 * 6 * 3 + 6 * 2 + 7))","8 + 2 * 5 * (2 * 7 + 9 + 3 + (7 * 2) * 4)","4 + (9 + 3 + 5) * (6 * 3 + (6 + 8 * 2) * 5 * 4) + 3","8 * 2 * (5 * 9 + 4) + 5 + ((7 * 7 * 2 + 5 + 3 * 9) * 8) * 9","2 + 8 + 8 + 4 * ((7 + 9 * 7 + 5) * 5 + 2 * 9 * (2 + 2 + 7 * 7 + 4) * 3) + 5","(7 * 8 + 8) * 8","8 * 6 + 8 + 3 + 2 + (8 + 9 + 2)","6 + 4 * 9 * ((9 + 9 * 2) * (5 * 7 * 3 + 4 * 6 * 6))","(9 + 4 + 7) + 2 + ((8 * 8 * 8 + 7) + 3 * 3 + 8 + 5 * (9 * 7 + 3 + 2 + 2 + 9))","(9 * 2 + (6 * 4 * 8 * 9 * 9 + 5) * 2) * 7 + 4 * (6 + 7 * 5 * 5 * 6 * (9 * 3 + 8))","8 * (7 + 5 * (8 + 3 + 9) + 6 + 6) + 2 + (4 * 2 + 8 * (3 * 4) + 7) + (2 + 4) * 8","(6 * 4 * 7 * 7 * 6 * (5 + 6 + 4 * 8 * 9)) + 7 + (8 + 3 + 6 + 8) * 8 * 5","4 * (4 + (7 + 3 * 2 + 9)) * 3 + 6 * 7 * 4","9 * (8 * 6 + 7 * 9 + 4 + 9) * 7 * 4 + 8","((8 * 7 * 6 + 4) * (4 + 9 * 5 + 8 * 2 * 7) * 2 + (6 * 3 + 9 + 6 + 5 * 7)) * 4","5 + 2 * ((7 * 8 * 6 * 4) * 4) * 4 * 4 + 9","5 + (2 + 2 + 3 * 5) + 2 * 2 * (7 * 7 * 2 + 4)","8 * (7 + (9 + 5 * 6 * 6) * (6 + 5 + 7)) * 3 * 6","(7 * 7 * 2 + 3 + 9) + 3 + 7 * 4 + 8 + 4","5 * (7 * 6 + (8 + 5 + 2) + 7 * 7) * (6 * (2 + 5 * 4) + 4 * 7 + 4 * (6 + 7)) + 2"]
sum = 0
input.each do |inp|
    it = inp.gsub('(', ' ( ').gsub(')',' )').gsub('  ', ' ')
    rpn = RPNExpression.from_infix(it)
    sum += rpn.eval
end
puts sum