function youtube(msg)
text = nil
if msg and msg.content and msg.content.text then
xname =  (Redis:get(Zelzal.."Zelzal:Name:Bot") or "بووت") 
text = msg.content.text.text
if text:match("^"..xname.." (.*)$") then
text = text:match("^"..xname.." (.*)$")
end
end
msg_chat_id = msg.chat_id
msg_id = msg.id
if tonumber(msg.sender_id.user_id) == tonumber(Fast) then
return false
end
if text then
local neww = Redis:get(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg.chat_id..":"..text) or Redis:get(Zelzal.."All:Get:Reides:Commands:Group"..text)
if neww then
text = neww or text
end
end
function time_to_sec(time)
    local sec = 0
    local time_table = {}
    for i in string.gmatch(time, "%d+") do
        table.insert(time_table, i)
    end
    local hour = tonumber(time_table[1])
    local min = tonumber(time_table[2])
    local sec = tonumber(time_table[3])
    return hour*3600 + min*60 + sec
end
if text == "تعطيل اليوتيوب" or text == "تعطيل يوتيوب" then
if not msg.Addictive then
return send(msg_chat_id,msg_id,'\n⇜ هذا الامر يخص ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:get(Zelzal.."youtubee"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل اليوتيوب مسبقاً","md",true )
else
Redis:set(Zelzal.."youtubee"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تعطيل اليوتيوب","md",true )
end
end
if text == "تفعيل اليوتيوب" or text == "تفعيل يوتيوب" then
if not msg.Addictive then
return send(msg_chat_id,msg_id,'\n⇜ هذا الامر يخص ( '..Controller_Num(7)..' ) ',"md",true)  
end
if not Redis:get(Zelzal.."youtubee"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل اليوتيوب مسبقاً","md",true )
else
Redis:del(TheMero.."youtubee"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم تفعيل اليوتيوب","md",true )
end
end
if text == "تعطيل التحميل" or text == "تعطيل تحميل" or text == "تعطيل السوشل" or text == "تعطيل سوشل" then
if not msg.Addictive then
return send(msg_chat_id,msg_id,'\n⇜ هذا الامر يخص ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:get(Zelzal.."soshle"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم "..text.." مسبقاً","md",true )
else
Redis:set(Zelzal.."soshle"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم "..text.." ","md",true )
end
end
if text == "تفعيل التحميل" or text == "تفعيل تحميل" or text == "تفعيل السوشل" or text == "تفعيل سوشل" then
if not msg.Addictive then
return send(msg_chat_id,msg_id,'\n⇜ هذا الامر يخص ( '..Controller_Num(7)..' ) ',"md",true)  
end
if not Redis:get(Zelzal.."soshle"..msg.chat_id)  then
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم "..text.." مسبقاً","md",true )
else
Redis:del(Zelzal.."soshle"..msg.chat_id)
return send(msg_chat_id,msg_id,GetByName(msg).."⇜ تم "..text.." ","md",true )
end
end
if text == "اليوتيوب للمميزين" or text == "يوتيوب للمميزين" or text == "التحميل للمميزين" or text == "السوشل للمميزين" or text == "سوشل للمميزين" then
if not msg.TheBasicsQ then
return send(msg_chat_id,msg_id,'\n⇜ هذا الامر يخص المالك ',"md",true) 
end
Redis:set(Zelzal.."sochal"..msg.chat_id,"true")
return send(msg.chat_id,msg.id,"⇜ تم تعيين "..text.." ومافوق ","md",true)
end
if text == "اليوتيوب للاعضاء" or text == "يوتيوب للاعضاء" or text == "التحميل للاعضاء" or text == "السوشل للاعضاء" or text == "سوشل للاعضاء" then
if not msg.TheBasicsQ then
return send(msg_chat_id,msg_id,'\n⇜ هذا الامر يخص المالك ',"md",true)
end
Redis:del(TheMero.."sochal"..msg.chat_id)
return send(msg.chat_id,msg.id,"⇜ تم تعيين السوشل لجميع الاعضاء ","md",true)
end
if text and text:match("^فيس (.*)$") or text and text:match("^(.*) فيس$") then
local facelink = text:match("^فيس (.*)$") or text:match("^(.*) فيس$")
if Redis:get(Zelzal.."soshle"..msg.chat_id) then
return false
end
if not msg.Distinguished and Redis:get(Zelzal.."sochal"..msg.chat_id) then
return send(msg.chat_id,msg.id,"⇜ عذراً عزيزي الفيسبوك للمميزين ومافوق فقط","md",true)
end
local nameuser = bot.getUser(msg.sender_id.user_id)
if nameuser.first_name then
nameuser = "["..nameuser.first_name.."](tg://user?id="..nameuser.id..")"
else
nameuser = 'لا يوجد اسم'
end
os.execute("yt-dlp "..facelink.." --max-filesize 50M -o 'face.mkv'")
local facefile = io.open("./face.mkv","r")
if facefile then
bot.sendVideo(msg_chat_id,msg_id,'./face.mkv',"- من قبل : "..nameuser.."️","md")
sleep(1)
os.remove("face.mkv")
else
return send(msg_chat_id,msg_id,'\n⇜ لا استطيع تحميل اكثر من 50 ميغا',"md",true)
end
end

if text and text:match("^تيك (.*)$") or text and text:match("^(.*) تيك$") then
local tiklink = text:match("^تيك (.*)$") or text:match("^(.*) تيك$")
if Redis:get(Zelzal.."soshle"..msg.chat_id) then
return false
end
if not msg.Distinguished and Redis:get(TheMero.."sochal"..msg.chat_id) then
return send(msg.chat_id,msg.id,"⇜ عذراً عزيزي التيك توك للمميزين ومافوق فقط","md",true)
end
local nameuser = bot.getUser(msg.sender_id.user_id)
if nameuser.first_name then
nameuser = "["..nameuser.first_name.."](tg://user?id="..nameuser.id..")"
else
nameuser = 'لا يوجد اسم'
end
os.execute("yt-dlp "..tiklink.." --max-filesize 50M -o 'tik.mp4'")
local tikfile = io.open("./tik.mp4","r")
if tikfile then
bot.sendVideo(msg_chat_id,msg_id,'./tik.mp4',"- من قبل : "..nameuser.."️","md") 
sleep(1)
os.remove("tik.mp4")
else
return send(msg_chat_id,msg_id,'\n⇜ لا استطيع تحميل اكثر من 50 ميغا',"md",true)
end
end

if text and text:match("^رابط ساوند (.*)$") then
local soundlink = text:match("^رابط ساوند (.*)$")
if Redis:get(Zelzal.."soshle"..msg.chat_id) then
return false
end
if not msg.Distinguished and Redis:get(Zelzal.."sochal"..msg.chat_id) then
return send(msg.chat_id,msg.id,"⇜ عذراً عزيزي الساوند للمميزين ومافوق فقط","md",true)
end
local nameuser = bot.getUser(msg.sender_id.user_id)
if nameuser.first_name then
nameuser = "["..nameuser.first_name.."](tg://user?id="..nameuser.id..")"
else
nameuser = 'لا يوجد اسم'
end
os.execute("yt-dlp "..soundlink.." --max-filesize 25M -o 'soundc.mp3'")
local soufile = io.open("./soundc.mp3","r")
if soufile then
bot.sendAudio(msg_chat_id,msg_id,'./soundc.mp3',"- من قبل : "..nameuser.."️","md",nil,"soundc")
sleep(1)
os.remove("soundc.mp3")
else
return send(msg_chat_id,msg_id,'\n⇜ لا استطيع تحميل اكثر من 25 ميغا',"md",true)
end
end
if text and text:match("^ساوند (.*)$") or text and text:match("^(.*) [Ss]$") then
local search = text:match("^ساوند (.*)$") or text:match("^(.*) [Ss]$")
if Redis:get(Zelzal.."soshle"..msg.chat_id) then
return false
end
if not msg.Distinguished and Redis:get(TheMero.."sochal"..msg.chat_id) then
return send(msg.chat_id,msg.id,"⇜ عذراً عزيزي الساوند للمميزين ومافوق فقط","md",true)
end
local jsonson = JSON.decode(request("https://anubis.fun/api/sound_search.php?q="..URL.escape(search)..""))
Redis:del(Zelzal.."soundidche"..msg.chat_id..msg.sender_id.user_id)
Redis:set(Zelzal.."soundidche"..msg.chat_id..msg.sender_id.user_id,search)
local datar = {data = {{text = "Louis", url = 'https://t.me/Y88F8'}}}
for i = 1,5 do
titlee = jsonson.result[''..i..''].title
link = jsonson.result[''..i..''].url
link = tostring(link)
link = link:gsub("https://soundcloud.com/",'') 
datar[i] = {{text = titlee , data = search..":socl:"..link}}
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = datar
}
bot.sendText(msg.chat_id,msg.id,' نتائج بحثك على الساوند ل ( *'..search..'* )',"md",false, false, false, false, reply_markup)
end
if text and text:match("^بحث (.*)$") then
local search = text:match("^بحث (.*)$")
if Redis:get(Zelzal.."youtubee"..msg.chat_id) then
return false
end
if not msg.Distinguished and Redis:get(Zelzal.."sochal"..msg.chat_id) then
return send(msg.chat_id,msg.id,"⇜ عذراً عزيزي اليوتيوب للمميزين ومافوق فقط","md",true)
end
local jsonyou = JSON.decode(request("https://www.bot-sms.shop/api/youtube/v4/api.php?search="..URL.escape(search)..""))
Redis:del(Zelzal.."youtidche"..msg.chat_id..msg.sender_id.user_id)
Redis:set(Zelzal.."youtidche"..msg.chat_id..msg.sender_id.user_id,search)
local datar = {data = {{text = "Louis", url = 'https://t.me/Y88F8'}}}
for i = 1,5 do
titlee = jsonyou.results[i].video.title
link = jsonyou.results[i].video.url
link = tostring(link)
link = link:gsub("https://youtu.be/",'') 
datar[i] = {{text = titlee , data = search..":yout:"..link}}
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = datar
}
bot.sendText(msg.chat_id,msg.id,' نتائج بحثك على اليوتيوب ل ( *'..search..'* )',"md",false, false, false, false, reply_markup)
end
