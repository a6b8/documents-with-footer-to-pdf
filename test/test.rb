require '../lib/documents_with_footer_to_pdf'

p = './1-test/'

DocumentsWithFooterToPdf.generate( 
    p, 
    :short, 
    { footer__table__right__top__text: 'TEST' }
) 

