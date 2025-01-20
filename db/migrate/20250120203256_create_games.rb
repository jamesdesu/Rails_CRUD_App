class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :title
      t.integer :releaseYear
      t.string :system
      t.string :publisher

      t.timestamps
    end
  end
end
