import React from 'react';
import styles from './styles/FeaturedCard.module.sass'
import { Column, Row } from "simple-flexbox";

const FeaturedCard = (props) => {
   if(!props.title) {
    return null
  }

  const goTo = (url) => {
    window.location.href = url
  }

  return (
    <div onClick={() => goTo(`/blog/posts/${props.slug}`)} className={`col-xs-12 ${styles.cardImage}`} style={{backgroundImage: `url(${props.cover_photo || 'http://placehold.it/500x500'})`, maxHeight: props.height, minHeight: props.height}}>
      <div className={styles.overlay} />
      <div className={styles.cardSubcategory}>
        <span>
          {props.blog_subcategory}
        </span>
      </div>
      <div className={`p3 ${styles.cardFooter}`}>
        <Row className={styles.cardTitle}>
          {props.title}
        </Row>
        <Row className={styles.cardDate}>
          {props.created_at}
        </Row>
      </div>
    </div>
  )
}

export default FeaturedCard;