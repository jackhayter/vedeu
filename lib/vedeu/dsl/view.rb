require 'vedeu/support/common'
require 'vedeu/models/view/composition'

module Vedeu

  module DSL

    # DSL for creating views.
    #
    # @api public
    class View

      class << self

        include Vedeu::Common

        # Register an interface by name which will display output from a event
        # or command. This provides the means for you to define your the views
        # of your application without their content.
        #
        # @todo More documentation required.
        #
        # @param name [String] The name of the interface. Used to reference the
        #   interface throughout your application's execution lifetime.
        # @param block [Proc] A set of attributes which define the features of
        #   the interface.
        #
        # @example
        #   Vedeu.interface 'my_interface' do
        #     ...
        #
        #   Vedeu.interface do
        #     name 'interfaces_must_have_a_name'
        #     ...
        #
        # @raise [InvalidSyntax] The required block was not given.
        # @return [Interface]
        def interface(name = '', &block)
          unless block_given?
            fail InvalidSyntax, "'#{__callee__}' requires a block."
          end

          Vedeu::Interface.build({ client: client(&block), name: name }, &block).store
        end

        # Immediate render
        #
        # Directly write a view buffer to the terminal. Using this method means
        # that the refresh event does not need to be triggered after creating
        # the views, though can be later triggered if needed.
        #
        # @param block [Proc] The directives you wish to send to render.
        #   Typically includes `view` with associated sub-directives.
        #
        # @example
        #   Vedeu.renders do
        #     view 'my_interface' do
        #       ...
        #
        # @raise [InvalidSyntax] The required block was not given.
        # @return [Array<Interface>]
        def renders(&block)
          unless block_given?
            fail InvalidSyntax, "'#{__callee__}' requires a block."
          end

          store(:store_immediate, &block)
        end

        # Deferred view
        #
        # Define a view (content) for an interface.
        #
        # @note The views declared within this block are stored in their
        #   respective interface back buffers until a refresh event occurs. When
        #   the refresh event is triggered, the back buffers are swapped into the
        #   front buffers and the content here will be rendered to
        #   {Terminal.output}.
        #
        # @param block [Proc] The directives you wish to send to render. Typically
        #   includes `view` with associated sub-directives.
        #
        # @example
        #   Vedeu.views do
        #     view 'my_interface' do
        #       ... some attributes ...
        #     end
        #     view 'my_other_interface' do
        #       ... some other attributes ...
        #     end
        #     ...
        #
        # @raise [InvalidSyntax] The required block was not given.
        # @return [Array<Interface>]
        def views(&block)
          unless block_given?
            fail InvalidSyntax, "'#{__callee__}' requires a block."
          end

          store(:store_deferred, &block)
        end

        private

        # Returns the client object which called the DSL method.
        #
        # @param block [Proc]
        # @return [Object]
        def client(&block)
          eval('self', block.binding)
        end

        # Creates a new Composition which may contain one or more views
        # (Interface objects).
        #
        # @param client [Object]
        # @param block [Proc]
        # @return [Vedeu::Composition]
        def composition(client, &block)
          Vedeu::Composition.build({ client: client }, &block)
        end

        # Stores each of the views defined in their respective buffers ready to
        # be rendered on next refresh.
        #
        # @param method [Symbol] An instruction; `:store_immediate` or
        #   `:store_deferred` which determines whether the view will be shown
        #   immediately or later respectively.
        # @param block [Proc]
        # @return [Array]
        def store(method, &block)
          composition(client(&block), &block).interfaces.map do |interface|
            interface.public_send(method)
          end
        end

      end

    end # View

  end # DSL

end # Vedeu
