require 'sequel'

Sequel.migration do
  up do
    create_table :messages do
      primary_key :id
      String :message
    end
  end

  down do
  end
end

