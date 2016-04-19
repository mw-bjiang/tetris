classdef (ConstructOnLoad) KeyPressEventData < event.EventData
    properties % ok to expose this property
        pKeyPressEventObj
    end
    
    methods
        function data = KeyPressEventData(eventdata)
            data.pKeyPressEventObj = eventdata;
        end % End of ctor
    end
end