# Example for MS SQL XML:
# select * from accounts where xml_options.value('(/hash/statement-id/node())[1]', 'nvarchar(max)') = '1138048820737'
class XmlWrapper
  def self.load(str)
    str && str.present? ? ((Hash.from_xml(str) || {})['hash'] || {}) : {}
  end

  def self.dump(object)
    object.to_xml(skip_instruct: true).gsub("\n",'').gsub(/> */, '>')
  end
end
