import React, { Component } from 'react';
import axios from "axios";
import Loader from '../shared/Loader'
import PodcastPreview from '../shared/PodcastPreview'
import { Column, Row } from "simple-flexbox";
import DownloadIcon from '../../images/download.png'
import PlayIcon from '../../images/play.png'
import ArrowIcon from '../../images/arrow.png'
import styles from './styles/Show.module.sass'

class Show extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isLoading: false,
      podcastEpisode: props.podcastEpisode,
    }

  }

  loadPodcast = (podcastEpisode) => {
    this.setState({
      isLoading: true,
      podcastEpisode: {
        ...podcastEpisode,
        resources: []
      }
    })

    const url = `/podcasts/episodes/${podcastEpisode.slug}`
    window.history.pushState("", "", url);
    axios(url,{
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    })
      .then(res => {
        this.setState({
          podcastEpisode: res.data
        }, () => {
          res.data.embedded_podcast.forEach(src => {
            var script = document.createElement("script");
            script.src = src
            document.body.append(script)
          })
        })
      })
      .catch(err => console.log(err))
      .finally(() => this.setState({
        isLoading: false
      }))
  }

  renderNextPreviousPodcast = () => {
    const { podcastEpisode } = this.state

    return (
      <Row className={`col-xs-12 p0 ${styles.previousNextPodcast}`}>
        <Column className={`col-xs-6 p0 ${styles.previousPodcast}`} >
          {
            podcastEpisode.previous_podcast ? (
                <p onClick={() => this.loadPodcast(podcastEpisode.previous_podcast)}>
                  <img src={ArrowIcon}/>
                  <span className="ml1">previous</span>
                </p>
            ) : (
              <p></p>
            )
          }
        </Column>
        <Column horizontal="end" className={`col-xs-6 p0 ${styles.nextPodcast}`} >
          {
            podcastEpisode.next_podcast ? (
                <p onClick={() => this.loadPodcast(podcastEpisode.next_podcast)}>
                  <span className="mr1">next</span>
                  <img src={ArrowIcon}/>
                </p>
            ) : (
              <p></p>
            )
          }
        </Column>
      </Row>
    )
  }

  componentDidMount() {
    const { podcastEpisode } = this.state

    podcastEpisode.embedded_podcast.forEach(element => {
      var script = document.createElement("script");
      script.src = element
      document.body.append(script)
    })
  }

  render() {
    const { isLoading, podcastEpisode } = this.state
    const { featuredEpisodes } = this.props

    return (
      <Row vertical="start" horizontal="center" className={`col-xs-12 container mt3 mb3 ${styles.showContainer}`} wrap={true}>
        <Column vertical="center" horizontal="center" className={`col-xs-12 col-md-6 mt3 ${styles.podcastsList}`}>
          {this.renderNextPreviousPodcast()}
          <Row horizontal="start" className={`col-xs-12 p0 ${styles.podcastTitle}`}>
            <h1>
              {podcastEpisode.title}
            </h1>
          </Row>
          <Row  className={`mb2 col-xs-12 mt2 p0 ${styles.podcastDescription}`}>
            <Column>
              <div
                dangerouslySetInnerHTML={{__html: podcastEpisode.content}}
              >
              </div>
            </Column>
          </Row>
          {this.renderNextPreviousPodcast()}
        </Column>
        <Column  className={`col-xs-12 col-md-5 ${styles.aside}`}>
          <Column vertical="center" horizontal="center" className={`col-xs-12 ${styles.resources}`}>
            <h1>
              Resources
            </h1>
            <Row wrap={true} horizontal="center" className="col-xs-12">
              {
                isLoading ? (
                  <Loader/>
                ) : (
                  podcastEpisode.resources.map((resource) => (
                    <Column key={resource.id} style={{backgroundImage: `url(${resource.cover_image})`}} className={`col-xs-12 mb3 ${styles.resourceImg}`}>
                      <a href={resource.url}></a>
                    </Column>
                  ))
                )
              }
            </Row>
          </Column>
          <Column className={styles.featured} vertical="center" horizontal="center">
            <h1>
              Featured Episodes
            </h1>
            <Row wrap={true} className="col-xs-12">
              {
                featuredEpisodes.map((podcast) => (
                  <Column key={podcast.id} className="col-xs-12">
                   <PodcastPreview {...podcast}/>
                  </Column>
                ))
              }
            </Row>
          </Column>
        </Column>
      </Row>
    )
  }
}

export default Show;