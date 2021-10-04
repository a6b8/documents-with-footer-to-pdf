require './lib/documents_with_footer_to_pdf'

DocumentsWithFooterToPdf.generate( 
    './example/', 
    :short, 
    { 
        footer__table__left__top__text: '<<--ENUMERATOR_ROMAN-->>. <<--HEADLINE-->>',
        footer__table__left__bottom__text: '<<--SUBHEADING-->>',
        footer__table__center__top__text: 'Application',
        footer__table__center__bottom__text: 'John Doe',
        footer__table__right__top__text: '<<--TIMESTAMP-->>',
        footer__table__right__bottom__text: '<<--PAGE_CURRENT-->> of <<--PAGE_TOTAL-->>',
        selectors__timestamp__strf: '%A, %e %B %Y'
    }
) 


DocumentsWithFooterToPdf.generate( 
    './example/', 
    :short, 
    { 
        footer__table__left__top__text: '<<--ENUMERATOR_INTEGER-->>. <<--HEADLINE-->>',
        footer__table__left__bottom__text: '<<--TIMESTAMP-->>',
        footer__table__center__top__text: '',
        footer__table__center__bottom__text: '',
        footer__table__right__top__text: '<<--PAGE_CURRENT-->>',
        footer__table__right__bottom__text: '',
    }
) 


DocumentsWithFooterToPdf.generate( 
    './example/', 
    :short, 
    { 
        footer__table__left__top__text: '<<--TIMESTAMP-->>',
        footer__table__left__bottom__text: '',
        footer__table__center__top__text: '<<--ENUMERATOR_CHAR-->> <<--HEADLINE-->>',
        footer__table__center__bottom__text: '',
        footer__table__right__top__text: '<<--PAGE_CURRENT-->>',
        footer__table__right__bottom__text: '',
    }
) 