Factory.define(:taxon) do |record|
  # associations:
  record.association(:taxonomy, :factory => :taxonomy)
  record.association(:parent, :factory => :root_taxon)
end

Factory.define(:root_taxon, :class => Taxon) do |record|
  record.association(:taxonomy, :factory => :taxonomy)
end
