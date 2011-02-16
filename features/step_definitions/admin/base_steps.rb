Given /^there is next (.+):$/ do |factory, table|
  factory = factory.gsub(/\s/, "_").singularize
  model = factory.camelcase.constantize
  model.delete_all
  table.hashes.each { |hash|
    Factory(factory.to_sym, hash)
  }
end