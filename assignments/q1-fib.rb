def fib(n, n1 = 1, n2 = 1)
  if n == 1
    return n1
  elsif n == 2
    return n2
  else
    new = n1 + n2
    n1 = n2
    n2 = new
    return fib(n - 1, n1, n2)
  end
end

if __FILE__ == $0
  p fib(1)
  p fib(6)
  p fib(11, 0)
end
