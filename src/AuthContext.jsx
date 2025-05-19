// src/AuthContext.js
import React, { createContext, useState, useEffect } from "react";

export const AuthContext = createContext({
  username: "",
  setUsername: () => {},
  password: "",
  setPassword: () => {},
  verified: false,
  setVerified: () => {},
  userData: null,
  setUserData: () => {},
});

export const AuthProvider = ({ children }) => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [verified, setVerified] = useState(false);
  const [userData, setUserData] = useState(null);

  useEffect(() => {
    console.log("Username:", username);
    console.log("Password:", password);
    console.log("Verified:", verified);
  }, [username, password, verified, userData]);

  return (
    <AuthContext.Provider
      value={{
        username,
        setUsername,
        password,
        setPassword,
        verified,
        setVerified,
        userData,
        setUserData,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};
