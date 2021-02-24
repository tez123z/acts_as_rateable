# frozen_string_literal: true
require 'rails/generators'
require 'rails/generators/migration'

module ActsAsRateable
  class InstallGenerator < Rails::Generators::Base

    include Rails::Generators::Migration

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
       "%.3d" % (current_migration_number(dirname) + 1)
      end
    end

    def create_migration_file
      migration_template 'migration.rb', 'db/migrate/acts_as_rateable.rb', migration_version: migration_version
    end

    def rails5_and_up?
      Rails::VERSION::MAJOR >= 5
    end

    def rails61_and_up?
      Rails::VERSION::MAJOR > 6 || (Rails::VERSION::MAJOR == 6 && Rails::VERSION::MINOR >= 1)
    end

    def migration_version
      if rails5_and_up?
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end

  end
end
