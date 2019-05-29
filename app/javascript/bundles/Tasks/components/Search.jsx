import React from 'react'

const Search = props => (
  <div className="form-group">
    <input
      id="term"
      type="search"
      className={ props.invalid ? "form-control is-invalid" : "form-control" }
      placeholder="Search"
      onChange={props.handleSearch}
      value={props.term}
    />
  </div>
)

export default Search
