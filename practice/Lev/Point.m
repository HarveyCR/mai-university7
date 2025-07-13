% Point.m
classdef Point
    properties
        x
        y
    end
    methods
        function obj = Point(x, y)
            % Constructor for Point class
            if nargin > 0
                obj.x = x;
                obj.y = y;
            else
                obj.x = 0;
                obj.y = 0;
            end
        end
    end
end