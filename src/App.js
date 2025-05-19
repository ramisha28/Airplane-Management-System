import React, { useContext, useState, useCallback } from "react";
import "./App.css";
import { Routes, Route, Navigate, useNavigate } from "react-router-dom";
import Login from "./Login";
import Home from "./Home";
import Navigation from "./Navigation";
import { AuthContext } from "./AuthContext";
import BookFlight from "./BookFlight";
import Footer from "./components/Footer";
import Toast from "./components/Toast";
import FlightSearchResults from "./components/FlightSearchResults";

function App() {
  const {
    username,
    password,
    setUsername,
    setPassword,
    verified,
    setVerified,
    setUserData,
  } = useContext(AuthContext);
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleLogout = useCallback(() => {
    setUsername("");
    setPassword("");
    setVerified(false);
    setError(null);
    navigate("/");
  }, [navigate, setUsername, setPassword, setVerified, setError]);

  const handleLogin = async (username, password) => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch(`http://localhost:3000/login`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ username, password }),
      });
      const data = await response.json();
      if (response.ok) {
        setUserData(data.data);
        setVerified(true);
        navigate("/");
      } else {
        setError(data.error || "Failed to login");
      }
    } catch (error) {
      setError("Error connecting to server");
    } finally {
      setLoading(false);
    }
  };

  console.log("from app.js Verified:", verified);
  return (
    <div className="App flex flex-col min-h-screen">
      <Navigation />
      <main className="flex-grow">
        {loading && <p>Loading...</p>}
        {error && (
          <Toast message={error} type="error" onClose={() => setError(null)} />
        )}
        <Routes>
          <Route path="/" element={<Home />} />
          <Route
            path="/book-flight"
            element={verified ? <BookFlight /> : <Navigate to="/login" />}
          />
          <Route
            path="/login"
            element={
              <Login
                onLogin={(username, password) => {
                  handleLogin(username, password);
                }}
              />
            }
          />
          <Route
            path="/admin/*"
            element={
              verified ? (
                <div>Admin Dashboard</div>
              ) : (
                <Navigate to="/login" />
              )
            }
          />
          <Route
            path="/student/*"
            element={
              verified ? (
                <div>Student Dashboard</div>
              ) : (
                <Navigate to="/login" />
              )
            }
          />
          <Route
            path="/search-results"
            element={<FlightSearchResults flights={[]} />}
          />
        </Routes>
      </main>
      <Footer />
    </div>
  );
}

export default App;
