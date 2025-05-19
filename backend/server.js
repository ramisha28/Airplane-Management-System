// backend/server.js
import express from 'express';
import sql from 'mssql';
import cors from 'cors';

const app = express();
const corsOptions = {
  origin: "http://localhost:3000", // Adjust this to match your frontend's URL
  optionsSuccessStatus: 200,
};
app.use(cors(corsOptions));
app.use(express.json());

const port = 3000; // Ensure the port is set to 3000
app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});



const baseConfig = {
  server: "DESKTOP-VSQ414T\\SQLEXPRESS", // Your server name from SSMS
  database: "FTP", // Replace with your database name
  options: {
    encrypt: false, // Use if you're on Windows Azure
    trustServerCertificate: true, // For local development
    trustedConnection: false, // Change to true for local development
    enableArithAbort: true,
    instancename: "SQLEXPRESS",
  },
};

// User login endpoint
app.post("/login", async (req, res) => {
  console.log("Login attempt:", req.body);
  const { username, password } = req.body;
  const config = {
    ...baseConfig,
    user: username,
    password: password,
  };

  try {
    console.log("Attempting database connection...");
    console.log("Username:", username);
    console.log("Password:", password);
    await sql.connect(config);
    console.log("Database connection successful");
    res.json({ message: "Login successful" });
  } catch (err) {
    console.error("SQL error:", err);
    res.status(401).json({ error: "Invalid credentials" });
  }
});

// Book flight endpoint
app.post("/book-flight", async (req, res) => {
  const {
    passenger_name,
    passenger_email,
    passenger_gender,
    aircraft,
    flight_departure_airport,
    flight_departure_datetime,
    flight_arrival_airport,
    flight_arrival_datetime,
    class: flight_class,
    seat,
    baggage_detail,
    payment_method,
    amount
  } = req.body;

  try {
    await sql.connect(baseConfig);

    // Insert passenger
    const passengerResult = await sql.query`
      INSERT INTO Passenger (passenger_name, passenger_email, passenger_gender)
      OUTPUT INSERTED.passenger_id
      VALUES (${passenger_name}, ${passenger_email}, ${passenger_gender})
    `;
    const passenger_id = passengerResult.recordset[0].passenger_id;

    // Insert flight
    const flightResult = await sql.query`
      INSERT INTO Flight (aircraft, flight_departure_airport, flight_departure_datetime, flight_arrival_airport, flight_arrival_datetime)
      OUTPUT INSERTED.flight_id
      VALUES (${aircraft}, ${flight_departure_airport}, ${flight_departure_datetime}, ${flight_arrival_airport}, ${flight_arrival_datetime})
    `;
    const flight_id = flightResult.recordset[0].flight_id;

    // Insert reservation
    const reservationResult = await sql.query`
      INSERT INTO Reservation (passenger, flight, class, seat, reservation_datetime)
      OUTPUT INSERTED.reservation_id
      VALUES (${passenger_id}, ${flight_id}, ${flight_class}, ${seat}, GETDATE())
    `;
    const reservation_id = reservationResult.recordset[0].reservation_id;

    // Insert baggage
    await sql.query`
      INSERT INTO Baggage (baggage_detail, passenger, flight)
      VALUES (${baggage_detail}, ${passenger_id}, ${flight_id})
    `;

    // Insert payment
    await sql.query`
      INSERT INTO Payment (reservation, amount, payment_method)
      VALUES (${reservation_id}, ${amount}, ${payment_method})
    `;

    res.status(201).json({ message: "Flight booked successfully" });
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "Failed to book flight" });
  }
});

export default app;
