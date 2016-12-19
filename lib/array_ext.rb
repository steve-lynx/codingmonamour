# encoding: utf-8
################################################################################
## Initial developer: Massimo Maria Ghisalberti <massimo.ghisalberti@gmail.org>
## Date: 2016-12-18
## Company: Pragmas <contact.info@pragmas.org>
## Licence: Apache License Version 2.0, http://www.apache.org/licenses/
################################################################################

class Array
  def extract_options!(array = self)
    array.last.is_a?(Hash) ? array.pop : {}
  end

  def natural_sort(array = self)
    array.sort_by {|str| str.natural_order} # (&String.natural_order)
  end

end
