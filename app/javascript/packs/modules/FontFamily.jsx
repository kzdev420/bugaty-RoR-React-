import React, { Component } from 'react';

export default (Component, fontFamily) => {
  return class extends React.Component {

    componentDidMount() {
      document.body.style.fontFamily = fontFamily
    }

    render() {
      return (
        <Component {...this.props}/>
      )
    }
  }
}