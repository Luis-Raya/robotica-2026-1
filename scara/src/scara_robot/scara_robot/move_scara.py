#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import JointState
import math
import time

class SimpleScara(Node):
    def __init__(self):
        super().__init__('simple_scara')
        self.pub = self.create_publisher(JointState, '/joint_states', 10)
        self.timer = self.create_timer(0.1, self.move)
        self.angle = 0.0
        self.get_logger().info('SCARA listo')
    
    def move(self):
        msg = JointState()
        msg.header.stamp = self.get_clock().now().to_msg()
        msg.name = ['link_1_joint', 'link_2_joint', 'link_3_joint']
        
        self.angle += 0.1
        theta1 = math.sin(self.angle) * 0.5
        theta2 = math.cos(self.angle) * 0.5
        theta3 = math.sin(self.angle * 0.5) * 0.3
        
        msg.position = [theta1, theta2, theta3]
        self.pub.publish(msg)

def main():
    rclpy.init()
    node = SimpleScara()
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == '__main__':
    main()