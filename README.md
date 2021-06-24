<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/documents-with-footer-to-pdf.svg" height="55px" name="Documents with Footer to Pdf for Ruby" alt="# Documents with Footer to .pdf for Ruby">
</a>

Add a footer to each document and create a single .pdf file all in one command.
<br>
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/examples.svg" height="55px" name="examples" alt="Examples">
</a>
<br>
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/table-of-contents.svg" height="55px" name="table-of-contents" alt="Table of Contents">
</a>
<br>
1. [Quickstart](#quickstart)<br>
2. [Parameters](#parameters)<br>
3. [Options](#options)<br>
4. [Contributing](#contributing)<br>
5. [Limitations](#limitations)<br>
6. [Credits](#credits)<br>
7. [License](#license)<br>
8. [Code of Conduct](#code-of-conduct)<br>
9. [Support my Work](#support-my-work)<br>

<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/quickstart.svg" height="55px" name="quickstart" alt="Quickstart">
</a>

```ruby

```
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/local-path-builder-for-ruby/readme/headlines/setup.svg" height="55px" name="setup" alt="Setup">
</a>

Add this line to your application's Gemfile:

```ruby
gem 'documents_with_footer_to_pdf'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install documents_with_footer_to_pdf


On Rubygems: 
- Gem: https://rubygems.org/gems/test
- Profile: https://rubygems.org/profiles/a6b8

<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/methods.svg" height="55px" name="methods" alt="Methods">
</a>

### .get_options()
```ruby
    require 'documents_with_footer_to_pdf'

    hash = DocumentsWithFooterToPdf.get_options() 
    # => { path: 
```


### .generate()
```ruby
    require 'documents_with_footer_to_pdf'

    hash = DocumentsWithFooterToPdf.generate( 
        folder, 
        console_mode,  
        options 
    )
```

**Input**
| **Type** | **Required** | **Description** | **Example** | **Description** |
|------:|:------|:------|:------|:------| 
| **headline** | ```String``` | Yes | "./test/" | Define path to folder |
| **console mode** | ```Symbol``` | Yes | ```:hash``` | Set test console output mode. Use ```:silent```, ```:short```, or ```:detail``` |
| **options** | ```'Hash'``` | No | ```{}``` | Change defaut options, please refer: <a href="#options">Options</a> for more info |

**Return**<br>
Boolean   
<br>
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/options.svg" height="55px" name="options" alt="Options">
</a>

### Path
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| A.1. | Children Tmp Name |:path__children__tmp__name | `"tmp-{{SALT}}"` | String | Change temporary folder name, {{SALT}} will replaced with current unix timestamp |
| A.2. | Children Pdf_combined Name |:path__children__pdf_combined__name | `"0-result-{{SALT}}"` | String | Change result folder name, {{SALT}} will replaced with current unix timestamp |


### Footer
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.1. | Position Top |:footer__position__top | `[0, 20]` | Array | Set footer position top. |
| B.2. | Position Bottom |:footer__position__bottom | `[0, 10]` | Array | Set footer position bottom. |
| B.3. | Table Left Top Text |:footer__table__left__top__text | `"<<--FILENAME-->>"` | String | Set text in field left-top |
| B.4. | Table Left Bottom Text |:footer__table__left__bottom__text | `""` | String | String | Set text in field left-bottom |
| B.5. | Table Center Top Text |:footer__table__center__top__text | `""` | String | String | Set text in field center-top |
| B.6. | Table Center Bottom Text |:footer__table__center__bottom__text | `""` | String | String | Set text in field center-bottom |
| B.7. | Table Right Top Text |:footer__table__right__top__text | `"<<--TIMESTAMP-->>"` | String | String | Set text in field right-top |
| B.8. | Table Right Bottom Text |:footer__table__right__bottom__text | `"<<--PAGE_CURRENT-->> from <<--PAGE_TOTAL-->>"` | String | String | Set text in field right-bottom |


### Selectors
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| C.1. | Timestamp Gsub |:selectors__timestamp__gsub | `"<<--TIMESTAMP-->>"` | String | Change marker for timestamp. |
| C.2. | Timestamp Strf |:selectors__timestamp__strf | `"%d.%m.%Y"` | String | Change format of date and time |
| C.3. | Page_current Gsub |:selectors__page_current__gsub | `"<<--PAGE_CURRENT-->>"` | String | Change marker for current page. |
| C.4. | Page_total Gsub |:selectors__page_total__gsub | `"<<--PAGE_TOTAL-->>"` | String | Change marker for total page size |
| C.5. | Enumerator_original Gsub |:selectors__enumerator_original__gsub | `"<<--ENUMERATOR_ORIGINAL-->>"` | String | Change marker for original enumeration |
| C.6. | Enumerator_integer Gsub |:selectors__enumerator_integer__gsub | `"<<--ENUMERATOR_INTEGER-->>"` | String | Change marker for integer enumeration |
| C.7. | Enumerator_char Gsub |:selectors__enumerator_char__gsub | `"<<--ENUMERATOR_CHAR-->>"` | String | Change marker for char enumeration |
| C.8. | Enumerator_roman Gsub |:selectors__enumerator_roman__gsub | `"<<--ENUMERATOR_ROMAN-->>"` | String | Change marker for roman letters enumeration |
| C.9. | Filename Gsub |:selectors__filename__gsub | `"<<--FILENAME-->>"` | String | Change marker for filename |
| C.10. | Path Gsub |:selectors__path__gsub | `"<<--PATH-->>"` | String | Change marker for full path |
| C.11. | Heading Gsub |:selectors__heading__gsub | `"<<--HEADLINE-->>"` | String | Change marker for headline |
| C.12. | Subheading Gsub |:selectors__subheading__gsub | `"<<--SUBHEADING-->>"` | String | Change marker for sub headline |

More Information on ```strf``` format: https://apidock.com/ruby/DateTime/strftime

### Params
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.1. | Footer Font_size |:params__footer__font_size | `9` | Integer | Set footer font size |
| D.2. | Document Width |:params__document__width | `500` | Integer | Set document width |
| D.3. | Image Density |:params__image__density | `300` | Integer | Set image density |
| D.4. | Search Subfolders |:params__search__subfolders | `false` | Boolean | Set if subfolders should be included in search |
| D.5. | Search Suffixs |:params__search__suffixs | `["jpg", "png", "pdf"]` | Array | Types of suffixes which are included (Supported jpg, png, pdf) |
| D.6. | Console Length |:params__console__length | `50` | Integer | Change length of console output |
</a>
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/contributing.svg" height="55px" name="contributing" alt="Contributing">
</a>

Bug reports and pull requests are welcome on GitHub at https://github.com/a6b8/documents-with-footer-to-pdf. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/a6b8/documents-with-footer-to-pdf/blob/master/CODE_OF_CONDUCT.md).
<br>
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/limitations.svg" height="55px" name="limitations" alt="Limitations">
</a>
- Made for local usage
- Some pdf fonts are not supported.
<br>
<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/credits.svg" height="55px" name="credits" alt="Credits">
</a>

This gem depend on following gems:
- **local_path_builder** <br>
  https://github.com/a6b8/local-path-builder-for-ruby <br>
- **FileUtils** <br>
  https://ruby-doc.org/stdlib-2.4.1/libdoc/fileutils/rdoc/FileUtils.html <br>
- **combine_pdf** <br>
  https://github.com/boazsegev/combine_pdf <br>
- **prawn** <br>
  https://github.com/prawnpdf/prawn <br>
- **image magick** <br>
  https://imagemagick.org/script/convert.php
<br>
<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/license.svg" height="55px" name="license" alt="License">
</a>

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
<br>
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/code-of-conduct.svg" height="55px" name="code-of-conduct" alt="Code of Conduct">
</a>
    
Everyone interacting in the documents-with-footer-to-pdf project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/a6b8/documents-with-footer-to-pdf/blob/master/CODE_OF_CONDUCT.md).
<br>
<br>
<br>
<a href="#table-of-contents">
<img href="#table-of-contents" src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/support-my-work.svg" height="55px" name="support-my-work" alt="Support my Work">
</a>
    
Donate by [https://www.paypal.com](https://www.paypal.com/donate?hosted_button_id=XKYLQ9FBGC4RG)