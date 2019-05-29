import React from 'react'
import TableRow from './TableRow'

const Table = props => (
  <table className="table">
    <thead>
      <tr>
        <th style={{width: '70%'}}>Description</th>
        <th style={{width: '15%'}}>Due</th>
        <th style={{width: '15%'}}></th>
      </tr>
    </thead>
    <tbody>
      { props.tasks.map((task, index) => (
          <TableRow key={index} {...task} />
      ))}
    </tbody>
  </table>
)

export default Table
