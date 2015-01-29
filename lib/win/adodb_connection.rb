require 'win32ole'
class AdodbConnection

  def initialize(path_to_file)
    @path = path_to_file
    create_connection
  end

  def get_data(sql)
    recordset = WIN32OLE.new('ADODB.Recordset')
    recordset.Open(sql, @connection)
    recordset.GetRows.transpose
  end

  def each(sql, options = {}, &block)
    recordset = WIN32OLE.new('ADODB.Recordset')
    (options || {}).each do |key, value|
      if key == 'sort'
        sql += " #{value}"
      end
    end
    recordset.Open(sql, @connection)
    @fields = []
    recordset.Fields.each do |field|
      @fields.push field.name
    end
    #begin
      recordset.MoveFirst
      until recordset.EOF
        hash={}
        recordset.Fields.each{|el| hash[el.Name] = el.value}
        block.call(hash)
        recordset.MoveNext
      end
    #rescue
    #  @data = []
    #end
  end

  def close
    @connection.Close
  end

  private

    def create_connection
      @connection = WIN32OLE.new('ADODB.Connection')
      @connection.Open("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=#{@path}")
    end

end
