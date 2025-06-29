# task8/grpc_server.py
from concurrent import futures
import grpc
import restaurant_pb2
import restaurant_pb2_grpc
from restaurant_service import RestaurantService  # your implementation

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    restaurant_pb2_grpc.add_RestaurantServiceServicer_to_server(RestaurantService(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    print("gRPC server running on port 50051...")
    server.wait_for_termination()

if __name__ == '__main__':
    serve()
