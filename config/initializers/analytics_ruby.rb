Analytics = Segment::Analytics.new({
                                     write_key: ENV['SEGMENT'],
                                     on_error: Proc.new { |status, msg| print msg }
                                   })