module AprilONeil
  module Formatters
    # xctool events: https://github.com/facebook/xctool/blob/master/Common/ReporterEvents.h
    class BaseFormatter
      def initialize(output)
        @output = output
      end

      def before_start
      end

      def begin_status(opts)
      end

      def end_status(opts)
      end

      def begin_action(opts)
      end

      def begin_xcodebuild(opts)
      end

      def begin_build_target(opts)
      end

      def begin_build_command(opts)
      end

      def end_build_command(opts)
      end

      def end_build_target(opts)
      end

      def end_xcodebuild(opts)
      end

      def begin_ocunit(opts)
      end

      def begin_test_suite(opts)
      end

      def begin_test(opts)
      end

      def test_output(opts)
      end

      def end_test(opts)
      end

      def end_test_suite(opts)
      end

      def end_ocunit(opts)
      end

      def end_action(opts)
      end

      def analyzer_result(opts)
      end

      def after_end
      end
    end
  end
end
