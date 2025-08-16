require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.public_file_server.headers = { "cache-control" => "public, max-age=#{2.days.to_i}" }
  else
    config.action_controller.perform_caching = false
  end

  config.cache_store = :memory_store
  config.active_storage.service = :local

  # ← 開発ではエラーを見たいので true を推奨
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false

  # URL生成用
  config.action_mailer.default_url_options = { host: ENV.fetch('APP_HOST', 'localhost:3000'), protocol: 'http' }

  # ★ SendGrid SMTP（ここからが重要）
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.sendgrid.net',
    port:                 587,
    user_name:            'apikey',                 # ← 文字通り "apikey"
    password:             ENV['SENDGRID_API_KEY'],  # ← .env の値
    authentication:       :plain,
    enable_starttls_auto: true
  }
  config.action_mailer.default_url_options = {
    host: ENV.fetch('APP_HOST'), protocol: 'https'
  }
  config.action_mailer.raise_delivery_errors = true

  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_record.query_log_tags_enabled = true
  config.active_job.verbose_enqueue_logs = true
  config.action_view.annotate_rendered_view_with_filenames = true
  config.action_controller.raise_on_missing_callback_actions = true
end
