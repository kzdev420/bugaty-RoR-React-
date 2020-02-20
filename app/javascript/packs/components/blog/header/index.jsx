import React, { Component } from 'react';
import FontFamily from '@modules/FontFamily'
import Mmenu from 'mmenu-js'
import styles from './styles/Header.module.sass'
import Post from './Post'
import FeaturedPost from './FeaturedPost'
import { Column, Row } from "simple-flexbox";
import '../../../application.sass'
import './styles/mmenu.css'

const magnificPopupConfig = {
  fixedContentPos: false,
  fixedBgPos: true,
  overflowY: 'auto',
  closeBtnInside: true,
  preloader: false,
  midClick: true,
  removalDelay: 300,
  mainClass: 'my-mfp-zoom-in',
  type: 'inline'
}

class Header extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentSubcategories: [],
      currentCategory: null,
      searchOpen: false,
      isOpen: false
    };
  }

  formSearch = () => (
    <form role='form' acceptCharset="UTF-8" action='/blog/posts' method='get'>
      <Row vertical='center'  horizontal='center'>
        <Column>
          <input className={styles.formInput} placeholder="I am looking for" name="search"/>
        </Column>
        <Column className="ml2">
          <button className={styles.goButton}>
            Go
          </button>
        </Column>
      </Row>
    </form>
  )

  mobileMenu = () => {
    if(this.props.activeSubcategory) {
      var subSlug = this.props.activeSubcategory.slug
    }

    return (
      <header className={`mobile-header visible-xs`}>
        <div className="container">
          <div className="row">
            <div className="col-xs-3">
              <a href="#my-menu"  className="hamburger hamburger--collapse" type="button">
                <span className="hamburger-box">
                  <span className="hamburger-inner ham"></span>
                </span>
              </a>
            </div>
            <div className="col-xs-6 text-center">
              <a href="/blog"><h1 className={styles.logoMobile}> Bugaty <span>Blog</span></h1></a>
            </div>
            <nav id="my-menu">
                <ul>
                    {
                      this.props.categories.map((category) => (
                        <li>
                          <a data-turbolinks="false" className={`${category.blog_subcategories.some(subcategory => subSlug === subcategory.slug) ? styles.activeMobileMenu : ''} ${styles.hoverMenu}`} href={`/blog/posts?category=${category.slug}`}>{category.title}</a>
                          {
                            category.blog_subcategories.length > 0 && (
                              <ul>
                                {
                                  category.blog_subcategories.map(subcategory => (
                                    <li><a className={`${subSlug === subcategory.slug ? styles.activeMobileMenu : ''} ${styles.hoverMenu}`} data-turbolinks="false" href={`/blog/posts?subcategory=${subcategory.slug}`}>{subcategory.title}</a></li>
                                  ))
                                }
                              </ul>
                            )
                          }
                        </li>
                      ))
                    }
                </ul>
            </nav>
            <div className="col-xs-3 text-right">
              <div className="ico-search-header-xs-wrap">
                <i className="ico ico-search-header-ico--xs" onClick={() => this.setState((prevState) => ({searchOpen: !prevState.searchOpen}))}></i>
              </div>
            </div>
            <div style={{display: this.state.searchOpen ? 'block' : 'none' }} className={`mobile-search ${styles.mobileSearch} col-xs-12`}>
              {this.formSearch()}
            </div>
          </div>
        </div>
      </header>
    )
  }

  componentDidMount () {
    new Mmenu( "#my-menu" );
  }

  render() {
    if(this.props.activeSubcategory) {
      var subcategorySlug = this.props.activeSubcategory.slug
    }

    return (
      <React.Fragment>
        <div className="hidden-xs" id="sectionTop">
          <div
            className={`text-white ${styles.greyHeader}`}
            dangerouslySetInnerHTML={{__html: this.props.topMenu}}
          >
          </div>
          <Row vertical='center' horizontal='center' className={`${styles.logoHeader} text-white`}>
            <Column horizontal='center' vertical='center' className={styles.logo}>
              <a href="/blog">
                  Bugaty <span>Blog</span>
              </a>
            </Column>
            <Column className="ml3">
              {
                this.formSearch()
              }
            </Column>
            <Column vertical='center'  horizontal='center'>
              <a href="/" className={`${styles.freeAdButton} ml3`} >Create Listing</a>
            </Column>
            <Column vertical='center'  horizontal='center'>
              <a href="/"  className={`${styles.joinCommunityButton} ml1`} >Join the community</a>
            </Column>
          </Row>
          <Row vertical='center'  horizontal='center' className={styles.categoriesRow}>
            <Row vertical='stretch'  horizontal='center' className={styles.categoriesContainer} >
              {
                this.props.categories.map((category) => (
                  <Column
                    onMouseOver={() => this.setState({ currentSubcategories: category.blog_subcategories, currentCategory: category.slug })}
                    vertical="center"
                    className={`${styles.category} p1 ml4`}
                    key={category.id}
                  >
                    <a href={`/blog/posts?category=${category.slug}`}>
                      {category.title}
                      <span className={`caret ${styles.caretSym}`}></span>
                    </a>
                  </Column>
                ))
              }
              {
                this.state.currentSubcategories.length > 0 && (

                  <ul className={`p0 ${styles['header-submenu-list']}`}>
                    <Row>
                      <Column className={`p4 col-xs-4 ${styles.subcategoriesList}`}>
                        {
                          this.state.currentSubcategories.map((subcategory, index) => {
                            return  (
                              <div key={index} className={`${styles.subcategories} ${ subcategorySlug === subcategory.slug && styles.active}`}>
                                <div className={styles.caret}></div>
                                <a href={`/blog/posts?subcategory=${subcategory.slug}`} key={subcategory.id}>
                                  {subcategory.title}
                                </a>
                              </div>
                            )
                          })
                        }
                      </Column>
                      <Row className="col-xs-8 row">
                        <Column className={`col-sm-6 pl4 pb4`} horizontal="center">
                          <Row className={`text-center col-xs-12 ${styles.sectionPost}`}>
                            <h5>
                              FEATURED
                            </h5>
                          </Row>
                          <Row>
                            <FeaturedPost {...this.props.menu_posts[this.state.currentCategory].featured}/>
                          </Row>
                        </Column>
                        <Column className={`col-sm-6 pl4 pb4`} horizontal="center">
                          <Row className={`text-center col-xs-12 ${styles.sectionPost}`}>
                            <h5>
                              RECENT
                            </h5>
                          </Row>
                          <Row wrap={true}>
                            {
                              this.props.menu_posts[this.state.currentCategory].recents.map(post => (
                                <Column key={post.id} className="col-xs-12">
                                  <Post {...post}/>
                                </Column>
                              ))
                            }
                          </Row>
                        </Column>
                      </Row>
                    </Row>
                  </ul>
                )
              }

            </Row>
          </Row>
        </div>
        {
          this.mobileMenu()
        }
      </React.Fragment>
    )
  }
}

export default FontFamily(Header, 'Nunito Sans')