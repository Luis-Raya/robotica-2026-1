from setuptools import setup

package_name = 'conversion_rpm'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='robousr',
    maintainer_email='robousr@todo.todo',
    description='Conversion de RPM a rad/s con señal senoidal',
    license='Apache License 2.0',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'rpm_publisher = conversion_rpm.rpm_publisher:main',
            'rpm_to_rads_converter = conversion_rpm.rpm_to_rads:main',
        ],
    },
)
