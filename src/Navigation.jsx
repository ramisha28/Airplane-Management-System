// src/Navigation.js
import React, { useContext } from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthContext } from "./AuthContext";

const Navigation = () => {
  const { username, setUsername, setPassword, setVerified } =
    useContext(AuthContext);
  const navigate = useNavigate();
  const handleLogout = () => {
    setUsername("");
    setPassword("");
    setVerified(false);
    navigate("/");
  };

  return (
    <nav className="navbar sticky top-0 z-50 px-6 py-4">
      <div className="container mx-auto flex justify-between items-center">
        <Link to="/" className="text-2xl font-bold text-white hover:text-accent transition-colors">
          Qatar Airways
        </Link>
        
        <div className="flex items-center space-x-6">
          <Link
            to="/book-flight"
            className="px-6 py-2 rounded-full bg-accent text-white hover:bg-[#ff5472] transition-all duration-300"
          >
            Book a Flight
          </Link>
          
          {username ? (
            <button
              onClick={handleLogout}
              className="px-6 py-2 rounded-full border-2 border-accent text-white hover:bg-accent transition-all duration-300"
            >
              Logout
            </button>
          ) : (
            <Link
              to="/login"
              className="px-6 py-2 rounded-full border-2 border-accent text-white hover:bg-accent transition-all duration-300"
            >
              Login
            </Link>
          )}
        </div>
      </div>
    </nav>
  );
};

export default Navigation;
