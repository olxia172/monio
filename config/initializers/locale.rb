I18n.load_path += Dir[Rails.root.join('config', 'locale', '*.{rb,yml}')]
I18n.available_locales = [:en, :pl]
I18n.default_locale = :pl
