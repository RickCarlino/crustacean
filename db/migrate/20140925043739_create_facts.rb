class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.references :topic
      t.timestamps
    end
  end
end
