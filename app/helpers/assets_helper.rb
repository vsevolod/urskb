module AssetsHelper

  def view_partial(name, locals={})
    Haml::Engine.new(File.read(File.join(Rails.root, 'app/views/', "#{name}.html.haml"))).render(self, locals)
  end

end
