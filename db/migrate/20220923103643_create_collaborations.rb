class CreateCollaborations < ActiveRecord::Migration[6.0]
  def change
    create_table :collaborations do |t|
      t.integer :target_user_id
      t.integer :applicant_user_id

      t.timestamps
    end
    add_index :collaborations, :target_user_id
    add_index :collaborations, :applicant_user_id
    add_index :collaborations, [:target_user_id, :applicant_user_id], unique: true
  end
end
