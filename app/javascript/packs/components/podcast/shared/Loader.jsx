import React from 'react';
import styles from './styles/Loader'
const Loader = () => {
  return (
    <div className={styles['lds-ring']}>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
    </div>
  )
}

export default Loader;