import React from 'react';
import { Link } from 'react-router-dom';

const Footer = () => {
  return (
    <footer className="bg-primary py-8 text-white">
      <div className="container mx-auto grid grid-cols-1 md:grid-cols-4 gap-8 px-4">
        <div>
          <h3 className="text-xl font-bold mb-4">Qatar Airways</h3>
          <p className="text-gray-300">Your journey begins with us</p>
        </div>
        <div>
          <h4 className="text-lg font-semibold mb-3">Quick Links</h4>
          <ul className="space-y-2">
            <li><Link to="/book-flight" className="text-gray-300 hover:text-accent">Book Flight</Link></li>
            <li><Link to="/flight-status" className="text-gray-300 hover:text-accent">Flight Status</Link></li>
            <li><Link to="/check-in" className="text-gray-300 hover:text-accent">Check-in</Link></li>
          </ul>
        </div>
        <div>
          <h4 className="text-lg font-semibold mb-3">Support</h4>
          <ul className="space-y-2">
            <li><Link to="/contact" className="text-gray-300 hover:text-accent">Contact Us</Link></li>
            <li><Link to="/faq" className="text-gray-300 hover:text-accent">FAQ</Link></li>
            <li><Link to="/baggage" className="text-gray-300 hover:text-accent">Baggage Info</Link></li>
          </ul>
        </div>
        <div>
          <h4 className="text-lg font-semibold mb-3">Connect With Us</h4>
          <div className="flex space-x-4">
            <a href="#" className="text-gray-300 hover:text-accent">
              <i className="fab fa-facebook"></i>
            </a>
            <a href="#" className="text-gray-300 hover:text-accent">
              <i className="fab fa-twitter"></i>
            </a>
            <a href="#" className="text-gray-300 hover:text-accent">
              <i className="fab fa-instagram"></i>
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;