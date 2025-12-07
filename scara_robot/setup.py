from setuptools import setup
import os
from glob import glob

package_name = 'scara_robot'

setup(
    name=package_name,
    version='1.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name, 'launch'), 
         glob(os.path.join('launch', '*.launch.py'))),
        (os.path.join('share', package_name, 'urdf'), 
         glob(os.path.join('urdf', '*'))),
        (os.path.join('share', package_name, 'rviz'), 
         glob(os.path.join('rviz', '*.rviz'))),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='alumno',
    maintainer_email='alumno@robotica.com',
    description='Robot SCARA para proyecto final',
    license='MIT',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'move_scara = scara_robot.move_scara:main',
        ],
    },
)
