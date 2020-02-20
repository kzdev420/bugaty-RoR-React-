import React from 'react';
import styles from './styles/Post.module.sass'
import { Column, Row } from "simple-flexbox";

const Post = (props) => {
  const goTo = (url) => {
    window.location.href = url
  }

  return (
     <Row className={`col-xs-12 p0 mt4 `}>
      <Column onClick={() => goTo(`/blog/posts/${props.slug}`)} className={`col-xs-6 ${styles.cardImage}`} style={{backgroundImage: `url(${props.cover_photo || 'http://placehold.it/500x500'})`, maxHeight: props.height, minHeight: props.height}}>
        <div className={styles.overlay} />
      </Column>
      <Row wrap={true} className={`col-xs-6 ${styles.cardBody}`}>
        <Column onClick={() => goTo(`/blog/posts/${props.slug}`)} className={styles.cardTitle}>
          {props.title}
        </Column>
        <Column className={`${styles.cardData} col-xs-12 mt1 p0`} vertical='center' horizontal="start" >
            <p>{props.created_at}</p>
        </Column>
      </Row>
    </Row>
  )
}

export default Post;