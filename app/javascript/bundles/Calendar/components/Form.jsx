import React from 'react'

const Form = props => (
  <form
    style={{width: '100%'}}
    onSubmit={props.handleFormSubmit}
  >
    <div className="form-group">
      <div className="custom-control" style={{paddingLeft: 0}}>
        <input
          id="task_description"
          type="text"
          className={
            props.task.description.length > 0 ?
              "form-control" : props.task.errors.length > 0 ?
              "form-control is-invalid" : "form-control"
          }
          value={props.task.description}
          onChange={props.handleDescriptionChange}
          autoComplete="off"
        />
        <div className="invalid-feedback">
          { props.task.errors.join(', ') }
        </div>
      </div>
    </div>
    <button type="submit" className="btn btn-primary">
      Create Task
    </button>
  </form>
)

export default Form
