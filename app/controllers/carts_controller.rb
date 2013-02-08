require "RMagick"
class CartsController < ApplicationController


  def index
    @order = "<h1>rrrrrrrrrrrr</h1>"
    respond_to do |format|
      format.html do
        # Render the show.rhtml template
      end

      #format.png do
      # Show cart icon with number of items in it
      icon = Magick::Image.read("#{Rails.root}/public/computer-cat.jpg").first

      drawable = Magick::Draw.new
      drawable.pointsize = 18.0
      drawable.font = ("#{Rails.root}/artwork/fonts/VeraMono.ttf")
      drawable.fill = '#fff'
      drawable.gravity = Magick::CenterGravity

      # Tweak the font to draw slightly up and left from the center
      #drawable.annotate(icon, 0, 0, -3, -6, @order.html_safe)
      drawable.annotate(icon, 0, 0, -150, -150, 'Menu')
      drawable.annotate(icon, 0, 0,  100, -150, 'Price')
      drawable.line(120, 150, 120,  30)

      send_data icon.to_blob, :filename => "#{@order}.jpg", :disposition => 'inline',  :type => "image/jpg"
      #end

    end
  end



     RMAGICK_HOME = 'http://www.imagemagick.org/RMagick/doc/'
     FNAME = "public/computer-cat.jpg"

     OPS = [
         [['blue_shift', 3], 'image1.html'],
         [['charcoal'], 'image1.html'],
         [['flop'], 'image2.html'],
         [['frame'], 'image2.html'],
         [['motion_blur', 0, 10, 30], 'image2.html'],
         [['normalize'],'image3.html'],
         [['oil_paint', 6], 'image3.html'],
         [['posterize'], 'image3.html'],
         [['quantize', 256, Magick::GRAYColorspace], 'image3.html'],
         [['rotate', 180], 'image3.html'],
         [['sepiatone'], 'image3.html'],
     ]

     WIDTH = 300
     HEIGHT = 200


  def test
   @data = []
# the Magick class used for annotations
    gc = Magick::Draw.new do |g|
      g.fill = 'white'
      g.font_weight = Magick::BoldWeight
      g.gravity = Magick::SouthGravity
      g.pointsize = 12
      g.undercolor = 'black'
    end

# the base image
    img = Magick::Image.read(FNAME)[0].strip!

    OPS.each do |op_arr|
      ops = op_arr[0]
      url = "#{RMAGICK_HOME}#{op_arr[1]}"

      ximg = img.send(*ops).resize_to_fit(WIDTH, HEIGHT)

      # label the image with the method name
      lbl = Magick::Image.new(WIDTH, HEIGHT)
      gc.annotate(ximg, 0, 0, 0, 0, ops[0])

      # save the new image to disk
      new_fname = "#{FNAME}-#{ops[0]}.jpg"
      ximg.write((new_fname))

      # output HTML for the chapter
       puts txt = <<HTML
  <tr>
   <td><pre><code>img.#{ops[0]}#{'(' + ops[1..-1].join(', ')+')' if ops.length > 1}</code></pre></td>
   <td><div class="imgwrap alone"><img src="#{new_fname}" alt="#{ops[0]}"></div></td>
  </tr>
HTML

    @data.push(txt)
    end
  end

end