class UserGroup < Granite::Base
  adapter sqlite
  table_name user_groups

  belongs_to :user

  belongs_to :group

  primary id : Int64
end
