import React from 'react';
import axios from 'axios';
import Paggy from "react-js-pagination";
import FeaturedCard from '../../shared/FeaturedCard'
import Loader from '../../shared/Loader'
import Card from '../../shared/Card'
import { Column, Row } from "simple-flexbox";
import styles from './styles/index.module.sass'
import '../../../../application.sass'

class Index extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      perPage: props.perPage,
      page: props.page || 1,
      totalItems: props.totalItems,
      isLoading: false,
      blogPosts: props.blogPosts,
      keyToSearch: props.category ? 'category' : props.subcategory ? 'subcategory' : ''
    }
    this.postsContainerRef = React.createRef();

  }

  fetchPosts = (pageNumber) => {
    const { perPage, keyToSearch } = this.state

    this.setState({
      isLoading: true
    })

    axios.get('/blog/posts', {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        params: {
          perPage,
          page: pageNumber,
          [keyToSearch]: this.props[keyToSearch]
        }
    })
      .then(({data}) => {
        this.setState({
          blogPosts: data,
          page: pageNumber
        }, () => {
          setTimeout(() => {
            scrollTo(0, this.postsContainerRef.current.scrollHeight)
          }, 0);
        })
      })
      .catch((err) => {
        console.log(err)
      })
      .finally(() => {
        this.setState({
          isLoading: false
        })
      })
  }

  render() {
    const { featuredPosts, searchQuery } = this.props
    const { blogPosts, page, perPage, totalItems, isLoading, keyToSearch } = this.state
    if(blogPosts .length === 0 && featuredPosts.length === 0) {
      return (
        <Row wrap={true} vertical="center" horizontal="center" className={styles.notFound}>
          <div>
            <h4>We did not find any results for: <span>{searchQuery}</span>.</h4>
            <br/>
            <h6>Check for any spelling errors or try a different search.</h6>
          </div>
        </Row>
      )
    }

    return (
      <React.Fragment>
        {
          featuredPosts.length > 0 && (
            <Row wrap={true} vertical='center' horizontal='center' className="container mb4 p0" >
              <div ref={this.postsContainerRef} className={`col-xs-12 p0 ${styles.postsContainer}`}>
                <Column className={`col-xs-12 ${featuredPosts.length > 1 ? 'col-md-6' : 'col-md-12'} mt4`} vertical='center' horizontal='center'>
                  <FeaturedCard {...featuredPosts[0]} height={500}/>
                </Column>
                <Column className={"col-xs-12 col-md-6 mt4 p0"} vertical='center' horizontal='center'>
                  <Row className="col-xs-12 p0" vertical='center' horizontal='center'>
                    <Column className="col-xs-12" vertical='center' horizontal='center'>
                      <FeaturedCard {...featuredPosts[1]} height={featuredPosts.length > 2 ? 235 : 500}/>
                    </Column>
                  </Row>
                  {
                    featuredPosts.length > 2 && (
                      <Row wrap={true} vertical='center' className="col-xs-12 p0"  horizontal='center'>
                        <Column className={`col-xs-12 ${featuredPosts.length > 3 ? 'col-sm-6' : 'col-sm-12'}  mt3`}  vertical='center' horizontal='center'>
                          <FeaturedCard {...featuredPosts[2]} height={245}/>
                        </Column>
                        <Column className="col-xs-12 col-sm-6 mt3"  vertical='center' horizontal='center'>
                          <FeaturedCard {...featuredPosts[3]} height={245}/>
                        </Column>
                      </Row>
                    )
                  }
                </Column>
              </div>
            </Row>
          )
        }
        {
          this.props[keyToSearch] && (
            <Row className="mt3 container react" vertical='center' horizontal='center'>
              <h1 className={styles.categoryTitle}>
                {this.props[keyToSearch].title}
              </h1>
            </Row>
          )
        }
        <Row wrap={true} horizontal='center' className="mb4 stretch" >
          {
            isLoading ? (
              <Loader/>
            ) : (
              blogPosts.map(post => (
                <Column key={post.id} className="col-xs-12 col-sm-4 mt3"  vertical='center' horizontal='center'>
                  <Card  {...post} height={245}/>
                </Column>
              ))
            )
          }
        </Row>
        <Row horizontal="center" vertical="center">
          <Paggy
            activePage={parseInt(page)}
            itemsCountPerPage={parseInt(perPage)}
            totalItemsCount={parseInt(totalItems)}
            pageRangeDisplayed={10}
            onChange={this.fetchPosts}
            activeClass={styles.paginationActive}
            itemClass={styles.pagination}
            linkClass={"mr2"}
            linkClassFirst={'hidden'}
            linkClassLast={'hidden'}
          />
        </Row>

      </React.Fragment>
    )
  }
}

export default Index;