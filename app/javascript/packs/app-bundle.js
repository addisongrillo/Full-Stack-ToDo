import ReactOnRails from 'react-on-rails'

import Tasks from '../bundles/Tasks/components/Tasks'
import Calendar from '../bundles/Calendar/components/Calendar'

// This is how react_on_rails can see the Tasks in the browser.
ReactOnRails.register({
  Tasks,
  Calendar
})
