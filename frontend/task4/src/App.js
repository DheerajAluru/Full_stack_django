import React, { useState } from 'react';
import axios from 'axios';
import './Form.css';

function App() {
  const [formData, setFormData] = useState({
    name: '',
    address: '',
    phone_number: '',
    rating: '',
  });

  const [successMessage, setSuccessMessage] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const handleChange = (e) => {
    setFormData((prev) => ({
      ...prev,
      [e.target.name]: e.target.value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSuccessMessage('');
    setErrorMessage('');

    const { name, address, phone_number, rating } = formData;

    if (!name || !address || !phone_number || !rating) {
      setErrorMessage('Please fill in all fields');
      return;
    }
    if (isNaN(rating) || rating < 0 || rating > 5) {
      setErrorMessage('Rating must be between 0 and 5');
      return;
    }

    try {
      await axios.post('http://localhost:8000/api/restaurants/', formData);
      setSuccessMessage('Restaurant added successfully!');
      setFormData({ name: '', address: '', phone_number: '', rating: '' });
    } catch (err) {
      setErrorMessage('Submission failed. Try again.');
      console.error(err);
    }
  };

  return (
    <div className="form-container">
      <h2>Add New Restaurant</h2>
      <form onSubmit={handleSubmit}>
        <input type="text" name="name" placeholder="Restaurant Name" value={formData.name} onChange={handleChange} required />
        <input type="text" name="address" placeholder="Address" value={formData.address} onChange={handleChange} required />
        <input type="text" name="phone_number" placeholder="Phone Number" value={formData.phone_number} onChange={handleChange} required />
        <input type="number" name="rating" placeholder="Rating (0-5)" value={formData.rating} onChange={handleChange} required />
        <button type="submit">Submit</button>
      </form>
      {successMessage && <p className="success">{successMessage}</p>}
      {errorMessage && <p className="error">{errorMessage}</p>}
    </div>
  );
}

export default App;
