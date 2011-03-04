Then /^I should see the following list of reports:$/ do |table|
  table.hashes.each do |attrs|
    with_scope("table.index") do
      page.should have_selector("a", :text => attrs["Name"])
      page.should have_selector("td", :text => attrs["Description"])
    end
  end
end

Then /^I should see the following (.+) sales:$/ do |t, table|
  table.hashes.each_with_index do |attrs, i|
    with_scope("table.admin-report tr:eq(#{i+2})") do
      attrs.values.each { |v| page.should have_selector("td", :text => v) }
    end
  end
end

