import React, { useState, useRef } from 'react';
import axios from 'axios'
import { Column, Row } from "simple-flexbox";
import styles from './styles/Newsletter.module.sass'


const Newsletter = (props) => {
  const [loading, setLoading] = useState(false)
  const [alertMessage, setAlertMessage] = useState('')
  const nameRef = useRef();
  const emailRef = useRef();

  const subscribe = async () => {

    setLoading(true)
    let message = ''
    try {
      const { authenticity_token } = props
      const email = emailRef.current.value
      const name = nameRef.current.value
      await axios.post('/podcasts/subscribe', { email, name, authenticity_token })
      message = 'We subcribed you to our newsletter, you will receive a email when a new podcast is published'
    } catch(err) {
      console.log(err)
      message = 'There was a problem and we couldn\'t subcribed you, please fill email and name correctly'
    }

    setLoading(false)
    setAlertMessage(message)
    setTimeout(() => {
      setAlertMessage('')
    }, 5000);
  }
  return (
    <Row wrap={true} className={`col-xs-12 ${styles.newsletterContainer}`} vertical="center" horizontal="center">
      <Row className={`col-xs-12 ${styles.commentAlert}`} horizontal="center" vertical="center">
        {
          alertMessage && (
            <div className={`alert alert-${alertMessage.includes('problem') ? 'danger' : 'success' } mt3 mb3`} role="alert">{alertMessage}</div>
          )
        }
      </Row>
      <Row className="col-xs-12 mt3" horizontal="center">
        <h1>
          Keep Up with Me
        </h1>
      </Row>
      <Row className="col-xs-12" horizontal="center">
        <div dangerouslySetInnerHTML={{__html: props.descriptionMessage}}>
        </div>
      </Row>
      <Row className={`col-xs-12 mb4 mt4 ${styles.subscribe}`} horizontal="center">
        <input ref={nameRef} placeholder="Name" className="mr2 col-xs-12 col-md-4"/>
        <input ref={emailRef} placeholder="Email" className="mr2 col-xs-12 col-md-4"/>
        <button disabled={loading} onClick={subscribe} className="col-xs-12 col-md-4">
          {loading ? 'Sending...' : 'Subscribe'}
        </button>
      </Row>
    </Row>
  )
}

export default Newsletter;