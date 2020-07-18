--R99 no recoil
--1445ms 27bullets 50ms/blt
--rx 26685,26788,27044,26096,27172,26941,27966,28503,29118,29016,28452,28196,28708,27223,27735,28478,29528,30143,29272,28913,27786,26480,27223,27607,27991,28811,28811
--ry 51599,49094,47591,45314,42126,38255,35022,32654,28919,25822,24092,19720,19173,15621,13617,12069,11932,11340,10930,10201,9427,7378,7651,6148,5465,6194,6194

state=1;
waitkone=0;
moneisclick=0;
k=5.5; --係數
--rx={0,-3,-3,5,5,5,-5,-5,-5,-5,-5          ,-3,-3,5,5,3,3,3,3,3,3          ,0,0,0,0,5,5,5      };
rx={0,103,256,-948,1076,-231,1025,537,615,-102,-564,-256,512,-1485,512,743,1050,615,-871,-359,-1127,-1306,743,384,384,820,0}
--ry={0,15,15,15,10,10,15,15,20,20,10       ,10,10,15,20,20,0,0,-20,-10,-10     ,0,0,0,0,-2,-2,-2      };
ry={0,-2505,-1503,-2277,-3188,-3871,-3233,-2368,-3735,-3097,-1730,-4372,-547,-3552,-2004,-1548,-137,-592,-410,-729,-774,-2049,273,-1503,-683,729,0}

EnablePrimaryMouseButtonEvents(true)
function OnEvent(event,arg)

    --OutputLogMessage("Event: "..event.." Arg: "..arg.."\n");

    if (event == "MOUSE_BUTTON_PRESSED" and arg == 1) then
        moneisclick=1;
    end
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 1) then
        moneisclick=0;
    end
    swit(event,arg);
    recoil(event,arg);
    --newrecoil(event,arg);

end

function swit(event,arg)
    
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 9) then
		if(state%2==1)then
			OutputLogMessage("ON\n");
            waitkone=1;
	        MoveMouseRelative(0,-10);
		else
            OutputLogMessage("OFF\n");
            waitkone=0;
            MoveMouseRelative(0,10);
		end
        state=(state+1)%2;
    end

end

function recoil(event,arg)
    r=1;
    if event == "MOUSE_BUTTON_PRESSED" and arg == 1 and waitkone == 1 then
        repeat
            MoveMouseRelative(-rx[r]*k/1000,-ry[r]*k/1000);
            local tm = GetRunningTime()
            local exiting
            repeat
                Sleep(50)
                exiting = not IsMouseButtonPressed(1)
            until exiting or GetRunningTime() - tm > 49
            r=r+1;
        until exiting or r>#rx
    end
end

function newrecoil(event,arg)
    r=1;
    if(arg == 1 and waitkone == 1)then
 
        --OutputLogMessage(arg..waitkone);
        repeat
            if (moneisclick == 1) then
                OutputLogMessage(moneisclick);
                MoveMouseRelative(-rx[r]*k/1000,-ry[r]*k/1000);
                Sleep(50);
                r=r+1;
                if(moneisclick == 0)then
                    break;
                end
            end
        until(moneisclick == 0 or r>#rx)

    end
end

function test(event,arg)
    PressMouseButton(2);
    a= tostring(IsMouseButtonPressed(2));
    return a;
end