Then /^I should see the following list of reports:$/ do |table|
  table.hashes.each do |attrs|
    with_scope("table.index") do
      page.should have_selector("a", :text => attrs["Name"])
      page.should have_selector("td", :text => attrs["Description"])
    end
  end
end
