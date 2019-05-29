import React, { Component } from 'react'
import axios from 'axios'
import TableRow from './TableRow'

class Tasks extends Component {
  state = {
    tasks: [{}, {}, {}, {}, {}]
  }

  componentDidMount(){
    this.fetchTasks()
  }

  fetchTasks = () => {
    axios.get(`/tasks.json`)
      .then(response => {
        const { tasks } = response.data
        this.setState({ tasks })
      })
  }

  render(){
    const { tasks } = this.state
    return(
      <table className="table">
        <thead>
          <tr>
            <th style={{width: '70%'}}>Description</th>
            <th style={{width: '15%'}}>Due</th>
            <th style={{width: '15%'}}></th>
          </tr>
        </thead>
        <tbody>
          { tasks.map((task, index) => (
              <TableRow key={index} {...task} />
          ))}
        </tbody>
      </table>
    )
  }
}

export default Tasks
