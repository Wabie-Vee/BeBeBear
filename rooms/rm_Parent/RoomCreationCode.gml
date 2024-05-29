if (!instance_exists(obj_Game)) {
    // Create the persistent object if it doesn't exist
    instance_create_layer(0, 0, "Instances", obj_Game);
}