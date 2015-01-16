# https://github.com/rails-sqlserver/activerecord-sqlserver-adapter

ActiveRecord::ConnectionAdapters::SQLServerAdapter.native_text_database_type   = 'varchar(max)'
ActiveRecord::ConnectionAdapters::SQLServerAdapter.native_string_database_type = 'nvarchar'
ActiveRecord::ConnectionAdapters::SQLServerAdapter.native_binary_database_type = 'image'
ActiveRecord::ConnectionAdapters::SQLServerAdapter.lowercase_schema_reflection = true
#ActiveRecord::Base.table_name_prefix = 'dbo.'
