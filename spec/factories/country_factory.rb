Factory.define :country do |f|
  f.name      "United States"
  f.iso3      "USA"
  f.iso       "US"
  f.iso_name  "UNITED STATES"
  f.id        "214"
  f.numcode   "840"
  f.zone { Zone.global }
end
