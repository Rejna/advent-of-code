# frozen_string_literal: true

class Node
  attr_accessor :name, :parent, :children

  def init(name, parent)
    @name = name
    @parent = parent
    @children = []
  end
end

input = ['COM)B', 'B)C', 'C)D', 'D)E', 'E)F', 'B)G', 'G)H', 'D)I', 'E)J', 'J)K', 'K)L']

solar_system2 = {
  name: 'COM',
  parent: nil,
  children: [
    {
      name: 'B',
      parent: 'COM',
      children: [
        {
          name: 'G',
          parent: 'B',
          children: [
            {
              name: 'H',
              parent: 'G',
              children: []
            }
          ]
        },
        {
          name: 'C',
          parent: 'B',
          children: [
            {
              name: 'D',
              parent: 'C',
              children: [
                {
                  name: 'I',
                  parent: 'D',
                  children: []
                },
                {
                  name: 'E',
                  parent: 'D',
                  children: [
                    {
                      name: 'F',
                      parent: 'E',
                      children: []
                    },
                    {
                      name: 'J',
                      parent: 'E',
                      children: [
                        {
                          name: 'K',
                          parent: 'J',
                          children: [
                            {
                              name: 'L',
                              parent: 'K',
                              children: []
                            }
                          ]
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}

solar_system = Node.new('COM', nil)

input.each do |relation|
  planets = relation.split(')')

  current_node = solar_system

  while current_node.name != planets[0]
    if current_node.children.empty?
      current_node = current_node.parent
    else
      current_node.children.each do |child_node|
        current_node = child_node
      end
    end
  end
  current_node.children << Node.new(planets[1], parent_node)
end
