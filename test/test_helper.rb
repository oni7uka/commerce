require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'
require 'minitest/reporters'
require 'faker'

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

module AroundEachTest
  def before_setup
    super
    DatabaseCleaner.clean
    DatabaseCleaner.start
  end
end

DatabaseCleaner.strategy = :transaction

class Minitest::Test
  include FactoryGirl::Syntax::Methods
  include AroundEachTest
end



class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  class << self
    def let name, &block
      name = name.to_s
      pre, post = "let '#{name}' cannot ", ". Please use another name."
      raise ArgumentError, "#{pre}begin with 'test'#{post}" if
        name =~ /\Atest/
      methods = self.instance_methods.map(&:to_s) - %w[subject]
      raise ArgumentError, "#{pre}override a method in Minitest::Spec#{post}" if
        methods.include? name
      define_method name do
        @_memoized ||= {}
        @_memoized.fetch(name) { |k| @_memoized[k] = instance_eval(&block) }
      end
    end

    def subject &block
      let :subject, &block
    end
  end
end
