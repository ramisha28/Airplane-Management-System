import React from 'react';

const FlightCard = ({ flight }) => (
  <div className="bg-white/10 p-6 rounded-lg backdrop-blur-md shadow-lg hover:transform hover:scale-105 transition-all">
    <div className="flex justify-between items-center mb-4">
      <div>
        <p className="text-lg font-bold text-white">{flight.airline}</p>
        <p className="text-sm text-gray-300">Flight {flight.flightNumber}</p>
      </div>
      <p className="text-xl font-bold text-accent">${flight.price}</p>
    </div>
    <div className="flex justify-between items-center">
      <div>
        <p className="text-white">{flight.departureTime}</p>
        <p className="text-sm text-gray-300">{flight.origin}</p>
      </div>
      <div className="text-center">
        <p className="text-sm text-gray-300">{flight.duration}</p>
        <div className="w-32 h-px bg-gray-600 my-2"></div>
      </div>
      <div className="text-right">
        <p className="text-white">{flight.arrivalTime}</p>
        <p className="text-sm text-gray-300">{flight.destination}</p>
      </div>
    </div>
    <button className="w-full mt-4 bg-accent text-white py-2 rounded-lg hover:bg-opacity-90 transition-all">
      Select Flight
    </button>
  </div>
);

const FlightSearchResults = ({ flights }) => {
  return (
    <div className="container mx-auto py-8">
      <h2 className="text-2xl font-bold text-white mb-6">Available Flights</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {flights.map((flight) => (
          <FlightCard key={flight.id} flight={flight} />
        ))}
      </div>
    </div>
  );
};

export default FlightSearchResults;