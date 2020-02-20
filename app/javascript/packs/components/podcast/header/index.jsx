import React from 'react';
import FontFamily from '@modules/FontFamily'
import Mmenu from 'mmenu-js'
import { slide as Menu } from 'react-burger-menu'
import { Column, Row } from "simple-flexbox";
import styles from './styles/Header.module.sass'

class Header extends React.Component {

  componentDidMount() {
    document.body.style.background = "white";

    const menu =  document.querySelectorAll("#my-menu li")
    menu.forEach(element => {
      element.className = ""
      element.removeAttribute('style')
    });
    new Mmenu( "#my-menu" );
  }


  mobileMenu = () => (
    <header className={`mobile-header visible-xs ${styles.mobileHeader}`}>
      <div className="container">
        <div className="row">
          <div className="col-xs-1">
              <a href="#my-menu"  className="hamburger hamburger--collapse" type="button">
                <span className="hamburger-box">
                <span className={`hamburger-inner ham ${styles.hambugerInner}`}></span>
              </span>
            </a>
          </div>
          <div className={`col-xs-11 text-center mt0 ${styles.headerTitle}`}>
             <a href="/podcasts" className="m0">
              BUGATY <span>PODCAST</span>
            </a>
          </div>
          <nav id="my-menu">
            <ul
              dangerouslySetInnerHTML={{__html: this.props.header_menu + this.mobileMenuExtraHTML()}}
            >
            </ul>
          </nav>
        </div>
      </div>
    </header>
  )

  mobileMenuExtraHTML = () => {
    return (`
      <li>
        <a href="/">Create Listing</a>
      </li>
      <li>
        <a href="/" >Join the community</a>
      </li>
    `)
  }

  render () {
    return (
      <React.Fragment>
        {this.mobileMenu()}
        <Row wrap={true} className="hidden-xs">
          <Column horizontal="center"  vertical="center" className={`${styles.headerTitle} col-xs-12`}>
            <a href="/podcasts" className="m0">
              BUGATY <span>PODCAST</span>
            </a>
          </Column>
          <ul
            className={`text-white hidden-xs col-xs-12 mt1 ${styles.headerMenu}`}
            dangerouslySetInnerHTML={{__html: this.props.header_menu}}
          >
          </ul>
          <Row horizontal="end" className="col-xs-12 mt2 container">
            <Column vertical='center'  horizontal='center'>
              <a href="/" className={`${styles.freeAdButton} ml3`} >Create Listing</a>
            </Column>
            <Column vertical='center'  horizontal='center'>
              <a href="/"  className={`${styles.joinCommunityButton} ml1`} >Join the community</a>
            </Column>
          </Row>
        </Row>
      </React.Fragment>
    )
  }
}

export default FontFamily(Header, 'Nunito Sans')