# == Schema Information
#
# Table name: job_postings
#
#  id              :integer          not null, primary key
#  job_description :text
#  job_posting     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class JobPosting < ApplicationRecord
end
