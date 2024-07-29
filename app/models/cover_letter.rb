# == Schema Information
#
# Table name: cover_letters
#
#  id                :integer          not null, primary key
#  cover_letter_text :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  job_posting_id    :integer          not null
#  user_id           :integer          not null
#
# Indexes
#
#  index_cover_letters_on_job_posting_id  (job_posting_id)
#  index_cover_letters_on_user_id         (user_id)
#
# Foreign Keys
#
#  job_posting_id  (job_posting_id => job_postings.id)
#  user_id         (user_id => users.id)
#
class CoverLetter < ApplicationRecord
  belongs_to :user
  belongs_to :job_posting
end
