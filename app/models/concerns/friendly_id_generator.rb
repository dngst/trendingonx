# frozen_string_literal: true

module FriendlyIdGenerator
  extend ActiveSupport::Concern

  class ReusableSlugGenerator < FriendlyId::SlugGenerator
    def available?(slug)
      if @config.uses?(::FriendlyId::Reserved) && @config.reserved_words.present? && @config.treat_reserved_as_conflict && @config.reserved_words.include?(slug)
        return false
      end

      !@scope.unscoped.exists?(slug:)
    end
  end
end
