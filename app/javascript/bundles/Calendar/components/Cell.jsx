import React from 'react'
import dateFns from 'date-fns'

const Cell = props => (
  <div
    id={`day-${dateFns.format(props.day, "YYYY-MM-DD")}`}
    className={`calendar-col cell ${
      !dateFns.isSameMonth(props.day, props.currentMonth) ? "disabled"
        : dateFns.isSameDay(props.day, props.currentDate) ? "current" : ""
  }`}>
    <div className="calendar-events">
      {
        props.dailyTasks.map(task => {
          return(
            <div key={task.id} className="calendar-event">
              {
                task.completed ?
                <s>{task.description}</s> :
                task.description
              }
            </div>
          )
        })
      }
    </div>

    <span className="number">
      { dateFns.format(props.day, "D")}
    </span>
  </div>
)

export default Cell
