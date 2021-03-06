class UpdateFactNamesAndValuesToBin < ActiveRecord::Migration
  def self.up
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql"
      execute %{ALTER TABLE fact_names MODIFY name varchar(255) COLLATE utf8_bin NOT NULL}
      execute %{ALTER TABLE fact_values MODIFY value varchar(255) COLLATE utf8_bin NOT NULL}
    end
  end

  def self.down
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql"
      execute %{ALTER TABLE fact_names MODIFY name varchar(255)}
      execute %{ALTER TABLE fact_values MODIFY value varchar(255)}
    end
  end
end
