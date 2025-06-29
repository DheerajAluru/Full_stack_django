# protocols/task8/restaurant_service.py
import restaurant_pb2
import restaurant_pb2_grpc

class RestaurantService(restaurant_pb2_grpc.RestaurantServiceServicer):
    def GetRestaurants(self, request, context):
        # Normally this would come from a database or external API
        restaurants = [
            restaurant_pb2.Restaurant(name="Pizza Palace", address="123 Main St", rating=4.5),
            restaurant_pb2.Restaurant(name="Burger Barn", address="456 Elm St", rating=4.2),
        ]
        return restaurant_pb2.RestaurantList(restaurants=restaurants)
