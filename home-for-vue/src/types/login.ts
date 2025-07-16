export interface LoginReqBody {
  username: string;
  password: string;
  code: string;
  uuid: string;
}

export interface loginResBody {
  token: string;
}
