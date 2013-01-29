def filter(data, clauses)
  clauses.keys.each do |field|
    clauses[field].keys.each do |op|
      if op == :gt
        data.select! { |datum| datum[field] > clauses[field][op] }
      elsif op == :gte
        data.select! { |datum| datum[field] >= clauses[field][op] }
      elsif op == :lt
        data.select! { |datum| datum[field] < clauses[field][op] }
      elsif op == :lte
        data.select! { |datum| datum[field] <= clauses[field][op] }
      elsif op == :eq
        data.select! { |datum| datum[field] = clauses[field][op] }
      elsif op == :neq
        data.select! { |datum| datum[field] != clauses[field][op] }
      elsif op == :exists
        data.select! { |datum| datum.has_key? field }
      end
    end
  end
end

def select(data, fields)
  return if fields.count == 0
  data.map! do |datum|
    new_hash = {}
    fields.each do |field|
      new_hash[field] = datum[field] if datum.has_key? field
    end
    new_hash
  end
  data
end

def sort_by(data, field)
  skip = []
  for i in 0...data.count
    skip.push data.remove(i) unless data[i].has_key? field
  end

  data.each do |datum|
    skip.push datum unless datum.has_key? field
  end
  data.sort!{ |a, b| a[field] <=> b[field] }
  data.concat skip
end

def limit(data, n)
end

def queryClasses(data, criteria)
  #criteria.keys.each do |criterion|
  #  if criterion == :filter
  #    filter data, criteria[criterion]
  #  elsif criterion == :select
  #    select data, criteria[criterion]
  #  elsif criterion == :sort_by
  #    sort_by data, criteria[criterion]
  #  elsif criterion == :limit
  #    limit data, criteria[criterion]
  #  end
  #end
  filter data, criteria[:filter]
  sort_by data, criteria[:sort_by]
  limit data, criteria[:limit]
  select data, criteria[:select]
end

if __FILE__ == $0
  data = [{
    :department => 'CS',
    :number => 101,
    :name => 'Intro to Computer Science',
    :credits => 1.00
  }, {
    :department => 'CS',
    :number => 82,
    :name => 'The Internet Seminar',
    :credits => 0.5
  }, {
    :department => 'ECE',
    :number => 52,
    :name => 'Intro to Digital Logic'
    # Note that the :credits key-value pair is missing
  }]
  criteria = {
    :filter => {
      :number => {
        :gt => 80
      },
      :credits => {
        :gte => 0.5
      }
    },
    :select => [:number, :name],
    :sort_by => :number
  }

  queryClasses(data, criteria)
  p data
end
