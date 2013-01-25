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
    get_children(tree[@node_name])
  end

  def get_children(hash)
    hash.keys.each do |key|
      # better way to do this?
      @children.push Tree.new({key => hash[key]})
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
