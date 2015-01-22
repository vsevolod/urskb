class Dictionary < ActiveRecord::Base

  has_ancestry

  validates :name, presence: true
  validates :old_id, uniqueness: true, if: Proc.new{|el| !el.old_id.blank?}

  def self.find_or_create_by_tag(tag_name, name)
    tag = Dictionary.where(tag: tag_name).first_or_create(name: tag_name)
    tag.children.where(name: name).first_or_create
  end

  def self.[](tag)
    self.find_by_tag(tag)
  end

end
