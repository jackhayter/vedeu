module Vedeu

  module Logging

    # Ensures we can always write to the log file by creating a
    # lock-less log device.
    #
    class LocklessLogDevice < ::Logger::LogDevice

      # Returns a new instance of Vedeu::Logging::LocklessLogDevice.
      #
      # @param log [void]
      # @return [Vedeu::Logging::LocklessLogDevice]
      def initialize(log = nil)
        @dev      = nil
        @filename = nil

        if log.respond_to?(:write) && log.respond_to?(:close)
          @dev = log

        else
          @dev      = open_logfile(log)
          @dev.sync = true
          @filename = log

        end
      end

      # @param message [String]
      # @return [void]
      def write(message)
        @dev.write(message)

      rescue StandardError => exception
        warn("log writing failed. #{exception}")
      end

      # @return [void]
      def close
        @dev.close
      rescue
        nil
      end

      private

      # @param log [String]
      # @return [void]
      def open_logfile(log)
        if FileTest.exist?(log)
          open(log, (File::WRONLY | File::APPEND))

        else
          logdev = open(log, (File::WRONLY | File::APPEND | File::CREAT))
          logdev.sync = true
          logdev

        end
      end

    end # LocklessLogDevice

  end # Logging

end # Vedeu
