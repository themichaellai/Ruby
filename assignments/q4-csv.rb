# Need error checking?
module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    attr_accessor :headers, :csv_contents
    def initialize(rows)
      first, *rest = rows
      @headers = first.split(', ')
      @headers_dict = {}
      @headers.each_with_index { |header, i| @headers_dict[header.to_sym] = i }
      @csv_contents = rest.map { |row| CsvRow.new(row.split(', '), @headers_dict) }
    end
  end
end

class CsvRow
  def initialize(row, headers_dict)
    @row = row
    @headers_dict = headers_dict
  end
  
  def method_missing(name)
    @row[@headers_dict[name]]
  end
end
class RubyCsv
  include ActsAsCsv
  acts_as_csv

  def each(&block)
    @csv_contents.each do |csv_row|
      block.call csv_row
    end
  end
    
end

if __FILE__ == $0
  lines = [
    'one, two',
    'lions, tigers',
    'flions, ftigers'
  ]
  csv = RubyCsv.new(lines)
  csv.each {|row| puts row.one}
end
