#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import JointState
import math
import numpy as np

class ScaraBangBang(Node):
    def __init__(self):
        super().__init__('scara_bangbang')
        self.pub = self.create_publisher(JointState, '/joint_states', 10)
        
        # Parámetros IGUALES a MATLAB
        self.L1 = 0.5
        self.L2 = 0.5
        self.L3 = 0.3
        self.x_in = 0.4
        self.y_in = -0.1
        self.theta_in = math.pi/2
        self.x_fin = 0.0
        self.y_fin = -1.3
        self.theta_fin = -math.pi/2
        self.t_total = 20.0
        self.dt = 0.1
        self.current_time = 0.0
        
        self.timer = self.create_timer(self.dt, self.move)
        self.get_logger().info('SCARA Bang-Bang iniciado')
    
    def cinematica_inversa(self, x, y, theta):
        """Cinemática inversa IGUAL a MATLAB"""
        x3 = x - self.L3 * math.cos(theta)
        y3 = y - self.L3 * math.sin(theta)
        R = math.sqrt(x3**2 + y3**2)
        
        # Calcular theta2
        arg = (R**2 - self.L1**2 - self.L2**2) / (2 * self.L1 * self.L2)
        arg = max(-1.0, min(1.0, arg))  # Clip como en MATLAB
        theta2 = math.pi - math.acos(arg)
        
        # Calcular theta1
        alfa = math.acos((R**2 + self.L1**2 - self.L2**2) / (2 * self.L1 * R))
        phi = math.atan2(y3, x3)
        theta1 = alfa - phi
        
        # Calcular theta3
        theta3 = theta - theta1 - theta2
        
        return theta1, theta2, theta3
    
    def trayectoria_bangbang(self, t):
        """Trayectoria Bang-Bang Parabolic Blend IGUAL a MATLAB"""
        if t <= self.t_total / 2:
            x = self.x_in + (2 * t**2 / self.t_total**2) * (self.x_fin - self.x_in)
            y = self.y_in + (2 * t**2 / self.t_total**2) * (self.y_fin - self.y_in)
            theta = self.theta_in + (2 * t**2 / self.t_total**2) * (self.theta_fin - self.theta_in)
        else:
            x = self.x_fin + ((4 * t / self.t_total - 2 * t**2 / self.t_total**2) - 2) * (self.x_fin - self.x_in)
            y = self.y_fin + ((4 * t / self.t_total - 2 * t**2 / self.t_total**2) - 2) * (self.y_fin - self.y_in)
            theta = self.theta_fin + ((4 * t / self.t_total - 2 * t**2 / self.t_total**2) - 2) * (self.theta_fin - self.theta_in)
        
        return x, y, theta
    
    def move(self):
        if self.current_time <= self.t_total:
            # Calcular punto en trayectoria Bang-Bang
            x, y, theta = self.trayectoria_bangbang(self.current_time)
            
            # Cinemática inversa
            theta1, theta2, theta3 = self.cinematica_inversa(x, y, theta)
            
            # Índice de manipulabilidad (como en MATLAB)
            w = abs(math.sin(theta2))
            
            # Publicar
            msg = JointState()
            msg.header.stamp = self.get_clock().now().to_msg()
            msg.header.frame_id = "base_link"
            msg.name = ['link_1_joint', 'link_2_joint', 'link_3_joint']
            msg.position = [float(theta1), float(theta2), float(theta3)]
            
            self.pub.publish(msg)
            
            # Log cada 2 segundos
            if self.current_time % 2.0 < self.dt:
                self.get_logger().info(
                    f't={self.current_time:.1f}s, '
                    f'Pos=({x:.3f}, {y:.3f}), '
                    f'Ang=({theta1:.3f}, {theta2:.3f}, {theta3:.3f}), '
                    f'w={w:.3f}'
                )
            
            self.current_time += self.dt
        else:
            self.get_logger().info('Trayectoria Bang-Bang completada')
            self.timer.cancel()

def main():
    rclpy.init()
    node = ScaraBangBang()
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == '__main__':
    main()
