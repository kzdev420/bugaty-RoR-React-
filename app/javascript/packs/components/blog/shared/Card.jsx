import React from 'react';
import styles from './styles/Card.module.sass'
import { Column, Row } from "simple-flexbox";

const Card = (props) => {
  if(!props.title) {
    return null
  }

  const goTo = (url) => {
    window.location.href = url
  }

  return (
    <Column wrap={true} className={`col-xs-12 p0 ${styles.card}`}>
      <Row onClick={() => goTo(`/blog/posts/${props.slug}`)} className={`col-xs-12 ${styles.cardImage}`} style={{backgroundImage: `url(${props.cover_photo || 'http://placehold.it/500x500'})`, maxHeight: props.height, minHeight: props.height}}>
        <div className={styles.overlay} />
        <div className={styles.cardSubcategory}>
          <span>
            {props.blog_subcategory}
          </span>
        </div>
      </Row>
      <Row wrap={true} className={`col-xs-12 ${styles.cardBody}`} flexGrow={1}>
        <Row onClick={() => goTo(`/blog/posts/${props.slug}`)} className={styles.cardTitle}>
          {props.title}
        </Row>
        <Row className={`${styles.cardData} col-xs-12 mt1 p0`} vertical='center' horizontal="space-between" >
          <Column className="col-xs-6 p0">
            <p>By <a className={styles.author} href="">{props.author}</a></p>
          </Column>
          <Column className="col-xs-6 p0 text-right">
            <p>{props.created_at}</p>
          </Column>
        </Row>
        {
          props.content_sanitize && (
            <Row >
              <p className={styles.cardDescription}>
                {props.content_sanitize.substring(0, 160)}...
              </p>
            </Row>
          )
        }
      </Row>
    </Column>
  )
}

export default Card;