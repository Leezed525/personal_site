import axios from '../utils/request'
import {LoginReqBody} from "../types/login";


export const login = (username: string, password: string, code: string, uuid: string) => {
  const data: LoginReqBody = {
    username: username,
    password: password,
    code: code,
    uuid: uuid,
  }
  return axios.post<any>("/login", data)
}


export const getInfo = () => {
  return axios.get<any>("/getInfo")
}

export const logout = () => {
  return axios.post<any>("/logout")
}

