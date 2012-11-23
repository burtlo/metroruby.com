class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.references :game
      t.references :platform
      t.string :version
      t.string :url
      t.timestamps
    end
    add_index :releases, :game_id
    add_index :releases, :platform_id
  end
end
