function locks(msg)
text = nil
if msg and msg.content and msg.content.text then
xname =  (Redis:get(Zelzal.."Zelzal:Name:Bot") or "بووت") 
text = msg.content.text.text
if text:match("^"..xname.." (.*)$") then
text = text:match("^"..xname.." (.*)$")
end
end
local msg_chat_id = msg.chat_id
local msg_id = msg.id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender_id.user_id
if tonumber(msg.sender_id.user_id) == tonumber(Zelzal) then
return false
end
if text then
local neww = Redis:get(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg.chat_id..":"..text) or Redis:get(Zelzal.."All:Get:Reides:Commands:Group"..text)
if neww then
text = neww or text
end
end
-------------------------------------------------
if text == "تفعيل البنك عام" or text == "تفعيل لعبه البنك عام" then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
Redis:del(Zelzal.."lock_getpankiuserall") 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل لعبة البنك*","md",true )
end 
if text == "تعطيل البنك عام" or text == "تعطيل لعبه البنك عام" then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
Redis:set(Zelzal.."lock_getpankiuserall",true)  
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل لعبة البنك*","md",true )
end   
if text == "تفعيل البنك" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(4).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."lock_getpankiuser"..msg.chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل لعبة البنك*","md",true )
end 
if text == "تعطيل البنك" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(4).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."lock_getpankiuser"..msg.chat_id,true)  
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل لعبة البنك*","md",true )
end   
if text == "تفعيل الصوتيات العامه" or text == "تفعيل الصوتيات عام" or text == "تفعيل الصوت عام" then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
if not Redis:get(Zelzal.."lock_geamsAudio"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل الصوتيات عام*","md",true )
else 
Redis:del(Zelzal.."lock_geamsAudio"..msg.chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل الصوتيات عام*","md",true )
end 
end
if text == "تعطيل الصوتيات العامه" or text == "تعطيل الصوتيات عام" or text == "تعطيل الصوت عام" then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
if Redis:get(Zelzal.."lock_geamsAudio"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل الصوتيات عام*","md",true )
else
Redis:set(Zelzal.."lock_geamsAudio"..msg.chat_id,true)  
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل الصوتيات عام*","md",true )
end   
end
if text == "تفعيل الصوتيات" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."lock_geamsAudio1"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل الصوتيات*","md",true )
else 
Redis:del(Zelzal.."lock_geamsAudio1"..msg.chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل الصوتيات*","md",true )
end 
end
if text == "تعطيل الصوتيات" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."lock_geamsAudio1"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل الصوتيات*","md",true )
else
Redis:set(Zelzal.."lock_geamsAudio1"..msg.chat_id,true)  
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل الصوتيات*","md",true )
end   
end
if text == "تعطيل التحذير" or text == "تعطيل التحذيرات" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل التحذير","md",true )
else
Redis:del(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل التحذير","md",true )
end
end
if text == "تفعيل التحذير" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل التحذير","md",true )
else
Redis:set(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل التحذير","md",true )
end
end
if text == "تعطيل زوجني" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ امـر زوجنـي معطـل مسبقـاً","md",true )
else
Redis:del(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل زوجني","md",true )
end
end
if text == "تفعيل زوجني" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ امـر زوجنـي مفعـل مسبقـاً","md",true )
else
Redis:set(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل زوجني","md",true )
end
end
if text == "تفعيل التاك التلقائي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."AutoTag"..msg_chat_id) then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ امـر التاك التلقـائـي مفعـل مسبقـاً","md",true )
else
Redis:set(Zelzal.."AutoTag"..msg_chat_id,"on") 
Redis:setex(Zelzal.."AutoTagTime"..msg_chat_id,150,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل التاك التلقـائـي","md",true )
end
end
if text == "تعطيل التاك التلقائي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."AutoTag"..msg_chat_id) then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ امـر التاك التلقـائـي معطـل مسبقـاً","md",true )
else
Redis:del(Zelzal.."AutoTag"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل التاك التلقـائـي","md",true )
end
end
if text == "تفعيل شعر" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الشعر","md",true )
Redis:del(Zelzal.."Zelzal:sh3ir:Abs"..msg.chat_id) 
end
if text == "تعطيل شعر" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الشعر","md",true )
Redis:set(Zelzal.."Zelzal:sh3ir:Abs"..msg.chat_id,true)  
end
if text == "تفعيل البايو" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل البايو","md",true )
Redis:del(Zelzal.."Zelzal:biousers"..msg.chat_id) 
end
if text == "تعطيل البايو" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل البايو","md",true )
Redis:set(Zelzal.."Zelzal:biousers"..msg.chat_id,true)  
end
if text == "تعطيل التسليه" or text == "قفل التسليه" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."trfeh"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل التسليه مسبقاً","md",true )
else
Redis:set(Zelzal.."trfeh"..msg.chat_id,"true")
Redis:set(Zelzal.."amrthshesh"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل التسليه","md",true )
end
end
if text == "تفعيل التسليه" or text == "فتح التسليه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."trfeh"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل التسليه مسبقاً","md",true )
else
Redis:del(Zelzal.."trfeh"..msg.chat_id)
Redis:del(Zelzal.."amrthshesh"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل التسليه","md",true )
end
end
if text == "تعطيل ردود البوت" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."replayallbot"..msg.chat_id) then
Redis:del(Zelzal.."Zelzal:zelzal:iraqq"..msg.chat_id) 
Redis:del(Zelzal.."Zelzal:zelzal:yemenn"..msg.chat_id) 
Redis:del(Zelzal.."Zelzal:zelzal:egibtt"..msg.chat_id) 
Redis:del(Zelzal.."Zelzal:zelzal:syriaa"..msg.chat_id) 
Redis:del(Zelzal.."Zelzal:zelzal:ksaa"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل ردود البوت مسبقاً","md",true )
else
Redis:del(Zelzal.."replayallbot"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:zelzal:iraqq"..msg.chat_id) 
Redis:del(Zelzal.."Zelzal:zelzal:yemenn"..msg.chat_id) 
Redis:del(Zelzal.."Zelzal:zelzal:egibtt"..msg.chat_id) 
Redis:del(Zelzal.."Zelzal:zelzal:syriaa"..msg.chat_id) 
Redis:del(Zelzal.."Zelzal:zelzal:ksaa"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل ردود البوت","md",true )
end
end
if text == "تفعيل ردود البوت" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."replayallbot"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل ردود البوت مسبقاً","md",true )
else
Redis:set(Zelzal.."replayallbot"..msg.chat_id,true)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل ردود البوت","md",true )
end
end
if text == "تعطيل الحظر المحدود" or text == "تعطيل منع التصفيه" or text == "تعطيل منع التصفير" or text == "تعطيل مكافح التصفير" or text == "فتح الخيانه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(4).." ) ","md",true)  
end
if Redis:get(Zelzal.."spammkick"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم فتـح الخيانـه مسبقاً*","md",true )
else
Redis:set(Zelzal.."spammkick"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امـر قفـل الخيانـه","md",true )
end
end
if text == "تفعيل الحظر المحدود" or text == "تفعيل منع التصفيه" or text == "تفعيل منع التصفير" or text == "تفعيل مكافح التصفير" or text == "قفل الخيانه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(4).." ) ","md",true)  
end
if not Redis:get(Zelzal.."spammkick"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم قفـل الخيانـه مسبقاً*","md",true )
else
Redis:del(Zelzal.."spammkick"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امـر قفـل الخيانـه","md",true )
end
end
if text == "تفعيل تاك عام" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if (Redis:get(Zelzal.."tagall@all"..msg.chat_id) == "open") then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر @all مسبقاً","md",true )
else
Redis:set(Zelzal.."tagall@all"..msg.chat_id,"open") 
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر @all","md",true )
end
end
if text == "تعطيل تاك عام" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if (Redis:get(Zelzal.."tagall@all"..msg.chat_id) == "close") then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر @all مسبقاً","md",true )
else
Redis:set(Zelzal.."tagall@all"..msg.chat_id,"close") 
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر @all","md",true )
end
end
if text == "تفعيل التاك" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if (Redis:get(Zelzal.."tagallgroup"..msg.chat_id) == "open") then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر التاق مسبقاً","md",true )
else
Redis:set(Zelzal.."tagallgroup"..msg.chat_id,"open") 
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر التاق","md",true )
end
end
if text == "تعطيل التاك" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if (Redis:get(Zelzal.."tagallgroup"..msg.chat_id) == "close") then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر التاق مسبقاً","md",true )
else
Redis:set(Zelzal.."tagallgroup"..msg.chat_id,"close") 
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر التاق","md",true )
end
end
if text == "تعطيل الصيغ" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."kadmeat"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل اوامر الصيغ مسبقاً","md",true )
else
Redis:set(Zelzal.."kadmeat"..msg.chat_id,"true")
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل اوامر الصيغ","md",true )
end
end
if text == "تفعيل الصيغ" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."kadmeat"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل اوامر التحويلات مسبقاً","md",true )
else
Redis:del(Zelzal.."kadmeat"..msg.chat_id)
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل اوامر الصيغ","md",true )
end
end
if text == "تعطيل انطق" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."intg"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر انطق مسبقاً","md",true )
else
Redis:set(Zelzal.."intg"..msg.chat_id,"true")
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر انطق","md",true )
end
end
if text == "تفعيل انطق" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."intg"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر انطق مسبقاً","md",true )
else
Redis:del(Zelzal.."intg"..msg.chat_id)
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر انطق","md",true )
end
end
if text == "تعطيل الابراج" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."brjj"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر الابراج مسبقاً","md",true )
else
Redis:set(Zelzal.."brjj"..msg.chat_id,"true")
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر الابراج","md",true )
end
end
if text == "تفعيل الابراج" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."brjj"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر الابراج مسبقاً","md",true )
else
Redis:del(Zelzal.."brjj"..msg.chat_id)
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر الابراج","md",true )
end
end
if text == "تعطيل اسمي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."idnotmemname"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر اسمي مسبقاً","md",true )
else
Redis:set(Zelzal.."idnotmemname"..msg.chat_id,"true")
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر اسمي ","md",true )
end
end
if text == "تفعيل اسمي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."idnotmemname"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر اسمي مسبقاً","md",true )
else
Redis:del(Zelzal.."idnotmemname"..msg.chat_id)
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر اسمي ","md",true )
end
end
if text == "تعطيل البايو" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."idnotmembio"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر البايو مسبقاً","md",true )
else
Redis:set(Zelzal.."idnotmembio"..msg.chat_id,"true")
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر البايو ","md",true )
end
end
if text == "تفعيل البايو" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."idnotmembio"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر البايو مسبقاً","md",true )
else
Redis:del(Zelzal.."idnotmembio"..msg.chat_id)
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر البايو ","md",true )
end
end
if text == "تعطيل ايدي العضو" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."idnotmem"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر ايدي العضو مسبقاً","md",true )
else
Redis:set(Zelzal.."idnotmem"..msg.chat_id,"true")
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تعطيل امر ايدي العضو","md",true )
end
end
if text == "تفعيل ايدي العضو" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."idnotmem"..msg.chat_id)  then
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر ايدي العضو مسبقاً","md",true )
else
Redis:del(Zelzal.."idnotmem"..msg.chat_id)
send(msg_chat_id,msg_id, GetByName(msg).."⇜ تم تفعيل امر ايدي العضو","md",true )
end
end
if text == "تفعيل متحركه" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل المتحركه","md",true )
Redis:del(Zelzal.."Abs:gif:Abs"..msg.chat_id) 
end
if text == "تعطيل متحركه" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل المتحركه","md",true )
Redis:set(Zelzal.."Abs:gif:Abs"..msg.chat_id,true)  
end
if text == "تفعيل ميمز" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الميمز","md",true )
Redis:del(Zelzal.."Abs:memz:Abs"..msg.chat_id) 
end
if text == "تعطيل ميمز" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الميمز","md",true )
Redis:set(Zelzal.."Abs:memz:Abs"..msg.chat_id,true)  
end
if text == "تفعيل ريمكس" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الريمكس","md",true )
Redis:del(Zelzal.."Abs:Remix:Abs"..msg.chat_id) 
end
if text == "تعطيل ريمكس" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الريمكس","md",true )
Redis:set(Zelzal.."Abs:Remix:Abs"..msg.chat_id,true)  
end
if text == "تفعيل صوره" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الصوره","md",true )
Redis:del(Zelzal.."Abs:Photo:Abs"..msg.chat_id) 
end
if text == "تعطيل صوره" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الصوره","md",true )
Redis:set(Zelzal.."Abs:Photo:Abs"..msg.chat_id,true)  
end
if text == "تفعيل انمي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل انمي","md",true )
Redis:del(Zelzal.."Abs:Anime:Abs"..msg.chat_id) 
end
if text == "تعطيل انمي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل انمي","md",true )
Redis:set(Zelzal.."Abs:Anime:Abs"..msg.chat_id,true)  
end
if text == "تفعيل فلم" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل فلم","md",true )
Redis:del(Zelzal.."Abs:Movies:Abs"..msg.chat_id) 
end
if text == "تعطيل فلم" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل فلم","md",true )
Redis:set(Zelzal.."Abs:Movies:Abs"..msg.chat_id,true)  
end
if text == "تفعيل مسلسل" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل مسلسل","md",true )
Redis:del(Zelzal.."Abs:Series:Abs"..msg.chat_id) 
end
if text == "تعطيل مسلسل" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل مسلسل","md",true )
Redis:set(Zelzal.."Abs:Series:Abs"..msg.chat_id,true)  
end
if text == "تفعيل التحقق" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:joinet"..msg_chat_id,true) 
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل التحقق","md",true )
end
if text == "تعطيل التحقق" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:joinet"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل التحقق","md",true )
end
if text == "تعطيل رتب التسليه" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."Redis:setRt"..msg.chat_id)  then
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل رتب التسليه مسيقاً","md",true )
else
Redis:set(Zelzal.."Redis:setRt"..msg.chat_id,"true")
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل رتب التسليه","md",true )
end
end
if text == "تفعيل رتب التسليه" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."Redis:setRt"..msg.chat_id)  then
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل رتب التسليه مسبقاً","md",true )
else
Redis:del(Zelzal.."Redis:setRt"..msg.chat_id)
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل رتب التسليه","md",true )
end
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Chat:Channel:Join:Name"..msg.chat_id), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Chat:Channel:Join"..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Channel:Join:Name"), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Channel:Join")}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
if TextMsg == "الرابط" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:Link"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الرابط","md",true )
end
if TextMsg == "الترحيب" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الترحيب","md",true )
end
if TextMsg == "الايدي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:Aiid"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل الايدي معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:Aiid"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل الايدي معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:Aiid"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل الايدي معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:Aiid"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل الايدي معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:Id"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل الايدي*","md",true )
end
if TextMsg == "الايدي بالصوره" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(4).." ) ","md",true)  
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:Aiid"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل الايدي معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:Aiid"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل الايدي معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:Aiid"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل الايدي معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:Aiid"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل الايدي معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل الايدي بالصوره*","md",true )
end
if TextMsg == "الردود" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Chat:Channel:Join:Name"..msg.chat_id), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Chat:Channel:Join"..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Channel:Join:Name"), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Channel:Join")}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
Redis:set(Zelzal.."Zelzal:Status:Reply"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل الردود*","md",true )
end
if TextMsg == "الردود العامه" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Chat:Channel:Join:Name"..msg.chat_id), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Chat:Channel:Join"..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Channel:Join:Name"), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Channel:Join")}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
Redis:set(Zelzal.."Zelzal:Status:ReplySudo"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل الردود العامه*","md",true )
end
if TextMsg == "الحظر" or TextMsg == "الطرد" or TextMsg == "التقييد" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Chat:Channel:Join:Name"..msg.chat_id), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Chat:Channel:Join"..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Channel:Join:Name"), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Channel:Join")}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
Redis:set(Zelzal.."Zelzal:Status:BanId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الطرد - الحظر - الكتم","md",true )
end
if TextMsg == "الرفع" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الرفع","md",true )
end
if TextMsg == "الالعاب" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:Games"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الالعاب","md",true )
end
if TextMsg == "اطردني" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:KickMe"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل اطردني","md",true )
end
if TextMsg == "البوت الخدمي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
Redis:set(Zelzal.."Zelzal:BotFree",true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل البوت الخدمي","md",true )
end
if TextMsg == "التواصل" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
Redis:set(Zelzal.."Zelzal:TwaslBot",true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل التواصل داخل البوت","md",true )
end
end
if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Chat:Channel:Join:Name"..msg.chat_id), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Chat:Channel:Join"..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = "inline",data = {{{text = Redis:get(Zelzal.."Zelzal:Channel:Join:Name"), url = "t.me/"..Redis:get(Zelzal.."Zelzal:Channel:Join")}, },}}
return send(msg.chat_id,msg.id,"\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*","md",false, false, false, false, reply_markup)
end
if TextMsg == "الرابط" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:Link"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الرابط","md",true )
end
if TextMsg == "الترحيب" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الترحيب","md",true )
end
if TextMsg == "الايدي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:Id"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل الايدي*","md",true )
end
if TextMsg == "الايدي بالصوره" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل الايدي بالصوره*","md",true )
end
if TextMsg == "الردود" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:Reply"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الردود","md",true )
end
if TextMsg == "الردود العامه" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
Redis:del(Zelzal.."Zelzal:Status:ReplySudo"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الردود العامه","md",true )
end
if TextMsg == "الحظر" or TextMsg == "الطرد" or TextMsg == "التقييد" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الطرد - الحظر - الكتم","md",true )
end
if TextMsg == "الرفع" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الرفع","md",true )
end
if TextMsg == "الالعاب" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:Games"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الالعاب","md",true )
end
if TextMsg == "اطردني" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:KickMe"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل اطردني","md",true )
end
if TextMsg == "البوت الخدمي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل البوت الخدمي","md",true )
end
Redis:del(Zelzal.."Zelzal:BotFree") 
return send(msg_chat_id,msg_id,"⇜ تم تعطيل البوت الخدمي ","md",true)
end
if TextMsg == "التواصل" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
Redis:del(Zelzal.."Zelzal:TwaslBot") 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل التواصل داخل البوت","md",true )
end
end
if text == "تعطيل امسح" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر امسح","md",true )
else
Redis:del(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر امسح","md",true )
end
end
if text == "تفعيل امسح" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر امسح","md",true )
else
Redis:set(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر امسح","md",true )
end
end
if text == "تفعيل الالعاب للمالكين" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(8).." ) ","md",true)  
end
Redis:del(Zelzal.."Zelzal:Status:Games:malk"..msg_chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الالعاب المالكين","md",true )
end
if text == "تعطيل الالعاب للمالكين" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(8).." ) ","md",true)  
end
Redis:set(Zelzal.."Zelzal:Status:Games:malk"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الالعاب المالكين","md",true )
end
if text == "تفعيل ردود البوت عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
Redis:del(Zelzal.."Zelzal:Status:repleall") 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل ردود البوت عام","md",true )
end
if text == "تعطيل ردود البوت عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(1).." ) ","md",true)  
end
Redis:set(Zelzal.."Zelzal:Status:repleall",true) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل ردود البوت عام","md",true )
end
if text == "تعطيل المسح التلقائي" or text == "تعطيل التنظيف التلقائي" or text == "قفل التنظيف التلقائي" or text == "قفل المسح التلقائي" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Status:Del:Media"..msg.chat_id)
 send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل المسح التلقائي","md",true )
return false
end 
if text == "تفعيل المسح التلقائي" or text == "تفعيل التنظيف التلقائي" or text == "فتح التنظيف التلقائي" or text == "فتح المسح التلقائي" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:Del:Media"..msg.chat_id,true)
send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل المسح التلقائي .. بنجاح ✅ *","md",true)
return false
end
if text == "تفعيل نزلني" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر نزلني","md",true )
Redis:del(Zelzal.."Zelzal:Nzlne:Abs"..msg.chat_id) 
end
if text == "تعطيل نزلني" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر نزلني","md",true )
Redis:set(Zelzal.."Zelzal:Nzlne:Abs"..msg.chat_id,true)  
end
if text == "تعطيل صورتي" or text == "تعطيل افتاري" or text == "قفل صورتي" or text == "قفل افتاري" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."myphoto"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر صورتي .. مسبقاً","md",true )
else
Redis:set(Zelzal.."myphoto"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر صورتي","md",true )
end
end
if text == "تفعيل صورتي" or text == "تفعيل افتاري" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:Aftary"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل افتاري معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:Aftary"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل افتاري معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:Aftary"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل افتاري معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:Aftary"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تفعيل افتاري معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not Redis:get(Zelzal.."myphoto"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر صورتي .. مسبقاً","md",true )
else
Redis:del(Zelzal.."myphoto"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر صورتي","md",true )
end
end
if text == "تفعيل قول" or text == "تفعيل قولي" or text == "تفعيل كول" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."kolklma"..msg.chat_id) then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر قول .. مسبقـاً","md",true )
else
Redis:set(Zelzal.."kolklma"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر قول","md",true )
end
end
if text == "تعطيل قول" or text == "تعطيل قولي" or text == "تعطيل كول" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."kolklma"..msg.chat_id) then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر قول .. مسبقـاً","md",true )
else
Redis:del(Zelzal.."kolklma"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر قول","md",true )
end
end
if text == "تعطيل حساب العمر" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."myages"..msg.chat_id) then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل حساب العمر","md",true )
else
Redis:set(Zelzal.."myages"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل حساب العمر","md",true )
end
end
if text == "تفعيل حساب العمر" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."myages"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل حساب العمر","md",true )
else
Redis:del(Zelzal.."myages"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل حساب العمر","md",true )
end
end
if text == "تعطيل اغنيه" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:get(Zelzal.."myniknea"..msg.chat_id) then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر اغنيه","md",true )
else
Redis:set(Zelzal.."myniknea"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر اغنيه","md",true )
end
end
if text == "تفعيل اغنيه" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if not Redis:get(Zelzal.."myniknea"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر اغنيه","md",true )
else
Redis:del(Zelzal.."myniknea"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر اغنيه","md",true )
end
end
-----------------
if text == "تفعيل البلاغات" or text == "تفعيل بلاغات" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل البلاغات","md",true )
Redis:set(Zelzal.."rebomsg"..msg.chat_id,true)
end
if text == "تعطيل البلاغات" or text == "تعطيل بلاغات" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل البلاغات","md",true )
Redis:del(Zelzal.."rebomsg"..msg.chat_id)
end
-----------------
if text == "تفعيل الشعار" or text == "تفعيل شعار" or text == "تفعيل التوحيد" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل شعار القروب","md",true )
Redis:set(Zelzal.."Bots:Lock:ProNames"..msg.chat_id,true)
end
if text == "تعطيل الشعار" or text == "تعطيل شعار" or text == "تعطيل التوحيد" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل شعار القروب","md",true )
Redis:del(Zelzal.."Bots:Lock:ProNames"..msg.chat_id)
end
if text == "تفعيل التفاعل" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."lock_altfael"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر التفاعل","md",true )
else 
Redis:del(Zelzal.."lock_altfael"..msg.chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر التفاعل","md",true )
end 
end
if text == "تعطيل التفاعل" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."lock_altfael"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر التفاعل","md",true )
else
Redis:set(Zelzal.."lock_altfael"..msg.chat_id,true)  
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر التفاعل","md",true )
end   
end
if text == "تفعيل نداء المالك" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(8).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."lock_getadmin"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ نداء المالك مفعـل مسبقـاً","md",true )
else 
Redis:del(Zelzal.."lock_getadmin"..msg.chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل امر نداء المالك","md",true )
end 
end
if text == "تعطيل نداء المالك" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(8).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."lock_getadmin"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ نداء المالك معطـل مسبقـاً","md",true )
else
Redis:set(Zelzal.."lock_getadmin"..msg.chat_id,true)  
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل امر نداء المالك","md",true )
end   
end
if text == "تفعيل الردود المتعدده" or text == "تفعيل الردود المتعددة" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal.."lock_repleyadded"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الردود المتعدده","md",true )
else 
Redis:del(Zelzal.."lock_repleyadded"..msg.chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل الردود المتعدده","md",true )
end 
end
if text == "تعطيل الردود المتعدده" or text == "تعطيل الردود المتعددة" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(6).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."lock_repleyadded"..msg.chat_id) then 
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الردود المتعدده","md",true )
else
Redis:set(Zelzal.."lock_repleyadded"..msg.chat_id,true)  
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل الردود المتعدده*","md",true )
end   
end
if text == "تفعيل الاوامر" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:Games"..msg_chat_id,true) 
Redis:set(Zelzal..'tagallgroup'..msg.chat_id,'open') 
Redis:set(Zelzal..'tagall@all'..msg.chat_id,'open') 
Redis:del(Zelzal.."knele"..msg.chat_id)
Redis:set(Zelzal.."Zelzal:Status:Link"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:BanId"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:ReplySudo"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:Reply"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:Id"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:SetId"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:KickMe"..msg_chat_id,true) 
Redis:set(Zelzal.."replayallbot"..msg.chat_id,true)
Redis:del(Zelzal.."amrthshesh"..msg.chat_id)
Redis:del(Zelzal.."trfeh"..msg.chat_id)
Redis:del(Zelzal.."spammkick"..msg.chat_id)
Redis:del(Zelzal.."intg"..msg.chat_id)
Redis:del(Zelzal.."kadmeat"..msg.chat_id)
Redis:del(Zelzal.."zhrfa"..msg.chat_id)
Redis:del(Zelzal.."brjj"..msg.chat_id)
Redis:del(Zelzal.."idnotmembio"..msg.chat_id)
Redis:del(Zelzal.."idnotmem"..msg.chat_id)
Redis:del(Zelzal..'lock_geamsAudio1'..msg.chat_id) 
Redis:del(Zelzal..'lock_geamsAudio'..msg.chat_id) 
Redis:del(Zelzal.."idnotmemname"..msg.chat_id)
Redis:del(Zelzal.."idnotmembio"..msg.chat_id)
Redis:set(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id,"true")
Redis:set(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,"⇜ تم تفعيل جميع الاوامر" )
end
-----------------
if text == "فتح الهمسه" or text == "تفعيل الهمسه" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."zed:hms"..msg_chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الهمسه .. بنجـاح").unLock,"md",true)  
end
if text == "تعطيل الهمسه" or text == "قفل الهمسه" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."zed:hms"..msg_chat_id,"off")
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الهمسه .. بنجـاح").Lock,"md",true)  
end
if text == "تفعيل اهمسلي" or text == "فتح اهمسلي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."zed:ehmsli"..msg_chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح اهمسلي .. بنجـاح").unLock,"md",true)  
end
if text == "قفل اهمسلي" or text == "تعطيل اهمسلي" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."zed:ehmsli"..msg_chat_id,"off")
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل اهمسلي .. بنجـاح").Lock,"md",true)  
end
if text == "تفعيل زاجل" or text == "فتح زاجل" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."zed:zagel"..msg_chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح زاجل .. بنجـاح").unLock,"md",true)  
end
if text == "قفل زاجل" or text == "تعطيل زاجل" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."zed:zagel"..msg_chat_id,"off")
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل زاجل .. بنجـاح").Lock,"md",true)  
end
if text == "قفل الحمايه" or text =="قفل الحماية" or text =="تفعيل الحمايه" or text =="تفعيل الحماية" or text =="تفعيل حمايه" or text == "قفل التفليش" or text == "تفعيل الحمايه 2" then 
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:tphlesh"..msg_chat_id,true) 
Redis:del(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id)
Redis:set(Zelzal.."myphoto"..msg.chat_id,"true")
Redis:set(Zelzal.."porn"..msg.chat_id,"true")
Redis:del(Zelzal.."spammkick"..msg.chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم تفعيل الحماية بنجاح").Lock,"md",true)  
return false
end 
if text == "فتح الحمايه" or text =="فتح الحماية" or text =="تعطيل الحمايه" or text =="تعطيل الحماية" or text =="تعطيل حمايه" or text == "فتح التفليش" or text == "تعطيل الحمايه 2" then 
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
Redis:del(Zelzal.."Zelzal:Lock:tphlesh"..msg_chat_id)  
Redis:set(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id,true)
Redis:del(Zelzal.."myphoto"..msg_chat_id)
Redis:del(Zelzal.."porn"..msg_chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم تعطيل الحماية").unLock,"md",true)  
return false
end
if text == "قفل التفليش" or text == "تفعيل الحمايه 2" then 
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:tphlesh"..msg_chat_id,true) 
Redis:del(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id)
Redis:set(Zelzal.."myphoto"..msg.chat_id,"true")
Redis:set(Zelzal.."porn"..msg.chat_id,"true")
Redis:del(Zelzal.."spammkick"..msg.chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفـل جميـع طـرق التفليـش .. بنجـاح").Lock,"md",true)  
return false
end 
if text == "فتح التفليش" or text == "تعطيل الحمايه 2" then 
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id,true)
Redis:del(Zelzal.."myphoto"..msg_chat_id)
Redis:del(Zelzal.."porn"..msg_chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتـح التفليـش .. بنجـاح").unLock,"md",true)  
return false
end
if text == "قفل الاباحي" or text == "قفل اباحي" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
if Redis:get(Zelzal..'porn'..msg.chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الاباحي مغلـق بالفعـل .. مسبقـاً ☑️\n⇜ كاشف الاباحي الذكـي مفعـل مسبقـاً على 💡 :\n⇜ الايدي بصورة + افتاري\n⇜ تستطيع الان تركهمـا مفتوحـين .. بأمـآن 🛡️*","md",true)
end
Redis:set(Zelzal.."porn"..msg.chat_id,"true")
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم تفعيـل حـذف الاباحي .. بنجـاح ☑️\n⇜ كاشف الاباحي الذكـي الان مفعـل على 💡 :\n⇜ الايدي بصورة + افتاري\n⇜ تستطيع الان تركهمـا مفتوحـين .. بأمـآن 🛡️").Lock,"md",true)
return false
end 
if text == "فتح الاباحي" or text == "فتح اباحي" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal..'porn'..msg.chat_id) then
return send(msg.chat_id,msg.id,"*⇜ الاباحي مفتـوح بالفعـل .. مسبقـاً*\n☑️","md",true)
end
Redis:del(Zelzal.."porn"..msg_chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الاباحي .. بنجـاح☑️").unLock,"md",true)  
return false
end
---------------------- Dev ZilZal ----------------------
if text == "تحكم الحظر" or text == "تحكم الطرد" or text == "تعطيل امر الحظر" or text == "تعطيل امر حظر" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ الحظر ⌡\n⇜ قم باختيار الرتب التي تريد منعها من الحظر 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر الحظر عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelasban'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelasban'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelassban'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelasssban'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelassssban'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر الحظر" or text == "تفعيل امر حظر" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ الحظر ⌡\n⇜ قم باختيار الرتب التي تريد الغاء منعها من الحظر 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم الغاء منع امر الحظر عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelesban'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelesban'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelessban'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelesssban'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelessssban'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تحكم الكتم" or text == "تعطيل امر الكتم" or text == "تعطيل امر كتم" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ الكتم ⌡\n⇜ قم باختيار الرتب التي تريد منعها من الكتم 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر الكتم عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelasmute'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelasmute'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelassmute'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelasssmute'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelassssmute'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر الكتم" or text == "تفعيل امر كتم" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ الكتم ⌡\n⇜ قم باختيار الرتب التي تريد الغاء منعها من الكتم 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم الغاء منع امر الكتم عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelesmute'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelesmute'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelessmute'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelesssmute'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelessssmute'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تحكم الرفع" or text == "تعطيل امر الرفع" or text == "تعطيل امر رفع" or text == "قفل امر الرفع" or text == "قفل امر رفع" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ الرفع ⌡\n⇜ قم باختيار الرتب التي تريد منعها من الرفع 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر الرفع عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن الاساسيين', data = msg.sender_id.user_id..'/zzzelasup'},},
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelasup'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelasup'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelassup'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelasssup'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر الرفع" or text == "تفعيل امر رفع" or text == "فتح امر الرفع" or text == "فتح امر رفع" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
Redis:del (Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) 
Redis:del (Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) 
Redis:del (Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) 
Redis:del (Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) 
Redis:del (Zelzal.."Zelzal:Managers:UpId"..msg_chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح امـر الرفـع .. بنجـاح").unLock,"md",true)  
return false
end 
---------------------- Dev ZilZal ----------------------
if text == "تحكم التنزيل" or text == "تعطيل امر التنزيل" or text == "تعطيل امر تنزيل" or text == "قفل امر التنزيل" or text == "قفل امر تنزيل" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ التنزيل ⌡\n⇜ قم باختيار الرتب التي تريد منعها من التنزيل 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر التنزيل عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن الاساسيين', data = msg.sender_id.user_id..'/zzzelasdw'},},
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelasdw'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelasdw'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelassdw'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelasssdw'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر التنزيل" or text == "تفعيل امر تنزيل" or text == "فتح امر التنزيل" or text == "فتح امر تنزيل" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
Redis:del (Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) 
Redis:del (Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) 
Redis:del (Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) 
Redis:del (Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) 
Redis:del (Zelzal.."Zelzal:Managers:DWId"..msg_chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح امـر التنزيـل .. بنجـاح").unLock,"md",true)  
return false
end 
---------------------- Dev ZilZal ----------------------
if text == "تحكم مسح رد" or text == "تعطيل امر مسح رد" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ مسح رد ⌡\n⇜ قم باختيار الرتب التي تريد منعها من مسح رد 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر مسح رد عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelasrad'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelasrad'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelassrad'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelasssrad'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelassssrad'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر مسح رد" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ مسح رد ⌡\n⇜ قم باختيار الرتب التي تريد الغاء منعها من مسح رد 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم الغاء منع امر مسح رد عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelesrad'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelesrad'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelessrad'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelesssrad'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelessssrad'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تحكم تثبيت" or text == "تعطيل امر تثبيت" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ تثبيت ⌡\n⇜ قم باختيار الرتب التي تريد منعها من تثبيت ?? \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر تثبيت عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelaspin'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelaspin'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelasspin'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelassspin'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelasssspin'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر تثبيت" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ تثبيت ⌡\n⇜ قم باختيار الرتب التي تريد الغاء منعها من تثبيت 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم الغاء منع امر تثبيت عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelespin'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelespin'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelesspin'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelessspin'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelesssspin'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تحكم همسه" or text == "تعطيل امر الهمسه" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ همسه ⌡\n⇜ قم باختيار الرتب التي تريد منعها من همسه 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر همسه عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelashms'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelashms'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelasshms'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelassshms'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelasssshms'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر همسه" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ همسه ⌡\n⇜ قم باختيار الرتب التي تريد الغاء منعها من همسه 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم الغاء منع امر همسه عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzeleshms'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zeleshms'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelesshms'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelessshms'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelesssshms'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تحكم اضف رد" or text == "تعطيل امر اضف رد" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ اضف رد ⌡\n⇜ قم باختيار الرتب التي تريد منعها من اضف رد 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر اضف رد عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelasarad'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelasarad'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelassarad'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelasssarad'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelassssarad'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر اضف رد" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ اضف رد ⌡\n⇜ قم باختيار الرتب التي تريد الغاء منعها من اضف رد 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم الغاء منع امر اضف رد عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelesarad'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelesarad'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelessarad'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelesssarad'},},
{{text = 'الادمنيـه', data = msg.sender_id.user_id..'/zelessssarad'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تعطيل امر تفعيل افتاري" or text == "تعطيل امر تفعيل صورتي" or text == "تعطيل امر فتح افتاري" or text == "تعطيل امر فتح صورتي" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ تفعيل افتاري ⌡\n⇜ قم باختيار الرتب التي تريد منعها من تفعيل افتاري 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر تفعيل افتاري عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelasaftr'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelasaftr'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelassaftr'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelasssaftr'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر تفعيل افتاري" or text == "تفعيل امر تفعيل صورتي" or text == "تفعيل امر فتح افتاري" or text == "تفعيل امر فتح صورتي" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ تفعيل افتاري ⌡\n⇜ قم باختيار الرتب التي تريد الغاء منعها من تفعيل افتاري 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم الغاء منع امر تفعيل افتاري عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelesaftr'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelesaftr'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelessaftr'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelesssaftr'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تعطيل امر تعطيل الايدي" or text == "تعطيل امر تفعيل الايدي بالصوره" or text == "تعطيل امر فتح الايدي" or text == "تعطيل امر فتح الايدي بالصوره" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ تعطيل الايدي ⌡\n⇜ قم باختيار الرتب التي تريد منعها من تعطيل الايدي 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم منع امر تعطيل الايدي عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelasiid'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelasiid'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelassiid'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelasssiid'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل امر تعطيل الايدي" or text == "تفعيل امر تفعيل الايدي بالصوره" or text == "تفعيل امر فتح الايدي" or text == "تفعيل امر فتح الايدي بالصوره" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local zilzal = '*⇜ مرحبـاً بـك عـزيـزي المالك الاساسي 🫂 \n⇜ فـي اوامـر التحكـم بصلاحيات الـرتب🎖\n⇜ بخصـوص امـر ⇜ ⌠ تعطيل الايدي ⌡\n⇜ قم باختيار الرتب التي تريد الغاء منعها من تعطيل الايدي 🚫 \n\n⇜ ملاحظـه :\n⇜ أي رتبه سوف تقوم باختيارها سوف يتم الغاء منع امر تعطيل الايدي عليها والرتب الاسفل منها بالترتيب*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'المالكيـن', data = msg.sender_id.user_id..'/zzelesiid'},},
{{text = 'المنشئيـن الاساسيين', data = msg.sender_id.user_id..'/zelesiid'},},
{{text = 'المنشئيـن', data = msg.sender_id.user_id..'/zelessiid'},},
{{text = 'المـدراء', data = msg.sender_id.user_id..'/zelesssiid'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل اكتموه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(4).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Status:Aktmooh"..msg.chat_id,true) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل امر اكتموه*","md",true )
end 
if text == "تعطيل اكتموه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(4).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."lock_iktmo"..msg.chat_id)  
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل امر اكتموه*","md",true )
end
if text == "تفعيل انذار" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."lock_inthare"..msg.chat_id) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيل امر انذار*","md",true )
end 
if text == "تعطيل انذار" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."lock_inthare"..msg.chat_id,true)  
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيل امر انذار*","md",true )
end
if text == "قفل الفارسيه" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:farsia"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفـل الفارسيه").Lock,"md",true)  
return false
end 
if text == "فتح الفارسيه" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:farsia"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الفارسيه").unLock,"md",true)  
return false
end 
if text == "قفل الدردشه" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:text"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الشات").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:AddMempar"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدخول" or text == "قفل الدخول بالرابط" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Join"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل دخول الاعضاء").Lock,"md",true)  
return false
end
if text == "قفل دخول الايران" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Lock:JoinFarsi"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفـل دخـول الإيران .. بنجـاح ✓").lockKick,"md",true)  
return false
end 
if text == "قفل البوتات" then  
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Bot:kick"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local text = 'قفل البوتات'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Bot:kick"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" or text == "تعطيل الاشعارات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:tagservr"..msg_chat_id,true)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الاشعارات").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:lockpin"..msg_chat_id,(bot.getChatPinnedMessage(msg_chat_id).id or true)) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التثبيت ").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:edittext"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" or text == "قفل تعديل الوسائط" then 
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:edit"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل تعديل الميديا").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Markdaun"..msg_chat_id,"del")  
Redis:set(Zelzal.."Zelzal:Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(Zelzal..'Zelzal:'..lock..msg_chat_id,"del")    
end
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل جميع الاوامر").Lock,"md",true)  
return false
end 
if text == "قفل وسائط المميزين" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:AlUasat"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل وسائط المميزين").Lock,"md",true)  
return false
end 
if text == "فتح وسائط المميزين" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:AlUasat"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح وسائط المميزين").unLock,"md",true)  
return false
end 
if text == "قفل الوسائط" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id,"del")  
Redis:set(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id,"del")  
Redis:set(Zelzal.."Zelzal:Lock:vico"..msg_chat_id,"del")  
Redis:set(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id,"del")  
Redis:set(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id,"del")  
Redis:set(Zelzal.."Zelzal:Lock:Video"..msg_chat_id,"del") 
Redis:del(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id)
Redis:set(Zelzal.."myphoto"..msg.chat_id,"true") 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل جميع الوسائط").Lock,"md",true)  
return false
end 
if text == "فتح الوسائط" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:vico"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Video"..msg_chat_id) 
Redis:set(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id,true)
Redis:del(Zelzal.."myphoto"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فـح جميع الوسائط").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:AddMempar"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح الدردشه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:text"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الشات").unLock,"md",true)  
return false
end 
if text == "فتح الدخول" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Join"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح دخول الاعضاء").unLock,"md",true)  
return false
end
if text == "فتح دخول الايران" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Lock:JoinFarsi"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتـح دخـول الإيران .. بنجـاح ✓").unLock,"md",true)  
return false
end 
if text == "فتح البوتات " then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Bot:kick"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:tagservr"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:lockpin"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح التثبيت").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:edittext"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح التعديل").unLock,"md",true)  
return false
end 
if text == "فتح تعديل الميديا" or text == "فتح تعديل الوسائط" then 
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:edit"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح تعديل الميديا").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(Zelzal..'Zelzal:'..lock..msg_chat_id)    
end
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:hset(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل التكرار'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:hset(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل التكرار'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:hset(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل التكرار'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:hset(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:hdel(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id ,"Spam:User")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Link"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الروابط'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Link"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الروابط'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Link"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الروابط'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Link"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Lock:Link"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الروابط").unLock,"md",true)  
return false
end
if text == "قفل الطائفيه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Lock:Taifia"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفـل الطـائفيـه .. بنجـاح ✓").Lock,"md",true)  
return false
end 
if text == "قفل الطائفيه بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الطائفيه'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Lock:Taifia"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفـل الطـائفيـه بالتقييـد .. بنجـاح ✓").lockKid,"md",true)  
return false
end 
if text == "قفل الطائفيه بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الطائفيه'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Lock:Taifia"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفـل الطـائفيـه بالكتـم .. بنجـاح ✓").lockKtm,"md",true)  
return false
end 
if text == "قفل الطائفيه بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الطائفيه'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Lock:Taifia"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفـل الطـائفيـه بالطـرد .. بنجـاح ✓").lockKick,"md",true)  
return false
end 
if text == "فتح الطائفيه" or text == "فتح الطائفية" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Lock:Taifia"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتـح الطـائفيـه .. بنجـاح ✓").unLock,"md",true)  
return false
end 
if text == "قفل المعرفات" or text == "قفل اليوزرات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:User:Name"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل المعرفات'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:User:Name"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل المعرفات'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:User:Name"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل المعرفات'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:User:Name"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" or text == "فتح اليوزرات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:User:Name"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:hashtak"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التاق").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل التاك'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:hashtak"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل التاك'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:hashtak"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل التاك'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:hashtak"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:hashtak"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Cmd"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الشارحه'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Cmd"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الشارحه'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Cmd"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الشارحه'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Cmd"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Cmd"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == "قفل الصور"then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الصور'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الصور'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = 'قفل الصور'
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصور").lockKick,"md",true)  
return false
end 
if text == "فتح الصور" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Video"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Video"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Video"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Video"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Video"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" or text == "قفل المتحركة" or text == "قفل المتحركات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل المتحركه").Lock,"md",true)  
return false
end
if text == "قفل المتحركه بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح المتحركه").unLock,"md",true)  
return false
end
if text == "قفل تيليثون" or text == "قفل تليثون" or text == "قفل تيلثون" or text == "قفل جمثون" or text == "قفل زدثون" or text == "قفل الجمثون" then 
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Jmthon"..msg_chat_id,"ktm")
Redis:del(Zelzal.."spammkick"..msg.chat_id)
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الجمثون .. بنجـاح").Lock,"md",true)  
return false
end
if text == "فتح تيليثون" or text == "فتح تليثون" or text == "فتح تيلثون" or text == "فتح جمثون" or text == "فتح زدثون" or text == "فتح الجمثون" then 
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
Redis:del(Zelzal.."Zelzal:Lock:Jmthon"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الجمثون .. بنجـاح").unLock,"md",true)  
return false
end
if text == "قفل التقليد" or text == "قفل الازعاج" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Takleed"..msg_chat_id,"ktm")
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التقليد .. بنجـاح").Lock,"md",true)  
return false
end
if text == "فتح التقليد" or text == "فتح الازعاج" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Takleed"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح التقليد .. بنجـاح").unLock,"md",true)  
return false
end
if text == "قفل الالعاب" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:geam"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:geam"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:geam"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:geam"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Lock:geam"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:vico"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:vico"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:vico"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:vico"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:vico"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Keyboard"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Keyboard"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Keyboard"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Keyboard"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Keyboard"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:forward"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:forward"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:forward"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:forward"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:forward"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Document"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Document"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Document"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Document"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Document"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Unsupported"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Unsupported"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Unsupported"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Unsupported"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Unsupported"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Markdaun"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Markdaun"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Markdaun"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Markdaun"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Markdaun"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Contact"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Contact"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Contact"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Contact"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Contact"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Spam"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Spam"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Spam"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Spam"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Spam"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:Inlen"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقييد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Inlen"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Inlen"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Lock:Inlen"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:Inlen"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الانلاين").unLock,"md",true)  
return false
end
if text == "قفل ارسال القناة" or text == "قفل القنوات" or text == "قفل القناه" or text == "قفل القناة" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:SenderChat"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل القنوات").Lock,"md",true)  
return false
end 
if text == "فتح ارسال القناة" or text == "فتح القنوات" or text == "فتح القناه" or text == "فتح القناة" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:SenderChat"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح القنوات").unLock,"md",true)  
return false
end 
if text == "قفل السب" or text == "قفل الفشار" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:phshar"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل السب").Lock,"md",true)  
return false
end 
if text == "فتح السب" or text == "فتح الفشار" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Lock:phshar"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح السب").unLock,"md",true)  
return false
end 
if text == "قفل الانكليزيه" or text == 'قفل الانكليزية' then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Zelzal:Lock:english"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الانكليزيه").Lock,"md",true)  
return false
end 
if text == "فتح الانكليزيه" or text == 'فتح الانكليزية' then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal.."Zelzal:Lock:english"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم فتح الانكليزيه").unLock,"md",true)  
return false
end

end

return {Zelzal = locks}