import React from 'react'
import dateFns from 'date-fns'

const Header = props => (
  <div className="header calendar-row flex-middle">
    <div className="calendar-col col-start">
      <div className="icon" onClick={props.prevMonth} id="prev-month">
        chevron_left
      </div>
    </div>
    <div className="calendar-col col-center">
      <span>
        { dateFns.format(props.currentMonth, "MMMM YYYY") }
      </span>
    </div>
    <div className="calendar-col col-end">
      <div className="icon" onClick={props.nextMonth} id="next-month">
        chevron_right
      </div>
    </div>
  </div>
)

export default Header
