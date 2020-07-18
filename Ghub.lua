--R99 no recoil ads shoot
state=1;
waitkone=0;
k=5.2; --係數
rx={0,103,256,-948,1076,-231,1025,537,615,-102,-564,-256,512,-1485,512,743,1050,615,-871,-359,-1127,-1306,743,384,384,820,0}
ry={0,-2505,-1503,-2277,-3188,-3871,-3233,-2368,-3735,-3097,-1730,-4372,-547,-3552,-2004,-1548,-137,-592,-410,-729,-774,-2049,273,-1503,-683,729,0}
EnablePrimaryMouseButtonEvents(true)

function OnEvent(event,arg)
    swit(event,arg);
    recoil(event,arg);
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
            MoveMouseRelative( -rx[r]*k/1000 , -ry[r]*k/1000 );
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
