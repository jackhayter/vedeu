module Vedeu

  # Trigger a registered or system event by name with arguments. If the
  # event stored returns a value, that is returned. If multiple events are
  # registered for a name, then the result of each event will be returned as
  # part of a collection.
  #
  # @example
  #   Vedeu.trigger(:my_event, :oxidize, 'nitrogen')
  #
  # @api private
  #
  class Trigger

    class << self

      # @param name [Symbol] The name of the event you wish to trigger. The event
      #   does not have to exist.
      # @param args [Array] Any arguments the event needs to execute correctly.
      # @return [Array]
      def trigger(name, *args)
        new(name, *args).trigger
      end

    end

    # @see Vedeu::Trigger.trigger
    # @return [Trigger]
    def initialize(name, *args)
      @name = name
      @args = args
      @repository = Vedeu.events
    end

    # @see Vedeu::Trigger.trigger
    # @return [Array]
    def trigger
      if results.one?
        results.first

      else
        results

      end
    end

    private

    attr_reader :name,
      :args,
      :repository

    # @return [Array<void>|void]
    def results
      @results ||= registered_events.map { |event| event.trigger(*args) }
    end

    # @return [Array|Array<Vedeu::Event>]
    def registered_events
      return [] unless repository.registered?(name)

      repository.find(name)
    end

  end # Trigger

end # Vedeu