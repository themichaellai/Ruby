def merge(left, right)
  result = []
  while left.count > 0 or right.count > 0
    if left.count > 0 and right.count > 0
      if (left.first <=> right.first) < 0
        result.push left.shift
      else
        result.push right.shift
      end
    elsif left.count > 0
      result.push left.shift
    elsif right.count > 0
      result.push right.shift
    end
  end
  result
end

def sort(arr)
  if arr.count <= 1
    return arr
  end

  left = []
  right = []
  arr[0...arr.count/2].each do |n|
    left.push n
  end
  arr[arr.count/2...arr.count].each do |n|
    right.push n
  end
  left = sort left
  right = sort right
  merge left, right
end

if __FILE__ == $0
  rand_nums = 10.times.map{ Random.rand(99) }
  p rand_nums
  p sort rand_nums
end
