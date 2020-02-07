import React, { Component } from 'react';
import Slider from "react-slick";
import axios from 'axios'
import Recommended from './Recommended'
import { Column, Row } from "simple-flexbox";
import styles from './styles/show.module.sass'
import CommentIcon from '../../../images/comment-icon.png'
import Loader from '../../shared/Loader'
import '../../../../application.sass'

import {
  FacebookShareButton,
  TwitterShareButton,
  LinkedinShareButton,
  PinterestShareButton,
  FacebookIcon,
  TwitterIcon,
  LinkedinIcon,
  PinterestIcon,
} from "react-share";


 var settings = {
  speed: 500,
  slidesToShow: 1,
  autoplay: true,
  slidesToScroll: 1
};

class Show extends Component {

  constructor(props) {
    super(props)
    this.textareaComment = React.createRef();
    this.state = {
      alertCommentMessage: null,
      blogPost: props.blogPost,
      loadingCommentButton: false,
      fetchingNewPost: false
    }

  }

  shareButtons = () => {
    return (
      <Row className={`col-xs-12 p0 mb2 mt2  ${styles.shareSocial}`}>
        <Column horizontal="center" vertical="start" className="col-xs-12 col-md-6 p0">
          Share:
        </Column>
        <Column horizontal="end" vertical="end" className="col-xs-12 col-md-6 p0">
          <FacebookShareButton url={window.location.href}>
            <FacebookIcon size={32} round={true} />
          </FacebookShareButton>
          <TwitterShareButton url={window.location.href}>
            <TwitterIcon size={32} round={true} />
          </TwitterShareButton>
          <LinkedinShareButton url={window.location.href}>
            <LinkedinIcon size={32} round={true} />
          </LinkedinShareButton>
          <PinterestShareButton url={window.location.href}>
            <PinterestIcon size={32} round={true} />
          </PinterestShareButton>

        </Column>
      </Row>
    )
  }

  goToFollowingPost = async (post) => {
    this.setState({
      blogPost: {
        ...post,
        comments: [],
        recommended: []
      },
      fetchingNewPost: true
    })
    const url = '/blog/posts/' + post.slug
    window.history.pushState("", "", url);

    try {
      window.scrollTo(0,0)
      const response = await axios.get(url, {
         headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        }
      })
      this.setState({
        blogPost: response.data,
        fetchingNewPost: false
      })
      response.data.script_tags.forEach(element => {
        var script = document.createElement("script");
        script.src = element
        document.body.append(script)
      })
    } catch(err) {
      console.log(err)
    }
  }

  addYourComment = async () => {
    const { slug } = this.state.blogPost
    const { authenticity_token } = this.props
    const comment = this.textareaComment.current.value
    let message = null
    try {
      this.setState({
        loadingCommentButton: true
      })
      await axios.post(`/blog/posts/${slug}/comments`, {
        content: comment,
        authenticity_token: authenticity_token
      })
      message = 'Your comment has been sent, our moderators will review it'
      this.textareaComment.current.value = ""
    } catch(err) {
      message = 'There was a problem and we couldn\'t send your comment'
    }

    this.setState({
      loadingCommentButton: false,
      alertCommentMessage: message
    })
    setTimeout(() => {
      this.setState({
        alertCommentMessage: null
      })
    }, 5000);
  }

  componentDidMount() {
    document.body.style.background = "white";
    this.state.blogPost.script_tags.forEach(element => {
      var script = document.createElement("script");
      script.src = element
      document.body.append(script)
    })
  }

  render() {
    const {
      title,
      blog_subcategory,
      content,
      created_at,
      author,
      bio,
      cover_photo,
      author_photo,
      next_post,
      previous_post,
      comments,
      comments_amount,
      recommended,
      tag
    } = this.state.blogPost
    const { currentUser } = this.props
    const { alertCommentMessage, loadingCommentButton, fetchingNewPost } = this.state
    return (
      <Row className={`${styles.postContainer} container react pr4 pl4`} wrap={true}>
        <Row wrap={true} horizontal="center" className={`col-xs-12 ${styles.postContent}`}>
          <Column horizontal="center" className={`col-xs-12 mt3 ${styles.blogSubcategory}`}>
            {blog_subcategory}
          </Column>
          <Column  horizontal="center" className={`col-xs-12 mt3 ${styles.postTitle}`}>
            {title}
          </Column>
          { this.shareButtons()}
          <div style={{backgroundImage: `url(${cover_photo || 'http://placehold.it/1000x500'})`}} className={`col-xs-12 ${styles.postCoverPhoto}`}>
          </div>
          <Row wrap={true} vertical="center" className={`p0 mb3 col-xs-12 mt2 ${styles.postData}`}>
            <Column horizontal="start" className="p0 col-xs-6 col-sm-4">
              <div>
                <img className={`mr1 ${styles.authorPhoto}`} src={author_photo || 'http://placehold.it/40x40'}/>
                By <span className={styles.authorName}>{author}</span>
              </div>
            </Column>
            <Column horizontal="center" className="p0 col-xs-6 col-sm-4">
              {created_at}
            </Column>
            <Column horizontal="end" className={`${styles.commentInfo} p0 col-xs-12 col-sm-4`}>
              <div>
                <img src={CommentIcon}/>
                <span>{comments_amount > 0 ? comments_amount : 'No'} Comments</span>
              </div>
            </Column>
          </Row>
          <Column className={`p0 col-xs-12 ${styles.postContent}`}>
            <div dangerouslySetInnerHTML={{__html: content}}></div>
          </Column>
          <div className={`p0 col-xs-12`}>
              {
                tag.length > 0 && tag.split(',').map(tagSplitted => {
                  return <a href={`/blog/posts?search=${tagSplitted.trim()}&tag=true`} className={styles.badges}>{tagSplitted.trim()}</a>
                })
              }
          </div>
          { this.shareButtons() }
        </Row>
        <Row wrap={true} horizontal="center" className={`col-xs-12 p0 mb4 ${styles.nextPreviousPost}`}>
          {
            fetchingNewPost ? (
              <Loader/>
            ) : (
              <React.Fragment>
                <Column onClick={() => {
                  if(previous_post) {
                  this.goToFollowingPost(previous_post)
                  }
                }} className={`col-xs-12 col-sm-6 p2 ${previous_post && styles.previousPost}`}>
                  {
                    previous_post ? (
                      <React.Fragment>
                        <p className="text-right">
                          Previous Article:
                        </p>
                        <p className="text-right">
                          {previous_post.title}
                        </p>
                    </React.Fragment>
                    ) : (
                    <p></p>
                    )
                  }
                </Column>
                <Column  onClick={() => {
                    if(next_post) {
                      this.goToFollowingPost(next_post)
                    }
                  }} className={`col-xs-12 col-sm-6 p2 ${ next_post && styles.nextPost}`}>
                  {
                    next_post ? (
                      <React.Fragment>
                        <p className="text-left">
                          Next Article:
                        </p>
                        <p className="text-left">
                          {next_post.title}
                        </p>
                      </React.Fragment>
                    ) : (
                      <p></p>
                    )
                  }
                </Column>
              </React.Fragment>
            )
          }
        </Row>
        <Row wrap={true} className={`col-xs-12 m3 ${styles.authorInfo}`}>
          <div>
            <img  className={styles.authorPhoto} src={author_photo || 'http://placehold.it/90x90'}/>
          </div>
          <Row wrap={true} className={`col-xs-12 col-md-9 ${styles.authorInformation}`}>
            <Column vertical="end" className={`col-xs-12 mb3 ${styles.authorName}`}>
              {author}
            </Column>
            <Column className={`col-xs-12 ${styles.authorBio}`}>
              {bio}
            </Column>
          </Row>
        </Row>
        <Row wrap={true} horizontal="center" vertical="center" className={`col-xs-12 p0 ${styles.recommended}`}>
          <Column horizontal="center" className={`col-xs-12 mb3 ${styles.recommendedTitle}`}>
              Recommended
          </Column>
          <Row vertical="stretch" className="hidden-xs">
            {
              fetchingNewPost ? (
                <Loader/>
              ) : (
                recommended.map(post => (
                  <Column key={post.slug} className="col-xs-12 col-md-4 mb3">
                    <Recommended goToFollowingPost={this.goToFollowingPost} post={post} />
                  </Column>
                ))
              )
            }
          </Row>
          <div className={`visible-xs-block ${styles.carousel}`}>
            <Slider {...settings}>
              {

                recommended.map(post => (
                  <Column key={post.slug} className="col-xs-12 col-md-4 mb3">
                    <Recommended goToFollowingPost={this.goToFollowingPost} post={post} />
                  </Column>
                ))
              }
            </Slider>
          </div>
        </Row>
        <Row wrap={true} className={`col-xs-12 ${styles.comments}`}>
          <Column horizontal="center" className={`col-xs-12 mt2 ${styles.commentsAmount}`}>
            {comments_amount} Comments
          </Column>
          <Column horizontal="center" className={`col-xs-12 ${styles.commentSubcontainer}`} >
            {
              currentUser ? (
                <Row wrap={true} horizontal="center" className={`col-xs-12 mb4 ${styles.commentBoxContainer}`}>
                  <Row className={`col-xs-12 ${styles.commentAlert}`} horizontal="center" vertical="center">
                    {
                      alertCommentMessage && (
                        <div className={`alert alert-${alertCommentMessage.includes('problem') ? 'danger' : 'success' } mt3 mb3`} role="alert">{alertCommentMessage}</div>
                      )
                    }
                  </Row>
                  <div>
                    <img className={styles.authorPhoto} src={currentUser.profile_photo || 'http://placehold.it/75x75'}/>
                  </div>
                  <Column className={`col-xs-12 pt1 col-md-9 ${styles.commentBox}`}>
                    <Row>
                        <textarea  maxLength="200" ref={this.textareaComment} className={`${styles.commentBox}`}/>
                    </Row>
                    <Row>
                      <button disabled={loadingCommentButton} onClick={this.addYourComment} className="p1 mt2 mb2">
                          {loadingCommentButton ? 'Sending...' : 'Add Your Comment' }
                      </button>
                    </Row>
                    <Row className={`${styles.comment}`}>
                      <p>
                        Please be patient, in order to keep our community safe your comment will be approved by site moderators.
                      </p>
                    </Row>
                  </Column>
                </Row>
              ) : (
                <Column horizontal="center" className={`col-xs-12 mt2 ${styles.signedInWarning}`}>
                  <div>
                    You must be <a data-turbolinks="false" href={`/?to=${window.location}`}>Signed In</a> to post a comment
                  </div>
                </Column>
              )
            }
            {
              fetchingNewPost ? (
                <Loader/>
              ) : (
                comments.map((comment) => (
                  <Row key={comment.id} horizontal="center" className={`col-xs-12 mb4`}>
                    <div>
                      <img className={styles.authorPhoto} src={comment.user.profile_photo || 'http://placehold.it/75x75'}/>
                    </div>
                    <Column className={`col-xs-12 pt1 col-md-9 ${styles.commentData}`}>
                      <Row className={`${styles.commentAuthor}`}>
                        <a href={`/users/${comment.user.slug}`}>{comment.user.name}</a> said {comment.created_at} ago
                      </Row>
                      <Row className={`${styles.comment}`}>
                        <p>{comment.content}</p>
                      </Row>
                    </Column>
                  </Row>
                ))
              )
            }
          </Column>
          <Column horizontal="center" className={`col-xs-12 mt2 mb4 ${styles.signedInAddYourOwn}`}>
            {
              !currentUser && (
                <a href={`/?to=${window.location}`}  data-turbolinks="false" >Sign In to add your own</a>
              )
            }
          </Column>
        </Row>
      </Row>
    )
  }
}

export default Show;