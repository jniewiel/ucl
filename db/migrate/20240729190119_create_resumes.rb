class CreateResumes < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes do |t|
      # t.datetime :created_at
      # t.datetime :updated_at
      t.text :resume
      t.references :user, null: false, foreign_key: true
      t.text :extracted_text

      t.timestamps
    end
  end
end
