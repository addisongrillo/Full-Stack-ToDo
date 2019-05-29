import React, { Component } from 'react'
import axios from 'axios'
import Menu from './Menu'
import Table from './Table'
import Search from './Search'
import Pagination from './Pagination'

class Tasks extends Component {
  state = {
    status: this.props.status,
    tasks:      [{}, {}, {}, {}, {}],
    due:        '',
    term:       '',
    page:       1,
    totalPages: 1
  }

  componentDidMount(){
    const { status, due, term, page } = this.state
    this.fetchTasks(status, due, term, page)
  }

  fetchTasks = (status, due, term, page) => {
    axios.get(`/tasks.json?status=${status}&due=${due}&term=${term}&page=${page}`)
      .then(response => {
        const { tasks, page, totalPages } = response.data
        this.setState({ tasks, status, due, term, page, totalPages })
      })
  }

  handleDueClick = selectedDue => {
    let { status, due, term, page } = this.state
    if(selectedDue === due){
      due = ''
    }else{
      due = selectedDue
    }
    this.fetchTasks(status, due, term, page)
  }

  handleSearch = event => {
    const term = event.target.value
    const { status, due, page } = this.state
    this.fetchTasks(status, due, term, page)
  }

  changePage = page => {
    const { status, due, term } = this.state
    this.fetchTasks(status, due, term, page)
  }

  render(){
    const { tasks, due, term, page, totalPages } = this.state
    return(
      <React.Fragment>
        <Menu due={due} handleDueClick={this.handleDueClick} />
        <Search
          term={term}
          handleSearch={this.handleSearch}
          invalid={ tasks.length === 0 && term.length > 0 }
        />
        <Table tasks={tasks}/>
        <Pagination
          page={page}
          totalPages={totalPages}
          changePage={this.changePage}
        />
      </React.Fragment>
    )
  }
}

export default Tasks
