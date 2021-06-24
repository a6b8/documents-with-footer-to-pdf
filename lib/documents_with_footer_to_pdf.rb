# frozen_string_literal: true

require_relative "documents_with_footer_to_pdf/version"
require 'local_path_builder'
require 'FileUtils'
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
                name: '0-result-{{SALT}}.pdf'
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
              text: '<<--PATH-->>'
            }
          },
          center: {
            top: {
              text: 'Antrag'
            },
            bottom: {
              text: 'Andreas Banholzer'
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


  def self.generate( root, silent, options={} )

    puts File.directory?(root)

    template = self.get_options()
    hash = Marshal.load( Marshal.dump( template ) )
    hash[:path][:root] = root

    hash[:params][:console][:silent] = silent == :silent ? true : false
    hash[:params][:console][:mode] = !hash[:params][:console][:silent] ? silent : ''
    hash[:path] = LocalPathBuilder.generate( hash[:path], :silent, Time.now.to_i.to_s )

    self.footer_image( hash )
    prepares = self.footer_prepare( hash )
    self.footer_generate( prepares, hash )
    self.footer_merge( hash )
    FileUtils.rm_rf( hash[:path][:children][:tmp][:full] )
  end


  private


  def self.debug( obj )
    return obj[:params][:console][:silent]
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
        cmd = "convert -density #{a}  -background white -alpha remove \"#{file}\" \"#{b}#{c}.jpg\""

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
          item[:enumerator][:roman] = self.roman_numerals( item[:enumerator][:integer] )
        else
          item[:enumerator][:style] = :char
          item[:enumerator][:char] = item[:enumerator][:original].upcase
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
