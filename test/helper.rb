# Copied from Paperclip's own test suite

require 'active_record'
require 'mocha'
require 'paperclip'
require 'shoulda'
require 'test/unit'

require 'paperclip-filemagic'

FIXTURES_DIR = File.join(File.dirname(__FILE__), "fixtures")
config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = ActiveSupport::BufferedLogger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config['test'])


class Dummy
end

def rebuild_model options = {}
  ActiveRecord::Base.connection.create_table :dummies, :force => true do |table|
    table.column :other, :string
    table.column :avatar_file_name, :string
    table.column :avatar_content_type, :string
    table.column :avatar_file_size, :integer
    table.column :avatar_updated_at, :datetime
    table.column :avatar_fingerprint, :string
  end
  rebuild_class options
end

def rebuild_class options = {}
  ActiveRecord::Base.send(:include, Paperclip::Glue)
  Object.send(:remove_const, "Dummy") rescue nil
  Object.const_set("Dummy", Class.new(ActiveRecord::Base))
  Dummy.class_eval do
    include Paperclip::Glue
    has_attached_file :avatar, options
  end
end

