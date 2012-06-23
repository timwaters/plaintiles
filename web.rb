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

  "<h1>Plain Tile Maker</h1>This app will serve simple, plain tiles for mapping applications
  <h2>Colors</h2>
  <a href='http://www.imagemagick.org/script/color.php#color_names'>http://www.imagemagick.org/script/color.php#color_names </a>
  <h2>Usage</h2>
  http://thisurl.com/colorname/X/Y/Z.png or basically something like: http://example.com/colourname/*
  <h2>#{tile_count} Tiles made so far:</h2>" + html_tiles

end

get '/:hex/*' do

  colour = params[:hex].scan(/[\w\s]+/)[0] || wheat # rudimentary param validation
  unless File.exist?("public/images/tiles/#{colour}.png")
    `convert -size 256x256 xc:#{colour} public/images/tiles/#{colour}.png`
    #TODO catch convert errors for missing colours "convert: unrecognized color"
  end

  send_file "public/images/tiles/#{colour}.png"

end

