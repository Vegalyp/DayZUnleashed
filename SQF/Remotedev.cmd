move dayz_anim.pbo "E:\dev_unleashedclient\addons\client"
move dayz_code.pbo "E:\dev_unleashedclient\addons\client"
move dayz_communityassets.pbo "E:\dev_unleashedclient\addons\client"
move dayz_epoch.pbo "E:\dev_unleashedclient\addons\client"
move dayz_sfx.pbo "E:\dev_unleashedclient\addons\client"
move unleashed_pack.pbo "E:\dev_unleashedclient\addons\client"
move dayz.pbo "E:\dev_unleashedclient\addons\client"
move dayz_equip.pbo "E:\dev_unleashedclient\addons\client"
move dayz_vehicles.pbo "E:\dev_unleashedclient\addons\client"
move dayz_weapons.pbo "E:\dev_unleashedclient\addons\client"
move dayz_server.pbo "E:\dev_unleashedclient\addons\server"


ftp -i -s:u.ftp
del /q E:\dev_unleashedclient\addons\client\*.pbo
del /q E:\dev_unleashedclient\addons\server\*.pbo