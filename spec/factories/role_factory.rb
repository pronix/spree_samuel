Factory.sequence(:role_sequence) {|n| "Role ##{n}"}

Factory.define(:role) do |record|
  record.name { Factory.next(:role_sequence) }
end

%w(user admin seller).each do |role_name|
  Factory.define("#{role_name}_role".to_sym, :parent => :role) do |r|
    r.name role_name.to_s
  end
end

