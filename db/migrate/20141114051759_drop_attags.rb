class DropAttags < ActiveRecord::Migration
  def change
    drop_table :at_tags
  end
end
