Array.class_eval do
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
  
  # created by http://stackoverflow.com/users/11951/daniel-lucraft
  def uniq_by(&blk)
    transforms = []
    self.select do |el|
      should_keep = !transforms.include?(t=blk[el])
      transforms << t
      should_keep
    end
  end
end