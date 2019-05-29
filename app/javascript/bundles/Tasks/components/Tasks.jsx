import React, { Component } from 'react'
import axios from 'axios'
import Menu from './Menu'
import Table from './Table'
import Search from './Search'

class Tasks extends Component {
  state = {
    status: this.props.status,
    tasks:  [{}, {}, {}, {}, {}],
    due:    '',
    term:   ''
  }

  componentDidMount(){
    const { status, due, term } = this.state
    this.fetchTasks(status, due, term)
  }

  fetchTasks = (status, due, term) => {
    axios.get(`/tasks.json?status=${status}&due=${due}&term=${term}`)
      .then(response => {
        const { tasks } = response.data
        this.setState({ tasks, status, due, term })
      })
  }

  handleDueClick = selectedDue => {
    let { status, due, term } = this.state
    if(selectedDue === due){
      due = ''
    }else{
      due = selectedDue
    }
    this.fetchTasks(status, due, term)
  }

  handleSearch = event => {
    const term = event.target.value
    const { status, due } = this.state
    this.fetchTasks(status, due, term)
  }

  render(){
    const { tasks, due, term } = this.state
    return(
      <React.Fragment>
        <Menu due={due} handleDueClick={this.handleDueClick} />
        <Search
          term={term}
          handleSearch={this.handleSearch}
          invalid={ tasks.length === 0 && term.length > 0 }
        />
        <Table tasks={tasks}/>
      </React.Fragment>
    )
  }
}

export default Tasks
