# -*- encoding : utf-8 -*-
class Copyright < ActiveRecord::Base

  has_many :meta_datum_copyrights

  acts_as_nested_set
  
  validates_presence_of :label

  def to_s
    label
  end

  def is_deletable?
    not has_descendants? and meta_datum_copyrights.empty?
  end

#######################################

  def usage(value = "")
    (is_custom? ? value : read_attribute(:usage))
  end

  def url(value = "")
    (is_custom? ? value : read_attribute(:url))
  end
  
#######################################
  
  def self.default
    @default ||= where(:is_default => true).first
  end

  def self.custom
    @custom ||= where(:is_custom => true).first
  end

  def self.public
    where(:label => "Public Domain / Gemeinfrei").first
  end

##################################################
  class << self

    def save_as_nested_set(nodes, parent = nil)
      case nodes.class.name
        when "Hash"
            if nodes.keys.first.is_a?(Hash)
              nodes.each_pair do |key,value|
                new_parent = create(key)
                new_parent.move_to_child_of parent if parent
                save_as_nested_set(value, new_parent) if value.is_a?(Array)
              end
            else
                new_leaf = create(nodes)
                new_leaf.move_to_child_of parent if parent
            end
        when "Array"
          nodes.each do |value|
            save_as_nested_set(value, parent)
          end
      end
    end

  end

end
