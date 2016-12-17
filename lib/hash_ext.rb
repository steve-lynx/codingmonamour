
class Hash
  def reverse_merge2(h)
    h.merge(self)
  end

  def reverse_merge!(other_hash)
    merge!( other_hash ){|key,left,right| left }
  end
end
