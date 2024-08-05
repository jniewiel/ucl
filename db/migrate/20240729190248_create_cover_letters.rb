class CreateCoverLetters < ActiveRecord::Migration[7.1]
  def change
    create_table :cover_letters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job_posting, null: false, foreign_key: true
      t.text :cover_letter_text
      t.timestamps
    end
  end
end
