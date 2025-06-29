import grpc
from concurrent import futures
import restaurant_pb2
import restaurant_pb2_grpc

class RestaurantService(restaurant_pb2_grpc.RestaurantServiceServicer):
    def GetRestaurant(self, request, context):
        return restaurant_pb2.RestaurantResponse(
            name="Cafe GoodFood",
            address="123 Main St",
            rating=4.6
        )

server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
restaurant_pb2_grpc.add_RestaurantServiceServicer_to_server(RestaurantService(), server)
server.add_insecure_port('[::]:50051')
server.start()
server.wait_for_termination()
