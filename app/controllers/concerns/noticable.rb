module Noticable
  extend ActiveSupport::Concern

  included do

    def create_notice(action:, model:)
      t('flash_messages.info', action: t("actions.#{action}"), model: t("models.#{model}"))
    end

  end
end
