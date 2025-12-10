import axios from "axios";
export const ApiWithoutToken = async (method, route) => {
  const promise = axios({
    method: method,
    url: `${process.env.REACT_APP_API}/${route}`,
    headers: {
      "content-type": "application/json",
    },
  });
  const response = await promise
    .then((resp) => {
      return resp;
    })
    .catch((err) => {
      return err.response;
    });

    
  return response;
};
