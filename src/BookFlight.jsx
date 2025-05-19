import React, { useState } from 'react';

const BookFlight = () => {
  const [formData, setFormData] = useState({
    passenger_name: '',
    passenger_email: '',
    passenger_gender: '',
    aircraft: '',
    flight_departure_airport: '',
    flight_departure_datetime: '',
    flight_arrival_airport: '',
    flight_arrival_datetime: '',
    class: '',
    seat: '',
    baggage_detail: '',
    payment_method: '',
    amount: ''
  });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch('http://localhost:3000/book-flight', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          passenger_name: formData.passenger_name.toString(),
          passenger_email: formData.passenger_email.toString(),
          passenger_gender: formData.passenger_gender.toString(),
          aircraft: parseInt(formData.aircraft),
          flight_departure_airport: parseInt(formData.flight_departure_airport),
          flight_departure_datetime: new Date(formData.flight_departure_datetime).toISOString(),
          flight_arrival_airport: parseInt(formData.flight_arrival_airport),
          flight_arrival_datetime: new Date(formData.flight_arrival_datetime).toISOString(),
          class: parseInt(formData.class),
          seat: parseInt(formData.seat),
          baggage_detail: formData.baggage_detail.toString(),
          payment_method: formData.payment_method.toString(),
          amount: parseInt(formData.amount)
        })
      });
      if (response.ok) {
        alert('Flight booked successfully');
        setFormData({
          passenger_name: '',
          passenger_email: '',
          passenger_gender: '',
          aircraft: '',
          flight_departure_airport: '',
          flight_departure_datetime: '',
          flight_arrival_airport: '',
          flight_arrival_datetime: '',
          class: '',
          seat: '',
          baggage_detail: '',
          payment_method: '',
          amount: ''
        });
      }
    } catch (error) {
      console.error('Error booking flight:', error);
    }
  };

  return (
    <div className="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto glass-effect rounded-2xl p-8 shadow-xl">
        <h2 className="text-4xl font-bold text-center text-accent mb-12">
          Book Your Flight
        </h2>
        
        <form onSubmit={handleSubmit} className="space-y-8">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-white mb-2">Passenger Name</label>
              <input
                type="text"
                className="w-full p-3 border rounded-lg bg-opacity-10 bg-white border-opacity-20 focus:border-accent focus:ring-1 focus:ring-accent text-white"
                placeholder="Passenger Name"
                value={formData.passenger_name}
                onChange={(e) => setFormData({...formData, passenger_name: e.target.value})}
              />
            </div>
            
            <div>
              <label className="block text-gray-700 mb-2">Passenger Email</label>
              <input
                type="email"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Passenger Email"
                value={formData.passenger_email}
                onChange={(e) => setFormData({...formData, passenger_email: e.target.value})}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-gray-700 mb-2">Passenger Gender</label>
              <input
                type="text"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Passenger Gender"
                value={formData.passenger_gender}
                onChange={(e) => setFormData({...formData, passenger_gender: e.target.value})}
              />
            </div>

            <div>
              <label className="block text-gray-700 mb-2">Aircraft</label>
              <input
                type="text"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Aircraft"
                value={formData.aircraft}
                onChange={(e) => setFormData({...formData, aircraft: e.target.value})}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-gray-700 mb-2">Departure Airport</label>
              <input
                type="text"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Departure Airport"
                value={formData.flight_departure_airport}
                onChange={(e) => setFormData({...formData, flight_departure_airport: e.target.value})}
              />
            </div>

            <div>
              <label className="block text-gray-700 mb-2">Departure DateTime</label>
              <input
                type="datetime-local"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                value={formData.flight_departure_datetime}
                onChange={(e) => setFormData({...formData, flight_departure_datetime: e.target.value})}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-gray-700 mb-2">Arrival Airport</label>
              <input
                type="text"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Arrival Airport"
                value={formData.flight_arrival_airport}
                onChange={(e) => setFormData({...formData, flight_arrival_airport: e.target.value})}
              />
            </div>

            <div>
              <label className="block text-gray-700 mb-2">Arrival DateTime</label>
              <input
                type="datetime-local"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                value={formData.flight_arrival_datetime}
                onChange={(e) => setFormData({...formData, flight_arrival_datetime: e.target.value})}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-gray-700 mb-2">Class</label>
              <input
                type="text"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Class"
                value={formData.class}
                onChange={(e) => setFormData({...formData, class: e.target.value})}
              />
            </div>

            <div>
              <label className="block text-gray-700 mb-2">Seat</label>
              <input
                type="text"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Seat"
                value={formData.seat}
                onChange={(e) => setFormData({...formData, seat: e.target.value})}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-gray-700 mb-2">Baggage Detail</label>
              <input
                type="text"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Baggage Detail"
                value={formData.baggage_detail}
                onChange={(e) => setFormData({...formData, baggage_detail: e.target.value})}
              />
            </div>

            <div>
              <label className="block text-gray-700 mb-2">Payment Method</label>
              <input
                type="text"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Payment Method"
                value={formData.payment_method}
                onChange={(e) => setFormData({...formData, payment_method: e.target.value})}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-gray-700 mb-2">Amount</label>
              <input
                type="number"
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#07ada0]"
                placeholder="Amount"
                value={formData.amount}
                onChange={(e) => setFormData({...formData, amount: e.target.value})}
              />
            </div>
          </div>

          <button
            type="submit"
            className="w-full py-4 px-8 rounded-full bg-secondary text-white text-lg font-semibold hover:bg-accent hover:text-background transition-all duration-300"
          >
            Book Flight
          </button>
        </form>
      </div>
    </div>
  );
};

export default BookFlight;