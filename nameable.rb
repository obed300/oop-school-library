module Nameable
  def correct_name
    raise NotImplementedError, 'Subclass must implement correct name'
  end
end
