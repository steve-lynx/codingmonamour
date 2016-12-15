module Helpers

  require 'yaml'

  def m_value(context, key, default)
    begin
      result = @metadatas[context.to_s][key.to_s]      
      result.nil? ? default : result
    rescue
      default
    end
  end

  def m_string(key, sep = ' ')
    val1 = m_value(:application, key.to_s, '').to_s
    val2 = m_value(:document, key.to_s, '').to_s
    "#{ val1 }#{ val2.empty? ? '' : sep + val2}"
  end

  def m_array(key)
    val1 = m_value(:application, key, [])
    val2 = m_value(:document, key, [])
    val1.size >= val2.size ? [val1, val2] : [val2, val1]
  end

  def m_metas
    list1, list2 = m_array(:metas)
    list1.concat(list2)
    (list1.reduce(list2) { |acc, v|
       kv = v.split('=')
       acc << %(<meta name="#{ kv[0].to_s.strip }" content="#{kv[1].to_s.strip }">)
       acc
      }).join('\n')
  end

  def m_keywords
    val1 = (m_value(:application, :keywords, '').to_s.split(',')).map { |k| k.strip }
    val2 = (m_value(:document, :keywords, '').to_s.split(',')).map { |k| k.strip }
    list1, list2 = val1.size >= val2.size ? [val1, val2] : [val2, val1]
    (list1.reduce(list2) { |acc, k|
       acc << k unless list2.include?(k)
       acc
      }).join(',')
  end

end
