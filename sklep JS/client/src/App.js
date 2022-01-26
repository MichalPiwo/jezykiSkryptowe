import logo from './logo.svg';
import React, { useState } from 'react';
import './App.css';
import Login from "./Components/Login"
import useToken from './Components/UseToken';
import Logout from './Components/Logout'
import Products from './Components/Products'

function App() {
    const { token, setToken } = useToken();

    console.log("App.js");
    console.log(token);
    console.log(setToken);

    if(!token) {
        return(
            <div className="App">
                <Login setToken={setToken} />
            </div>
            )
    }

  return (
    <div className="App">
        <Logout/>
        <Products/>
    </div>
  );
}

export default App;
