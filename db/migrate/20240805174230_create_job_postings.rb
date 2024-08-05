class CreateJobPostings < ActiveRecord::Migration[7.1]
  def change
    create_table :job_postings do |t|
      t.string :job_posting
      t.text :job_description
      t.timestamps
    end
  end
end
