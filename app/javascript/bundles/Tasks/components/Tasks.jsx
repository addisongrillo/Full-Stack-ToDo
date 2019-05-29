import React, { Component } from 'react'
import axios from 'axios'
import Menu from './Menu'
import Table from './Table'

class Tasks extends Component {
  state = {
    status: this.props.status,
    tasks:  [{}, {}, {}, {}, {}]
  }

  componentDidMount(){
    const { status } = this.state
    this.fetchTasks(status)
  }

  fetchTasks = (status) => {
    axios.get(`/tasks.json?status=${status}`)
      .then(response => {
        const { tasks } = response.data
        this.setState({ tasks, status })
      })
  }

  render(){
    const { tasks } = this.state
    return(
      <React.Fragment>
        <Menu />
        <Table tasks={tasks}/>
      </React.Fragment>
    )
  }
}

export default Tasks
