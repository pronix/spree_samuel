#ToDo don't share global variables

Given /^the allready exist batches with statistics and transactions$/ do
  @time_now = Time.now
  Time.stubs(:now => @time_now)

  @statistic = AuthorizeNet::Reporting::BatchStatistics.new(
    :charge_amount => 80,
    :charge_count => 2,
    :error_count => 0,
    :refund_count => 0,
    :decline_count => 0,
    :void_count => 0
  )

  @transaction = AuthorizeNet::Reporting::TransactionDetails.new(
    :id => 155,
    :account_number => "XXXXX4546",
    :submitted_at => Time.now.to_datetime,
    :settle_amount => "12",
    :account_type => "CredirCard",
    :status => "sucessfullyCreated"
  )

  @previous_month = Time.now - 1.month

  @this_month_batches = [
    AuthorizeNet::Reporting::Batch.new(
      :id => 100,
      :settled_at => Time.now.to_datetime,
      :state => "sucessfullyCreated",
      :statistics => [@statistic],
      :payment_method => "CreditCard"
    )
  ]
  @previous_month_batches = [
    AuthorizeNet::Reporting::Batch.new(
      :id => 55,
      :settled_at => @previous_month,
      :state => "sucessfullyCreated",
      :statistics => [@statistic],
      :payment_method => "CreditCard"
    )
  ]

  AuthorizeNetReports.stubs(:batches).with(Time.now.at_beginning_of_month, Time.now.at_end_of_month).returns(@this_month_batches)

  AuthorizeNetReports.stubs(:batches).with(@previous_month.at_beginning_of_month, @previous_month.at_end_of_month).returns(@previous_month_batches)

  AuthorizeNetReports.stubs(:transactions => [@transaction])

  AuthorizeNetReports.stubs(:transaction => @transaction)
end

Then /^I should see (.+) transactions$/ do |month|
  batches = case month
  when "this month"
    @this_month_batches
  else
    @previous_month_batches
  end

  batches.each do |batch|
    with_scope("table.index") do
      page.should have_selector("a", :text => batch.id.to_s, :id => "batch_id_link_#{batch.id}")
#      page.should have_selector("td", :text => batch.settled_at.strftime("%B %d, %Y %H:%M")) Fix me bug with time zones
      page.should have_selector("td", :text => "$80.00") #Fix me format_price @statistic.charge_amount
      page.should have_selector("td", :text => @statistic.charge_count.to_s)
      page.should have_selector("td", :text => batch.payment_method)
      page.should have_selector("td", :text => batch.state)
      page.should have_selector("td", :text => @statistic.error_count.to_s)
      page.should have_selector("td", :text => @statistic.refund_count.to_s)
      page.should have_selector("td", :text => @statistic.decline_count.to_s)
      page.should have_selector("td", :text => @statistic.void_count.to_s)
    end
  end
end

Then /^I should not see (.+) transactions$/ do |month|
  batches = case month
  when "this month"
    @this_month_batches
  else
    @previous_month_batches
  end

  batches.each do |batch|
    with_scope("table.index") do
      "I should not see \"#{batch.id}\" within \"#batch_id_link_#{batch.id}\""
    end
  end
end

Then /^I select previous month$/ do
  /I select "#{Date::MONTHNAMES[(Time.now - 1.month).month]}" from "#date_month"/
end