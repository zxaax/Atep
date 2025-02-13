function porn_d(msg)
text = nil
if msg and msg.content and msg.content.text then
text = msg.content.text.text
end
local msg_chat_id = msg.chat_id
local msg_id = msg.id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender_id.user_id
if tonumber(msg.sender_id.user_id) == tonumber(Zelzal) then
return false
end
if text then
local neww = Redis:get(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg.chat_id..":"..text)
if neww then
text = neww or text
end
end
if Redis:get(Zelzal..'pooorn'..msg.chat_id) then
if msg.Originators or msg.Origimators then
return false
end
if msg.chat_id ~= "-1001935599871" then
return false
end
if (msg.content.photo or msg.content.sticker or msg.content.animation or msg.content.video) then
local result = msg
local num = math.random(99999)
if result.content.photo then 
if result.content.photo.sizes[3] then
idPhoto = result.content.photo.sizes[3].photo.remote.id
idd =  result.content.photo.sizes[3].photo.id
elseif result.content.photo.sizes[2] then
idPhoto = result.content.photo.sizes[2].photo.remote.id
idd =  result.content.photo.sizes[2].photo.id
elseif result.content.photo.sizes[1]  then
idPhoto = result.content.photo.sizes[1].photo.remote.id
idd = result.content.photo.sizes[1].photo.id
end
typeee = "jpg"
elseif result.content.sticker then
idPhoto = result.content.sticker.sticker.remote.id
idd = msg.content.sticker.sticker.id
typeee = "jpg"
elseif result.content.animation then
idPhoto = result.content.animation.animation.remote.id
idd = msg.content.animation.animation.id
typeee = "mp4"
elseif msg.content.video then
idPhoto = result.content.video.video.remote.id
idd = msg.content.video.video.id
typeee = "mp4"
end
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num.."."..typeee.."")
return bot.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
os.remove(""..num.."."..typeee.."")
return false
else
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..idPhoto)) 
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,""..num.."."..typeee.."") 
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if out == "" then 
os.remove(""..num.."."..typeee.."")
return false 
end
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num.."."..typeee.."")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
local Get_Chat = bot.getChat(msg.chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg.chat_id)
local bains = bot.getUser(msg.sender_id.user_id)
if bains.first_name then
klajq = '['..bains.first_name..'](tg://user?id='..bains.id..')'
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ''..bains.username..' '
else
basgk = 'لا يوجد'
end
local czczh = ''..bains.first_name..''
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = czczh, url = "https://t.me/"..bains.username..""},
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*⇜ مرحبًا عزيزي المالك ⚠️*\n*⇜ شخص ما قام بـ ارسـال اباحيه في قروبك 🔞*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n*⇜ لا تقلق تم التعرف ع الاباحيه*\n*⇜ وحذفها من المجموعة .. بنجاح ✅*',"md",false, false, false, false, reply_markup)
end
end
os.remove(""..num.."."..typeee.."")
end
os.remove(""..num.."."..typeee.."")
end
end
if text == "مسح البورنو" or text == "مسح الاباحي" or text == "تنظيف الاباحي" then
if msg.ControllerBot then
Redis:del(Zelzal.."sex_ids")
Redis:del(Zelzal.."not_sex_ids")
send(msg.chat_id,msg.id,"• تم ✅")
end
end


end
return {Zelzal = porn_d}