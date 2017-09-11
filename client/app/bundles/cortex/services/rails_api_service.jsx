import axios from 'axios';

const SetRailsAPIService = ( railsContext, session) => {
  if (railsContext.serverSide === true) {
    return axios
  }
  axios.defaults.baseURL = window.location.origin
  axios.defaults.headers.common['X-CSRF-Token'] = session.csrf_token
  axios.defaults.headers.common['Accept'] = 'application/json'
  return axios
}

export default SetRailsAPIService
