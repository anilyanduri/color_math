class ColorMath

  # r       The red color value (int)
  # g       The green color value (int)
  # b       The blue color value (int)
  def initialize(r, g, b)
    @r = r
    @g = g
    @b = b
  end

  def to_hex
    self.class.rgb_to_hex(@r, @g, @b)
  end

  def to_rgb
    return @r, @g, @b
  end

  def to_hsl
    self.class.rgb_to_hsl(@r, @g, @b)
  end

  # Class methods

  # creates a color object from hex code
  def self.from_hex(hex)
    r, g, b = hex_to_rgb(hex)
    new(r, g, b)
  end

  # h       The hue (int) 0 - 360
  # s       The saturation (int) 0 - 100
  # l       The lightness (int) 0 - 100
  def self.from_hsl(h, s, l)
    r, g, b = hsl_to_rgb(h, s, l)
    new(r, g, b)
  end

  def self.rgb_to_hex(r, g, b)
    rbg = [r,g,b]
    hex = "#"
    rbg.each do |component|
      _hex = component.to_s(16)
      if component < 16
        hex << "0#{_hex}"
      else
        hex << _hex
      end
    end
    hex.upcase
  end

  def self.hex_to_rgb(hex)
    hex.gsub!("#", "")
    components = hex.scan(/.{2}/)
    components.collect { |component| component.to_i(16) }
  end

  # Converts an RGB color value to HSL. Conversion formula
  # adapted from http://en.wikipedia.org/wiki/HSL_color_space. and 
  #            # http://stackoverflow.com/a/9493060/520008
  # Assumes r, g, and b are contained in the set [0, 255] and

  # r       The red color value (int)
  # g       The green color value (int)
  # b       The blue color value (int)
  # The HSL representation [hue, saturation, luminosity]

  def self.rgb_to_hsl(r, g, b)
    r /= 255.0
    g /= 255.0
    b /= 255.0
    max = [r, g, b].max
    min = [r, g, b].min
    h = (max + min) / 2.0
    s = (max + min) / 2.0
    l = (max + min) / 2.0

    if(max == min)
      h = 0
      s = 0 # achromatic
    else
      d = max - min;
      s = l >= 0.5 ? d / (2.0 - max - min) : d / (max + min)
      case max
        when r 
          h = (g - b) / d + (g < b ? 6.0 : 0)
        when g 
          h = (b - r) / d + 2.0
        when b 
          h = (r - g) / d + 4.0
      end
      h /= 6.0
    end
    return [(h*360).round, (s*100).round, (l*100).round]
  end

  # Converts an HSL color value to RGB. Conversion formula
  # adapted from http://en.wikipedia.org/wiki/HSL_color_space. and 
  #            # http://stackoverflow.com/a/9493060/520008
  # returns r, g, and b in the set [0, 255].
  # h       The hue (int) 0 - 360
  # s       The saturation (int) 0 - 100
  # l       The lightness (int) 0 - 100
  # returns The RGB representation [r, g, b]
  def self.hsl_to_rgb(h, s, l)
    h = h/360.0
    s = s/100.0
    l = l/100.0

    r = 0.0
    g = 0.0
    b = 0.0
    
    if(s == 0.0)
      r = l.to_f
      g = l.to_f
      b = l.to_f #achromatic
    else
      q = l < 0.5 ? l * (1 + s) : l + s - l * s
      p = 2 * l - q
      r = hue_to_rgb(p, q, h + 1/3.0)
      g = hue_to_rgb(p, q, h)
      b = hue_to_rgb(p, q, h - 1/3.0)
    end

    return [(r * 255).round, (g * 255).round, (b * 255).round]
  end

  def self.hue_to_rgb(p, q, t)
    t += 1                                  if(t < 0) 
    t -= 1                                  if(t > 1)
    return (p + (q - p) * 6 * t)            if(t < 1/6.0) 
    return q                                if(t < 1/2.0) 
    return (p + (q - p) * (2/3.0 - t) * 6)  if(t < 2/3.0) 
    return p
  end

end