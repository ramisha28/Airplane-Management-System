// src/Login.js
import React, { useState, useContext } from "react";
import { AuthContext } from "./AuthContext";

const Login = ({ onLogin }) => {
  const { setUsername, setPassword, setLoginType, setVerified } =
    useContext(AuthContext);
  const [localUsername, setLocalUsername] = useState("");
  const [localPassword, setLocalPassword] = useState("");
  const [message, setMessage] = useState("");
  const [loginType, setLocalLoginType] = useState(""); // New state for login type

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      console.log("Logging in with:", localUsername, localPassword);
      console.log("gonna post to http://localhost:3000/login");
      const response = await fetch("http://localhost:3000/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          username: localUsername,
          password: localPassword,
        }),
      });
      const data = await response.json();
      if (response.ok) {
        setMessage(data.message);
        setUsername(localUsername);
        setPassword(localPassword);
        setVerified(true); // Set verified to true
        onLogin(localUsername, localPassword);
      } else {
        setMessage(data.error || "Login failed");
      }
    } catch (error) {
      console.error("Error logging in:", error);
      console.log("Login failed form Login.js");
      setMessage("Login failed");
    }
  };

  return (
    <div className="flex justify-center items-center min-h-screen">
      <form
        onSubmit={handleSubmit}
        className="glass-effect p-8 rounded-2xl shadow-xl w-full max-w-md space-y-6"
      >
        <h2 className="text-3xl font-bold text-center text-white mb-8">
          Login
        </h2>

        <div className="mb-4">
          <label htmlFor="username" className="block text-white mb-2">
            Username:
          </label>
          <input
            type="text"
            id="username"
            value={localUsername}
            onChange={(e) => {
              setLocalUsername(e.target.value);
              console.log("username:", e.target.value);
            }}
            required
            className="w-full p-3 border rounded-lg bg-opacity-10 bg-white border-opacity-20 focus:border-accent focus:ring-1 focus:ring-accent text-white"
          />
        </div>

        <div className="mb-4">
          <label htmlFor="password" className="block text-gray-300 mb-2">
            Password:
          </label>
          <input
            type="password"
            id="password"
            value={localPassword}
            onChange={(e) => {
              setLocalPassword(e.target.value);
              console.log("password:", e.target.value);
            }}
            required
            className="w-full p-2 border border-gray-600 rounded bg-gray-700 text-white"
          />
        </div>

        <div className="flex space-x-4">
          <button
            type="button"
            className="flex-1 py-3 px-6 rounded-full bg-secondary text-white hover:bg-accent hover:text-background transition-all duration-300"
          >
            Register
          </button>
          <button
            type="submit"
            className="flex-1 py-3 px-6 rounded-full bg-secondary text-white hover:bg-accent hover:text-background transition-all duration-300"
          >
            Login
          </button>
        </div>

        {message && (
          <div
            className={`mt-4 p-2 rounded text-center ${
              message.includes("failed")
                ? "bg-red-100 text-red-700"
                : "bg-green-100 text-green-700"
            }`}
          >
            {message}
          </div>
        )}
      </form>
    </div>
  );
};

export default Login;