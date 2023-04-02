# frozen_string_literal: true
module Loofah
  module HTML5 # :nodoc:
    #
    #  Subclass of Nokogiri::HTML5::DocumentFragment.
    #
    #  See Loofah::ScrubBehavior and Loofah::TextBehavior for additional methods.
    #
    class DocumentFragment < Nokogiri::HTML5::DocumentFragment
      include Loofah::TextBehavior

      class << self
        def parse(tags, encoding = nil)
          doc = Loofah::HTML5::Document.new

          encoding ||= tags.respond_to?(:encoding) ? tags.encoding.name : "UTF-8"
          doc.encoding = encoding

          new(doc, tags)
        end
      end

      #
      #  Returns the HTML markup contained by the fragment
      #
      def to_s
        serialize_root.children.to_s
      end

      alias :serialize :to_s

      def serialize_root
        at_xpath("./body") || self
      end
    end
  end
end
