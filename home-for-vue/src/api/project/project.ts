import axios from '../../utils/request';


// 项目获取
export const listProject = (params: any) => {
  // 返回的数据格式可以和服务端约定
  return axios.get<any[]>('/front/project/list', params);
};

