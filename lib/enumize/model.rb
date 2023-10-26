# frozen_string_literal: true

module Enumize
  module Model
    extend ActiveSupport::Concern

    class_methods do
      if Rails.version.to_f < 7.0
        def enum(opts)
          super(opts)

          opts.each do |name, values|
            _enumize(name, values)
          end
        end
      end

      def _enum(name, values, **options)
        super(name, values, **options)

        _enumize(name, values, **options)
      end

      def _enumize(name, values, **options)
        klass = self
        singular_model_name = klass.name.singularize.underscore
        locale_prefix = "activerecord.enums.#{singular_model_name}"

        # def status_name; I18n.t("activerecord.enums.book.status.#{status}"); end
        detect_enum_conflict!(name, "#{name}_name")
        define_method("#{name}_name") do
          return "" if send(name).nil?
          I18n.t("#{locale_prefix}.#{name}.#{send(name)}")
        rescue I18n::MissingTranslationData
          self[field].titleize
        end

        # def status_color; I18n.t("activerecord.enums.book.status_color.#{status}"); end
        detect_enum_conflict!(name, "#{name}_color")
        define_method("#{name}_color") do
          return "black" if send(name).nil?
          I18n.t("#{locale_prefix}.#{name}_color.#{send(name)}", raise: true)
        rescue I18n::MissingTranslationData
          return "black"
        end

        # def status_value; Book.statuses[self.status]; end
        detect_enum_conflict!(name, "#{name}_value")
        define_method("#{name}_value") do
          return nil if send(name).nil?
          klass.send(name.to_s.pluralize)[self[name]]
        end

        # Book.state_options # => [["Draft", "draft"], ["Published", "published"], ["Archived", "archived"]]
        detect_enum_conflict!(name, "#{name}_options", true)
        define_singleton_method("#{name}_options") do
          send(name.to_s.pluralize).map do |k, _|
            label = new(name => k).send("#{name}_name")
            [label, k]
          end

          # Book.status_of_published
          values.each do |key, val|
            detect_enum_conflict!(name, "#{name}_of_#{key}", true)
            define_singleton_method("#{name}_of_#{key}") do
              klass.where("#{name}": val)
            end
          end
        end
      end
    end
  end
end
