import React from 'react'
import { Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap'
import dateFns from 'date-fns'
import Form from './Form'

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
    <ModalFooter>
      <Form
        task={props.task}
        handleDescriptionChange={props.handleDescriptionChange}
        handleFormSubmit={props.handleFormSubmit}
      />
    </ModalFooter>
  </Modal>
)

export default CalendarModal
