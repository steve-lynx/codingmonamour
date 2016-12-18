
class Hash
  def reverse_merge2(h)
    h.merge(self)
  end

  def reverse_merge!(other_hash)
    merge!( other_hash ){|key,left,right| left }
  end

  def fetch2(keys, default = nil)    
    result = self.fetch(keys.delete_at(0), default)
    keys.each { |k| result = result.fetch(k, default) if result.is_a?(Hash) }
    result
  end
  
end
