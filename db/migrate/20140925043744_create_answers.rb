class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.references :fact
      t.text :data
      t.timestamps
    end
  end
end
