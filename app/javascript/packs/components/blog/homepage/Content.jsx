import React from 'react';
import FeaturedCardContainer from '../shared/FeaturedCardContainer'
import CategoryCardContainer from '../shared/CategoryCardContainer'

const Content = (props) => {
  return (
    <React.Fragment>
      <FeaturedCardContainer featuredBlogs={props.featuredBlogs}/>
      {
        Object.keys(props.blogs).map((key) => (
          <CategoryCardContainer key={key} category={key} blogs={props.blogs[key]}/>
        ))
      }
    </React.Fragment>
  )
}

export default Content;