# triplight.rb
# trip.rb version 0.0.3
# 10/23/2002 18:14:47 GMT+9:00
# 2ch trip 8 or 10 or other! 
# Copyright (c) 2002 Igarashi Makoto (raccy)
# You can redistribute it and/or modify it under the same term as Ruby.

module TripLight
  module_function
  def trip(str, n = 8)
    str.crypt(salt(str))[-n, n]
  end
  def salt(str)
    (str + "H.")[1,2].
        gsub(/[^\.-z]/, ".").
        tr(":;<=>?@[\\\\]^_`", "ABCDEFGabcdef")
  end
end

