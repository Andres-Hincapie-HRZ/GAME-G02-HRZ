import axios from "axios";

const API_URL = `${process.env.REACT_APP_API}/login/`;

const register = (email, username, icon, password, hcaptchaToken, otp) => {
  return axios.post(API_URL + "register/account", {
    email,
    username,
    icon,
    password,
    captcha: hcaptchaToken,
    otp
  });
};

const login = (email, password) => {
  return axios
    .post(API_URL + "login/account", {
      username: email,
      password,
    })
    .then((response) => {
      if (response.data.code != 200) {
        throw new Error();
      } else {
        localStorage.setItem("user", JSON.stringify(response.data));
        console.log(response);
      }
      return response;
    });
};

const logout = () => {
  localStorage.removeItem("user");
};

export default {
  register,
  login,
  logout,
};
