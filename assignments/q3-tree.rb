class Tree
  attr_accessor :children, :node_name

  def initialize(name, children=[])
    @children = children
    @node_name = name
  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end
end
class Tree

  def initialize(tree)
    @children = []
    @node_name = tree.keys.first
    if not tree[@node_name].nil?
      @children = tree[@node_name].keys.map{ |key| 
        #puts "#{key} => #{tree[@node_name][key]}"
        Tree.new({key => tree[@node_name][key]})
      }
    end
  end

  def to_s
    @node_name
  end
end

if __FILE__ == $0
  tree = Tree.new({
    'grandpa' => {
      'dad' => {
        'child 1' => {},
        'child 2' => {}
      },
      'uncle' => {
        'child 3' => {},
        'child 4' => {}
      }
    }
  })
  tree.visit_all {|node| p "#{node.node_name} #{node.children}"}
end
