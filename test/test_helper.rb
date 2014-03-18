module ValidatesEmailSanTest
  module Initializer
    def self.load_dependencies
      require 'test/unit'
      
      require 'active_support'
      require 'active_support/test_case'
      require 'active_record'
      
      if const_defined?(:I18n) && I18n.respond_to?(:enforce_available_locales)
        I18n.enforce_available_locales = true
      end
      
      $:.unshift File.expand_path('../../lib', __FILE__)
      require File.expand_path('../../rails/init', __FILE__)
    end
    
    def self.configure_database
      ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
      ActiveRecord::Migration.verbose = false
    end
    
    def self.setup_database
      ActiveRecord::Schema.define(:version => 1) do
        create_table :members do |t|
          t.column :email, :string
        end
      end
    end
    
    def self.teardown_database
      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.drop_table(table)
      end
    end
    
    def self.start
      load_dependencies
      configure_database
    end
  end
end

ValidatesEmailSanTest::Initializer.start