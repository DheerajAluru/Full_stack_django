import redis
import json
import time

r = redis.Redis(host='localhost', port=6379, db=0)

def get_restaurant_data(id):
    key = f"restaurant:{id}"
    data = r.get(key)
    if data:
        print("Cache hit!")
        return json.loads(data)
    
    # Mock DB fetch
    print("Cache miss. Fetching from DB...")
    restaurant = {
        "id": id,
        "name": "Mock Cafe",
        "address": "123 Lane",
        "rating": 4.5
    }
    r.set(key, json.dumps(restaurant), ex=60)
    return restaurant

print(get_restaurant_data(1))
time.sleep(2)
print(get_restaurant_data(1))
