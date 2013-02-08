require 'RMagick'
require 'rails/all'
class Image
  include  Magick
  def just
    img = ImageList.new("public/computer-cat.jpg")
    txt = Draw.new
    img.annotate(txt, 0,0,0,0, "In ur Railz, annotatin ur picz."){
      txt.gravity = Magick::SouthGravity
      txt.pointsize = 25
      txt.stroke = "#000000"
      txt.fill = "#ffffff"
      txt.font_weight = Magick::BoldWeight
    }
    img.format = "jpeg"
    send_data img.to_blob, :stream => "false", :filename => "test.jpg", :type => "image/jpeg", :disposition => "inline"
  end

  def draw_image
    #Image parameters


    options = {:img_width => 300, :img_height => 250, :text_color => "#FFFFFF", :font_size => 36,
               :text => "ddddd", :bg_color => "#000"}

    #Initialize a container with it's width and height

    container=Magick::Image.new(options[:img_width],options[:img_height]){

      self.background_color = options[:bg_color]
    }

#Initialize a new image
    image=  Magick::Draw.new
    image.stroke('transparent')
    image.fill(options[:text_color])
    image.font='/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType/Verdana_Italic.ttf'
    image.pointsize=options[:font_size]
    image.font_weight=Magick::BoldWeight
    image.text(0,0,options[:text])
    image.text_antialias(false)
    image.font_style=Magick::NormalStyle
    image.gravity=Magick::CenterGravity

#Place the image onto the container
    image.draw(container)
    container = container.raise(3,1)

# To test the image(a pop up will show you the generated dynamic image)
    container.display

# generated image will be saved in public directory
 # container.write("public/image.gif")

       #img = ImageList.new("/public/computer-cat.jpg")
       #img.format = "jpeg"

          send_data File.read("#{Rails.root}/public/computer-cat.jpg", :mode => "rb"), :filename => 'test.gif', :type => 'image/gif'
       #  send_data img.to_blob, :stream => "false", :filename => "test.jpg", :type => "image/jpeg", :disposition => "inline"

  end


end

Image.new.draw_image