def obj_prepare( root, debug )
    obj = {
        :path => {
            :root => nil,
            :name => '',
            :full => nil,
            :children => {
                :tmp => {
                    :name => 'tmp',
                    :full => nil,
                    :children => {
                    :jpg => {
                        :name => '0-jpg',
                        :full => nil
                    },
                    :pdf_single => {
                        :name => '1-pdf-single--w-footer',
                        :full => nil
                    }
                    }
                },
                :pdf_combined => {
                    :name => '0-with-footer',
                    :full => nil
                }
            }
        }
    }
    
    obj[:path][:root] = root
    return obj
end
  