import React, { useEffect } from 'react';
import { Column, Row } from "simple-flexbox";
import styles from './styles/PodcastPreview.module.sass'
import DownloadIcon from '../../images/download.png'
import PlayIcon from '../../images/play.png'
import Loader from './Loader'

const PodcastPreview = (props) => {
  useEffect(() => {
    if(props.preview_podcast_script) {
      var script = document.createElement("script");
      script.src = props.preview_podcast_script
      document.body.append(script)
    }
  }, []);

  return (
    <Row wrap={true} className={`p2 ${styles.containerPreview}`}>
      <Row className={styles.podcastTitle}>
        <h1>
          <a href={`/podcasts/episodes/${props.slug}`}>
            {props.title}
          </a>
        </h1>
      </Row>
      {
        props.preview_podcast_div ? (
          <Row className={`mb3 ${styles.wrapperVideo}`}>
            <div
             className={props.preview_podcast_div.includes('iframe') ? 'iframeContainer' : ''}
             dangerouslySetInnerHTML={{__html: props.preview_podcast_div}}
            >
            </div>
          </Row>
        ) : (
          <Row className={`mb3 ${styles.podcastPreview}`}>
            <Column horizontal="start" vertical="center" className="col-xs-6">
              <img className={styles.playButton} src={PlayIcon}/>
            </Column>
            <Column horizontal="end" vertical="center" className="col-xs-6">
              <span>
                13.12.2019
              </span>
              <strong className="mb1">
                48:30min
              </strong>
              <span>
                <img className={styles.downloadButton} src={DownloadIcon}/>
              </span>
            </Column>
          </Row>
        )
      }
      <Row className={`col-xs-12 p0 ${styles.podcastDescription}`}>
        {
          props.small_description
        }
      </Row>
      <Row className={`col-xs-12 p0 ${styles.podcastLink}`}>
        <a href={`/podcasts/episodes/${props.slug}`}>More ...</a>
      </Row>
    </Row>
  )
}

export default PodcastPreview;