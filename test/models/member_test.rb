require 'test_helper'

class MemberTest < ActiveSupport::TestCase
	test "student id should work" do
		x = Member.new
		x.studentid = "32165480"
		x.email = "a@b.com"
		x.name = "haha"

		assert x.valid?
	end

	test "invalid student id" do
		x = Member.new
		x.studentid = "3216548"
		x.email = "a@b.com"
		x.name = "haha"

		assert !x.valid?
	end

	test "invalid student id letter" do
		x = Member.new
		x.studentid = "3216548a"
		x.email = "a@b.com"
		x.name = "haha"

		assert !x.valid?
	end

end
