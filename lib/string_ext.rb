# encoding: utf-8
################################################################################
## Initial developer: Massimo Maria Ghisalberti <massimo.ghisalberti@gmail.org>
## Date: 2016-12-18
## Company: Pragmas <contact.info@pragmas.org>
## Licence: Apache License Version 2.0, http://www.apache.org/licenses/
################################################################################

class String

  def natural_order(nocase = false)
    str = self
    i = true
    str = str.upcase if nocase
    str.gsub(/\s+/, '').split(/(\d+)/).map {|x| (i = !i) ? x.to_i : x}
  end
  
  def trunc_at_word(options = {})
    options.reverse_merge!({
      :omission => ' ...',
      :num => 8
    })
    t = self[/(\s*\S+){#{options[:num]}}/]
    if t
      t += options[:omission] if t.size < self.size
      t
    else
      self
    end
  end
  
  def to_slug(size = 128, sep = '-')
    chars = %r{[^[A-Za-z0-9]]|\b[aeiou]\b}i
    self.strip.gsub(chars, sep).squeeze(sep).gsub(%r{^-|-$},'').downcase
  end

  class << self
    def random_string(len)
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      rndstring = ""
      1.upto(len) { |i| rndstring << chars[rand(chars.size-1)] }
      rndstring
    end
  end

end

