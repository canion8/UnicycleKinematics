function [true_point] = correct_position(lidar_plot, true_point, odometry_point)

    global initial_true_point

    % coordinates of the top right corner of the corridor, necessary to
    % correct position
    top_right_corner = [ 15 10 ];
    
    [rho, theta] = get_rho_theta(lidar_plot);

    corridor = find_corridor(true_point);
    
    switch(corridor)
        
        case states.corridor1

            true_angle_lidar = theta + pi/2;
            
            if abs( wrapToPi(true_angle_lidar - true_point(3)) ) > ang_threshold 
                return
            end

            true_x_lidar = rho;

            if abs( true_point(1) - true_x_lidar ) > dist_threshold
                return
            end
            
            true_point(1) = true_dist_lidar;
            true_point(3) = true_angle_lidar;    
                
        case states.corridor2
            
            true_angle_lidar = theta;
            
            if abs( wrapToPi(true_angle_lidar - true_point(3)) ) > ang_threshold 
                return
            end
            
            true_y_lidar = top_right_corner(2) - rho;

            if abs( true_point(1) - true_y_lidar ) > dist_threshold
                return
            end
            
            true_point(2) = true_dist_lidar;            
            true_point(3) = true_angle_lidar;
            
        case states.corridor3
            
            true_angle_lidar = theta - pi/2;
            
            if abs( wrapToPi(true_angle_lidar - true_point(3)) ) > ang_threshold 
                return
            end
            
            true_x_lidar = top_right_corner(1) - rho;

            if abs( true_point(1) - true_x_lidar ) > dist_threshold
                return
            end
            
            true_point(1) = true_dist_lidar;            
            true_point(3) = true_angle_lidar;

        case states.corridor4
            
             true_angle_lidar = theta - pi;
            
            if abs( wrapToPi(true_angle_lidar - true_point(3)) ) > ang_threshold 
                return
            end
            
            true_y_lidar = top_right_corner(2) - rho;

            if abs( true_point(1) - true_y_lidar ) > dist_threshold
                return
            end
            
            true_point(2) = true_dist_lidar;            
            true_point(3) = true_angle_lidar;

    end

    first_ang = initial_true_point(3);
    initial_true_point = true_point(1:2,1) - [ cos(first_ang) -sin(first_ang) ; sin(first_ang) cos(first_ang) ] * odometry_point(1:2).' ;
    initial_true_point(3) = wrapToPi(true_point(3) - odometry_point(3));
    
    initial_true_point = initial_true_point.';
    
    disp('did a correction');


end