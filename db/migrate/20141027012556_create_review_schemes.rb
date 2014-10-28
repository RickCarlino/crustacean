class CreateReviewSchemes < ActiveRecord::Migration
  def change
    create_table :review_schemes do |t|
      t.integer :question_id
      t.integer :counter_question_id
    end
  end
end
