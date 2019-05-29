import React from 'react'

const Pagination = props => (
  <div className="btn-toolbar" role="toolbar">
    <div className="btn-group mr-2">
      <button
        className="btn btn-secondary"
        onClick={ () => { props.changePage(1) } }
        id="first-page"
      >
        First
      </button>
    </div>
    <div className="btn-group mr-2">
      <button
        className="btn btn-light"
        onClick={ () => { props.changePage(props.page - 1) } }
        disabled={ props.page === 1 }
        id="prev-page"
      >
        Prev
      </button>
      <button
        className="btn btn-light"
        onClick={ () => { props.changePage(props.page + 1) } }
        disabled={ props.page === props.totalPages }
        id="next-page"
      >
        Next
      </button>
    </div>
    <div className="btn-group mr-2">
      <button
        className="btn btn-secondary"
        onClick={ () => { props.changePage(props.totalPages) } }
        id="last-page"
      >
        Last
      </button>
    </div>
    <div className="btn-group ml-auto" role="group">
      <div style={{margin: '.375 rem'}}>
        Page {props.page} of {props.totalPages}
      </div>
    </div>
  </div>
)

export default Pagination
