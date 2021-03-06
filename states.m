classdef states
    enumeration
        state0, detect_door, turn_then_detect, detect_then_turn,...
        door_left, door_right, door_left_and_right, door_forward,...
        follow_trajectory, corridor1, corridor2, corridor3, corridor4,...
        facing_up, facing_down, facing_left, facing_right,...
        first_substate, last_substate, last_state, no_state, ...
        turn_left, turn_right, turn, stop, determine_door_state, correct_position_state
    end
end