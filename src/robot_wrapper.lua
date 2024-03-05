local robot_wrapper = {}

--- Base ground sensor readings.
-- The base ground sensor reads the color of the floor. It is a list of 8 readings,
-- each containing a table composed of value and offset. The value is either 0 or 1,
-- where 0 means black (or dark gray), and 1 means white (or light gray). The offset
-- corresponds to the position read on the ground by the sensor. The position is expressed
-- as a 2D vector stemming from the center of the robot. The vector coordinates are in cm.
-- The difference between this sensor and the robot.motor_ground is that this sensor returns
-- binary readings (0 = black/1 = white), while robot.motor_ground can distinguish different
-- shades of gray.
-- @field value number The value read by the sensor (0 for black, 1 for white).
-- @field offset table The position read on the ground by the sensor, expressed as a 2D vector.
-- @field offset.x number The x-coordinate of the position vector (in cm).
-- @field offset.y number The y-coordinate of the position vector (in cm).
---@class BaseGroundReading
---@field value number
---@field offset {x: number, y: number}

--- List of base ground sensor readings.
---@return BaseGroundReading[]
function robot_wrapper.get_base_ground()
	-- Implementation should call the corresponding robot module function
	return robot.base_ground
end

--- Distance scanner sensor readings.
-- The distance scanner is a rotating device with four sensors. Two sensors are short-range (4cm to 30cm)
-- and two are long-range (20cm to 150cm). Each sensor returns up to 6 values every time step, for a total
-- of 24 readings (12 short-range and 12 long-range). Each reading is a table composed of angle in radians
-- and distance in cm. The distance value can also be -1 or -2. When it is -1, it means that the object detected
-- by the sensor is closer than the minimum sensor range (4cm for short-range, 20cm for long-range).
-- When a sensor returns -2, it's because no object was detected at all.
--
-- @field angle number The angle at which the object is detected (in radians).
-- @field distance number The distance to the detected object (in cm).
--
---@class DistanceScannerReading
---@field angle number
---@field distance number

--- List of distance scanner sensor readings.
---@type DistanceScannerReading[]

--- List of distance scanner sensor readings.
---@return DistanceScannerReading[]
function robot_wrapper.get_distance_scanner()
	return robot.distance_scanner
end

--- Enable the distance scanner.
function robot_wrapper.enable_distance_scanner()
	robot_wrapper.get_distance_scanner().enable()
end

--- Disable the distance scanner.
function robot_wrapper.disable_distance_scanner()
	robot_wrapper.get_distance_scanner().disable()
end

--- Set the angle of the distance scanner.
---@param angle number The angle to set (in radians).
function robot_wrapper.set_distance_scanner_angle(angle)
	robot_wrapper.get_distance_scanner().set_angle(angle)
end

--- Set the RPM of the distance scanner.
---@param rpm number The RPM to set.
function robot_wrapper.set_distance_scanner_rpm(rpm)
	robot_wrapper.get_distance_scanner().set_rpm(rpm)
end

--- Light sensor readings.
-- The light sensor allows the robot to detect light sources. The robot has 24 light sensors, equally distributed
-- in a ring around its body. Each sensor reading is composed of an angle in radians and a value in the range [0,1].
-- The angle corresponds to where the sensor is located in the body with respect to the front of the robot, which
-- is the local x axis. Regarding the value, 0 corresponds to no light being detected by a sensor, while values > 0
-- mean that light has been detected. The value increases as the robot gets closer to a light source.
--
-- @field angle number The angle at which the light source is detected (in radians).
-- @field value number The value representing the intensity of light detected (in the range [0,1]).
--
---@class LightSensorReading
---@field angle number
---@field value number

--- List of light sensor readings.
---@type LightSensorReading[]

--- List of light sensor readings.
---@return LightSensorReading[]
function robot_wrapper.get_light_sensor_readings()
	-- Implementation should call the corresponding robot module function
	return robot.light
end


--- Proximity sensor readings.
-- The proximity sensors detect objects around the robots. The sensors are 24 and are equally distributed 
-- in a ring around the robot body. Each sensor has a range of 10cm and returns a reading composed of an angle 
-- in radians and a value in the range [0,1]. The angle corresponds to where the sensor is located in the body 
-- with respect to the front of the robot, which is the local x axis. Regarding the value, 0 corresponds to no 
-- object being detected by a sensor, while values > 0 mean that an object has been detected. The value increases 
-- as the robot gets closer to the object.
--
-- @field angle number The angle at which an object is detected (in radians).
-- @field value number The value representing the proximity of the detected object (in the range [0,1]).
--
---@class ProximitySensorReading
---@field angle number
---@field value number

--- List of proximity sensor readings.
---@type ProximitySensorReading[]

--- List of proximity sensor readings.
---@return ProximitySensorReading[]
function robot_wrapper.get_proximity_sensor_readings()
    -- Implementation should call the corresponding robot module function
    return robot.proximity
end


--- Robot wheel motion control.
-- The real robot moves using two sets of wheels and tracks called treels. For simplicity, we treat the treels like normal wheels.
-- To move the robot, use set_velocity(l,r) where l and r are the left and right wheel velocity, respectively. By 'wheel velocity' 
-- we mean linear velocity. In other words, if you say set_velocity(5,5), the robot will move forward at 5cm/s.
-- You can get some information about robot motion and wheels, too. axis_length is the distance between the two wheels in cm. 
-- velocity_left and velocity_right store the current wheel velocity. distance_left and distance_right store the linear distance 
-- covered by the wheels in the last time step.
--
-- @field axis_length number The distance between the two wheels (in cm).
-- @field velocity_left number The current velocity of the left wheel (in cm/s).
-- @field velocity_right number The current velocity of the right wheel (in cm/s).
-- @field distance_left number The linear distance covered by the left wheel in the last time step (in cm).
-- @field distance_right number The linear distance covered by the right wheel in the last time step (in cm).
--
---@class WheelMotionControl
---@field axis_length number
---@field velocity_left number
---@field velocity_right number
---@field distance_left number
---@field distance_right number

--- Set the velocity of the robot wheels.
---@param l number The velocity of the left wheel (in cm/s).
---@param r number The velocity of the right wheel (in cm/s).
function robot_wrapper.set_velocity(l, r)
	robot.wheels.set_velocity(l, r)
end

--- Get information about robot motion and wheels.
---@return WheelMotionControl
function robot_wrapper.get_wheel_info()
    -- Implementation should call the corresponding robot module function
    return {
        axis_length = robot.wheels.axis_length,
        velocity_left = robot.wheels.velocity_left,
        velocity_right = robot.wheels.velocity_right,
        distance_left = robot.wheels.distance_left,
        distance_right = robot.wheels.distance_right
    }
end



return robot_wrapper
