import React from 'react';
import Card from './Card'
import { Column, Row } from "simple-flexbox";
import styles from './styles/CategoryCardContainer.module.sass'
import '../../../application.sass'

const CategoryCardContainer = (props) => {
  if(props.blogs.length === 0) {
    return null
  }

  return (
    <Row wrap={true} vertical='center' horizontal='center' className="container mb4" >
      <Row vertical='center' horizontal='center'>
          <h1 className={styles.categoryTitle}>
           {props.category}
          </h1>
      </Row>
      <Row wrap={true} className="col-xs-12" vertical='stretch' horizontal='center'>
        <Column className={`col-xs-12 ${props.blogs.length > 1 ? 'col-md-6' : 'col-md-12'} mt2`} vertical='center' horizontal='center'>
          <Card {...props.blogs[0]} height={500}/>
        </Column>
        <Column className="col-xs-12 col-md-6 mt2 p0" vertical='stretch' horizontal='center'>
          <Row className={`"col-xs-12 p0" ${props.blogs.length == 2 ? 'h-100' : ''}`} vertical='center' horizontal='center'>
            <Column className={`col-xs-12 ${props.blogs.length == 2 ? 'h-100' : ''}`} vertical='center' horizontal='center'>
              <Card {...Object.assign(props.blogs[1] || {}, {content_sanitize: ''})} height={props.blogs.length > 2 ? 235 : 500}/>
            </Column>
          </Row>
          {
            props.blogs.length > 2 && (
              <Row wrap={true} vertical='stretch' className="col-xs-12 p0"  horizontal='center'>
                <Column className={`col-xs-12 ${props.blogs.length > 3 ? 'col-sm-6' : 'col-sm-12'} mt3`}  vertical='center' horizontal='center'>
                  <Card {...Object.assign(props.blogs[2] || {}, {content_sanitize: ''})} height={245}/>
                </Column>
                {
                   props.blogs.length > 3 && (
                      <Column className="col-xs-12 col-sm-6 mt3"  vertical='center' horizontal='center'>
                        <Card {...Object.assign(props.blogs[3] || {}, {content_sanitize: ''})} height={245}/>
                      </Column>
                   )
                }
              </Row>
            )
          }
        </Column>
      </Row>
      {
        props.blogs.length > 4 && (
          <React.Fragment>
            <Row className="mt3 container" vertical='center' horizontal='center'>
              <h1 className={styles.categoryTitle}>
                {props.category}
              </h1>
            </Row>
            <Row wrap={true} horizontal='center'>
              <Column className="col-xs-12 col-sm-4 mt3"  vertical='center' horizontal='center'>
                <Card  {...props.blogs[4]} height={245}/>
              </Column>
              {
                props.blogs[5] && (
                  <Column className="col-xs-12 col-sm-4 mt3"  vertical='center' horizontal='center'>
                    <Card  {...props.blogs[5]} height={245}/>
                  </Column>
                )
              }
              {
                props.blogs[6] && (
                  <Column className="col-xs-12 col-sm-4 mt3"  vertical='center' horizontal='center'>
                    <Card  {...props.blogs[6]} height={245}/>
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

export default CategoryCardContainer;