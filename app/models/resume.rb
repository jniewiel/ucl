# == Schema Information
#
# Table name: resumes
#
#  id             :integer          not null, primary key
#  extracted_text :text
#  resume         :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_resumes_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Resume < ApplicationRecord
  belongs_to :user
end
