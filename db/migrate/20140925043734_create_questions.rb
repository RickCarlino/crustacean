class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :topic
      t.string :name
      t.timestamps
    end
  end
end
