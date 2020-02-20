import React, { Component } from 'react';
import Paggy from "react-js-pagination";
import axios from "axios";
import { Column, Row } from "simple-flexbox";
import PodcastPreview from '../shared/PodcastPreview'
import Loader from '../shared/Loader'
import Podcaster from '../../images/podcaster.png'
import styles from './styles/Index.module.sass'

class Index extends Component {
  constructor(props) {
    super(props)
    this.state = {
      perPage: props.perPage,
      page: props.page || 1,
      totalItems: props.totalItems,
      isLoading: false,
      podcastEpisodes: props.podcastEpisodes,
    }
    this.subcriptionFormRef = React.createRef();

  }

  fetchPodcasts = (pageNumber) => {
    const { perPage } = this.state
    this.setState({
      isLoading: true,
      podcastEpisodes: []
    })
    window.scrollTo(0,0)
    axios.get('/podcasts', {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      params: {
        perPage,
        page: pageNumber
      }
    })
    .then((res) => this.setState({
      podcastEpisodes: res.data
    }))
    .catch((err) => console.log(err))
    .finally(() => this.setState({
      isLoading: false,
      page: pageNumber
    }))


  }

  render() {
    const { podcastEpisodes, isLoading, page, perPage, totalItems } = this.state
    const { podcastHost, contactMessage } = this.props
    return (
      <Row wrap={true} className="col-xs-12 mb3 container">
        <Column horizontal="center" className="col-xs-12 col-md-6">
          {
            isLoading ? (
              <Loader/>
            ) : (
              podcastEpisodes.map(podcast => (
                <Row key={podcast.id} className="col-xs-12">
                  <PodcastPreview {...podcast} />
                </Row>
              ))
            )
          }
          <Row horizontal="center" vertical="center">
            <Paggy
              activePage={parseInt(page)}
              itemsCountPerPage={parseInt(perPage)}
              totalItemsCount={parseInt(totalItems)}
              pageRangeDisplayed={10}
              onChange={this.fetchPodcasts}
              activeClass={styles.paginationActive}
              itemClass={styles.pagination}
              linkClass={"mr2"}
              linkClassFirst={'hidden'}
              linkClassLast={'hidden'}
            />
          </Row>
        </Column>
        <Column className="col-xs-12 mt4 col-md-5">
          <Row wrap={true} className={`col-xs-12 ${styles.meetTheHost}`}>
            <Row horizontal="center" className="col-xs-12">
              <h1>
                MEET THE HOST
              </h1>
            </Row>
            <Row wrap={true} className={`col-xs-12 mb3 ${styles.hostPhoto}`}>
              <Column horizontal="center" className="col-xs-12 mt2 col-sm-6">
                <img src={podcastHost.profile_picture_1} />
              </Column>
              <Column horizontal="center" className="col-xs-12 mt2 col-sm-6">
                <img src={podcastHost.profile_picture_2} />
              </Column>
            </Row>
            <Row className="col-xs-12">
              <div className={styles.hostDescription}
                dangerouslySetInnerHTML={{__html: podcastHost.description}}
              >
              </div>
            </Row>
          </Row>
          <Row wrap={true} className={`col-xs-12 mt2 mb4 ${styles.subscribe}`}>
            <Row horizontal="center" className="col-xs-12">
              <h1>
                Subscribe
              </h1>
            </Row>
            <Row horizontal="center" className="col-xs-12">
              <div className='subscriptions-container'
                dangerouslySetInnerHTML={{__html: this.props.subcriptionPodcast}}
              >
              </div>
            </Row>
          </Row>
          <Row className={`col-xs-12 ${styles.messageBox}`}>
            <div className="p4"
              dangerouslySetInnerHTML={{__html: contactMessage}}
            >

            </div>
          </Row>
        </Column>
      </Row>
    )
  }
}

export default Index;