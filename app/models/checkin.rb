class Checkin < ActiveRecord::Base
	validates :studentid, presence: true, format: { with: /\A[0-9]+\z/ }, length: {is: 9}, uniqueness: {scope: :date, message: "Already checked in at this time."}
	attr_accessor :m_email, :m_paid, :m_name

	validate :fot_payment_status

	before_validation :fixStudentId

	def fixStudentId
		self.studentid = "4" + self.studentid if self.studentid.length == 8
	end

	def fot_payment_status
		# first event?

		events = Checkin.where(:studentid => self.studentid).count
		return true if events == 0

		# member?
		mem = Member.find_by_studentid(self.studentid)

		if (mem == nil)
			errors.add(:studentid, "Is not a member and has been to " + events.to_s + " events so far.")
			return false
		else
			# paid or we let him in?
			if (mem.paid == true)
				return true
			end
			errors.add(:studentid, "Hasn't paid yet. Been to " + events.to_s + " so far.")
			return false
		end	
	end

end
