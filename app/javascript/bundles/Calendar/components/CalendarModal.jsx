import React from 'react'
import { Modal, ModalHeader, ModalBody } from 'reactstrap'
import dateFns from 'date-fns'

const CalendarModal = props => (
  <Modal isOpen={props.modalOpen} toggle={props.closeModal}>
    <ModalHeader toggle={props.closeModal}>
      { dateFns.format(props.selectedDate, "dddd, MMMM Do") }
    </ModalHeader>
    <ModalBody>
      <ul>
        {
          props.dailyTasks.map(task => {
            return(
              <li key={task.id}>
                <a href={task.location}>
                  {
                    task.completed ?
                    <s>{task.description}</s> :
                    task.description
                  }
                </a>
              </li>
            )
          })
        }
      </ul>
      {
        props.dailyTasks.length === 0 &&
        <p><i>No tasks due today</i></p>
      }
    </ModalBody>
  </Modal>
)

export default CalendarModal
