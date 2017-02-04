class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Devise - Omniauthable
      t.string   :provider
      t.string   :uid

      ## Devise - Rememberable
      t.datetime :remember_created_at

      ## Devise - Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
  
      ## Custom fields
      t.string   :name
      t.string   :email
      t.string   :image
      t.string   :token
      t.string   :expires_at

      t.timestamps 
    end

    add_index :users, :email,              unique: true
    add_index :users, :uid,                unique: true
  end
end
