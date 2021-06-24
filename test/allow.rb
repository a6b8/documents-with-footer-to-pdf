def get_allow_list( params )
    lists = {}
    lists[:allow] = []
    lists[:block] = []

    params.keys.each do | lvl1 |
        if params[ lvl1 ].class.to_s.eql? 'Hash'
            params[ lvl1 ].keys.each do | lvl2 |
                if params[ lvl1 ][ lvl2 ].class.to_s.eql? 'Hash'
                    params[ lvl1 ][ lvl2 ].keys.each do | lvl3 |
                        if params[ lvl1 ][ lvl2 ][ lvl3 ].class.to_s.eql? 'Hash'
                            params[ lvl1 ][ lvl2 ][ lvl3 ].keys.each do | lvl4 |
                                if params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ].class.to_s.eql? 'Hash'
                                    params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ].keys.each do | lvl5 |
                                        if params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ][ lvl5 ].class.to_s.eql? 'Hash'
                                            params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ][ lvl5 ].keys.each do | lvl6 |
                                                if params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ][ lvl5 ].class.to_s.eql? 'Hash'
                                                    puts 'HERE'
                                                else
                                                    str = ( lvl1.to_s + '__' + lvl2.to_s + '__' + lvl3.to_s + '__' + lvl4.to_s ).to_sym
                                                    if !params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ].nil?
                                                        lists[:allow].push( str )
                                                    else
                                                        lists[:block].push( str )
                                                    end
                                                end
                                            end
                                            puts 'HERE'
                                        else
                                            str = ( lvl1.to_s + '__' + lvl2.to_s + '__' + lvl3.to_s + '__' + lvl4.to_s ).to_sym
                                            if !params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ].nil?
                                                lists[:allow].push( str )
                                            else
                                                lists[:block].push( str )
                                            end
                                        end
                                    end
                                    puts 'HERE'
                                else
                                    str = ( lvl1.to_s + '__' + lvl2.to_s + '__' + lvl3.to_s + '__' + lvl4.to_s ).to_sym
                                    if !params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ].nil?
                                        lists[:allow].push( str )
                                    else
                                        lists[:block].push( str )
                                    end
                                end
                            end
                        else
                            str = ( lvl1.to_s + '__' + lvl2.to_s + '__' + lvl3.to_s ).to_sym
                            if !params[ lvl1 ][ lvl2 ][ lvl3 ].nil?
                                lists[:allow].push( str )
                            else
                                lists[:block].push( str )
                            end
                        end
                    end
                else
                    str = ( lvl1.to_s + '__' + lvl2.to_s ).to_sym
                    if !params[ lvl1 ][ lvl2  ].nil? 
                        lists[:allow].push( str )
                    else
                        lists[:block].push( str )
                    end
                end
            end
        else
            str = lvl1
            if !params[ lvl1 ].nil?
                lists[:allow].push( str )
            else
                lists[:block].push( str )
            end
        end
    end
    return lists
end

require '/Users/andreasbanholzer/PROJEKTE/2021-06-documents-with-footer-to-pdf/1/documents_with_footer_to_pdf/lib/documents_with_footer_to_pdf.rb'

