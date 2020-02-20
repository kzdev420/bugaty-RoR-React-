import React from 'react';
import CommentIcon from '../../../images/comment-icon.png'
import styles from './styles/Recommended.module.sass'
import { Column, Row } from "simple-flexbox";

const Recommended = (props) => {
  const { post } = props

  if(!post.title) {
    return null
  }

  return (
    <Row wrap={true} className={`col-xs-12 p0 ${styles.card}`}>
      <Row onClick={() => props.goToFollowingPost(post)} className={`col-xs-12 ${styles.cardImage}`} style={{backgroundImage: `url(${post.cover_photo || 'http://placehold.it/500x500'})`, maxHeight: props.height, minHeight: props.height}}>
        <div className={styles.overlay} />
         <div className={styles.cardSubcategory}>
          <span>
            {post.blog_subcategory}
          </span>
        </div>
      </Row>
      <Row wrap={true} className={`col-xs-12 ${styles.cardBody}`}>
        <Row onClick={() => props.goToFollowingPost(post)} className={styles.cardTitle}>
          {post.title}
        </Row>
        <Row className={`col-xs-12 p0 ${styles.dateAndAuthor}`}>
          <Column className="col-xs-6 p0">
            <p>By <a className={styles.author} href="">{post.author}</a></p>
          </Column>
          <Column className="col-xs-6 p0 text-right">
            <p>{post.created_at}</p>
          </Column>
        </Row>
        {
          post.content_sanitize && (
            <Row>
              <p className={styles.cardDescription}>
                {post.content_sanitize.substring(0, 160)}...
              </p>
            </Row>
          )
        }
      </Row>
      <Row vertical="center">
        <img src={CommentIcon}/> {post.comments_amount}
      </Row>
    </Row>
  )
}

export default Recommended;