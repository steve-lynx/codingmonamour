# encoding: UTF-8

class Array
  def extract_options!(array = self)
    array.last.is_a?(Hash) ? array.pop : {}
  end

  def natural_sort(array = self)
    array.sort_by {|str| str.natural_order} # (&String.natural_order)
  end

end
