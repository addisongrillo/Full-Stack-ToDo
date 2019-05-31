import React from 'react'

const Days = () => (
  <div className="days calendar-row">
    {
      ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map(day => {
        return(
          <div className="calendar-col col-center" key={day}>
            { day }
          </div>
        )
      })
    }
  </div>
)

export default Days
