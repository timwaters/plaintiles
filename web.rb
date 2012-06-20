require 'sinatra'

get '/' do
  "<h1>Plain Tile Maker</h1>This app will serve simple, plain tiles for mapping applications
  <h2>Colors</h2>
  <a href='http://www.imagemagick.org/script/color.php#color_names'>http://www.imagemagick.org/script/color.php#color_names </a>
 <h2>Usage</h2>
 http://thisurl.com/colorname/X/Y/Z.png "

  end

get '/:hex/*' do
 params[:hex]
 color = params[:hex].scan(/[\w\s]+/)[0] || wheat
 `convert -size 256x256 xc:#{color} tile.png`
 send_file 'tile.png'
 end

