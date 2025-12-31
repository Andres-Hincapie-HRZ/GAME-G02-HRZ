import axios from "axios";
import { logout } from "../actions/auth";
import store from '../store';

export const Api = async (method, route, data) => {
  const user = JSON.parse(localStorage.getItem("user"));
  const promise = axios({
    method: method,
    url: `${process.env.REACT_APP_API}/${route}`,
    headers: {
      Authorization: `${user.data.token}`,
      "content-type": "application/json",
    },
    data,
  });
  const response = await promise
    .then((resp) => {
      const { status, data } = resp;

      if (status === 401 || data.code === 401)
        store.dispatch(logout());

      return resp;
    })
    .catch((err) => {
      return err.response;
    });

  return response;
};