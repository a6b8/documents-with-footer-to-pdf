def obj_prepare_path( obj, salt, status )
  def helper_parse_path( str )
    if str[ str.length - 1, 1 ] != '/'
      str = str + '/'
    end
    return str
  end

  def draw_obj_line_edge( l, offset )
      str = ''
      for i in 1..( ( l - 1 ) * offset )
        str += ' '
      end
      if l > 1
        str += "┗"
        str += "━"
        str += " "
      else
        str += '    '
      end
      return str
  end
  
  def draw_obj_path_local( str, l, offset )
    result = ''
    for i in 0..( ( l - 1 ) * offset )
      result += ' '
    end
    result += ''
    result += str
    return result
  end

  def helper_obj_path( name, salt, k, f=nil )
    str = ''
    str += draw_obj_line_edge( name[ 1, name.length ].to_i, 4 )
    str += 'hash[:path]'
    if k.length == 0

    else
      for i in 0..k.length-1
        str += '[:children]'
        str += '[:'
        str += k[ i ].to_s
        str += ']'      
      end
    end

    if !f.nil?
      str += '[:files][:'
      str += f.to_s
      str += '][:full]'    
    else
      str += '[:full]'
    end
    return str
  end
  
  def helper_insert_salt( salt, str )
    if salt[ 0, 1 ] == ''
      
    else
      if salt[ 0, 1 ] == '-'
      else
        salt = '-' + salt      
      end
    end

    str = str.gsub( "{{SALT}}", salt )
    return str
  end

  def helper_parse_path( str )
    if str[ str.length - 1, 1 ] != '/'
      str = str + '/'
    end
    return str
  end

  def draw_obj_line_edge( l, offset )
      str = ''
      for i in 1..( ( l - 1 ) * offset )
        str += ' '
      end
      if l > 1
        str += "┗"
        str += "━"
        str += " "
      else
        str += '    '
      end
      return str
  end
  
  def draw_obj_path_local( str, l, offset )
    result = ''
    for i in 0..( ( l - 1 ) * offset )
      result += ' '
    end
    result = result[ 1, result.length ]
    
    if str.index('.') != nil
      result += 'File: '
    else
      result += 'Folder: '
    end
    result += str
    return result
  end

  def helper_obj_path( name, salt, k, f=nil )
    str = ''
    str += draw_obj_line_edge( name[ 1, name.length ].to_i, 4 )
    str += ''
    str += 'hash[:path]'
    if k.length == 0

    else
      for i in 0..k.length-1
        str += '[:children]'
        str += '[:'
        str += k[ i ].to_s
        str += ']'      
      end
    end

    if !f.nil?
      str += '[:files][:'
      str += f.to_s
      str += '][:full]'    
    else
      str += '[:full]'
    end
    return str
  end
  
  def helper_insert_salt( salt, str )
    if salt[ 0, 1 ] == ''
      
    else
      if salt[ 0, 1 ] == '-'
      else
        salt = '-' + salt      
      end
    end

    str = str.gsub( "{{SALT}}", salt )
    return str
  end

  mode = {
    :general => nil,
    :hash => nil,
    :path => nil
  }
    
  case status
    when 0
      mode[:general] = false
      mode[:hash] = false
      mode[:path] = false
    when 1
      mode[:general] = true
      mode[:hash] = true
      mode[:path] = false
    when 2
      mode[:general] = true
      mode[:hash] = false
      mode[:path] = true
    when 3
      mode[:general] = true
      mode[:hash] = true
      mode[:path] = true
  end
  
  
  mode[:general] ? puts( 'TREE OVERVIEW' ) : ''
  
  obj[:full] = ''
  obj[:full] += obj[:root]
  obj[:full] += helper_parse_path( helper_insert_salt( salt, obj[:name] ) )
  
  mode[:hash] ? puts( helper_obj_path( 'l1', salt, [ ] ) ) : ''
  mode[:path] ? puts( draw_obj_path_local( obj[:full], 2, 4 ) ) : ''

  obj[:children].keys.each { | l2 | 
      obj[:children][ l2 ][:full] = ''
      obj[:children][ l2 ][:full] += obj[:full]
      obj[:children][ l2 ][:full] += helper_parse_path( helper_insert_salt( salt, obj[:children][ l2 ][:name] ) )
      mode[:hash] ? puts( helper_obj_path( 'l2', salt, [ l2 ] ) ) : ''
      mode[:path] ? puts( draw_obj_path_local( obj[:children][ l2 ][:full], 3, 4 ) ) : ''
      FileUtils.mkdir_p obj[:children][ l2 ][:full]

      if !obj[:children][ l2 ][:files].nil?
        obj[:children][ l2 ][:files].keys.each { | f1 | 
          obj[:children][ l2 ][:files][ f1 ][:full] = '' 
          obj[:children][ l2 ][:files][ f1 ][:full] += obj[:children][ l2 ][:full] 
          obj[:children][ l2 ][:files][ f1 ][:full] += helper_insert_salt( salt, obj[:children][ l2 ][:files][ f1 ][:name] )
          mode[:hash] ? puts( helper_obj_path( 'l2', salt, [ l2 ], f1 ) ) : ''
          mode[:path] ? puts( draw_obj_path_local( obj[:children][ l2 ][:files][ f1 ][:full], 3, 4 ) ) : ''
        }
      end

      if !obj[:children][ l2 ][:children].nil?
        obj[:children][ l2 ][:children].keys.each { | l3 | 
          obj[:children][ l2 ][:children][ l3 ][:full] = ''
          obj[:children][ l2 ][:children][ l3 ][:full] += obj[:children][ l2 ][:full]
          obj[:children][ l2 ][:children][ l3 ][:full] += helper_parse_path( helper_insert_salt( salt, obj[:children][ l2 ][:children][ l3 ][:name] ) )

          FileUtils.mkdir_p obj[:children][ l2 ][:children][ l3 ][:full]
          mode[:hash] ? puts( helper_obj_path( 'l3', salt, [ l2, l3 ] ) ) : ''
          mode[:path] ? puts( draw_obj_path_local( obj[:children][ l2 ][:children][ l3 ][:full], 4, 4 ) ) : ''

          if !obj[:children][ l2 ][:children][ l3 ][:files].nil?
            obj[:children][ l2 ][:children][ l3 ][:files].keys.each { | f2 | 
              obj[:children][ l2 ][:children][ l3 ][:files][ f2 ][:full] = ''
              obj[:children][ l2 ][:children][ l3 ][:files][ f2 ][:full] += obj[:children][ l2 ][:children][ l3 ][:full]
              obj[:children][ l2 ][:children][ l3 ][:files][ f2 ][:full] += helper_insert_salt( salt, obj[:children][ l2 ][:children][ l3 ][:files][ f2 ][:name] )
              mode[:hash] ? puts( helper_obj_path( 'l3', salt, [ l2, l3 ], f2 ) ) : ''
              mode[:path] ? puts( draw_obj_path_local( obj[:children][ l2 ][:children][ l3 ][:files][ f2 ][:full], 4, 4 ) ) : ''
            }
          end
        }
      end
  }
  return obj
end


def resize_jpgs( data, obj, debug )
  files = []

  [ '.jpg', '.png'].each { | suffix | 
    files +=  Dir[ obj[:path][:root] + '*' + suffix ]
  }


  files.each do | file |
    p = ''
    p += obj[:path][:children][:resized][:full]
    p += File.basename( file )
      .split( '.' )[ 0 ]
      .downcase
      .split( '_' )
      .join( '-' )
    p += '.jpg'

    i = Image.read( file ).first
    i.format = 'JPEG'
    data[:width] != -1 ? i.resize_to_fit!( data[:width] ) : ''
    i.write( p ) { self.quality = data[:quality] }
  end
  return true
end


puts 
puts 'RESIZE JPGS'
puts '----------------------------'
puts ''
puts 'SET FOLDER '
print '>>  '

path = gets.chomp
path[ path.length - 1, path.length - 1 ].index( '/' ).nil? ? path = path + '/' : ''

puts
puts 'SET WIDTH (default: original width)'
print '>>  '

width_ = gets.chomp
width_.eql?( '' ) ? width_ = -1 : width_ = width_.to_i

puts
puts 'SET QUALITY (default: 100)'
print '>>  '

quality_ = gets.chomp
quality_.eql?( '' ) ? quality_ = 100 : quality_ = quality_.to_i



require 'RMagick'
include Magick
require 'FileUtils'

data = {}
data[:path] = path
data[:width] = width_
data[:quality] = quality_

hash = {
  :path => {
    :root => data[:path],
    :name => '',
    :full => nil,
    :children => {
      :resized => {
        :name => '0-resized',
        :full => nil
      }
    }
  }
}


debug = false
hash[:path] = obj_prepare_path( hash[:path], '', debug )
resize_jpgs( data, hash, debug )