class Member < ActiveRecord::Base
	validates :studentid, presence: true, format: { with: /\A[0-9]+\z/ }, length: {is: 9}
 	validates :email, uniqueness: true
 	validates :studentid, uniqueness: true

	before_validation :fixStudentId

	def fixStudentId
		self.studentid = self.studentid[1..self.studentid.length] if self.studentid.length == 9
	end

end
