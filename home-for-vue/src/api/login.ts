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

export const getEmailCode = (imgCode: string, uuid: string, email: string) => {
  const data = {
    imgCode,
    uuid,
    email,
  }
  return axios.post<any>("/front/email/code", data);
};

export const register = (data: any) => {
  return axios.post<any>("/front/user/register", data);
}

export const resetPwd = (data: any) => {
  return axios.put<any>("/front/user/resetPwd", data);
}

