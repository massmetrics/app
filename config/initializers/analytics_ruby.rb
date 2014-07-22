Analytics = AnalyticsRuby       # Alias for convenience
Analytics.init({
                 secret: ENV['SEGMENT'],          # The write key for stevenmagelowitz/massmetrics
                 on_error: Proc.new { |status, msg| print msg }  # Optional error handler
               })