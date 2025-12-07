from launch import LaunchDescription
from launch_ros.actions import Node
import os
from ament_index_python.packages import get_package_share_directory

def generate_launch_description():
    
    package_name = 'scara_robot'
    package_dir = get_package_share_directory(package_name)
    
    urdf_path = os.path.join(package_dir, 'urdf', 'scara.urdf')
    rviz_config = os.path.join(package_dir, 'rviz', 'scara.rviz')
    
    with open(urdf_path, 'r') as f:
        robot_desc = f.read()
    
    return LaunchDescription([
        Node(
            package='robot_state_publisher',
            executable='robot_state_publisher',
            name='robot_state_publisher',
            parameters=[{'robot_description': robot_desc}]
        ),
        
        Node(
            package='scara_robot',
            executable='move_scara',
            name='scara_mover'
        ),
        
        Node(
            package='joint_state_publisher_gui',
            executable='joint_state_publisher_gui',
            name='joint_state_publisher_gui'
        ),
        
        Node(
            package='rviz2',
            executable='rviz2',
            name='rviz2',
            arguments=['-d', rviz_config]
        )
    ])
