class CreateUserpermissions < ActiveRecord::Migration
  include MigrationHelpers
  include Constants

  def up 
    create_table :userpermissions do |t|

      t.belongs_to  :media_resource, :polymorphic => true, :null => false
      t.references :user, :null => false

      ACTIONS.each do |action|
        t.boolean "may_#{action}", :default => false
        t.boolean "maynot_#{action}", :default => false
      end

    end

    add_index :userpermissions, ref_id(User)
    add_index :userpermissions, :media_resource_id
    add_index :userpermissions, :media_resource_type
    ACTIONS.each do |action|
      add_index :userpermissions, "may_#{action}"
      add_index :userpermissions, "maynot_#{action}"
    end

   cascade_on_delete Userpermission, User
    
  end


  def down
    drop_table :userpermissions
  end

end
