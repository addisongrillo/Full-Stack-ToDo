import React from 'react'

const Menu = props => (
  <p style={{minHeight: 30}}>
    <span className="badge badge-clickable badge-danger mr-1">
      Past Due
    </span>
    <span className="badge badge-clickable badge-warning mr-1">
      Due Soon
    </span>
    <span className="badge badge-clickable badge-success mr-1">
      Due Later
    </span>
    <span className="badge badge-clickable badge-secondary">
      Not Due
    </span>
  </p>
)

export default Menu
