require "tilt/html/pipeline/version"

require "tilt"
require "html/pipeline"

module Tilt
  module HTML
    module Pipeline
      def self.root
        Pathname.new(File.expand_path('..', __FILE__))
      end

      # A tilt compatible render for HTML pipeline.
      class Renderer
        # HTML::Pipeline instance.
        attr_reader :pipeline

        def initialize(pipeline)
          @pipeline = pipeline
        end

        # Creates a rendering class for tilt 
        def renderer
          # If we don't set this up, Ruby will get confused and possibly
          # crash when calling variables, methods, or name that may be the
          # same.
          scope = self

          # Create a class that can handle all of our 
          Class.new(Tilt::PlainTemplate).tap do |klass|
            # Setup the pipeline as a class variable so that
            # the render call can get to it.
            klass.define_singleton_method :pipeline do
              scope.pipeline
            end

            # Now setup the renderer to use the pipeline.
            klass.class_eval do
              # Render everything from the pipeline, ja.
              def evaluate(scope, locals, &block)
                result = self.class.pipeline.call(data)
                result[:output].to_s
              end
            end
          end
        end
      end
    end
  end
  
  # Register HTML::Pipelines with a Tilt file extension.
  def self.register_html_pipeline(extension, *args)
    pipeline = ::HTML::Pipeline.new(*args)
    renderer = Tilt::HTML::Pipeline::Renderer.new(pipeline).renderer
    # Register with tilt.
    Tilt.register renderer, extension
  end
end