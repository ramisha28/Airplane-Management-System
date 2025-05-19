// src/Home.jsx
import React from "react";
import Navigation from "./Navigation";
import airplaneImage from "./airplane.jpg"; // Update the path to your airplane image

const Home = () => {
  return (
    <div
      className="h-screen bg-cover bg-center flex flex-col overflow-hidden"
      style={{ backgroundImage: `url(${airplaneImage})`, overflow: 'hidden', scrollbarWidth: 'none', msOverflowStyle: 'none' }}
    >
      <div className="flex-grow flex justify-center items-center">
        <h1 className="text-4xl font-bold text-[#07ada0]">
          Welcome to Airline Management System
        </h1>
      </div>
    </div>
  );
};

export default Home;