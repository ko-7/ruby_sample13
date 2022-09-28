class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :planner
      t.string :maintitle
      t.text :about
      t.string :title_content1
      t.text :content1
      t.string :title_content2
      t.text :content2
      t.string :title_content3
      t.text :content3
      t.string :title_cotent4
      t.text :content4
      t.string :title_content5
      t.text :content5
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :events, [:user_id, :created_at]
  end
end
