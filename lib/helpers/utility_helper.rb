module UtilityHelper
  def cssify(hash={})
    hash.inject([]) do |memo, object|
      memo << object.join(': ')
    end.join('; ')
  end
end
