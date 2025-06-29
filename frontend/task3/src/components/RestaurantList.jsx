import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './RestaurantList.css';

const RestaurantList = () => {
  const [restaurants, setRestaurants] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    axios.get('http://localhost:8000/api/restaurants/')
      .then((res) => {
        setRestaurants(res.data);
        setLoading(false);
      })
      .catch((err) => {
        console.error(err);
        setError(true);
        setLoading(false);
      });
  }, []);

  if (loading) return <p className="status">Loading...</p>;
  if (error) return <p className="status error">Failed to load data</p>;

  return (
    <div className="container">
      <h2 className="title">Restaurant Directory</h2>
      <div className="restaurant-list">
        {restaurants.map((restaurant) => (
          <div className="card" key={restaurant.id}>
            <h3>{restaurant.name}</h3>
            <p><strong>Address:</strong> {restaurant.address}</p>
            <p><strong>Phone:</strong> {restaurant.phone_number}</p>
            <p><strong>Rating:</strong> ⭐ {restaurant.rating}</p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default RestaurantList;
