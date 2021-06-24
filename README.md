<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/Headline.svg" height="55px" name="headline" alt="# Headline">
</a>

Short Description Text 
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
gem 'test'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install test


On Rubygems: 
- Gem: https://rubygems.org/gems/test
- Profile: https://rubygems.org/profiles/a6b8

<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/methods.svg" height="55px" name="methods" alt="Methods">
</a>

### .example()
```ruby
    require 'local_path_builder'

    hash = Template.example( 
        headline, 
        console_mode,  
        options 
    )
```


**Input**
| **Type** | **Required** | **Description** | **Example** | **Description** |
|------:|:------|:------|:------|:------| 
| **headline** | ```String``` | Yes | "Test" | Define path structure |
| **console mode** | ```Symbol``` | Yes | ```:hash``` | Set test console output mode. Use ```:silent```, ```:hash```, ```:path``` or ```:both``` |
| **salt** | ```String``` | No | ```123``` | Use test salt to create unique filenames. |

**Return**<br>
Hash    
<br>
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/options.svg" height="55px" name="options" alt="Options">


## Options
### Path
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| A.1. | Name |:path__name | `\"\"` | String | |
| A.2. | Children Tmp Name |:path__children__tmp__name | `\"tmp-{{SALT}}\"` | String | |
| A.3. | Children Pdf_combined Name |:path__children__pdf_combined__name | `\"0-result-{{SALT}}\"` | String | |

### Footer
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.1. | Position Top |:footer__position__top | `[0, 20]` | Array | |
| B.2. | Position Bottom |:footer__position__bottom | `[0, 10]` | Array | |
| B.3. | Table Left Top Text |:footer__table__left__top__text | `\"<<--FILENAME-->>\"` | String | |
| B.4. | Table Left Bottom Text |:footer__table__left__bottom__text | `\"\"` | String | |
| B.5. | Table Center Top Text |:footer__table__center__top__text | `\"\"` | String | |
| B.6. | Table Center Bottom Text |:footer__table__center__bottom__text | `\"\"` | String | |
| B.7. | Table Right Top Text |:footer__table__right__top__text | `\"<<--TIMESTAMP-->>\"` | String | |
| B.8. | Table Right Bottom Text |:footer__table__right__bottom__text | `\"<<--PAGE_CURRENT-->> from <<--PAGE_TOTAL-->>\"` | String | |

### Selectors
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| C.1. | Timestamp Gsub |:selectors__timestamp__gsub | `\"<<--TIMESTAMP-->>\"` | String | |
| C.2. | Timestamp Key |:selectors__timestamp__key | `timestamp` | Symbol | |
| C.3. | Timestamp Strf |:selectors__timestamp__strf | `\"%d.%m.%Y\"` | String | |
| C.4. | Page_current Gsub |:selectors__page_current__gsub | `\"<<--PAGE_CURRENT-->>\"` | String | |
| C.5. | Page_current Key |:selectors__page_current__key | `page__current` | Symbol | |
| C.6. | Page_total Gsub |:selectors__page_total__gsub | `\"<<--PAGE_TOTAL-->>\"` | String | |
| C.7. | Page_total Key |:selectors__page_total__key | `page__total` | Symbol | |
| C.8. | Enumerator_original Gsub |:selectors__enumerator_original__gsub | `\"<<--ENUMERATOR_ORIGINAL-->>\"` | String | |
| C.9. | Enumerator_original Key |:selectors__enumerator_original__key | `enumerator__original` | Symbol | |
| C.10. | Enumerator_integer Gsub |:selectors__enumerator_integer__gsub | `\"<<--ENUMERATOR_INTEGER-->>\"` | String | |
| C.11. | Enumerator_integer Key |:selectors__enumerator_integer__key | `enumerator__integer` | Symbol | |
| C.12. | Enumerator_char Gsub |:selectors__enumerator_char__gsub | `\"<<--ENUMERATOR_CHAR-->>\"` | String | |
| C.13. | Enumerator_char Key |:selectors__enumerator_char__key | `enumerator__char` | Symbol | |
| C.14. | Enumerator_roman Gsub |:selectors__enumerator_roman__gsub | `\"<<--ENUMERATOR_ROMAN-->>\"` | String | |
| C.15. | Enumerator_roman Key |:selectors__enumerator_roman__key | `enumerator__roman` | Symbol | |
| C.16. | Filename Gsub |:selectors__filename__gsub | `\"<<--FILENAME-->>\"` | String | |
| C.17. | Filename Key |:selectors__filename__key | `filename` | Symbol | |
| C.18. | Path Gsub |:selectors__path__gsub | `\"<<--PATH-->>\"` | String | |
| C.19. | Path Key |:selectors__path__key | `path` | Symbol | |
| C.20. | Heading Gsub |:selectors__heading__gsub | `\"<<--HEADLINE-->>\"` | String | |
| C.21. | Heading Key |:selectors__heading__key | `heading` | Symbol | |
| C.22. | Subheading Gsub |:selectors__subheading__gsub | `\"<<--SUBHEADING-->>\"` | String | |
| C.23. | Subheading Key |:selectors__subheading__key | `subheading` | Symbol | |


### Params
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.1. | Footer Font_size |:params__footer__font_size | `9` | Integer | |
| D.2. | Document Width |:params__document__width | `500` | Integer | |
| D.3. | Image Density |:params__image__density | `300` | Integer | |
| D.4. | Search Subfolders |:params__search__subfolders | `false` | FalseClass | |
| D.5. | Search Suffixs |:params__search__suffixs | `[\"jpg\", \"png\", \"pdf\"]` | Array | |
| D.6. | Console Length |:params__console__length | `50` | Integer | |
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
- Test
<br>
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/documents-with-footer-to-pdf/readme/headlines/credits.svg" height="55px" name="credits" alt="Credits">
</a>
- Test
<br>
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