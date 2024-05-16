/// @description Smooth Interpolation between Two Numbers and Return Result

/// @param start_value
/// @desc The starting value
/// @default 0

/// @param end_value
/// @desc The ending value
/// @default 100

/// @param duration
/// @desc The duration of the interpolation (in seconds)
/// @default 1
function LERP(argument0, argument1, argument2){
var start_value = argument0;
var end_value = argument1;
var duration = argument2;

var lerp_value;

// Get the current time
var start_time = current_time;

// Loop until the interpolation is complete
repeat (1) {
    // Calculate the elapsed time
    var elapsed_time = current_time - start_time;
    
    // Check if the interpolation is complete
    if (elapsed_time >= duration * 1000000) { // Convert seconds to microseconds
        // Ensure the final value is reached
        lerp_value = end_value;
        break; // Exit the loop
    }
    
    // Update the interpolation time
    var time = elapsed_time / 1000000; // Convert microseconds to seconds
    
    // Perform linear interpolation
    lerp_value = lerp(start_value, end_value, time / duration);
    
    // You can also use lerp_value in your game to update positions, sizes, etc.
}

// Return the interpolated value as the result of the script
return lerp_value;
}