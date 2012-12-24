class String
  def constantize
    self.split("::").inject(Module) {|acc, val| acc.const_get(val)}
  end

  def camelize
    self.split('_').map {|w| w.capitalize}.join
  end
end