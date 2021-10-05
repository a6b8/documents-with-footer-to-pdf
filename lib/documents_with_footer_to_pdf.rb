# frozen_string_literal: true

require_relative "documents_with_footer_to_pdf/version"
require 'local_path_builder'
require 'fileutils'
require 'combine_pdf'
require 'prawn'

Prawn::Fonts::AFM.hide_m17n_warning = true

module DocumentsWithFooterToPdf
  class Error < StandardError; end
  # Your code goes here...

  def self.get_options()
    return {
      path: {
        root: nil,
        name: '',
        children: {
          tmp: {
            name: 'tmp-{{SALT}}',
            children: {
              jpg: {
                name: '0-jpg'
              },
                pdf_single: {
                  name: '1-pdf-single--w-footer'
              }
            }
          },
          pdf_combined: {
            name: '0-result-{{SALT}}',
            files: {
              result: {
                name: 'result.pdf'
              }
            }
          }
        }
      },
      footer: {
        position: {
          top: [ 0, 20 ],
          bottom: [ 0, 10 ]
        },
        table: {
          left: {
            top: {
              text: '<<--FILENAME-->>'
            },
            bottom: {
              text: ''
            }
          },
          center: {
            top: {
              text: ''
            },
            bottom: {
              text: ''
            }
          },
          right: {
            top: {
              text: '<<--TIMESTAMP-->>'
            },
            bottom: {
              text: '<<--PAGE_CURRENT-->> from <<--PAGE_TOTAL-->>'
            }
          }
        }
      },
      selectors: {
        timestamp: {
          gsub: '<<--TIMESTAMP-->>',
          key: :timestamp,
          strf: '%d.%m.%Y',
        },
        page_current: {
          gsub: '<<--PAGE_CURRENT-->>',
          key: :page__current
        },
        page_total: {
          gsub: '<<--PAGE_TOTAL-->>',
          key: :page__total
        },
        enumerator_original: {
          gsub: '<<--ENUMERATOR_ORIGINAL-->>',
          key: :enumerator__original
        },
        enumerator_integer: {
          gsub: '<<--ENUMERATOR_INTEGER-->>',
          key: :enumerator__integer
        },
        enumerator_char: {
          gsub: '<<--ENUMERATOR_CHAR-->>',
          key: :enumerator__char
        },
        enumerator_roman: {
          gsub: '<<--ENUMERATOR_ROMAN-->>',
          key: :enumerator__roman
        },
        filename: {
          gsub: '<<--FILENAME-->>',
          key: :filename
        },
        path: {
          gsub: '<<--PATH-->>',
          key: :path
        },
        heading: {
          gsub: '<<--HEADLINE-->>',
          key: :heading
        },
        subheading: {
          gsub: '<<--SUBHEADING-->>',
          key: :subheading
        }
      },
      params: {
        footer: {
          font_size: 9
        },
        document: {
          width: 500
        },
        image: {
          density: 300
        },
        search: {
          subfolders: false,
          suffixs: [ 'jpg', 'png', 'pdf' ]
        },
        console: {
          silent: nil,
          mode: nil,
          length: 50
        }
      }
    }
  end


  def self.generate( folder, silent, options={} )
    
    hash = Marshal.load( Marshal.dump( self.get_options() ) )
    if self.validate_generate( folder, silent, options, hash )
            
      hash[:path][:root] = folder
      hash[:params][:console][:silent] = silent == :silent ? true : false
      hash[:params][:console][:mode] = !hash[:params][:console][:silent] ? silent : ''
       
      hash = self.options_update( options, hash, 'set_options' ) 
      hash[:path] = LocalPathBuilder.generate( hash[:path], :silent, Time.now.to_i.to_s )

      self.footer_image( hash )
      prepares = self.footer_prepare( hash )
      self.footer_generate( prepares, hash )
      self.footer_merge( hash )
      FileUtils.rm_rf( hash[:path][:children][:tmp][:full] )
    end
  end


  private


  def self.debug( obj )
    return obj[:params][:console][:silent]
  end


  def self.options_update( vars, template, mode )
    def self.str_difference( a, b )
      a = a.to_s.downcase.split( '_' ).join( '' )
      b = b.to_s.downcase.split( '_' ).join( '' )
      longer = [ a.size, b.size ].max
      same = a
        .each_char
        .zip( b.each_char )
        .select { | a, b | a == b }
        .size
      ( longer - same ) / a.size.to_f
    end


    allow_list = [
      :path__children__tmp__name,
      :path__children__pdf_combined__name,
      :footer__position__top,
      :footer__position__bottom,
      :footer__table__left__top__text,
      :footer__table__left__bottom__text,
      :footer__table__center__top__text,
      :footer__table__center__bottom__text,
      :footer__table__right__top__text,
      :footer__table__right__bottom__text,
      :selectors__timestamp__gsub,
      :selectors__timestamp__strf,
      :selectors__page_current__gsub,
      :selectors__page_total__gsub,
      :selectors__enumerator_original__gsub,
      :selectors__enumerator_integer__gsub,
      :selectors__enumerator_char__gsub,
      :selectors__enumerator_roman__gsub,
      :selectors__filename__gsub,
      :selectors__path__gsub,
      :selectors__heading__gsub,
      :selectors__subheading__gsub,
      :params__footer__font_size,
      :params__document__width,
      :params__image__density,
      :params__search__subfolders,
      :params__search__suffixs,
      :params__console__length
    ]

    messages = []
    _options = Marshal.load( Marshal.dump( template ) )
    
    vars.keys.each do | key |
      if allow_list.include?( key ) 
  
        keys = key.to_s.split( '__' ).map { | a | a.to_sym }
        case( keys.length )
          when 1
            _options[ keys[ 0 ] ] = vars[ key ]
          when 2
            _options[ keys[ 0 ] ][ keys[ 1 ] ] = vars[ key ]
          when 3
            _options[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ] = vars[ key ]
          when 4
            _options[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ] = vars[ key ]
          when 5
            _options[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ][ keys[ 4 ] ] = vars[ key ]
          when 6
            _options[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ][ keys[ 4 ] ][ keys[ 5   ] ] = vars[ key ]
        end
      else
        nearest = allow_list
          .map { | word | { score: self.str_difference( key, word ), word: word } }
          .min_by { | item | item[:score] }

        message = "\"#{key}\" is not a valid key, did you mean \"<--similar-->\"?"
        message = message.gsub( '<--similar-->', nearest[:word].to_s )
        messages.push( message )
      end
    end
    
    result = nil
    case mode
      when 'check_options'
        result = messages
      when 'set_options'
        result = _options
    end

    return result
  end


  def self.validate_generate( folder, silent, vars, template )
    messages = {
      folder: [],
      silent: [],
      options: [],
      other: []
   }

    if folder.class.to_s.eql?( 'String' )
      if File.directory?( folder )

      else
        messages[:folder].push( "\"#{folder}\" is not a valid path or not exist.")
      end
    else
      messages[:folder].push( 'Is not Type "String"')
    end

    if silent.class.to_s.eql?( 'Symbol' )
      if [:silent, :short, :detail].include?( silent )

      else
        messages[:silent].push( 'Is not :silent, :short or :detail')
      end
    else
      messages[:silent].push( 'Is not Type "Symbol"')
    end

    if vars.class.to_s.eql?( 'Hash' )
      messages[:options] = self.options_update( vars, template, 'check_options' )
    else
      messages[:options].push( 'Is not Type "Hash".') 
    end

    valid = messages.keys.map { | key | messages[ key ].length }.sum == 0

    if !valid
      puts 'Following errors occured:'
      messages.keys.each do | key |
        if messages[ key ].length != 0
          puts "  #{key[ 0, 1 ].upcase}#{key[ 1, key.length ]}"
          messages[ key ].each do | m |
            puts "  - #{m}"
          end
        end
      end
    end
    return valid
  end


  def self.footer_image( obj )
    files = []

    star = '*'
    obj[:params][:search][:subfolders] ? star = '**/*' : ''
    obj[:params][:search][:suffixs]
      .each { | a | files += Dir[ "#{obj[:path][:full]}#{star}.#{a}" ].sort }

    t = files
      .map { | a | a.split( '.' ).last }
      .inject( Hash.new( 0 ) ) { |total, e| total[e] += 1 ;total }
      .map { | a | ".#{a[ 0 ]} #{a[ 1 ]}" }
      .join(', ')

    !self.debug( obj ) ? print( "1. \tFind Files (#{files.length} Total | #{t}):" ) : ''

    files.each.with_index do | file, index |
        a = obj[:params][:image][:density].to_s
        b = obj[:path][:children][:tmp][:children][:jpg][:full]
        c = File.basename( file ).split( '.' )[ 0..-2 ].join( '.' )
        cmd = "convert -density #{a} -background white -alpha remove \"#{file}\" \"#{b}#{c}.jpg\""

        out = IO.popen( cmd )
        out.readlines

        self.console_mode( file, index, obj )
    end

    !self.debug( obj ) ? puts : ''

    return true
  end


  def self.footer_prepare( obj )
    def self.roman_numerals( integer )
      def self.next_lower_key( integer, values )
        arabics = values.keys
        next_lower_index = ( arabics.push( integer ).sort.index( integer ) ) - 1
        arabics[next_lower_index]
      end
      
      values = {
        1 => 'I',
        4 => 'IV',
        5 => 'V',
        9 => 'IX',
        10 => 'X',
        40 => 'XL',
        50 => 'L',
        90 => 'XC',
        100 => 'C',
        400 => 'CD',
        500 => 'D',
        900 => 'CM',
        1000 => 'M'
      }
      
      roman = ''
      while integer > 0
        if values[ integer ]
          roman += values[ integer ]
          return roman
        end
    
        roman += values[ self.next_lower_key( integer, values ) ]
        integer -= self.next_lower_key( integer, values )
      end
    end
    
    
    def self.create_selectors( str, item, alpha )
      if str.index( '--' ) == 1
        item[:valid] = true
        a = str.split( '--' )
        item[:enumerator][:original] = a[ 0 ]
        case a.length
          when 2
            item[:heading] = a[ 1 ]
          when 3
            item[:heading] = a[ 1 ]
            item[:subheading] = a[ 2 ]
        end
      
        if /\A[-+]?[0-9]+\z/.match( item[:enumerator][:original] ).to_a.length != 0
          item[:enumerator][:style] = :integer
          item[:enumerator][:integer] = item[:enumerator][:original].to_i
          item[:enumerator][:char] = alpha[ item[:enumerator][:integer]-1 ]
          item[:enumerator][:roman] = self.roman_numerals( item[:enumerator][:integer] )
        else
          item[:enumerator][:style] = :char
          item[:enumerator][:char] = item[:enumerator][:original].upcase
          item[:enumerator][:integer] =alpha.index( item[:enumerator][:char] ) + 1
          item[:enumerator][:roman] = self.roman_numerals( alpha.index( item[:enumerator][:char] ) + 1 )
        end
      else
        item[:valid] = false
        item[:heading] = str
      end
      
      return item
    end

    timestamp = Time.now.strftime( obj[:selectors][:timestamp][:strf] )
    paths = Dir[ obj[:path][:children][:tmp][:children][:jpg][:full] + '*' ]
    pages = []

    alpha = ( 'A'.upto( 'Z' ) ).to_a
    for i in 0..paths.length - 1
      path = paths[ i ]
      
      p = {
        file: {
          from: nil,
          to: nil
        },
        selectors: {
          valid: nil,
          timestamp: nil,
          heading: nil,
          filename: nil,
          path: nil,
          subheading: nil,
          enumerator: {
            style: nil,
            original: nil,
            char: nil,
            integer: nil,
            roman: nil
          },
          page: {
            current: nil,
            total: nil
          }
        }
      }
  
      p[:file][:from] = path

      name = File.basename( path ).split( '.' )[ 0..-2 ].join( '.' )
      tmp = obj[:path][:children][:tmp][:children][:pdf_single][:full]
      p[:file][:to] = "#{tmp}#{name}.pdf"

      p[:selectors] = self.create_selectors( name, p[:selectors], alpha )
      p[:selectors][:timestamp] = timestamp 
      p[:selectors][:filename] = path.split('/').last
      p[:selectors][:path] = path
      p[:selectors][:page][:current] = ( i + 1 ).to_s
      p[:selectors][:page][:total] = paths.length.to_s
      pages.push( p )
    end

    return pages
  end


  def self.footer_generate( prepares, obj )
    !self.debug( obj ) ? print( "2.\tWrite Footer:" ) : ''

    prepares.each.with_index do | prepare, index |
      footer = Marshal.load( Marshal.dump( obj[:footer] ) )
      footer[:table].keys.each do | align |
        footer[:table][ align ].keys.each do | position |
          sels = obj[:selectors].keys.map { | a | [ obj[:selectors][ a ][:gsub], obj[:selectors][ a ][:key] ] }
          sels.each do | sel |
            if footer[:table][ align ][ position ][:text].include? sel[ 0 ]
              keys = sel[ 1 ].to_s.split( '__' ).map { | a | a.to_sym }
              case keys.length
                when 1
                  footer[:table][ align ][ position ][:text] = footer[:table][ align ][ position ][:text]
                    .gsub( sel[ 0 ], prepare[:selectors][ keys[ 0 ] ].to_s )
                when 2
                  footer[:table][ align ][ position ][:text] = footer[:table][ align ][ position ][:text]
                    .gsub( sel[ 0 ], prepare[:selectors][ keys[ 0 ] ][ keys[ 1 ] ].to_s )
              end
            end
          end
        end
      end

      Prawn::Document.generate( prepare[:file][:to] ) do | pdf |
        pdf.image(
          prepare[:file][:from],
          at: [ 0, pdf.bounds.top ],
          width: obj[:params][:document][:width]
        )

        footer[:table].keys.each do | align |
          footer[:table][ align ].keys.each do | position |
            pdf.text_box(
              footer[:table][ align ][ position ][:text],
              size: obj[:params][:footer][:font_size],
              align: align,
              at: footer[:position][ position ],
            )
          end
        end
      end

      self.console_mode( prepare[:file][:from], index, obj )
    end

    !self.debug( obj ) ? puts : ''

    return true
  end


  def self.footer_merge( obj )
    !self.debug( obj ) ? puts( "3.\tMerge" ) : ''
    
    files = Dir[ obj[:path][:children][:tmp][:children][:pdf_single][:full] + '*.pdf' ].sort
    
    pdf = CombinePDF.new
    files.each do | file |
      pdf << CombinePDF.load( file )
    end

    p = obj[:path][:children][:pdf_combined][:files][:result][:full]
    pdf.save( p )
    
    return true
  end


  def self.console_mode( file, index, obj )
    if !self.debug( obj )
      case obj[:params][:console][:mode]
        when :short
          index%obj[:params][:console][:length] == 0 ? print( "\n\t" ) : ''
          print( '.' )
        when :detail
          puts ( "\t" )
          p = ''
          if file.length > obj[:params][:console][:length]
            _start = obj[:params][:console][:length] / 5
            _end = obj[:params][:console][:length] - _start
            p += file[ 0, _start ]
            p += '...'
            p += file[ file.length - _end, file.length]
          else
            p = file
          end
          print( "\t- #{p}" )
      end
    else
    end
  end
end
