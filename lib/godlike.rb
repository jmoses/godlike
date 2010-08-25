# Godlike
# Extracted code from Carlos Brando's autotest notifications
# Wanted to make something easy that would play a cool sound
# after a successful test run
# aka: GODLIKE

module Godlike
  extend self
  
  def play_sound sound_file
    Thread.new { `#{File.expand_path(File.dirname(__FILE__) + "/../bin/")}/playsound #{sound_file}` }
  end

  def success
    sound_file = ""
    sounds_directory = "#{File.dirname(__FILE__)}/godlike/sounds"
  
    if defined?(GODLIKE_SOUND)
      sound_name = GODLIKE_SOUND.is_a?(Proc) ? GODLIKE_SOUND.call : GODLIKE_SOUND
      if File.exists? "#{sounds_directory}/#{sound_name}.mp3"
        sound_file = "#{sounds_directory}/#{sound_name}.mp3"
      else
        sound_file = sound_name
      end
    else
      sound_file = "#{sounds_directory}/godlike.mp3"
    end
    play_sound(sound_file)
  end

  def fail
    # do nothing
  end

  def pending
    # do nothing
  end
end

if defined?(Autotest)
  Autotest.add_hook :ran_command do |autotest|
      result = Result.new(autotest)
      if result.exists?
        if result.has?('test-error') || result.has?('test-failed') || result.has?('example-failed')
          Godlike.fail
        elsif result.has?('example-pending')
          Godlike.pending
        else
          Godlike.success
        end
      end
  end
end

if defined?(LeftRight)
  require 'active_support'
  module LeftRight
    class Runner < Test::Unit::UI::Console::TestRunner
      def finished_with_sound(elapsed_time)
        passed_count = @result.run_count     -
                       @result.failure_count -
                       @result.error_count   - lr.state.skipped_count
        if passed_count > 0 && @result.failure_count.zero? && @result.error_count.zero?
          Godlike.success
        end
        finished_without_sound(elapsed_time)
      end
      alias_method_chain :finished, :sound
    end
  end
end

if defined?(Test::Unit)
  require 'test/unit/ui/console/testrunner' 
  require 'active_support'
  
  class Test::Unit::UI::Console::TestRunner
    def finished_with_sound(elapsed_time)
      if @faults.empty?
        Godlike.success
      end
      finished_without_sound(elapsed_time)
    end
    alias_method_chain :finished, :sound
  end
end