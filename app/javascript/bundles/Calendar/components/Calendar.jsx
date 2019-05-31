import React, { Component } from 'react'
import dateFns from 'date-fns'
import Header from './Header'
import Days from './Days'
import Cells from './Cells'
import axios from 'axios'
import CalendarModal from './CalendarModal'

class Calendar extends Component {
  state = {
    currentMonth: new Date(),
    currentDate:  new Date(),
    tasks:        {},
    selectedDate: new Date(),
    modalOpen:    false
  }

  componentDidMount(){
    const { currentMonth } = this.state
    this.fetchTasks(currentMonth)
  }

  fetchTasks = currentMonth => {
    const monthStart  = dateFns.startOfMonth(currentMonth)
    const monthEnd    = dateFns.endOfMonth(monthStart)
    const startDate   = dateFns.format(dateFns.startOfWeek(monthStart), "YYYY-MM-DD")
    const endDate     = dateFns.format(dateFns.endOfWeek(monthEnd), "YYYY-MM-DD")
    axios.get(`/calendar.json?start_date=${startDate}&end_date=${endDate}`)
      .then(response => this.setState({ tasks: response.data, currentMonth }))
  }

  handleDateClick = day => {
    this.setState({ selectedDate: day, modalOpen: true })
  }

  closeModal = () => {
    this.setState({ modalOpen: false })
  }

  nextMonth = () => {
    const currentMonth = dateFns.addMonths(this.state.currentMonth, 1)
    this.fetchTasks(currentMonth)
  }

  prevMonth = () => {
    const currentMonth = dateFns.subMonths(this.state.currentMonth, 1)
    this.fetchTasks(currentMonth)
  }

  render(){
    const { currentMonth, currentDate, tasks, selectedDate, modalOpen } = this.state
    return(
      <div className="calendar">
        <Header
          currentMonth={currentMonth}
          prevMonth={this.prevMonth}
          nextMonth={this.nextMonth}
        />
        <Days />
        <Cells
          currentMonth={currentMonth}
          currentDate={currentDate}
          tasks={tasks}
          handleDateClick={this.handleDateClick}
        />
        <CalendarModal
          modalOpen={modalOpen}
          selectedDate={selectedDate}
          closeModal={this.closeModal}
          dailyTasks={ tasks[dateFns.format(selectedDate, 'YYYY-MM-DD')] || [] }
        />
      </div>
    )
  }
}

export default Calendar
