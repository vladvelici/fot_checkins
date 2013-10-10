require 'test_helper'

class CheckinTest < ActiveSupport::TestCase

	test "check in non member at 2nd event" do
		x = Checkin.new
		x.studentid = id(:nonmember)
		x.date = "2013-10-10"

		assert !x.valid?
	end

	test "check in non member at first event" do
		x = Checkin.new
		x.studentid = "55555555"
		x.date = "2013-10-10"

		assert x.valid?
	end

	test "Checking in should succeed (member, paid)" do
		x = Checkin.new()
		x.studentid = id(:dave)
		x.date = "2013-10-10"

		assert x.valid?
	end

	test "Checking in unpaid member" do
		x = Checkin.new
		x.studentid = id(:gogu)
		x.date = "2013-10-10"
		assert !x.valid?
	end

	test "Duplicate check-in" do
		x = Checkin.new
		x.studentid = id(:dave)
		x.date = "2013-10-03"

		assert !x.valid?
	end
end
