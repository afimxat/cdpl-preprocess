classdef HandleObject < handle
    %HANDLEOBJECT1 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Object=[];
    end
    
    methods
        function obj=HandleObject(receivedObject)
            obj.Object=receivedObject;
        end
    end
    
end