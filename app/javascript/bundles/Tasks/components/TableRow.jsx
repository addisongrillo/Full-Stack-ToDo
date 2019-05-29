import React from 'react'

const TableRow = props => (
  <tr id={`task_${props.id}`}>
    <td>
      {
        props.completed             ?
        <s>{props.description}</s>  :
        props.description
      }
    </td>
    <td>
      <span className={props.due_date_class}>
        {props.due_date}
      </span>
    </td>
    <td>
      <a href={props.location || "#"} className="btn btn-info">
        Details
      </a>
    </td>
  </tr>
)

export default TableRow
