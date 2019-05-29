import React, { Component } from 'react'
import axios from 'axios'
import Menu from './Menu'
import Table from './Table'

class Tasks extends Component {
  state = {
    status: this.props.status,
    tasks:  [{}, {}, {}, {}, {}],
    due: ''
  }

  componentDidMount(){
    const { status, due } = this.state
    this.fetchTasks(status, due)
  }

  fetchTasks = (status, due) => {
    axios.get(`/tasks.json?status=${status}&due=${due}`)
      .then(response => {
        const { tasks } = response.data
        this.setState({ tasks, status, due })
      })
  }

  handleDueClick = selectedDue => {
    let { status, due } = this.state
    if(selectedDue === due){
      due = ''
    }else{
      due = selectedDue
    }
    this.fetchTasks(status, due)
  }

  render(){
    const { tasks, due } = this.state
    return(
      <React.Fragment>
        <Menu due={due} handleDueClick={this.handleDueClick} />
        <Table tasks={tasks}/>
      </React.Fragment>
    )
  }
}

export default Tasks
