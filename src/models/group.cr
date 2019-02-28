class Group < Granite::Base
  adapter sqlite
  table_name groups

  primary id : Int64
  field name : String
  field external_id : String
end
