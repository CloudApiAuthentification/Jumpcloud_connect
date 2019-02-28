class Article < Granite::Base
  adapter sqlite
  table_name articles

  belongs_to :group

  primary id : Int64
  field body : String
end
