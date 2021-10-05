require './lib/documents_with_footer_to_pdf'
require 'fileutils'


path = Dir.pwd  + '/test/example/'
tests = [
    { 
        footer__table__left__top__text: '<<--ENUMERATOR_ROMAN-->>. <<--HEADLINE-->>',
        footer__table__left__bottom__text: '<<--SUBHEADING-->>',
        footer__table__center__top__text: 'Application',
        footer__table__center__bottom__text: 'John Doe',
        footer__table__right__top__text: '<<--TIMESTAMP-->>',
        footer__table__right__bottom__text: '<<--PAGE_CURRENT-->> of <<--PAGE_TOTAL-->>',
        selectors__timestamp__strf: '%A, %e %B %Y'
    },
    { 
        footer__table__left__top__text: '<<--ENUMERATOR_INTEGER-->>. <<--HEADLINE-->>',
        footer__table__left__bottom__text: '<<--TIMESTAMP-->>',
        footer__table__center__top__text: '',
        footer__table__center__bottom__text: '',
        footer__table__right__top__text: '<<--PAGE_CURRENT-->>',
        footer__table__right__bottom__text: '',
    },
    { 
        footer__table__left__top__text: '<<--TIMESTAMP-->>',
        footer__table__left__bottom__text: '',
        footer__table__center__top__text: '<<--ENUMERATOR_CHAR-->> <<--HEADLINE-->>',
        footer__table__center__bottom__text: '',
        footer__table__right__top__text: '<<--PAGE_CURRENT-->>',
        footer__table__right__bottom__text: '',
    }
]
 
rs = []
tests.each.with_index do | test, index |
    folder = "result-#{index }"
    test[:path__children__pdf_combined__name] = folder
    DocumentsWithFooterToPdf.generate( path, :detail, test )
    check = "#{path}#{folder}/result.pdf"
    puts "[#{index}]  #{check}"
    rs.push( File.exist?( check ) )
end 
 
if rs.all?
    puts "All tests passed."
    exit 0
else
    puts "Not all tests passed."
    exit 1
end

