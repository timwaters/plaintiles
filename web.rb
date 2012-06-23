require 'sinatra'

get '/' do

  tiles = []
  Dir.chdir("public/images/tiles") do
    tiles = Dir.glob('*.png')
  end
  tile_count = tiles.length
  html_tiles = ""
  tiles.each do | tile |
    html_tiles = html_tiles + "#{tile}<img src='/images/tiles/#{tile}'  style='padding:0.1em'>"
  end

  "<h1>Plain Tile Maker</h1>This app will serve simple, plain 256x256 png format tiles for mapping applications
  <h2>Colours</h2>
  Choose from any of the 675 colours by name in the table here: <a href='http://www.imagemagick.org/script/color.php#color_names'>http://www.imagemagick.org/script/color.php#color_names </a>
  <h2>Usage</h2>
  <pre><b>http://plaintiles.herokuapp.com/colorname/X/Y/Z.png</b></pre> or even something like: <pre><b>http://plaintiles.herokuapp.com/colourname/* </b></pre> <br />
  For example try: <a href='http://plaintiles.herokuapp.com/hotpink/1/2/3.png'>http://plaintiles.herokuapp.com/hotpink/1/2/3.png</a>  or <a href='http://plaintiles.herokuapp.com/DodgerBlue/0/0/0.png'>http://plaintiles.herokuapp.com/DodgerBlue/0/0/0.png</a> <br />
  <h2>Examples</h2>
  Here's an <a href='http://geocommons.com/maps/180483'>example of the plain tiles being used in GeoCommons.com</a>
  <h2>#{tile_count} Cached tiles</h2> #{html_tiles} 
  <h2>About</h2>
  Made by <a href='http://thinkwhere.wordpress.com'>Tim Waters</a> @tim_waters <br />
 <a href='https://github.com/timwaters/plaintiles'>Get the code on github</a>"
end

get '/:hex/*' do

  colour = params[:hex].scan(/[\w\s]+/)[0] || wheat # rudimentary param validation
  unless File.exist?("public/images/tiles/#{colour}.png")
    `convert -size 256x256 xc:#{colour} public/images/tiles/#{colour}.png`
    #TODO catch convert errors for missing colours "convert: unrecognized color"
  end

  send_file "public/images/tiles/#{colour}.png"

end

