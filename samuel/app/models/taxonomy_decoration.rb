Taxonomy.class_eval do
  validates :name, :uniqueness => true
end
