// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import * as React from 'react'
import * as ReactDOM from 'react-dom'
import { HomePage } from '../src/components/home_page'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <HomePage/>,
    document.body.appendChild(document.createElement('div')),
  )
})
