Taxon.class_eval do
  validates :name, :uniqueness => {:scope => :taxonomy_id}
end
