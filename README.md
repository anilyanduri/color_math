# color math
Ruby Gem for RGB to HSL and RGB to HSV color model conversion algorithms in Ruby

# Installation

gem install color_math

# Usage 

  require 'rubygems' 

  require 'color_math' 

  cl  = ColorMath.new 255, 255, 255

  cl.to_hex # returns hex notation of r g b (255, 255, 255)

  cl.to_hsl # returns hsl notation of r g b (255, 255, 255)

  also can be initialized from hsl or hex with

  cl = ColorMath.from_hsl(360, 100, 100) #where 360 is hue, 100 is saturation and 100 is luminous or brightness
  cl = ColorMath.from_hex("#FFFFFF") 
  