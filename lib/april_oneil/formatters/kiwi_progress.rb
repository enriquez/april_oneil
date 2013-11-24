require 'april_oneil/formatters/base_formatter'
require 'rainbow'

module AprilONeil
  module Formatters
    class KiwiProgress < BaseFormatter
      DARK_GRAY_COLOR = "333333"

      def initialize(output)
        super(output)

        Sickill::Rainbow.enabled = true

        @passed  = []
        @pending = []
        @failed  = []
      end

      def begin_build_target(opts)
        project = opts['project']
        target  = opts['target']
        @output.puts if @test_target
        @output.puts "Building #{project} / #{target}"
        @test_target = target # assume last target is the test target
      end

      def end_build_command(opts)
        succeeded = opts['succeeded']
        if succeeded
          @output.print ".".foreground(:cyan)
        else
          @output.print "E".foreground(:red)
          @output.puts
          @output.puts
          @output.puts opts["emittedOutputText"].color(DARK_GRAY_COLOR)
        end
      end

      def begin_ocunit(opts)
        @output.puts
        @output.puts "Running Tests"
      end

      def test_output(opts)
        # print NSLog statements while ignoring Kiwi output
        output = opts["output"]
        @output.print output.color(DARK_GRAY_COLOR) unless output =~ /^.+\[.+\] \+/
      end

      def end_test(opts)
        succeeded = opts["succeeded"]
        if succeeded
          output = opts["output"]
          if output[/\[([A-Z]+)\]/] == '[PENDING]'
            @output.print "*".foreground(:yellow)
            @pending << opts
          else
            @output.print ".".foreground(:green)
            @passed << opts
          end
        else
          @output.print "F".foreground(:red)
          @failed << opts
        end
      end

      def end_action(opts)
        @summary = opts if opts["name"] == "test"
      end

      def after_end
        @output.puts
        @output.print pending_summary
        @output.print failure_summary
        @output.print run_summary
      end

      protected

      def pending_summary
        output = ''

        if @pending.count > 0
          output = "\nPending:\n"
          @pending.each do |pending|
            if pending["output"] =~ /\+ \'(.+)\'/
              test_name = $1
              output << "  #{test_name}\n"
            end
          end
        end

        output
      end

      def failure_summary
        output = ''
        if @failed.count > 0
          output << "\nFailures:\n"
          @failed.each do |failed|
            name_added  = false
            exceptions  = failed["exceptions"]
            class_name  = failed["className"]
            method_name = failed["methodName"]
            exceptions.each do |exception|
              test_file   = File.basename(exception["filePathInProject"])
              line_number = exception["lineNumber"]
              reason      = exception["reason"]
              if reason =~ /\'(.+)\' \[\w+\], (.+)/
                test_name = $1
                message   = $2

                if !name_added
                  output << "  #{test_name}\n"
                  output << "    -only #{@test_target}:#{class_name}/#{method_name}\n".foreground(:cyan)
                  name_added = true
                end

                if test_file =~ /Unknown File/
                  output << "    #{message}\n".foreground(:red)
                else
                  location = "# #{test_file}:#{line_number}".color(DARK_GRAY_COLOR)
                  output << "    #{message.color(:red)} #{location}\n"
                end
              end
            end
          end
          output << "\n"
        end

        output
      end

      def run_summary
        output = ''
        if @summary
          duration = @summary["duration"].to_f
          duration_in_ms = (duration * 1000).floor
          failure_count = @failed.count
          pending_count = @pending.count
          total_count   = @passed.count + pending_count + failure_count

          output = "\nFinished in #{duration_in_ms}ms\n"
          counts = ''

          if total_count > 0
            counts << "#{total_count} tests, #{failure_count} failures"
            counts << ", #{pending_count} pending" if pending_count > 0
          end

          counts << "\n"

          if failure_count > 0
            output << counts.foreground(:red)
          elsif pending_count > 0
            output << counts.foreground(:yellow)
          else
            output << counts.foreground(:green)
          end
        end

        output
      end
    end
  end
end
