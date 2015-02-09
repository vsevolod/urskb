class PokRules

  def self.xml_options(node, options = {})
    options = {data: 'varchar', table: nil}.merge(options)
    options[:table] += '.' if options[:table]
    "#{options[:table]}xml_options.value('(/hash/#{node}/node())[1]', '#{options[:data]}')"
  end

end
