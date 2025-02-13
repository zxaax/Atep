function rotba(msg)
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
-----------------
-----------------------------------------------------------------------------
if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = bot.searchPublicChat(UserName[2])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if UserName[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مطور ثانوي🎖️ ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:DevelopersQ:Groups",UserId_Info.id)
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته من المطورين الثانويين🎖️").Reply,"md",true)  
end
end
if UserName[1] == 'مطور' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مطور ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Developers:Groups",UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته من قائمة المطورين ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
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
if not Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مالك ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته من مالك ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك )*',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو منشئ اساسي").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته من منشئ اساسي ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو منشئ  ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته من المنشئين ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مدير" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مدير ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته من المدراء ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "ادمن" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو ادمن ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته من الادمن ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مميز" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مميز ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته من المميزين ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == 'مطوره ثانويه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مطوره ثانويه🎖️ ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:MevelopersQ:Groups",UserId_Info.id)
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلتها من المطورات الثانويات🎖️").Replly,"md",true)  
end
end
if UserName[1] == 'مطوره' then
if not msg.DevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مطوره").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mevelopers:Groups",UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلتها من قائمة المطورات ").Replly,"md",true)  
end
end
if UserName[1] == "مالكه" then
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
if not Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مالكه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلتها من المالكات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "منشئه اساسيه" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك )*',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو منشئه اساسيه").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلتها من المنشئات الاساسيات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "منشئه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو منشئه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلتها من المنشئات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مديره" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مديره ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلتها من قائمة المديرات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "ادمونه" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو ادمونه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلتها من ادمونه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مميزه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مميزه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلتها من المميزات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
end
if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مطور ثانوي🎖️ ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:DevelopersQ:Groups",Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته من المطورين الثانويين🎖️").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n⇜ هذا الامر يخص { '..Controller_Num(2)..' } ',"md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:Developers:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مطور ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Developers:Groups",Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته من قائمة المطورين ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
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
if not Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مالك ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته من مالك ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك )*',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو منشئ اساسي ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته من منشئ اساسي ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو منشئ ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته من المنشئين ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "مدير" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مدير ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته من مدير ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "ادمن" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو ادمن ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته من ادمن ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "مميز" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مميز ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته من مميز ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == 'مطوره ثانويه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مطوره ثانويه🎖️ ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:MevelopersQ:Groups",Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلتها من المطورات الثانويات🎖️").Replly,"md",true)  
end
end
if TextMsg == 'مطوره' then
if not msg.DevelopersQ then
return send(msg_chat_id,msg_id,'\n⇜ هذا الامر يخص { '..Controller_Num(2)..' } ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مطوره ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mevelopers:Groups",Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلتها من قائمة المطورات ").Replly,"md",true)  
end
end
if TextMsg == "مالكه" then
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
if not Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مالكه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلتها من المالكات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "منشئه اساسيه" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك )*',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو منشئه اساسيه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلتها من المنشئات الاساسيات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "منشئه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو منشئه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلتها من المنشئات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "مديره" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مديره ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلتها من مديره ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "ادمونه" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو ادمونه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلتها من ادمونه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "مميزه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مميزه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلتها من مميزه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "خول" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."kholat:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من الخولات قبل كدة 🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."kholat:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من الخولات لازم ياخد دروس رجوله😂🌚 ").Reply,"md",true)  
end
end
if (TextMsg == "عروسه" or TextMsg == "عروسة") and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."wtka:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلهـا من العروسـات .. مسبقـاً ").Replly,"md",true)  
else
Redis:srem(Zelzal.."wtka:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلها من العروسات بعد مانمسح مكياجها 😂🌚 ").Replly,"md",true)  
end
end
if TextMsg == "مز" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."moza:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ العضـو ليس في قائمـة المـزز 🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."moza:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلـه من قائمـة المـزز بعد ما ارتبـط بسميـره 😂🌚").Reply,"md",true)  
end
end
if TextMsg == "مزه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."moza:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ العضـوه ليست مـزه 🙃 ").Replly,"md",true)  
else
Redis:srem(Zelzal.."moza:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلهـا من قائمـة المـزز بعد ما ارتبطـت 🌚😹 ").Replly,"md",true)  
end
end
if TextMsg == "كلب" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."klb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ الكلب دا بطل هوهوه ونزلناه  🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."klb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من الكلاب خليه يرجع العضمه😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "حمار" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."mar:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ الحمار دا عقل من زمان   🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."mar:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من الحمير تعال نفك الكارو منك😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "صاك" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."smb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ غيـر موجـود فـ قائمـة صاكيـن الكـروب 🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."smb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من قائمـة صاكيـن الكـروب 😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "صاكه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."smba:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ غيـر موجـوده فـ قائمـة صـاكـات الكـروب 🙃 ").Replly,"md",true)  
else
Redis:srem(Zelzal.."smba:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلهـا من قائمـة صـاكـات الكـروب 😂🌚 ").Replly,"md",true)  
end
end
if TextMsg == "حات" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."hat:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ غيـر موجـود فـ قائمـة حتيت الكـروب 🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."hat:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من قائمـة حتيت الكـروب 😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "حاته" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."hata:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ غيـر موجـود فـ قائمـة حاتـات الكـروب 🙃 ").Replly,"md",true)  
else
Redis:srem(Zelzal.."hata:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلهـا من قائمـة حاتـات الكـروب 😂🌚 ").Replly,"md",true)  
end
end
if (TextMsg == "خراط" or TextMsg == "كذاب") and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."kdbw:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ بطل الخرط زمان 😂🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."kdbw:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من قائمه الخراطين وبطل يخرط ع الناس 😂🌚 ").Reply,"md",true)  
end
end
if (TextMsg == "خراطه" or TextMsg == "كذابه") and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."kdbb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ هذه البنت بطلت الخرط زمان 😂🙃 ").Replly,"md",true)  
else
Redis:srem(Zelzal.."kdbb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلهـا من قائمه الخراطات وبطلت تخرط ع الناس 😂🌚 ").Replly,"md",true)  
end
end
if TextMsg == "قرد" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."2rd:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ بطل يتنطط على الشجـر 😂🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."2rd:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من قايمه القرود تعال نزلو من الشجره 😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "ربح" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."2rbh:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ بطل يتنطط على الشجـر 😂🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."2rbh:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من قائمـة الرباح تعال نزلو من الشجره 😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "ربحه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."3rbh:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ بطلت تتنطط على الشجـر 😂🙃 ").Replly,"md",true)  
else
Redis:srem(Zelzal.."3rbh:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلهـا من قائمـة الرباح تعال نزلو من الشجره 😂🌚 ").Replly,"md",true)  
end
end
if TextMsg == "دب" or TextMsg == "دبدوب" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."2db:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ليـس في قائمـة الدببـه 😂🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."2db:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلـه من قائمـة الدببـه .. بنجـاح 😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "دبه" or TextMsg == "دبدوبه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."3db:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ليـست في قائمـة الدببـه 😂🙃 ").Replly,"md",true)  
else
Redis:srem(Zelzal.."3db:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلهـا من قائمـة الدببـه .. بنجـاح 😂🌚 ").Replly,"md",true)  
end
end
if TextMsg == "خادم" or TextMsg == "خاطم" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."2kdm:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ليـس خـاطم هنـا 😂🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."2kdm:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلـه خاطـم .. بنجـاح 😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "خادمه" or TextMsg == "خاطمه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."3kdm:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ليـست خـاطمـه هنـا 😂🙃 ").Replly,"md",true)  
else
Redis:srem(Zelzal.."3kdm:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلهـا خاطمـه .. بنجـاح 😂🌚 ").Replly,"md",true)  
end
end
if TextMsg == "صايع" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."3ra:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ بطل يمشي ورا الحريم 😂🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."3ra:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من الصايعـين لازم ياخد دروس رجوله😂🌚").Reply,"md",true)  
end
end
if TextMsg == "غبي" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."8by:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ يارب تعقل وتبقا ذكي 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."8by:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ خير اهو شغل مخك اهو نزلناك من الاغبياء🌚 ").Reply,"md",true)  
end
end
if TextMsg == "كيكه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not Redis:sismember(Zelzal.."kika:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ مـو كيكـه اصـلا حتـى انزلـه 🍰🤢").Replly,"md",true)  
else
Redis:srem(Zelzal.."kika:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلـه كيكـه .. بنجـاح 🍰😭").Replly,"md",true)  
end
end
if TextMsg == "عسل" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not Redis:sismember(Zelzal.."assl:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ مـو عسـل اصـلا حتـى انزلـه 🍯🤢").Reply,"md",true)  
else
Redis:srem(Zelzal.."assl:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلـه عسـل .. بنجـاح 🍯😭").Reply,"md",true)  
end
end
if TextMsg == "زق" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if not Redis:sismember(Zelzal.."zk:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ مـو زق اصـلا حتـى انزلـه 💩😹").Reply,"md",true)  
else
Redis:srem(Zelzal.."zk:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلـه زق .. بنجـاح 💩😹").Reply,"md",true)  
end
end
end
if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local UserInfo = bot.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل مو مطور ثانوي🎖️ ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:DevelopersQ:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر نزلته من المطورين الثانويين🎖️").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل مو مطور ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Developers:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر نزلته من قائمة المطورين ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
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
if not Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو مالك ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلته من مالك ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيـل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك )*',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو منشئ اساسي ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلته من منشئ اساسي ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو منشئ ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلته من منشئ ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "مدير" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو مدير  ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلته من مدير ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "ادمن" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو ادمن  ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلته من الادمن ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "مميز" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو مميز ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلته من مميز ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == 'مطوره ثانويه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل مو مطوره ثانويه🎖️ ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:MevelopersQ:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر نزلتها من المطورات الثانويات🎖️").Replly,"md",true)  
end
end
if UserId[1] == 'مطوره' then
if not msg.DevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل مو مطوره ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mevelopers:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر نزلتها من قائمة المطورات ").Replly,"md",true)  
end
end
if UserId[1] == "مالكه" then
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
if not Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو مالكه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلتها من المالكات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "منشئه اساسيه" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك )*',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو منشئه اساسيه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلتها من المنشئات الاساسيات ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "منشئه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو منشئه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلتها من منشئ ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "مديره" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو مديره  ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلتها من مديره ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "ادمونه" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو ادمونه  ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلتها من ادمونه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "مميزه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:DWId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( التنزيل ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if not Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مو مميزه ").Replly,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر نزلتها من مميزه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتنزيل احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المنزل :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المنزله :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = bot.searchPublicChat(UserName[2])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ هو من قبل مطور ثانوي🎖️ ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:DevelopersQ:Groups",UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته مطور ثانوي🎖️").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ هو من قبل مطور ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Developers:Groups",UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
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
if Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مالك ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته مالك ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(8)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل منشئ اساسي ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته منشئ اساسي ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل منشئ  ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته منشئ  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مدير" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مدير ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته مدير  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "ادمن" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل ادمن ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته ادمن  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مميز" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مميز ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته مميز ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مطوره ثانويه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ هي من قبل مطوره ثانويه🎖️ ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:MevelopersQ:Groups",UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعتها مطوره ثانويه🎖️").Replly,"md",true)  
end
end
if UserName[1] == "مطوره" then
if not msg.DevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ هي من قبل مطوره ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mevelopers:Groups",UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعتها مطوره ").Replly,"md",true)  
end
end
if UserName[1] == "مالكه" then
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
if Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مالكه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعتها مالكه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "منشئه اساسيه" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(8)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل منشئه اساسيه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعتها منشئه اساسيه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "منشئه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل منشئه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعتها منشئه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مديره" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مديره ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعتها مديره  ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "ادمونه" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end 
if Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل ادمونه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعتها ادمونه  ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserName[1] == "مميزه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مميزه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,UserId_Info.id) 
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعتها مميزه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId_Info.id)
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ هو من قبل مطور ثانوي🎖️ ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:DevelopersQ:Groups",Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته مطور ثانوي🎖️").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Developers:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ هو من قبل مطور ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Developers:Groups",Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
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
if Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مالك ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته مالك ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(8)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل منشئ اساسي ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته منشئ اساسي ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل منشئ ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته منشئ ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "مدير" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مدير ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته مدير  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "ادمن" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل ادمن ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته ادمن  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "مميز" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مميز ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته مميز  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == 'مطوره ثانويه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ هي من قبل مطوره ثانويه🎖️ ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:MevelopersQ:Groups",Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعتها مطوره ثانويه🎖️").Replly,"md",true)  
end
end
if TextMsg == 'مطوره' then
if not msg.DevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ هي من قبل مطوره ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mevelopers:Groups",Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعتها مطوره ").Replly,"md",true)  
end
end
if TextMsg == "مالكه" then
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
if Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مالكه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعتها مالكه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "منشئه اساسيه" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(8)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل منشئه اساسيه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعتها منشئه اساسيه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "منشئه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل منشئه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعتها منشئه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "مديره" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مديره ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعتها مديره  ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "ادمونه" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل ادمونه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعتها ادمونه  ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "مميزه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مميزه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعتها مميزه  ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local RinkkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(Message_Reply.sender_id.user_id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if TextMsg == "خول" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."kholat:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ محطوط ف قايمة الخولات من  بدري 😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."kholat:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم ترقيته خول بالمجموعة لما يسترجل هننزلو 😂  ").Reply,"md",true)  
end
end
if TextMsg == "عروسه" or TextMsg == "عروسة" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."wtka:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ دي اجمـد عروسـه هنا في القائمـه من بدري 😂 ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."wtka:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ مـزة وتستاهل تنرفع عروسـة المجموعة 👰🌚 ").Replly,"md",true)  
end
end
if TextMsg == "مز" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."moza:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ المستخـدم مـز ومرفـوع من زمان 😂😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."moza:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـه مـز .. بنجـاح ✓😂  ").Reply,"md",true)  
end
end
if TextMsg == "مزه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."moza:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ دي مـزه ومرفـوعـه من زمان 😂😂 ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."moza:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعهـا مـزه الجـروب .. بنجـاح ✓😂  ").Replly,"md",true)  
end
end
if TextMsg == "كلب" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."klb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ دا مولود كده ومحطوط عندنا من زمان بيشمشم علي اي بنت 😂 😂").Reply,"md",true)  
else
Redis:sadd(Zelzal.."klb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعه كلب خليه يجي ياخد عضمه😂").Reply,"md",true)  
end
end
if TextMsg == "حمار" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."mar:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ نزلناه من زمان وفكينا الكارو 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."mar:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعه حمار خليه يجي نركبلو عربية كرو😂  ").Reply,"md",true)  
end
end
if TextMsg == "صاك" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."smb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاه من زمان وموجـود فـ قائمـة صاكيـن الكـروب 😘🥰 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."smb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـه صـاك .. بنجـاح ✓\n⇜ تعـال حبـي الصـاك انطينـي بوسـه 😘🥳").Reply,"md",true)  
end
end
if TextMsg == "صاكه" or TextMsg == "صاكة" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."smba:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاهـا من زمان وموجـوده فـ قائمـة صاكـات الكـروب 😘🥰 ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."smba:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـها صـاكـه الكـروب .. بنجـاح ✓\n⇜ تعـالي حبـي الصـاكه انطينـي بوسـه 😘🥳").Replly,"md",true)  
end
end
if TextMsg == "حات" or TextMsg == "الحات" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."hat:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاه من زمان وموجـود فـ قائمـة حتيت الكـروب 😘🥰 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."hat:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـه حات .. بنجـاح ✓\n⇜ تعـال حبـي الحات نطينـي بوسـه 😘🥳").Reply,"md",true)  
end
end
if TextMsg == "حاته" or TextMsg == "حاتة" or TextMsg == "الحاته" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."hata:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعناهـا من زمان وموجـود فـ قائمـة حاتـات الكـروب 😘🥰 ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."hata:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعهـا حـاته الكـروب .. بنجـاح ✓\n⇜ تعـالي حبـي الحـاته خـل نصيـر اصـدقاء 😘🥳").Replly,"md",true)  
end
end
if TextMsg == "خراط" or TextMsg == "كذاب" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."kdbw:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاه من زمان خـراط 😂😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."kdbw:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـه خراط المجموعـه .. بنجـاح 😂✓  ").Reply,"md",true)  
end
end
if TextMsg == "خراطه" or TextMsg == "كذابه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."kdbb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاهـا من زمان خـراطـه 😂😂 ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."kdbb:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعهـا خراطـه المجموعـه .. بنجـاح 😂✓  ").Replly,"md",true)  
end
end
if TextMsg == "قرد" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."2rd:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاه من زمان قـرد ع الشجره  😂😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."2rd:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعه قرد في المجموعه تعال خدلك موزه  😂  ").Reply,"md",true)  
end
end
if TextMsg == "ربح" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."2rbh:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاه من زمان ربـح ع الشجره  😂😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."2rbh:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعه ربـح القـروب تعال خدلك موزه 🙈🐒").Reply,"md",true)  
end
end
if TextMsg == "ربحه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."3rbh:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاهـا من زمان ربـحـه ع الشجره  😂😂 ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."3rbh:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعهـا ربـحـه القـروب ..بنجـاح✓\n⇜ تعالي خديلك موزه ياالربحـه 🙈🐒").Replly,"md",true)  
end
end
if TextMsg == "دب" or TextMsg == "دبدوب" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."2db:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاه من زمان دبدوب القـروب 😂😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."2db:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعه دبدوب القـروب .. بنجـاح 🦥😹").Reply,"md",true)  
end
end
if TextMsg == "دبه" or TextMsg == "دبدوبه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."3db:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاهـا من زمان دبدوبـه القـروب 😂😂 ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."3db:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعهـا دبدوبـه القـروب .. بنجـاح 🦥😹").Replly,"md",true)  
end
end
if TextMsg == "خادم" or TextMsg == "خاطم" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."2kdm:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاه من زمان خـاطم القـروب 😂🌚 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."2kdm:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعه خاطـم .. بنجـاح 🌚😹").Reply,"md",true)  
end
end
if TextMsg == "خادمه" or TextMsg == "خاطمه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."3kdm:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ رفعنـاهـا من زمان خـاطمـه القـروب 😂🌚 ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."3kdm:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعهـا خاطـمـه .. بنجـاح 🌚😹").Replly,"md",true)  
end
end
if TextMsg == "صايع" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."3ra:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ محدش محترمه كده كده  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."3ra:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـه صايـع الكروب قولولو عيب يمشي ورا البنات 😂  ").Reply,"md",true)  
end
end
if TextMsg == "غبي" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."8by:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ هو كده كده محطوط ف قايمة الاغبية  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."8by:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعه غبي المجموعة  😂  ").Reply,"md",true)  
end
end
if TextMsg == "كيكه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:sismember(Zelzal.."kika:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ مرفـوع كيكـه من زمـان 🍰😋").Replly,"md",true)  
else
Redis:sadd(Zelzal.."kika:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـه كيكـه ..بنجـاح 🍰🧁😋😻").Replly,"md",true)  
end
end
if TextMsg == "عسل" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:sismember(Zelzal.."assl:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ مرفـوع عسـل من زمـان 🍯😻😋").Reply,"md",true)  
else
Redis:sadd(Zelzal.."assl:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـه عسـل ..بنجـاح 🍯😋😻").Reply,"md",true)  
end
end
if TextMsg == "زق" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه ياورع .. مايمديـك تهيـنني ؟!*","md",true)  
end
if UserInfo.id == 6642636501 or UserInfo.id == 6642636501 or UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مبـرمـج السـورس*","md",true)  
elseif UserInfo.id == 6642636501 then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن مطـور السـورس*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المـالك الاسـاسي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور الثـانـوي*","md",true)  
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserInfo) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserInfo) then
return send(msg_chat_id,msg_id,"*⇜ هييـه ياورع .. مايمديـك تهيـن المطـور*","md",true)  
end
if Redis:sismember(Zelzal.."zk:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ مرفـوع زق من زمـان 💩🤮").Reply,"md",true)  
else
Redis:sadd(Zelzal.."zk:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم رفعـه زق ..بنجـاح 💩 👉😹").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local UserInfo = bot.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ هو من قبل مطور ثانوي🎖️ ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:DevelopersQ:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر رفعته مطور ثانوي🎖️").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ هو من قبل مطور ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Developers:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر رفعته مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
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
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مالك ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعته مالك ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(8)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل منشئ اساسي ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعته منشئ اساسي ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل منشئ ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Originators:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعته منشئ  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "مدير" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مدير ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Managers:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعته مدير ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "ادمن" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل ادمن ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعته ادمن  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "مميز" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مميز ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعته مميز  ").Reply,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == 'مطوره ثانويه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ هي من قبل مطوره ثانويه🎖️ ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:MevelopersQ:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر رفعتها مطوره ثانويه🎖️").Replly,"md",true)  
end
end
if UserId[1] == 'مطوره' then
if not msg.DevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ هي من قبل مطوره ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mevelopers:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر رفعتها مطوره ").Replly,"md",true)  
end
end
if UserId[1] == "مالكه" then
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
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مالكه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعتها مالكه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "منشئه اساسيه" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(8)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل منشئه اساسيه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعتها منشئه اساسيه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)

local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "منشئه" then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل منشئه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعتها منشئه ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "مديره" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مديره ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعتها مديره ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "ادمونه" then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Managers or msg.Mamagers then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل ادمونه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعتها ادمونه  ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
if UserId[1] == "مميزه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",true, false, false, false, reply_markup)
end
if (not msg.Originators or not msg.Origimators) and not Redis:get(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ الرفع معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:TheBasics:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Originators:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Managers:UpId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ ( الرفع ) معطل من قبل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ من قبل مميزه ").Replly,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id,UserId[2]) 
send(msg_chat_id,msg_id,Reply_Status(UserId[2],"⇜ ابشر رفعتها مميزه  ").Replly,"md",true)  
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local RinkBot = Controller(msg_chat_id,msg.sender_id.user_id)
local onend = bot.getUser(msg.sender_id.user_id)
if onend.username and onend.username ~= "" and onend.first_name then
zname = '['..onend.first_name..'](t.me/'..onend.username..')'
zuser = ''..onend.username..' '
else
zname = '['..onend.first_name..'](tg://user?id='..onend.id..')'
zuser = 'لا يوجد'
end
local twond = bot.getUser(UserId[2])
local RinkkBot = Controller(msg_chat_id,twond.id)
if twond.username and twond.username ~= "" and twond.first_name then
zzname = '['..twond.first_name..'](t.me/'..twond.username..')'
zzuser = ''..twond.username..' '
else
zzname = '['..twond.first_name..'](tg://user?id='..twond.id..')'
zzuser = 'لا يوجد'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام برفع احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المرفوع :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'\n*⇜ رتبته المرفوعه :* '..RinkkBot..'',"md",true, false, false, false, reply_markup)
end
end
end
end
if text == 'الثانويين' or text == 'المطورين الثانوين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:DevelopersQ:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مطورين ثانويين , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المطور الثانوي🎖️*\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المطورين الثانويين🎖️', data = msg.sender_id.user_id..'/DevelopersQ'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الثانويات' or text == 'المطورات الثانويات' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:MevelopersQ:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مطورات ثانويات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المطورات الثانويات🎖️*\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المطورات الثانويات🎖️', data = msg.sender_id.user_id..'/MevelopersQ'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' or text == 'مسح المطورين' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Developers:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مطورين بعد , ","md",true)  
end
ListMembers = '\n*⇜ قائمـة المطـورين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المطورين', data = msg.sender_id.user_id..'/Developers'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورات' or text == 'مسح المطورات' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Mevelopers:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مطورات بعد , ","md",true)  
end
ListMembers = '\n*⇜ قائمـة المطورات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المطورات', data = msg.sender_id.user_id..'/Mevelopers'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المالكين' or text == 'مسح المالكين' then
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
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مالكين , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المالكين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المالكين', data = msg.sender_id.user_id..'/TheBasicsQ'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المالكات' or text == 'مسح المالكات' then
if not msg.MalekAsase or not msg.MalemAsase then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مالكات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المالكات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المالكات', data = msg.sender_id.user_id..'/TheMasicsQ'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' or text == 'مسح المنشئين الاساسيين' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد منشئين اساسيين , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المنشئين الاساسيين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المنشئين الاساسيين', data = msg.sender_id.user_id..'/TheBasics'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئات الاساسيات' or text == 'مسح المنشئات الاساسيات' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد منشئات اساسيات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المنشئات الاساسيات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المنشئات الاساسيات', data = msg.sender_id.user_id..'/TheMasics'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين' or text == 'مسح المنشئين' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد منشئين , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المنشئين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المنشئين', data = msg.sender_id.user_id..'/Originators'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئات' or text == 'مسح المنشئات' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد منشئات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المنشئات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المنشئات', data = msg.sender_id.user_id..'/Origimators'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المدراء' or text == 'مسح المدراء' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مدراء , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المدراء *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المدراء', data = msg.sender_id.user_id..'/Managers'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المديرات' or text == 'مسح المديرات' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مديرات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المديرات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المديرات', data = msg.sender_id.user_id..'/Mamagers'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمنيه' or text == 'مسح الادمنيه' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد ادمنيه , ","md",true)  
end
ListMembers = '\n*⇜ قائمة الادمنيه *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح الادمنيه', data = msg.sender_id.user_id..'/Addictive'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمونات' or text == 'مسح الادمونات' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد ادمونات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة الادمونات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح الادمونات', data = msg.sender_id.user_id..'/Mddictive'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزين' or text == 'مسح المميزين' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مميزين , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المميزين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المميزين', data = msg.sender_id.user_id..'/DelDistinguished'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزات' or text == 'مسح المميزات' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مميزات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المميزات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المميزات', data = msg.sender_id.user_id..'/DelMistinguished'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الخولات' then
local Info_Members = Redis:smembers(Zelzal.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد خولات حاليا , ","md",true)  
end
ListMembers = '\n*⇜ قائمه الخولات \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الخول *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الخول * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الخولات', data = msg.sender_id.user_id..'/Delkholat'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'العروسات' or text == 'تاك للعروسات' or text == 'عروسات' then
local Info_Members = Redis:smembers(Zelzal.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد عروسـات بنات المجمـوعـة بعـدهن سناكـل 🌚😹🤷🏻‍♀*","md",true)  
end
ListMembers = '\n*⇜ قائمـة عروسـات المجمـوعـة 👰🏻‍♀🌸 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - العروسـه *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - العروسـه * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح العروسـات', data = msg.sender_id.user_id..'/Delwtk'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'تاك للمزز' or text == 'المزز' or text == 'مزز' then
local Info_Members = Redis:smembers(Zelzal.."moza:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ مفيش متوحدين هنا كلهم اتعالجو 😂😂 , ","md",true)  
end
ListMembers = '\n*⇜ قائمـة مـزز  المجمـوعـة 🦦🦦💃 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - المـزه *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - المـزه* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المـزز', data = msg.sender_id.user_id..'/Deltwhd'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الكلاب' or text == 'كلاب' then
local Info_Members = Redis:smembers(Zelzal.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش كلاب هنا 🐸🐸* ","md",true)  
end
ListMembers = '\n*⇜ قائمه الكلاب \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الكلب *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الكلب * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الكلاب', data = msg.sender_id.user_id..'/Delklb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الحمير' or text == 'حمير' then
local Info_Members = Redis:smembers(Zelzal.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش حمير هنا يصحبي 🐸🐸*","md",true)  
end
ListMembers = '\n*⇜ قائمه الحمير \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الحمار *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الحمار * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الحمير', data = msg.sender_id.user_id..'/Delmar'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الصايعين' or text == 'الصيع' or text == 'تاك للصايعين' or text == 'تاك للصيع' then
local Info_Members = Redis:smembers(Zelzal.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش صايعيـن هنا دا كـروب محتـرم 😂🌚*","md",true)  
end
ListMembers = '\n*⇜ قائمـه صايعيـن المجمـوعـة \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الصايع *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الصايع * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الاولاد الصايعيـن', data = msg.sender_id.user_id..'/Del3ra'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الصاكين' or text == 'تاك للصاكين' then
local Info_Members = Redis:smembers(Zelzal.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش صاكـين هنا 😂😂*","md",true)  
end
ListMembers = '\n*⇜ قائمـة صاكيـن الكـروب 😍💞 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الصاك *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الصاك * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الصاكيـن', data = msg.sender_id.user_id..'/Delsmb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الصاكات' or text == 'تاك للصاكات' then
local Info_Members = Redis:smembers(Zelzal.."smba:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش صاكـات هنا 😂😂*","md",true)  
end
ListMembers = '\n*⇜ قائمـة صاكـات الكـروب 💋😍💞 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - صاكـه *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - صاكـه * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الصـاكـات', data = msg.sender_id.user_id..'/Delsmba'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الحتيت' or text == 'تاك للحات' or text == 'حتيت' then
local Info_Members = Redis:smembers(Zelzal.."hat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش صاكـين هنا 😂😂*","md",true)  
end
ListMembers = '\n*⇜ قائمـة حتيت الكـروب 😍💞 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الحات *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الحات * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الحتيت', data = msg.sender_id.user_id..'/Delhat'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الحاتات' or text == 'تاك للحاته' then
local Info_Members = Redis:smembers(Zelzal.."hata:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش صاكـين هنا 😂??*","md",true)  
end
ListMembers = '\n*⇜ قائمـة حـاتات الكـروب 😍💞 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الحـاته *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الحـاته * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الحاتات', data = msg.sender_id.user_id..'/Delhata'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الخراطين' or text == 'الكذابين' then
local Info_Members = Redis:smembers(Zelzal.."kdbw:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مابش خراطيـن هانا ياصاحبي 😂😂 , *","md",true)  
end
ListMembers = '\n*⇜ قائمه الخراطين \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الخراطين', data = msg.sender_id.user_id..'/Delkdbw'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الخراطات' or text == 'الكذابات' then
local Info_Members = Redis:smembers(Zelzal.."kdbb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مابش خراطات هانا ياصاحبي 😂😂 , *","md",true)  
end
ListMembers = '\n*⇜ قائمه الخراطات \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الخراطات', data = msg.sender_id.user_id..'/Delkdbb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'القرود' or text == 'قرود' then
local Info_Members = Redis:smembers(Zelzal.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش قرود هنا يصحبي 🐒🐒*","md",true)  
end
ListMembers = '\n*⇜ قائمه القرود \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح القرود', data = msg.sender_id.user_id..'/Del2rd'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الرباح' or text == 'رباح' then
local Info_Members = Redis:smembers(Zelzal.."2rbh:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش ربـاح هنا يصحبي 🌚🐒 *","md",true)  
end
ListMembers = '\n*⇜ قائمـه الربـاح 🐒 \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الربح *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الربح * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الربـاح', data = msg.sender_id.user_id..'/Del2rbh'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الربحات' or text == 'ربحات' then
local Info_Members = Redis:smembers(Zelzal.."3rbh:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش ربـحـات هنا يصحبي 🌚🐒 *","md",true)  
end
ListMembers = '\n*⇜ قائمـه ربحـات القـروب 🐒 \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - ربحه *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - ربحه * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الربحـات', data = msg.sender_id.user_id..'/Del3rbh'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الدببه' or text == 'دببه' then
local Info_Members = Redis:smembers(Zelzal.."2db:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش دببـه هنا يصحبي 🌚🦥*","md",true)  
end
ListMembers = '\n*⇜ قائمـه الدببـه 🦥 \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الدبدوب *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الدبدوب * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الدببـه', data = msg.sender_id.user_id..'/Del2db'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الدبدوبات' or text == 'دبدوبات' then
local Info_Members = Redis:smembers(Zelzal.."3db:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش دبدوبـات هنا يصحبي 🌚🦥*","md",true)  
end
ListMembers = '\n*⇜ قائمـه دبدوبـات القـروب 🦥 \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - دبدوبه *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - دبدوبه * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الدبدوبات', data = msg.sender_id.user_id..'/Del3db'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الاخدام' or text == 'اخدام' then
local Info_Members = Redis:smembers(Zelzal.."2kdm:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش اخطـام هنا يصحبي 🌚😹*","md",true)  
end
ListMembers = '\n*⇜ قائمـه اخطـام القـروب 🌚 \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - خادم *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - خادم * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الاخطـام', data = msg.sender_id.user_id..'/Del2kdm'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الخادمات' or text == 'خادمات' then
local Info_Members = Redis:smembers(Zelzal.."3kdm:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش اخطـام هنا يصحبي 🌚😹*","md",true)  
end
ListMembers = '\n*⇜ قائمـه خاطمـات القـروب 🌚 \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - خادمه *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - خادمه * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الخاطمـات', data = msg.sender_id.user_id..'/Del3kdm'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الاغبياء' or text == 'اغبياء' then
local Info_Members = Redis:smembers(Zelzal.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش اغبيـاء هنا يصحبي 😂😂 , *","md",true)  
end
ListMembers = '\n*⇜ قائمـه الأغبيـاء  \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الغبي *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الغبي * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الاغبياء', data = msg.sender_id.user_id..'/Del8by'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الكيك' or text == 'تاك للكيك' or text == 'الكيكات' or text == 'كيك' then
local Info_Members = Redis:smembers(Zelzal.."kika:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش كيكـات هنـا .. للأسـف ياصاحبـي 🍩😭*","md",true)  
end
ListMembers = '\n*⇜ قائمـه كيكـات الكـروب 🍰🍽😋 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - كيكـه 🍽 *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - كيكـه 🍽 * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الكيكـات', data = msg.sender_id.user_id..'/bkika:Group'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'عسل' or text == 'تاك للعسل' or text == 'العسل' then
local Info_Members = Redis:smembers(Zelzal.."assl:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش عسـل هنـا .. للأسـف ياصاحبـي 🍯😭*","md",true)  
end
ListMembers = '\n*⇜ قائمـه عسـل الكـروب 🍯🐝😋 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - العسـل ??🐝 *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - العسـل 🍯🐝 * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- مسح العسـل', data = msg.sender_id.user_id..'/bassl:Group'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'تاك للزق' or text == 'تاك زق' or text == 'الزق' then
local Info_Members = Redis:smembers(Zelzal.."zk:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ مفيش زق هنـا .. للأسـف ياصاحبـي 💩 👉😹*","md",true)  
end
ListMembers = '\n*⇜ قائمـه الـزق 💩 \nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - الـزق 💩 *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - الـزق 💩 * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = '- تنظيـف الـزق', data = msg.sender_id.user_id..'/bzk:Group'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين عام' or text == 'قائمه العام' then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد محظورين عام*","md",true)  
end
ListMembers = '\n⇜ قائمة المحظورين عام  \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المحظورين عام', data = msg.sender_id.user_id..'/BanAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد محظورين*","md",true)  
end
ListMembers = '\n⇜ قائمة المحظورين  \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المحظورين', data = msg.sender_id.user_id..'/BanGroup'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مكتومين*","md",true)  
end
ListMembers = '\n⇜ قائمة المكتومين  \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {{{text = 'مسح المكتومين', data = msg.sender_id.user_id..'/SilentGroupGroup'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
--------------------------------------------------------------------------------------------------------------


end
return {Zelzal = rotba}
