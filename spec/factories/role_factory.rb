Factory.sequence(:role_sequence) {|n| "Role ##{n}"}

Factory.define(:role) do |record|
  record.name { Factory.next(:role_sequence) }
end

[:admin, :seller, :user].each {  |role|
  Factory.define(:"#{role}_role", :parent => :role) { |r| r.name role.to_s }
}

