import React from 'react';
import Card from './Card'
import FeaturedCard from './FeaturedCard'
import { Column, Row } from "simple-flexbox";
import styles from './styles/FeaturedCardContainer.module.sass'
import '../../../application.sass'

const FeaturedCardContainer = (props) => {
  return (
    <Row wrap={true} vertical='center' horizontal='center' className="container react mb4" >
      <Row wrap={true} className="col-xs-12" vertical='center' horizontal='center'>
        <Column className={`col-xs-12 ${props.featuredBlogs.length > 1 ? 'col-md-6' : 'col-md-12'} mt4`} vertical='center' horizontal='center'>
          <FeaturedCard {...props.featuredBlogs[0]} height={500}/>
        </Column>
        <Column className={`${styles.noMarginMobile} col-xs-12 col-md-6 mt4 p0 `} vertical='center' horizontal='center'>
          <Row className="col-xs-12 hidden-xs p0" vertical='center' horizontal='center'>
            <Column className="col-xs-12" vertical='center' horizontal='center'>
              <FeaturedCard {...props.featuredBlogs[1]} height={props.featuredBlogs.length > 2 ? 235 : 500}/>
            </Column>
          </Row>
          {
            props.featuredBlogs.length > 2 && (
              <Row wrap={true} vertical='center' className="col-xs-12 p0"  horizontal='center'>
                <Column className={`col-xs-6 ${props.featuredBlogs.length > 3 ? 'col-sm-6' : 'col-sm-12'}  mt3`}  vertical='center' horizontal='center'>
                  <FeaturedCard {...props.featuredBlogs[2]} height={245}/>
                </Column>
                <Column className="col-xs-6 col-sm-6 mt3"  vertical='center' horizontal='center'>
                  <FeaturedCard {...props.featuredBlogs[3]} height={245}/>
                </Column>
              </Row>
            )
          }
        </Column>
      </Row>
      {
        props.featuredBlogs.length > 4 && (
          <React.Fragment>
            <Row className="col-xs-12 mt3" vertical='center' horizontal='center'>
              <h1 className={styles.categoryTitle}>
                Featured Posts
              </h1>
            </Row>
            <Row className="col-xs-12" wrap={true} vertical='stretch' horizontal='center'>
              <Column className="col-xs-12 col-sm-4 mt3"  vertical='center' horizontal='center'>
                <Card {...props.featuredBlogs[4]}  height={245}/>
              </Column>
              {
                props.featuredBlogs[5] && (
                  <Column className="col-xs-12 col-sm-4 mt3"  vertical='center' horizontal='center'>
                    <Card {...props.featuredBlogs[5]}  height={245}/>
                  </Column>
                )
              }

              {
                props.featuredBlogs[6] && (
                  <Column className="col-xs-12 col-sm-4 mt3"  vertical='center' horizontal='center'>
                    <Card {...props.featuredBlogs[6]}  height={245}/>
                  </Column>
                )
              }
            </Row>
          </React.Fragment>
        )
      }
    </Row>
  )
}

export default FeaturedCardContainer;