from launch import LaunchDescription
from launch_ros.actions import Node
import os

def generate_launch_description():
    
    urdf_path = os.path.join(
        os.path.dirname(__file__),
        '..', 'urdf', 'scara.urdf'
    )
    
    with open(urdf_path, 'r') as f:
        robot_desc = f.read()
    
    return LaunchDescription([
        Node(
            package='robot_state_publisher',
            executable='robot_state_publisher',
            name='robot_state_publisher',
            output='screen',
            parameters=[{'robot_description': robot_desc}]
        ),
        
        Node(
            package='scara_robot',
            executable='move_scara',
            name='scara_mover',
            output='screen'
        ),
        
        Node(
            package='rviz2',
            executable='rviz2',
            name='rviz2',
            arguments=['-d', os.path.join(os.path.dirname(__file__), '..', 'rviz', 'scara.rviz')]
        ),
        
        Node(
            package='joint_state_publisher_gui',
            executable='joint_state_publisher_gui',
            name='joint_state_publisher_gui'
        )
    ])