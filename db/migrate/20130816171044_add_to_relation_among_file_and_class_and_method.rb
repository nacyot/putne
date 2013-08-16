class AddToRelationAmongFileAndClassAndMethod < ActiveRecord::Migration
  def change
    add_column :target_methods, :target_class_id, :integer
    add_column :target_classes, :target_file_id, :integer
  end
end
