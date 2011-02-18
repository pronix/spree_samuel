Factory.define :state do |f|
  f.name "New Yourk"
  f.abbr "NY"
  f.country { Country.default }
end

