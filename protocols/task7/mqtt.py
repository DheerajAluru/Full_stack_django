import paho.mqtt.client as mqtt

BROKER = "test.mosquitto.org"
TOPIC = "restaurant/orders"

# Subscriber
def on_message(client, userdata, msg):
    print(f"Received: {msg.payload.decode()} on topic {msg.topic}")

subscriber = mqtt.Client()
subscriber.on_message = on_message
subscriber.connect(BROKER, 1883)
subscriber.subscribe(TOPIC)
subscriber.loop_start()

# Publisher
publisher = mqtt.Client()
publisher.connect(BROKER, 1883)
publisher.publish(TOPIC, "New order placed!")

import time
time.sleep(2)
subscriber.loop_stop()
