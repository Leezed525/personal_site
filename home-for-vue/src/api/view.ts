import axios from '../utils/request'

export const pageView = () => {
  return axios.get('/front/pv/view');
}

export const uniqueView = () => {
  return axios.get('/front/uv/view');
}
