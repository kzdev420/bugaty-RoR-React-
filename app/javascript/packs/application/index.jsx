import { Content } from '../components/blog/homepage'
import BlogHeader from '../components/blog/header'
import PodcastHeader from '../components/podcast/header'
import PodcastShow from '../components/podcast/show'
import PodcastNewsletter from '../components/podcast/newsletter'
import PodcastIndex from '../components/podcast/index'
import BlogPostIndex from '../components/blog/post/index'
import BlogPostShow from '../components/blog/post/show'
import WebpackerReact from 'webpacker-react'
import Turbolinks from 'turbolinks'
import 'typeface-nunito-sans'
Turbolinks.start()

WebpackerReact.setup({
  BlogHeader,
  Content,
  BlogPostIndex,
  BlogPostShow,
  PodcastHeader,
  PodcastShow,
  PodcastIndex,
  PodcastNewsletter
})
