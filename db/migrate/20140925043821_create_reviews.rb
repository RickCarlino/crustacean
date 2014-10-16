class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :owner, polymorphic: true
      t.references :question
      t.references :answer
      t.references :fact
      t.boolean :last_quiz_result
      t.datetime :next_review
      t.datetime :last_review
      t.timestamps
    end
  end
end
