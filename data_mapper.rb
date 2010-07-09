#!/usr/bin/env ruby
require 'dm-core'
DataMapper.setup :default, 'sqlite3::memory:'
#class Photo
#  include DataMapper::Resource
#  property :photo_id, DataMapper::Types::Serial
#  property :name,     String
#  has n, :taggings
#  has n, :tags, :through => :taggings
#end
#
#class Tag
#  include DataMapper::Resource
#  property :tag_id, DataMapper::Types::Serial
#  property :name,     String
#  has n, :taggings
#  has n, :photos, :through => :taggings
#end
#
#class Tagging
#  include DataMapper::Resource
#  property :tagging_id, DataMapper::Types::Serial
#  property :name,     String
#  belongs_to :tag
#  belongs_to :photo
#end
#class Photo
#  include DataMapper::Resource
#  property :photo_id, DataMapper::Types::Serial
#  property :name,     String
#  has n, :taggings
#  has n, :astags, :model => 'Tag', :child_key => [:id],
#    :parent_key => [:photo_id], :through => :taggings
#end
#
#class Tag
#  include DataMapper::Resource
#  property :tag_id, DataMapper::Types::Serial
#  property :name,     String
#  has n, :taggings
#  has n, :asfotos, :model => 'Photo', :child_key => [:id],
#    :parent_key => [:tag_id], :through => :taggings
#end
#
#class Tagging
#  include DataMapper::Resource
#  property :id, DataMapper::Types::Serial
#  property :name,     String
#  belongs_to :astag, :model => 'Tag', :child_key => [:tag_id]
#  belongs_to :asfoto, :model => 'Photo', :child_key => [:photo_id]
#end
class User
  include DataMapper::Resource
  property :user_id, DataMapper::Types::Serial
  property :name,     String
  has n, :collaborations
  has n, :collab_projects, :model => 'Project', :child_key => [:id], :parent_key => [:user_id], :through => :collaborations
end

class Project
  include DataMapper::Resource
  property :project_id, DataMapper::Types::Serial
  property :name,     String
  has n, :collaborations
  has n, :collab_users, :model => 'User', :child_key => [:id], :parent_key => [:project_id], :through => :collaborations
end

class Collaboration
  include DataMapper::Resource

  property :id, Serial

  belongs_to :collab_user, :model => 'User', :child_key => [:user_id]
  belongs_to :collab_project, :model => 'Project', :child_key => [:project_id]
end
DataMapper.auto_migrate!