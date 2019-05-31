import React from 'react'
import dateFns, { startOfWeek } from 'date-fns'
import Cell from './Cell'

const Cells = props => {
  const monthStart  = dateFns.startOfMonth(props.currentMonth)
  const monthEnd    = dateFns.endOfMonth(props.currentMonth)
  const startDate   = dateFns.startOfWeek(monthStart)
  const endDate     = dateFns.endOfWeek(monthEnd)
  const rows        = []
  let days          = []
  let day           = startDate
  while (day <= endDate) {
    for (let i = 0; i < 7; i++) {
      let dailyTasks = props.tasks[dateFns.format(day, "YYYY-MM-DD")] || []
      days.push(<Cell key={day} day={day} {...props} dailyTasks={dailyTasks}/>)
      day = dateFns.addDays(day, 1)
    }
    rows.push(
      <div className="calendar-row" key={day}>
        { days }
      </div>
    )
    days = []
  }
  return <div className="body">{rows}</div>
}

export default Cells
