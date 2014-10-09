class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :topic
      t.string :name
      t.string :review_strategy, default: 'all'
      t.string :only_review_id
      t.boolean :special, default: true
      t.timestamps
    end
  end
end
