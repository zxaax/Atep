URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
utf8 = require("libs/utf8")
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
luatele = require('./libs/luatele')
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخرى \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخرى \nToken not saved, try again')
end 
os.execute('lua5.3 Zelzal.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua5.3 Zelzal.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ ايدي المطور \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua5.3 Zelzal.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
local Zelzal = io.open("Zelzal", 'w')
Zelzal:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
sudo lua5.3 Zelzal.lua
done
]])
Zelzal:close()
local Run = io.open("Run", 'w')
Run:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
screen -S ]]..Redis:get(SshId.."Info:Redis:User")..[[ -X kill
screen -S ]]..Redis:get(SshId.."Info:Redis:User")..[[ ./Zelzal
done
]])
Run:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('rm -rf luatele.zip ;chmod +x Zelzal;chmod +x Run;./Run')
os.execute('rm -fr $HOME/.CallBack-Bot')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
Zelzal = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..Zelzal)
bot = luatele.set_config{api_id=29065853,api_hash='777aac491624cce8ea86ec0a693a66de',session_name=Zelzal,token=Token}
Bot_Name = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "بوت")
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos = {Sudo_Id,1260465030}
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
if Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId) then
ControllerAll = true
end
end
return ControllerAll
end
function mderall(msg)
mderall = false
local statuse = Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id)
if statuse then
mderall = true
end
return mderall
end
function Controllerbanall(ChatId,UserId)
Status = 0
local Controll2 = Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId)
DevelopersQ = Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId) 
if UserId == 1260465030 then
Status = true
elseif UserId == 1260465030 or UserId == 1260465030 or UserId == 1260465030 or UserId == 1260465030 then
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == Zelzal then
Status = true
elseif Controll2 then
Status = true
elseif DevelopersQ then
Status = true
else
Status = false
end
return Status
end
function GetByName(msg)
local UserInfo = bot.getUser(msg.sender_id.user_id)
Name_py = '*⇜ من*  ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
return Name_py
end
function Controller(ChatId,UserId)
Status = 0
local Controll2 = Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId)
Developers = Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId)
Mevelopers = Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId) 
DevelopersQ = Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId)
MevelopersQ = Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId)
MalekAsase = Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..ChatId,UserId)
MalemAsase = Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..ChatId,UserId)
TheBasicsQ = Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..ChatId,UserId)
TheMasicsQ = Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..ChatId,UserId) 
TheBasics = Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..ChatId,UserId)
TheMasics = Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Zelzal.."Zelzal:Originators:Group"..ChatId,UserId)
Origimators = Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..ChatId,UserId) 
Managers = Redis:sismember(Zelzal.."Zelzal:Managers:Group"..ChatId,UserId)
Mamagers = Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..ChatId,UserId) 
Addictive = Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..ChatId,UserId)
Mddictive = Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..ChatId,UserId) 
Distinguished = Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..ChatId,UserId)
Mistinguished = Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..ChatId,UserId)
StatusMember = bot.getChatMember(ChatId,UserId).status.luatele
if UserId == 1260465030 then
Status = 'مبرمج السورس🎖️'
elseif UserId == 1260465030 or UserId == 1260465030 or UserId == 1260465030 or UserId == 1260465030 then
Status = 'مطور السورس🎖️'
elseif UserId == Sudo_Id then  
Status = Redis:get(Zelzal.."Zelzal:Sudo:General:Reply") or 'مطور اساسي🎖️'
elseif Controll2 then
Status = Redis:get(Zelzal.."Zelzal:Sudo2:General:Reply") or 'مطور اساسي²🎖'
elseif UserId == Zelzal then
Status = 'البوت'
elseif DevelopersQ then
Status = Redis:get(Zelzal.."Zelzal:DeveloperQ:General:Reply") or 'المطور الثانوي🎖️'
elseif MevelopersQ then
Status = Redis:get(Zelzal.."Zelzal:MeveloperQ:General:Reply") or 'المطوره الثانويه🎖️'
elseif Developers then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Developer:Bot:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Developer:General:Reply") or 'المطـــور '
elseif Mevelopers then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Meveloper:Bot:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Meveloper:General:Reply") or 'المطـــوره '
elseif MalekAsase then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:PresidentQQ:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:PresidentQQ:General:Reply") or  'المــــالك الاسـاسـي 🌟'
elseif MalemAsase then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:PresidentQQ:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:MresidentQQ:General:Reply") or  'المــــالكه الاسـاسـيه 🌟'
elseif TheBasicsQ then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:PresidentQ:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:PresidentQ:General:Reply") or  'المــــــالك 🌟'
elseif TheMasicsQ then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:MresidentQ:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:MresidentQ:General:Reply") or  'المــــــالكــه 🌟'
elseif TheBasics then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:President:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:President:General:Reply") or 'المنشئ الاساسي 🌟'
elseif TheMasics then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Mresident:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Mresident:General:Reply") or 'المنشئـه الاساسيـه 🌟'
elseif Originators then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Constructor:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Constructor:General:Reply") or 'المنشــىء 🌟'
elseif Origimators then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Monstructor:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Monstructor:General:Reply") or 'المنشــئـه 🌟'
elseif Managers then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Manager:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Manager:General:Reply") or 'المـــــدير 🌟'
elseif Mamagers then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Mamager:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Mamager:General:Reply") or 'المـــــديره 🌟'
elseif Addictive then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Admin:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Admin:General:Reply") or 'الادمـــــن 🌟'
elseif Mddictive then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Mdmin:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Mdmin:General:Reply") or 'الادمـــــونــه 🌟'
elseif StatusMember == "chatMemberStatusCreator" then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or 'مالك القروب'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or 'مشرف القروب'
elseif Distinguished then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Vip:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Vip:General:Reply") or 'المميــز ⭐️'
elseif Mistinguished then
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Mip:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Mip:General:Reply") or 'المميــزه ⭐️'
else
Status = Redis:get(Zelzal..'Zelzal:SetRt'..ChatId..':'..UserId) or Redis:get(Zelzal.."Zelzal:Mempar:Group:Reply"..ChatId) or Redis:get(Zelzal.."Zelzal:Mempar:General:Reply") or 'عضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'المطور الاساسي'
elseif tonumber(Num) == 2 then  
Status = 'المطور الثانوي'
elseif tonumber(Num) == 2 then  
Status = 'المطوره الثانويه'
elseif tonumber(Num) == 3 then  
Status = 'المطور'
elseif tonumber(Num) == 3 then  
Status = 'المطوره'
elseif tonumber(Num) == 4 then  
Status = 'المنشئ الاساسي'
elseif tonumber(Num) == 4 then  
Status = 'المنشئه الاساسيه'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 5 then  
Status = 'المنشئه'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 6 then  
Status = 'المديره'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
elseif tonumber(Num) == 7 then  
Status = 'الادمونه'
elseif tonumber(Num) == 8 then  
Status = 'المالك'
elseif tonumber(Num) == 8 then  
Status = 'المالكه'
else
Status = 'مميز'
end  
return Status
end
function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = bot.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
local reply_markupp = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير معلومات المجموعه ⇜ '..(t1 or change_info), data = UserId..'/groupNum1//'..user2},
},
{
{text = '- تثبيت الرسائل ⇜ '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2},
},
{
{text = '- حظر المستخدمين ⇜ '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2},
},
{
{text = '- دعوة المستخدمين ⇜ '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2},
},
{
{text = '- مسح الرسائل ⇜ '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2},
},
{
{text = '- اضافة مشرفين ⇜ '..(t6 or promote), data = UserId..'/groupNum6//'..user2},
},
{
{text = '✦ إخفـاء الامـر ✦', data ='/delAmr'}
},
}
}
edit(ChatId,MsgId,"*⇜ حـدد صلاحيات المشـرف - *", 'md', false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = bot.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function last_id(channel)
local api = request("https://java60.ml/Anubis/post_num.php?channel="..channel)
local api_decode = JSON.decode(api)
local num = api_decode["last_post_id"]
return tonumber(num)
end
function sleep(n)
os.execute("sleep " .. n)
end
if Redis:get(Zelzal..'chsource') then
chsource = Redis:get(Zelzal..'chsource')
else
chsource = "Tepthon"
end
if Redis:get(Zelzal..'chdevolper') then
chdevolper = Redis:get(Zelzal..'chdevolper')
else 
chdevolper = "PPYNY"
end
function FlterBio(Bio)
local Bio = tostring(Bio):lower()
Bio = Bio:gsub("https://[%a%d_]+",'') 
Bio = Bio:gsub("http://[%a%d_]+",'') 
Bio = Bio:gsub("telegram.dog/[%a%d_]+",'') 
Bio = Bio:gsub("telegram.me/[%a%d_]+",'') 
Bio = Bio:gsub("t.me/[%a%d_]+",'') 
Bio = Bio:gsub("[%a%d_]+.pe[%a%d_]+",'') 
Bio = Bio:gsub("@[%a%d_]+",'')
Bio = Bio:gsub("]","")
Bio = Bio:gsub("[[]","")
Bio = Bio:gsub("#[%a%d_]+",'')
return Bio
end
function getbio(User)
kk = "لا يوجد"
local url = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..User);
data = json:decode(url)
if data.result then
if data.result.bio then
kk = data.result.bio
end
end
return kk
end
function calc(math) 
math = math:gsub(" ","")
if math:match("%d+") then
local res = io.popen("echo 'scale=1; "..math.."' › bc"):read('*a')
return res
else
return "⇜ لم استطيع اجراء العملية الحسابية"
end
end
function getuser(User)
local LuaProjects = "لا يوجد"
local url = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..User);
local response = json:decode(url)
if response.result and response.result.active_usernames then
LuaProjects = response.result.active_usernames
end
return LuaProjects
end
function lock_del(msg, fa)
bot.deleteMessages(msg.chat_id, {[1] = msg.id})
end
function ctime(seconds)
local seconds = tonumber(seconds)
if seconds <= 0 then
return "00:00"
else
hours = string.format("%02.f", math.floor(seconds/3600));
mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
return mins..":"..secs
end
end
function DelClear()
bot.deleteMessages(msg.chat_id, {[1] = msg.id})
end
function coin(coin)
local Coins = tostring(coin)
local Coins = Coins:gsub('٠','0')
local Coins = Coins:gsub('١','1')
local Coins = Coins:gsub('٢','2')
local Coins = Coins:gsub('٣','3')
local Coins = Coins:gsub('٤','4')
local Coins = Coins:gsub('٥','5')
local Coins = Coins:gsub('٦','6')
local Coins = Coins:gsub('٧','7')
local Coins = Coins:gsub('٨','8')
local Coins = Coins:gsub('٩','9')
local Coins = Coins:gsub('-','')
local conis = tonumber(Coins)
return conis
end
function RunCallBack(msg)
plugin = dofile("./Callback.lua")
if plugin and plugin.Zelzal and msg then
results = plugin.Zelzal(msg)
end
end
function RunGames(msg)
plugin = dofile("./Games.lua")
if plugin and plugin.Zelzal and msg then
results = plugin.Zelzal(msg)
end
end
function zhrfa(msg)
plugin = dofile("./zhrfa.lua")
if plugin and plugin.Zelzal and msg then
results = plugin.Zelzal(msg)
end
end
function rdood(msg)
plugin = dofile("./rdood.lua")
if plugin and plugin.Zelzal and msg then
results = plugin.Zelzal(msg)
end
end
function rotba(msg)
plugin = dofile("./rotba.lua")
if plugin and plugin.Zelzal and msg then
results = plugin.Zelzal(msg)
end
end
function porn_d(msg)
plugin = dofile("./porno.lua")
if plugin and plugin.Zelzal and msg then
results = plugin.Zelzal(msg)
end
end
function locks(msg)
plugin = dofile("./locks.lua")
if plugin and plugin.Zelzal and msg then
results = plugin.Zelzal(msg)
end
end
function smsm(msg)
plugin = dofile("./smsm.lua")
if plugin and plugin.Zelzal and msg then
results = plugin.Zelzal(msg)
end
end
function to_table(index)
return serpent.block(index , {comment=false})
end
function request(req)
local link = io.popen('curl -s "'..req..'"'):read('*a')
return link
end
BASSE = "https://api.telegram.org/bot" ..Token.. "/"
function getRes(Url)
Url = BASSE .. Url
Req = https.request(Url)
Res = JSON.decode(Req)
return Res
end
function editrtp(chat,user,msgid,useri)
if Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..chat,useri) then
BanGroupz = "نعم"
else
BanGroupz = "لا"
end
if Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..chat,useri) then
SilentGroupz = "نعم"
else
SilentGroupz = "لا"
end
if Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..chat,useri)  then
TheBasicsz = "نعم"
else
TheBasicsz = "لا"
end
if Redis:sismember(Zelzal.."Zelzal:Originators:Group"..chat,useri) then
Originatorsz = "نعم"
else
Originatorsz = "لا"
end
if Redis:sismember(Zelzal.."Zelzal:Managers:Group"..chat,useri) then
Managersz = "نعم"
else
Managersz = "لا"
end
if Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..chat,useri) then
Addictivez = "نعم"
else
Addictivez = "لا"
end
if Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..chat,useri) then
Distinguishedz = "نعم"
else
Distinguishedz = "لا"
end
local reply_markup = bot.replyMarkup{type = 'inline',data = {
{
{text = '- منشئ اساسي : '..TheBasicsz, data =user..'/statusTheBasicsz/'..useri},{text = '- منشئ : '..Originatorsz, data =user..'/statusOriginatorsz/'..useri},
},
{
{text = '- مدير : '..Managersz, data =user..'/statusManagersz/'..useri},{text = '- ادمن : '..Addictivez, data =user..'/statusAddictivez/'..useri},
},
{
{text = '- مميز : '..Distinguishedz, data =user..'/statusDistinguishedz/'..useri},
},
{
{text = '- تنزيل الكل ', data =user..'/statusmem/'..useri},
},
{
{text = 'إخفـاء الامـر ', data ='/delAmr1'}
}
}
}
return edit(chat,msgid,'\n‌*⇜ تحكم بالرتب*', 'md', true, false, reply_markup)
end
-----------------
function muteUser(chat,user,msgid,useri)
if Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..chat,useri) then
BanGroup = "✓"
else
BanGroup = "✗"
end
if Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..chat,useri) then
SilentGroup = "✓"
else
SilentGroup = "✗"
end
local reply_markup = bot.replyMarkup{type = 'inline',data = {
{{text ='كتم العضو : '..SilentGroup, data =user..'/statusktm/'..useri},},
{{text ='طرد العضو : '..BanGroup, data =user..'/statusban/'..useri},},
{{text = 'إخفـاء الامـر -', data ='/delAmr1'}}}}
return edit(chat,msgid,'-› تستطيع من خلال الازرار كتم وطرد العضو \n- علامة ✓ تعني تم الامر\n- علامة ✗ تعني لم يتم الامر', 'md', true, false, reply_markup)
end
-----------------
function GetSetieng(ChatId)
if Redis:get(Zelzal.."Zelzal:Lock:phshar"..ChatId) then 
alphsar = "نعم"
else 
alphsar = "لا"    
end
if Redis:get(Zelzal.."Zelzal:Lock:alkfr"..ChatId) then 
alkfr = "نعم"
else 
alkfr = "لا"    
end
if Redis:get(Zelzal.."Zelzal:Lock:tphlesh"..ChatId) then 
tphlesh = "نعم"
else 
tphlesh = "لا"    
end
if Redis:get(Zelzal.."Zelzal:Lock:farsia"..ChatId) then 
farsia = "نعم"
else 
farsia = "لا"    
end
-----------------
if Redis:get(Zelzal.."Zelzal:lockpin"..ChatId) then 
lock_pin = "نعم"
else 
lock_pin = "لا"    
end
if Redis:get(Zelzal.."Zelzal:Lock:tagservr"..ChatId) then 
lock_tagservr = "نعم"
else 
lock_tagservr = "لا"
end
if Redis:get(Zelzal.."Zelzal:Lock:text"..ChatId) then 
lock_text = "نعم"
else 
lock_text = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:AddMempar"..ChatId) == "kick" then
lock_add = "نعم"
else 
lock_add = "لا "    
end    
if Redis:get(Zelzal.."Zelzal:Lock:Join"..ChatId) == "kick" then
lock_join = "نعم"
else 
lock_join = "لا "    
end    
if Redis:get(Zelzal.."Zelzal:Lock:edit"..ChatId) then 
lock_edit = "نعم"
else 
lock_edit = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Chek:Welcome"..ChatId) then
welcome = "نعم"
else 
welcome = "لا "    
end
if Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..ChatId, "Spam:User") == "kick" then  
flood = "بالطرد "     
elseif Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..ChatId,"Spam:User") == "keed" then  
flood = "بالتقييد "     
elseif Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..ChatId,"Spam:User") == "mute" then  
flood = "بالكتم "           
elseif Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..ChatId,"Spam:User") == "del" then  
flood = "نعم"
else     
flood = "لا "     
end
if Redis:get(Zelzal.."Zelzal:Lock:Photo"..ChatId) == "del" then
lock_photo = "نعم" 
elseif Redis:get(Zelzal.."Zelzal:Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقييد "   
elseif Redis:get(Zelzal.."Zelzal:Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "لا "   
end    
if Redis:get(Zelzal.."Zelzal:Lock:Contact"..ChatId) == "del" then
lock_phon = "نعم" 
elseif Redis:get(Zelzal.."Zelzal:Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "لا "    
end    
if Redis:get(Zelzal.."Zelzal:Lock:Link"..ChatId) == "del" then
lock_links = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:Cmd"..ChatId) == "del" then
lock_cmds = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif Redis:get(Zelzal.."Zelzal:Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:User:Name"..ChatId) == "del" then
lock_user = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:hashtak"..ChatId) == "del" then
lock_hash = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:vico"..ChatId) == "del" then
lock_muse = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "لا "    
end 
if Redis:get(Zelzal.."Zelzal:Lock:Video"..ChatId) == "del" then
lock_ved = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:Animation"..ChatId) == "del" then
lock_gif = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:Sticker"..ChatId) == "del" then
lock_ste = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:geam"..ChatId) == "del" then
lock_geam = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "لا "    
end    
if Redis:get(Zelzal.."Zelzal:Lock:vico"..ChatId) == "del" then
lock_vico = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "لا "    
end    
if Redis:get(Zelzal.."Zelzal:Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقييد "
elseif Redis:get(Zelzal.."Zelzal:Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "لا "
end
if Redis:get(Zelzal.."Zelzal:Lock:forward"..ChatId) == "del" then
lock_fwd = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "لا "    
end    
if Redis:get(Zelzal.."Zelzal:Lock:Document"..ChatId) == "del" then
lock_file = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "لا "    
end    
if Redis:get(Zelzal.."Zelzal:Lock:Unsupported"..ChatId) == "del" then
lock_self = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقييد "   
elseif Redis:get(Zelzal.."Zelzal:Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:Markdaun"..ChatId) == "del" then
lock_mark = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "لا "    
end
if Redis:get(Zelzal.."Zelzal:Lock:Spam"..ChatId) == "del" then 
lock_spam = "نعم"
elseif Redis:get(Zelzal.."Zelzal:Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقييد "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif Redis:get(Zelzal.."Zelzal:Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "لا "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam,
farsia = farsia,
tphlesh = tphlesh,
alkfr = alkfr,
alphsar = alphsar
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'ماش التفاعل' 
elseif tonumber(Message) < 200 then 
MsgText = 'تفاعلك ضعيف'
elseif tonumber(Message) < 400 then 
MsgText = 'شد حيلك' 
elseif tonumber(Message) < 700 then 
MsgText = 'تفاعلك يمشي حال' 
elseif tonumber(Message) < 1200 then 
MsgText = 'ملك التفاعل' 
elseif tonumber(Message) < 2000 then 
MsgText = 'تفاعلك يجنن' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اساس التفاعل انت'  
elseif tonumber(Message) < 4000 then 
MsgText = 'ياعيني عالتفاعل' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(Message) < 5500 then 
MsgText = 'التفاعل بطل استمر' 
elseif tonumber(Message) < 7000 then 
MsgText = 'اهنيك تفاعل رهيب' 
elseif tonumber(Message) < 9500 then 
MsgText = 'كفوو يالتفاعل' 
elseif tonumber(Message) > 100000 then 
MsgText = 'تفاعل نار وشرار'  
end 
return MsgText 
end
function Total_groups(Message)  
local MsgText = ''  
if tonumber(Message) < 200 then 
MsgText = 'غير متفاعل'
elseif tonumber(Message) < 400 then 
MsgText = 'بده يتحسن'
elseif tonumber(Message) < 600 then 
MsgText = 'شبه متفاعل'
elseif tonumber(Message) < 800 then 
MsgText = 'متفاعل'
elseif tonumber(Message) < 1000 then 
MsgText = 'متفاعل قوي'
elseif tonumber(Message) < 1300 then 
MsgText = 'متفاعل جدا'
elseif tonumber(Message) < 1600 then 
MsgText = 'اقوى تفاعل'
elseif tonumber(Message) < 1800 then 
MsgText = 'متفاعل نار'
elseif tonumber(Message) < 2200 then 
MsgText = 'قمة التفاعل'
elseif tonumber(Message) < 2600 then 
MsgText = 'ملك التفاعل'
elseif tonumber(Message) < 3000 then 
MsgText = 'امبراطور التفاعل'
elseif tonumber(Message) > 10000 then 
MsgText = 'التفاعل كلو'
end 
return MsgText 
end
function TotalNsba(Message)  
local MsgText = ''  
print(Message)
if tonumber(Message) < 200 then 
MsgText = "10"
elseif tonumber(Message) < 400 then 
MsgText = "20"
elseif tonumber(Message) < 600 then 
MsgText = "25"
elseif tonumber(Message) < 800 then 
MsgText = "33"
elseif tonumber(Message) < 1000 then 
MsgText = "45"
elseif tonumber(Message) < 1300 then 
MsgText = "52"
elseif tonumber(Message) < 1600 then 
MsgText = "67"
elseif tonumber(Message) < 1800 then 
MsgText = "70"
elseif tonumber(Message) < 2200 then 
MsgText = "75"
elseif tonumber(Message) < 2600 then 
MsgText = "80"
elseif tonumber(Message) < 3000 then 
MsgText = "85"
elseif tonumber(Message) < 3600 then 
MsgText = "88"
elseif tonumber(Message) < 4000 then 
MsgText = "89"
elseif tonumber(Message) < 5000 then 
MsgText = "90"
elseif tonumber(Message) < 6000 then 
MsgText = "92"
elseif tonumber(Message) < 8000 then 
MsgText = "93"
elseif tonumber(Message) < 10000 then 
MsgText = "94"
elseif tonumber(Message) < 11000 then 
MsgText = "95"
elseif tonumber(Message) < 12000 then 
MsgText = "96"
elseif tonumber(Message) < 11800 then 
MsgText = "97"
elseif tonumber(Message) < 14000 then 
MsgText = "98"
elseif tonumber(Message) < 30000 then 
MsgText = "99"
elseif tonumber(Message) < 10000000000 then 
MsgText = "100"
end 
return MsgText 
end
function Getpermissions(ChatId)
local Get_Chat = bot.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end
return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = bot.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = ' نعم ' else web = ' لا '
end
if Get_Chat.permissions.can_change_info then
info = ' نعم ' else info = ' لا '
end
if Get_Chat.permissions.can_invite_users then
invite = ' نعم ' else invite = ' لا '
end
if Get_Chat.permissions.can_pin_messages then
pin = ' نعم ' else pin = ' لا '
end
if Get_Chat.permissions.can_send_media_messages then
media = ' نعم ' else media = ' لا '
end
if Get_Chat.permissions.can_send_messages then
messges = ' نعم ' else messges = ' لا '
end
if Get_Chat.permissions.can_send_other_messages then
other = ' نعم ' else other = ' لا '
end
if Get_Chat.permissions.can_send_polls then
polls = ' نعم ' else polls = ' لا '
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '- تغيير معلومات القروب : '..info, data = UserId.. '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data = UserId.. '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = 'إخفـاء الامـر ', data ='/delAmr'}
},
}
}
edit(ChatId,MsgId,"‌*⇜ صلاحيات القروب : *", 'md', false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
KtmAll = Redis:sismember(Zelzal.."Zelzal:KtmAll:Groups",UserId) ,
BanAll = Redis:sismember(Zelzal.."Zelzal:BanAll:Groups",UserId) ,
BanGroup = Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..ChatId,UserId) ,
SilentGroup = Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local UserInfo = bot.getUser(UserId)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
if UserInfo.username then
UserInfousername = '['..UserInfo.first_name..'](t.me/'..UserInfo.username..')'
else
UserInfousername = '['..UserInfo.first_name..'](tg://user?id='..UserId..')'
end
return {
Lock     = '\n*⇜ بواسطـة* 「 '..UserInfousername..' 」\n*'..TextMsg..'*\n ✓',
unLock   = '\n*⇜ بواسطـة* 「 '..UserInfousername..' 」\n*'..TextMsg..'*\n ✓',
lockKtm  = '\n*⇜ بواسطـة* 「 '..UserInfousername..' 」\n*'..TextMsg..'*\n*⇜ بالكتم *',
lockKid  = '\n*⇜ بواسطـة* 「 '..UserInfousername..' 」\n*'..TextMsg..'*\n*⇜ بالتقييد *',
lockKick = '\n*⇜ بواسطـة* 「 '..UserInfousername..' 」\n*'..TextMsg..'*\n*⇜ بالطرد *',
Reply    = '\n*⇜ الحلـو*「 '..UserInfousername..' 」\n*'..TextMsg..'*',
Replly    = '\n*⇜ الحلـوه*「 '..UserInfousername..' 」\n*'..TextMsg..'*'
}
end
function Locks_Status(UserId,msg,text)
local UserInfo = bot.getUser(UserId)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
if UserInfo.username then
UserInfousername = '['..UserInfo.first_name..'](t.me/'..UserInfo.username..')'
else
UserInfousername = '['..UserInfo.first_name..'](tg://user?id='..UserId..')'
end
local StatusMember = bot.getChatMember(msg.chat_id,UserId).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
lockmode = true
else
lockmode = false
end
if (not msg.Developers or not msg.Mevelopers) and Redis:sismember(Zelzal.."Zelzal:Developers:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( المطـور ) فقـط*\n ✓'
return Locktext
elseif (lockmode == false) and Redis:sismember(Zelzal.."Zelzal:Creator:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( مـالك المجمـوعـة ) فقـط*\n ✓'
return Locktext
elseif (not msg.MalekAsase or not msg.MalemAsase) and Redis:sismember(Zelzal.."Zelzal:MalekAsase:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( المـالك الاسـاسي ) فقـط*\n ✓'
return Locktext
elseif (not msg.TheBasicsQ or not msg.TheMasicsQ) and Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( المـالك ) فقـط*\n ✓'
return Locktext
elseif (not msg.TheBasics or not msg.TheMasics) and Redis:sismember(Zelzal.."Zelzal:TheBasics:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( المنشئ الاسـاسي ) فقـط*\n ✓'
return Locktext
elseif (not msg.Originators or not msg.Origimators) and Redis:sismember(Zelzal.."Zelzal:Originators:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( المنشئ ) فقـط*\n ✓'
return Locktext
elseif (not msg.Managers or not msg.Mamagers) and Redis:sismember(Zelzal.."Zelzal:Managers:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( المديـر ) فقـط*\n ✓'
return Locktext
elseif (not msg.Addictive or not msg.Mddictive) and Redis:sismember(Zelzal.."Zelzal:Addictive:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( الادمـن ) فقـط*\n ✓'
return Locktext
elseif (not msg.Distinguished or not msg.Mistinguished) and Redis:sismember(Zelzal.."Zelzal:Distinguished:Cmd:Lock"..msg.chat_id,text) then
Locktext = '\n*⇜ عـذراً عـزيـزي* 「 '..UserInfousername..' 」\n*⇜ امـر ( *'..text..'* ) مغـلق 🚫\n⇜ تم تخصيصه لـ ( المميـز ) فقـط*\n ✓'
return Locktext
else
Locktext = 'noon'
return Locktext
end
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
local Controll2 = Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId)
DevelopersQ = Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId) 
MevelopersQ = Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId) 
Developers = Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId)
Mevelopers = Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId) 
TheBasicsQ = Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..ChatId,UserId)
TheMasicsQ = Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..ChatId,UserId) 
TheBasics = Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..ChatId,UserId)
TheMasics = Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Zelzal.."Zelzal:Originators:Group"..ChatId,UserId)
Origimators = Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..ChatId,UserId)
Managers = Redis:sismember(Zelzal.."Zelzal:Managers:Group"..ChatId,UserId)
Mamagers = Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..ChatId,UserId)
Mddictive = Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..ChatId,UserId)
Mistinguished = Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..ChatId,UserId)
StatusMember = bot.getChatMember(ChatId,UserId).status.luatele
MalekAsase = Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..ChatId,UserId)
MalemAsase = Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..ChatId,UserId)
if UserId == 1895219306 then
Status = true
elseif UserId == 925972505 or UserId == 5746412340 or UserId == 6269975462 or UserId == 1985225531 then
Status = true
elseif UserId == Sudo_Id or Controll2 then
Status = true
elseif UserId == Zelzal then
Status = true
elseif DevelopersQ or MevelopersQ then
Status = true
elseif Developers or Mevelopers then
Status = true
elseif MalekAsase or MalemAsase then
Status = true
elseif TheBasicsQ or TheMasicsQ then
Status = true
elseif TheBasics or TheMasics then
Status = true
elseif Originators or Origimators then
Status = true
elseif Managers or Mamagers then
Status = true
elseif Addictive or Mddictive then
Status = true
elseif Distinguished or Mistinguished then
Status = true
else
Status = false
end  
return Status
end 
function StatusCanOrNotCanin(ChatId,UserId)
Status = nil
local Controll2 = Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId)
DevelopersQ = Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId) 
MevelopersQ = Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId) 
Developers = Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId)
Mevelopers = Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId) 
TheBasicsQ = Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..ChatId,UserId)
TheMasicsQ = Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..ChatId,UserId) 
TheBasics = Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..ChatId,UserId)
TheMasics = Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Zelzal.."Zelzal:Originators:Group"..ChatId,UserId)
Origimators = Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..ChatId,UserId)
Managers = Redis:sismember(Zelzal.."Zelzal:Managers:Group"..ChatId,UserId)
Mamagers = Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..ChatId,UserId)
Mddictive = Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..ChatId,UserId)
Mistinguished = Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..ChatId,UserId)
StatusMember = bot.getChatMember(ChatId,UserId).status.luatele
MalekAsase = Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..ChatId,UserId)
MalemAsase = Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..ChatId,UserId)
if UserId == 1895219306 then
Status = true
elseif UserId == 925972505 or UserId == 5746412340 or UserId == 6269975462 or UserId == 1985225531 then
Status = true
elseif UserId == Sudo_Id or Controll2 then
Status = true
elseif UserId == Zelzal then
Status = true
elseif DevelopersQ or MevelopersQ then
Status = true
elseif Developers or Mevelopers then
Status = true
elseif MalekAsase or MalemAsase then
Status = true
elseif TheBasicsQ or TheMasicsQ then
Status = true
elseif TheBasics or TheMasics then
Status = true
elseif Originators or Origimators then
Status = true
elseif Managers or Mamagers then
Status = true
elseif Addictive or Mddictive then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
local Controll2 = Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId)
DevelopersQ = Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId)
MevelopersQ = Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId) 
Developers = Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId)
Mevelopers = Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId) 
TheBasicsQ = Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..ChatId,UserId)
TheMasicsQ = Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..ChatId,UserId) 
TheBasics = Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..ChatId,UserId)
TheMasics = Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Zelzal.."Zelzal:Originators:Group"..ChatId,UserId)
Origimators = Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..ChatId,UserId)
Managers = Redis:sismember(Zelzal.."Zelzal:Managers:Group"..ChatId,UserId)
Mamagers = Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..ChatId,UserId)
Mddictive = Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..ChatId,UserId)
Mistinguished = Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..ChatId,UserId)
StatusMember = bot.getChatMember(ChatId,UserId).status.luatele
MalekAsase = Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..ChatId,UserId)
MalemAsase = Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..ChatId,UserId)
if UserId == 1895219306 then
Status = true
elseif UserId == 925972505 or UserId == 5746412340 or UserId == 6269975462 or UserId == 1985225531 then
Status = true
elseif UserId == Sudo_Id or Controll2 then
Status = true
elseif UserId == Zelzal then
Status = true
elseif DevelopersQ or MevelopersQ then
Status = true
elseif Developers or Mevelopers then
Status = true
elseif MalekAsase or MalemAsase then
Status = true
elseif TheBasicsQ or TheMasicsQ then
Status = true
elseif TheBasics or TheMasics then
Status = true
elseif Originators or Origimators then
Status = true
elseif Managers or Mamagers then
Status = true
elseif Addictive or Mddictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
else
Status = false
end  
return Status
end 
function GetInfoBot(msg)
local GetMemberStatus = bot.getChatMember(msg.chat_id,Zelzal).status.rights
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{
SetAdmin = promote,
BanUser = restrict_members,
Invite = invite_users,
PinMsg = pin_messages,
DelMsg = delete_messages,
Info = change_info
}
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
local function Info_Video(x)
local f=io.popen(x)
if f then
local s=f:read"*a"
f:close()
if s == 'a' then
end
return s
end
end
-----------------
function downloadd(FileUrl, FilePath, FileName)
local respbody = {}
local options = {
url = FileUrl,
sink = ltn12.sink.table(respbody),
redirect = true
}
local response = nil
if FileUrl:starts("https") then
options.redirect = false
response = {
https.request(options)
}
else
response = {
http.request(options)
}
end
local code = response[2]
local headers = response[3]
local status = response[4]
if code ~= 200 then
return nil
end
FilePathToSave = FilePath .. "/" .. FileName
file = io.open(FilePathToSave, "w+")
file:write(table.concat(respbody))
file:close()
return FilePathToSave
end
-----------------
function ChannelJoinch(msg)
JoinChannel = true
local Channel = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)
if Channel then
local url , res = https.request('https://api.telegram.org/bot'..Token..'/getchatmember?chat_id=@'..Channel..'&user_id='..msg.sender_id.user_id)
local ChannelJoin = JSON.decode(url)
var(ChannelJoin)
if ChannelJoin.result.status == "left" then
JoinChannel = false
end
end
return JoinChannel
end
function ChannelJoin(msg)
JoinChannel = true
if not Redis:sismember(Zelzal.."BotFree:Group:",msg.chat_id) then
local Channel = Redis:get(Zelzal..'Zelzal:Channel:Join')
if Channel then
local url , res = https.request('https://api.telegram.org/bot'..Token..'/getchatmember?chat_id=@'..Channel..'&user_id='..msg.sender_id.user_id)
if res == 200 then
local ChannelJoin = JSON.decode(url)
if ChannelJoin.result.status == "left" then
JoinChannel = false
end
end
end
end
return JoinChannel
end
-----------------
function edit(chat,rep,text,parse, dis, disn, reply_markup)
shh = tostring(text)
if Redis:get(Zelzal..'rmzsource') then
shh = shh:gsub("⇜",Redis:get(Zelzal..'rmzsource'))
end
local listm = Redis:smembers(Zelzal.."Words:r")
for k,v in pairs(listm) do
i ,j  = string.find(shh, v)
if j and i then
local x = string.sub(shh, i,j)
local neww = Redis:get(Zelzal.."Word:Replace"..x)  
shh = shh:gsub(x,neww)
else
shh = shh
end
end
return bot.editMessageText(chat,rep,shh, parse, dis, disn, reply_markup)
end
function send(chat,rep,text,parse,dis,clear,disn,back,markup)
sh = tostring(text)
if Redis:get(Zelzal..'rmzsource') then
sh = sh:gsub("⇜",Redis:get(Zelzal..'rmzsource'))
end
local listm = Redis:smembers(Zelzal.."Words:r")
for k,v in pairs(listm) do
i ,j  = string.find(sh, v)
if j and i then
local x = string.sub(sh, i,j)
local neww = Redis:get(Zelzal.."Word:Replace"..x)  
sh = sh:gsub(x,neww)
else
sh = sh
end
end
return bot.sendText(chat,rep,sh,parse,dis, clear, disn, back, markup)
end
function ss(msg,text) 
return send(msg.chat_id,msg.id,text)
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender_id.user_id
local msg_id = msg.id
local text = nil
if msg.reply_to_message_id ~= 0 then
local mrply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if mrply and mrply.sender_id then
rep_idd = mrply.sender_id.user_id or mrply.sender_id.chat_id
else
return false 
end
end
if msg.date and msg.date < tonumber(os.time() - 15) then
return false
end
if data.content.text then
text = data.content.text.text
end
if tonumber(msg.sender_id.user_id) == tonumber(Zelzal) then
print('This is reply for Bot')
return false
end
if msg.sender_id.luatele == "messageSenderChat" then
if Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,msg.sender_id.user_id) then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if Redis:get(Zelzal.."Zelzal:Lock:SenderChat"..msg_chat_id) then
local m = Redis:get(Zelzal.."chadmin"..msg_chat_id) 
if msg.sender_id.user_id == tonumber(m) or msg.sender_id.user_id == tonumber(msg_chat_id) then
return false
else
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
return false
end
if tonumber(msg.sender_id.user_id) == 1260465030 then
msg.Name_Controller = 'مبرمج السورس🎖️'
msg.The_Controller = 1
elseif tonumber(msg.sender_id.user_id) == 1260465030 or tonumber(msg.sender_id.user_id) == 1260465030 or tonumber(msg.sender_id.user_id) == 1260465030 then
msg.Name_Controller = 'مطور السورس🎖️️'
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender_id.user_id) == true then  
msg.The_Controller = 1
msg.Name_Controller = Redis:get(Zelzal.."Zelzal:Sudo:General:Reply") or 'مطور اساسي🎖️'
elseif Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",msg.sender_id.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = Redis:get(Zelzal.."Zelzal:Sudo2:General:Reply") or 'مطور اساسي²🎖️'
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",msg.sender_id.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = Redis:get(Zelzal.."Zelzal:DeveloperQ:General:Reply") or 'المطـور الثانوي '
elseif Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",msg.sender_id.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = Redis:get(Zelzal.."Zelzal:MeveloperQ:General:Reply") or 'المطـوره الثـانويـه'
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",msg.sender_id.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Developer:Bot:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Developer:General:Reply") or 'المطـــور '
elseif Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",msg.sender_id.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Meveloper:Bot:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Meveloper:General:Reply") or 'المطـــوره '
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 444
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:PresidentQQ:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:PresidentQQ:General:Reply") or  'المــــالك الاسـاسـي 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 444
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:PresidentQQ:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:MresidentQQ:General:Reply") or  'المــــالكه الاسـاسـيه 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:PresidentQ:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:PresidentQ:General:Reply") or  'المــــــالك 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:MresidentQ:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:MresidentQ:General:Reply") or  'المــــــالكــه 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:President:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:President:General:Reply") or 'المنشئ الاساسي 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Mresident:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Mresident:General:Reply") or 'المنشئـه الاساسيـه 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Constructor:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Constructor:General:Reply") or 'المنشــىء 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Monstructor:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Monstructor:General:Reply") or 'المنشــئـه 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Manager:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Manager:General:Reply") or 'المـــــدير 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Mamager:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Mamager:General:Reply") or 'المـــــديره 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Admin:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Admin:General:Reply") or 'الادمـــــن 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Mdmin:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Mdmin:General:Reply") or 'الادمـــــونــه 🌟'
elseif Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Vip:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Vip:General:Reply") or 'المميــز ⭐️'
elseif Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Mip:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Mip:General:Reply") or 'المميــزه ⭐️'
elseif Redis:sismember(Zelzal.."Zelzal:Cleener:Group"..msg.chat_id,msg.sender_id.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Vip:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Vip:General:Reply") or 'المنظـف'
elseif tonumber(msg.sender_id.user_id) == tonumber(Zelzal) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.Name_Controller = Redis:get(Zelzal..'Zelzal:SetRt'..msg.chat_id..':'..msg.sender_id.user_id) or Redis:get(Zelzal.."Zelzal:Mempar:Group:Reply"..msg.chat_id) or Redis:get(Zelzal.."Zelzal:Mempar:General:Reply") or 'عضو'
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.Controll2 = true
msg.DevelopersQ = true
msg.MevelopersQ = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Developers = true
msg.Mevelopers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 444 or msg.The_Controller == 9 then
msg.MalekAsase = true
msg.MalemAsase = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 444 or msg.The_Controller == 9 then
msg.Cleener = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 444 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.TheBasicsQ = true
msg.TheMasicsQ = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 444 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 9 then
msg.TheBasics = true
msg.TheMasics = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 444 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Originators = true
msg.Origimators = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 444 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Managers = true
msg.Mamagers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 444 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Addictive = true
msg.Mddictive = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 444 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Distinguished = true
msg.Mistinguished = true
end
-----------------
if msg.sender_id.luatele ~= "messageSenderChat" then
if Redis:get(Zelzal.."Zelzal:Game:akape"..msg.chat_id..msg.sender_id.user_id) then
if text == Redis:get(Zelzal.."Zelzal:Game:akape"..msg.chat_id..msg.sender_id.user_id) then 
Redis:del(Zelzal.."Zelzal:Game:akape"..msg.chat_id..msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
return send(msg_chat_id,msg_id,"\n‌*⇜ اجابتك صحيحة\n‌⇜ تم رفع القيود عنك*","md",true)  
end
end
if Statusrestricted(msg.chat_id,msg.sender_id.user_id).KtmAll == true then
return bot.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Statusrestricted(msg.chat_id,msg.sender_id.user_id).BanAll == true then
return bot.deleteMessages(msg.chat_id,{[1]= msg.id}),bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender_id.user_id).BanGroup == true then
return bot.deleteMessages(msg.chat_id,{[1]= msg.id}),bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender_id.user_id).SilentGroup == true then
return bot.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if text then
Redis:incr(Zelzal.."Num:MssEgeS:Days"..msg.chat_id..os.date("%d")) 
elseif msg.content.luatele == "messageChatAddMembers" then
Redis:incr(Zelzal.."Num:AddMempber:Days"..msg.chat_id..os.date("%d")) 
elseif msg.content.luatele == "messagePinMessage" then
Redis:incr(Zelzal.."Num:PinMsg:Days"..msg.chat_id..os.date("%d")) 
elseif msg.content.luatele == "messageChatJoinByLink" then
Redis:incr(Zelzal.."Num:joinlink:Days"..msg.chat_id..os.date("%d"))
elseif msg.content.luatele == "messageChatDeleteMember" then
Redis:incr(Zelzal.."Num:DelMember:Days"..msg.chat_id..os.date("%d"))
end
-----------------
if msg.content.luatele == "messageChatJoinByLink" and Redis:get(Zelzal..'Zelzal:Status:joinet'..msg.chat_id) == 'true' then
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'انا لست بوت', data = msg.sender_id.user_id..'/UnKed'},
},
}
} 
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg.chat_id, msg.id, '‌*⇜ اختر انا لست بوت لكي اتحقق منك*', 'md',false, false, false, false, reply_markup)
end
if (Redis:get(Zelzal..'Zelzal:All:FilterText'..msg_chat_id..':'..msg.sender_id.user_id) == 'DelFilterq') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
print('&')
if msg.content.luatele == "messagePhoto" then
Filters = 'الصوره'
Redis:srem(Zelzal.."Zelzal:All:List:Filter",'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(Zelzal.."Zelzal:All:Filter:Group:"..msg.content.photo.sizes[1].photo.id)  
elseif msg.content.luatele == "messageAnimation" then
Filters = 'المتحركه'
Redis:srem(Zelzal.."Zelzal:All:List:Filter",'animation:'..msg.content.animation.animation.id)  
Redis:del(Zelzal.."Zelzal:All:Filter:Group:"..msg.content.animation.animation.id)  
elseif msg.content.luatele == "messageSticker" then
Filters = 'الملصق'
Redis:srem(Zelzal.."Zelzal:All:List:Filter",'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(Zelzal.."Zelzal:All:Filter:Group:"..msg.content.sticker.sticker.id)  
elseif text then
Redis:srem(Zelzal.."Zelzal:All:List:Filter",'text:'..text)  
Redis:del(Zelzal.."Zelzal:All:Filter:Group:"..text)  
Filters = 'النص'
end
Redis:del(Zelzal..'Zelzal:All:FilterText'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"‌⇜ تم الغاء منع ("..Filters..") عام","md",true)  
end
end
if Redis:get(Zelzal.."Zelzal:Lock:text"..msg_chat_id) and not msg.Distinguished then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" and not msg.MalekAsase then
if Redis:get(Zelzal.."Zelzal:Lock:Join"..msg.chat_id) == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
if msg.content.luatele == "messageChatJoinByLink" and not msg.Distinguished then
if Redis:get(Zelzal.."Lock:JoinFarsi"..msg.chat_id) == "kick" then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local names = FlterBio(UserInfo.first_name) 
if names and (names:match("ژ") or names:match("چ") or names:match("۴") or names:match("مهسا") or names:match("sara") or names:match("گ") or names:match("نازنین") or names:match("آسمان") or names:match("ڄ") or names:match("پ") or names:match("Sanaz") or names:match("𝓈𝒶𝓇𝒶") or names:match("سارة") or names:match("GIRL") or names:match("Lady") or names:match("فتاة") or names:match("👅")) then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif names and (names:match("سمانه") or names:match("بهار") or names:match("maryam") or names:match("👙") or names:match("هانیه") or names:match("هستی") or names:match("💋") or names:match("ندا") or names:match("Mina") or names:match("خانم") or names:match("ایناز") or names:match("مبینا") or names:match("امینی") or names:match("سرنا") or names:match("اندیشه") or names:match("لنتكلم") or names:match("دریا") or names:match("زاده") or names:match("نااز") or names:match("بیتا") or names:match("💄")) then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
local Lock_Bots = Redis:get(Zelzal.."Zelzal:Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
if tonumber(v) ~= tonumber(Zelzal) then
local Info_User = bot.getUser(v) 
if Info_User.type.luatele == "userTypeBot" then
if Lock_Bots == "del" and (not msg.Managers or not msg.Mamagers) then
bot.setChatMemberStatus(msg.chat_id,v,'banned',0)
elseif Lock_Bots == "kick" and (not msg.Managers or not msg.Mamagers) then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
end
end
end
end
if msg.content.luatele == "messageChatAddMembers" then
Redis:incr(Zelzal.."Zelzal:Num:Add:Memp"..msg_chat_id..":"..msg.sender_id.user_id) 
end
if msg.content.luatele == "messageChatJoinByLink" then
if Redis:get(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id) then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
UserIdMalek = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
UserIdMalek = v.member_id.user_id
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,v.member_id.user_id) 
else
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,v.member_id.user_id) 
end
end
end
local UserInfoo = bot.getUser(UserIdMalek)
if UserInfoo.first_name == "" then
keyboardd = {} 
keyboardd.inline_keyboard = {
{{text = '˹𓌗 قنـاة البـوت 𓌗.',url="t.me/"..chsource..""}},
}
else
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = 'المالك', url='tg://user?id='..UserIdMalek},
},
}
end
local Welcome = Redis:get(Zelzal.."Zelzal:Welcome:Group"..msg_chat_id)
if Welcome then
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*⇜ مرحباً عزيزي المالك 🧚‍♀*\n*⇜ عضو جديد انضـم لـ القـروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'',"md",false, false, false, false, reply_markup)
end
if UserInfo.username then
UserInfousername = '@'..UserInfo.username
else
UserInfousername = 'لا يوجد '
end
Welcome = Welcome:gsub('{الاسم}',"["..(FlterBio(UserInfo.first_name)..'](tg://user?id='..msg.sender_id.user_id..')' or '---')) 
Welcome = Welcome:gsub('{اليوزر}',("@"..UserInfo.username or '---')) 
Welcome = Welcome:gsub('{المجموعه}',(Get_Chat.title or '---')) 
Welcome = Welcome:gsub('{الاعضاء}',Info_Chats.member_count) 
Welcome = Welcome:gsub('{الادمنيه}',Info_Chats.administrator_count) 
Welcome = Welcome:gsub('{الوقت}',os.date("%H:%M:%S")) 
Welcome = Welcome:gsub('{التاريخ}',os.date("%Y/%m/%d")) 
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(Welcome)..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else 
local GroupsWelcome = Redis:get(Zelzal.."Zelzal:Welcome:Groups")
if GroupsWelcome then
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*⇜ مرحباً عزيزي المالك 🧚‍♀*\n*⇜ عضو جديد انضـم لـ القـروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'',"md",false, false, false, false, reply_markup)
end
GroupsWelcome = GroupsWelcome:gsub('{الاسم}',"["..(FlterBio(UserInfo.first_name)..'](tg://user?id='..msg.sender_id.user_id..')' or '---')) 
GroupsWelcome = GroupsWelcome:gsub('{اليوزر}',("@"..UserInfo.username or '---')) 
GroupsWelcome = GroupsWelcome:gsub('{المجموعه}',(Get_Chat.title or '---')) 
GroupsWelcome = GroupsWelcome:gsub('{الاعضاء}',Info_Chats.member_count) 
GroupsWelcome = GroupsWelcome:gsub('{الادمنيه}',Info_Chats.administrator_count) 
GroupsWelcome = GroupsWelcome:gsub('{الوقت}',os.date("%H:%M:%S")) 
GroupsWelcome = GroupsWelcome:gsub('{التاريخ}',os.date("%Y/%m/%d")) 
local TextWelcome = (GroupsWelcome or "يآهلا وسهلآ بغالي\nالله يحييك نوّرت قروبنا\n✓")
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TextWelcome)..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TextWelcome = ("يآهلا وسهلآ بالغآلي \nالله يحييك نوّرت قروبنا\n✓")
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TextWelcome)..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
end
if (not msg.Distinguished or not msg.Mistinguished) and msg.content.luatele ~= "messageChatAddMembers" and Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender_id.user_id) == tonumber(Zelzal) then
return false
end
local floods = Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_Max = Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(Redis:get(Zelzal.."Zelzal:Spam:Cont"..msg.sender_id.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0), send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"‌⇜ كرر نفس الرسالة وتم طرده").Reply,"md",true)
end
if type == "del" then 
return bot.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ كرر نفس الرسالة وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ كرر نفس الرسالة وتم كتمه").Reply,"md",true)  
end
end
Redis:setex(Zelzal.."Zelzal:Spam:Cont"..msg.sender_id.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_Max = Redis:hget(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 
if text and not msg.Distinguished then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if Redis:get(Zelzal.."Zelzal:Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الكلايش \n ✓',"md")
end
elseif Redis:get(Zelzal.."Zelzal:Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الكلايش \n ✓',"md")
end
elseif Redis:get(Zelzal.."Zelzal:Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الكلايش \n ✓',"md")
end
elseif Redis:get(Zelzal.."Zelzal:Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الكلايش \n ✓',"md")
end
end
end
if msg.forward_info and (not msg.Managers or not msg.Mamagers) then -- التوجيه
local Fwd_Group = Redis:get(Zelzal.."Zelzal:Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل توجيه \n ✓',"md")
end
elseif Fwd_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل توجيه \n ✓',"md")
end
elseif Fwd_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل توجيه \n ✓',"md")
end
elseif Fwd_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل توجيه \n ✓',"md")
end
end
return false
end 
if msg.content.luatele == "messagePhoto" or msg.content.luatele == "messageAnimation" or msg.content.luatele == "messageSticker" or msg.content.luatele == "messageVoiceNote" or msg.content.luatele == "messageVideo" or msg.content.luatele == "messageAudio" or msg.content.luatele == "messageVideoNote" then
if not msg.Addictive or not msg.Mddictive then
if Redis:get(Zelzal.."Zelzal:Lock:AlUasat"..msg_chat_id) then 
return bot.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
end
if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Distinguished then  -- الكيبورد
local Keyboard_Group = Redis:get(Zelzal.."Zelzal:Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل كيبورد \n ✓',"md")
end
elseif Keyboard_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل كيبورد \n ✓',"md")
end
elseif Keyboard_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل كيبورد \n ✓',"md")
end
elseif Keyboard_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل كيبورد \n ✓',"md")
end
end
end
end 
local UserInfo = bot.getUser(msg.sender_id.user_id)
if msg.sender_id.user_id ~= 1895219306 then 
local names = (UserInfo.first_name or '...')..(UserInfo.last_name or '...')
if names and  names:find("𝙕 .࿆𝜜 .࿆𝙕") then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
return send(msg_chat_id,0,'[ليه منتحل اسم مطور السورس ياورع](tg://user?id='..msg.sender_id.user_id..')',"md")
end
end
if msg.sender_id.user_id ~= 925972505 then 
local names = (UserInfo.first_name or '...')..(UserInfo.last_name or '...')
if names and  names:find("𝖹Ꭵᥣᴢᥲ️ᥣ") then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
return send(msg_chat_id,0,'[ليه منتحل اسم مطور السورس ياورع](tg://user?id='..msg.sender_id.user_id..')',"md")
end
end
if msg.sender_id.user_id ~= Sudo_Id and Redis:get(Zelzal.."thiftname") then
local names = (UserInfo.first_name or '...')..(UserInfo.last_name or '...')
local thift = Redis:get(Zelzal.."Zelzal:Thift:Bot")
if names and  names:find(thift) then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
send(msg_chat_id,0,'[ليه منتحل اسم مطوري ياورع 😡](tg://user?id='..msg.sender_id.user_id..')',"md")
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
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
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ مرحبًـا سيـدي المطـور 🙋🏻‍♀*\n*⇜ حيـوان جديـد منتحـل اسمـك 🥷*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمـه :* '..klajq..' \n*⇜ ايديـه :* '..msg.sender_id.user_id..'\n*⇜ يـوزره :* @'..basgk..'',"md",false, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ مرحبًـا سيـدي المطـور 🙋🏻‍♀*\n*⇜ حيـوان جديـد منتحـل اسمـك 🥷*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمـه :* '..klajq..' \n*⇜ ايديـه :* '..msg.sender_id.user_id..'\n*⇜ يـوزره :* @'..basgk..'',"md",false, false, false, false, reply_markup)
end
end
end
if Redis:get(Zelzal..msg.chat_id.."thiftgname") then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
SenderMalik = true
else
SenderMalik = false
end
if SenderMalik == false then
local names = (UserInfo.first_name or '...')..(UserInfo.last_name or '...')
local thift = Redis:get(Zelzal..msg.chat_id.."Zelzal:Thift:Group")
if names and  names:find(thift) then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
send(msg_chat_id,0,'[ليه منتحل اسم مالك القروب ياورع 😡](tg://user?id='..msg.sender_id.user_id..')',"md")
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
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
if Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id) then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:BotGroub"..msg.chat_id)
send(Loger_Id,0,'\n*⇜ مرحبًـا سيـدي المـالك 🙋🏻‍♀*\n*⇜ حيـوان جديـد منتحـل اسمـك 🥷*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمـه :* '..klajq..' \n*⇜ ايديـه :* '..msg.sender_id.user_id..'\n*⇜ يـوزره :* @'..basgk..'',"md",false, false, false, false, reply_markup)
end
end
end
end
if msg.content.location and not msg.Distinguished then  -- الموقع
if location then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مواقع \n ✓',"md")
end
end
end 
if msg.content.text and msg.content.text.entities and msg.content.text.entities[0] and msg.content.text.entities[0].type.luatele == "textEntityTypeTextUrl" or msg.content.text and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type.luatele == "textEntityTypeTextUrl" then
if not msg.Addictive or not msg.Mddictive then  -- الماركداون
local Markduan_Gtoup = Redis:get(Zelzal.."Zelzal:Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n 」'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الماركداون \n ✓',"md")
end
elseif Markduan_Gtoup == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الماركداون \n ✓',"md")
end
elseif Markduan_Gtoup == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الماركداون \n ✓',"md")
end
elseif Markduan_Gtoup == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الماركداون \n ✓',"md")
end
end
end
end 
if msg.content.game and not msg.Distinguished then  -- الالعاب
local Games_Group = Redis:get(Zelzal.."Zelzal:Lock:geam"..msg_chat_id)
if Games_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الالعاب \n ✓',"md")
end
elseif Games_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الالعاب \n ✓',"md")
end
elseif Games_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الالعاب \n ✓',"md")
end
elseif Games_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الالعاب \n ✓',"md")
end
end
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = Redis:get(Zelzal.."Zelzal:lockpin"..msg_chat_id)
if Pin_Msg and (not msg.Managers or not msg.Managers) then
if Pin_Msg:match("(%d+)") then 
local PinMsg = bot.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return send(msg_chat_id,msg_id,"\n⇜ المعذرة ماعندي صلاحية تثبيت الرسائل","md",true)
end
end
local UnPin = bot.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return send(msg_chat_id,msg_id,"\n⇜ المعذرة ماعندي صلاحية الغاء تثبيت الرسائل","md",true)
end
return send(msg_chat_id,msg_id,"\n⇜ تثبيت الرسائل مقفل بالقروب","md",true)
end
end 
if msg.content.luatele == "messageChatJoinByLink" then
if Redis:get(Zelzal.."Zelzal:Lock:Join"..msg.chat_id) == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
if msg.content.luatele == "messageChatDeleteMember" and not Redis:get(Zelzal.."spammkick"..msg.chat_id) then 
if msg.sender_id.user_id ~= Zelzal then
Num_Msg_Max = 4
local UserInfo = bot.getUser(msg.sender_id.user_id)
local names = FlterBio(UserInfo.first_name)
local monsha = Redis:smembers(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id) 
if Redis:ttl(Zelzal.."mkal:setex:" .. msg.chat_id .. ":" .. msg.sender_id.user_id) < 0 then
Redis:del(Zelzal.."delmembars"..msg.chat_id..msg.sender_id.user_id)
end
local ttsaa = (Redis:get(Zelzal.."delmembars"..msg.chat_id..msg.sender_id.user_id) or 0)
if tonumber(ttsaa) >= tonumber(3) then 
local type = Redis:hget(Zelzal.."Storm:Spam:Group:User"..msg.chat_id,"Spam:User") 
local removeMembars = https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg.chat_id .. "&user_id=" ..msg.sender_id.user_id.."&can_change_info=false&can_manage_chat=false&can_manage_voice_chats=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
local Json_Info = JSON.decode(removeMembars)
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg.chat_id,msg.sender_id.user_id)
if Json_Info.ok == false and Json_Info.error_code == 400 and Json_Info.description == "Bad Request: CHAT_ADMIN_REQUIRED" then
if #monsha ~= 0 then 
local ListMembers = '\n*⇜ تاك للمالكين*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(monsha) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local v = monsha[1]
local tecxt = ListMembers.."\n• نداء للمالك {[ > Click < ](tg://user?id="..v..")}"..
"\n• المشرف {["..names.." ](tg://user?id="..msg.sender_id.user_id..")}"..
"\n• قام بالتكرار في ازاله الاعضاء \n• لا يمكنني تنزيله من المشرفين"
send(msg_chat_id,msg_id,tecxt,"md")
end
end
if Json_Info.ok == false and Json_Info.error_code == 400 and Json_Info.description == "Bad Request: can't remove chat owner" then
if #monsha ~= 0 then 
local ListMembers = '\n*⇜ تاك للمالكين*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(monsha) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local v = monsha[1]
local tecxt = ListMembers.."\n• نداء للمالك {[ > Click < ](tg://user?id="..v..")}"..
"\n• المشرف {["..names.." ](tg://user?id="..msg.sender_id.user_id..")}"..
"\n• هناك عمليه تخريب وطرد الاعضاء , ليست لدي صلاحيه اضافه مشرفين لتنزيله"
send(msg_chat_id,msg_id,tecxt,"md")
end
end
if Json_Info.ok == true and Json_Info.result == true then
if #monsha ~= 0 then 
local ListMembers = '\n*⇜ تاك للمالكين*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(monsha) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local v = monsha[1]
local tecxt = ListMembers.."\n• نداء للمالك {[ > Click < ](tg://user?id="..v..")}"..
"\n• المشرف {["..names.." ](tg://user?id="..msg.sender_id.user_id..")}"..
"\n• قام بتكرار طرد الاعضاء وطرد اكثر من 3 وتم تنزيله من المشرفين "
send(msg_chat_id,0,tecxt,"md")
end
end
Redis:del(Zelzal.."delmembars"..msg.chat_id..msg.sender_id.user_id)
end
Redis:setex(Zelzal.."mkal:setex:" .. msg.chat_id .. ":" .. msg.sender_id.user_id, 3600, true) 
Redis:incrby(Zelzal.."delmembars"..msg.chat_id..msg.sender_id.user_id, 1)  
end
end

if text and text:match('طرد @(.*)') or text and text:match('حظر @(.*)') or text and text:match('طرد (%d+)') or text and text:match('حظر (%d+)') then 
if not Redis:get(Zelzal.."spammkick"..msg.chat_id) then 
if msg.sender_id.user_id ~= Zelzal then
Num_Msg_Max = 4
local UserInfo = bot.getUser(msg.sender_id.user_id)
local names = FlterBio(UserInfo.first_name)  
local monsha = Redis:smembers(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id) 
if Redis:ttl(Zelzal.."qmkal:setex:" .. msg.chat_id .. ":" .. msg.sender_id.user_id) < 0 then
Redis:del(Zelzal.."qdelmembars"..msg.chat_id..msg.sender_id.user_id)
end
local ttsaa = (Redis:get(Zelzal.."qdelmembars"..msg.chat_id..msg.sender_id.user_id) or 0)
if tonumber(ttsaa) >= tonumber(5) then 
local removeMembars = https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg.chat_id .. "&user_id=" ..msg.sender_id.user_id.."&can_change_info=false&can_manage_chat=false&can_manage_voice_chats=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
local Json_Info = JSON.decode(removeMembars)
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg.chat_id,msg.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg.chat_id,msg.sender_id.user_id)
if Json_Info.ok == false and Json_Info.error_code == 400 and Json_Info.description == "Bad Request: CHAT_ADMIN_REQUIRED" then
if #monsha ~= 0 then 
local ListMembers = '\n*⇜ تاك للمالكين*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(monsha) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local tecxt = ListMembers.."\n• المشرف {["..names.." ](tg://user?id="..msg.sender_id.user_id..")}"..
"\n• قام بالتكرار في ازاله الاعضاء \n• لا يمكنني تنزيله من المشرفين"
send(msg_chat_id,msg_id,tecxt,"md")
end
end
if Json_Info.ok == false and Json_Info.error_code == 400 and Json_Info.description == "Bad Request: can't remove chat owner" then
if #monsha ~= 0 then 
local ListMembers = '\n*⇜ تاك للمالكين*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(monsha) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local tecxt = ListMembers.."\n• المشرف {["..names.." ](tg://user?id="..msg.sender_id.user_id..")}"..
"\n• هناك عمليه تخريب وطرد الاعضاء , ليست لدي صلاحيه اضافه مشرفين لتنزيله"
send(msg_chat_id,msg_id,tecxt,"md")
end
end
if Json_Info.ok == true and Json_Info.result == true then
if #monsha ~= 0 then 
local ListMembers = '\n*⇜ تاك للمالكين*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(monsha) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local v = monsha[1]
local tecxt = ListMembers.."\n• نداء للمالك {[ > Click < ](tg://user?id="..v..")}"..
"\n• المشرف {["..names.." ](tg://user?id="..msg.sender_id.user_id..")}"..
"\n• قام بتكرار طرد الاعضاء وطرد اكثر من 3 وتم تنزيله من المشرفين "
send(msg_chat_id,msg_id,tecxt,"md")
end
end
Redis:del(Zelzal.."qdelmembars"..msg.chat_id..msg.sender_id.user_id)
end
Redis:setex(Zelzal.."qmkal:setex:" .. msg.chat_id .. ":" .. msg.sender_id.user_id, 3600, true) 
Redis:incrby(Zelzal.."qdelmembars"..msg.chat_id..msg.sender_id.user_id, 1)  
end
end 
end

if msg.content.luatele == "messagePhoto" and Redis:get(Zelzal..'welcom_ph:witting'..msg.sender_id.user_id) then  -- الصور
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal..':WELCOME_BOT',idPhoto)
Redis:del(Zelzal..'welcom_ph:witting'..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, '⇜ تم تغيير صورة ترحيب البوت\n ✓')
end
if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
Redis:incr(Zelzal.."Zelzal:Num:Add:Memp"..msg_chat_id..":"..msg.sender_id.user_id) 
local AddMembrs = Redis:get(Zelzal.."Zelzal:Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = Redis:get(Zelzal.."Zelzal:Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = bot.getUser(v) 
if Info_User.type.luatele == "userTypeRegular" then
Redis:incr(Zelzal.."Zelzal:Num:Add:Memp"..msg.chat_id..":"..msg.sender_id.user_id) 
if AddMembrs == "kick" and not msg.Distinguished then
bot.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
end
end
end 
if msg.content.luatele == "messageContact" or text and text:match("77(%d+)") or text and text:match("78(%d+)") or text and text:match("75(%d+)") then
if not msg.Distinguished then  -- الجهات
local Contact_Group = Redis:get(Zelzal.."Zelzal:Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل جهات \n ✓',"md")
end
elseif Contact_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل جهات \n ✓',"md")
end
elseif Contact_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل جهات \n ✓',"md")
end
elseif Contact_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل جهات \n ✓',"md")
end
end
end
end 
if msg.content.luatele == "messageVideoNote" and not msg.Distinguished then  -- بصمه الفيديو
local Videonote_Group = Redis:get(Zelzal.."Zelzal:Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل بصمات الفيديو \n ✓',"md")
end
elseif Videonote_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل بصمات الفيديو \n ✓',"md")
end
elseif Videonote_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل بصمات الفيديو \n ✓',"md")
end
elseif Videonote_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل بصمات الفيديو \n ✓',"md")
end
end
end 
if msg.content.luatele == "messageDocument" and not msg.Distinguished then  -- الملفات
local Document_Group = Redis:get(Zelzal.."Zelzal:Lock:Document"..msg_chat_id)
if Document_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الملفات \n ✓',"md")
end
elseif Document_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الملفات \n ✓',"md")
end
elseif Document_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الملفات \n ✓',"md")
end
elseif Document_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الملفات \n ✓',"md")
end
end
end 
if msg.content.luatele == "messageAudio" and not msg.Distinguished then  -- الملفات الصوتيه
local Audio_Group = Redis:get(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مقاطع صوت \n ✓',"md")
end
elseif Audio_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مقاطع صوت \n ✓',"md")
end
elseif Audio_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مقاطع صوت \n ✓',"md")
end
elseif Audio_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مقاطع صوت \n ✓',"md")
end
end
end 
if msg.content.luatele == "messageVideo" then  -- الفيديو
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Distinguished or msg.Mistinguished then
testmod = true
else
testmod = false
end
if testmod == false then
local Video_Grouo = Redis:get(Zelzal.."Zelzal:Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مقاطع فيديو \n ✓',"md")
end
elseif Video_Grouo == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مقاطع فيديو \n ✓',"md")
end
elseif Video_Grouo == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مقاطع فيديو \n ✓',"md")
end
elseif Video_Grouo == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل مقاطع فيديو \n ✓',"md")
end
end
end
end 
if text and text:match("[A-Z]") or text and text:match("[a-z]") then
if (not msg.Distinguished or not msg.Mistinguished) and Redis:get(Zelzal.."Zelzal:Lock:english"..msg_chat_id) then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع الكلام باللغة الانكليزية هنا \n ✓',"md")
end
end
end
if msg.content.luatele == "messageVoiceNote" and not msg.Distinguished then  -- البصمات
local Voice_Group = Redis:get(Zelzal.."Zelzal:Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل فويسات \n ✓',"md")
end
elseif Voice_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل فويسات \n ✓',"md")
end
elseif Voice_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل فويسات \n ✓',"md")
end
elseif Voice_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل فويسات \n ✓',"md")
end
end
end
if msg.content.luatele == "messageSticker" then  -- الملصقات
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Distinguished or msg.Mistinguished then
testmod = true
else
testmod = false
end
print(testmod)
if testmod == false then
local Sticker_Group = Redis:get(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل ستيكرات \n ✓',"md")
end
elseif Sticker_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل ستيكرات \n ✓',"md")
end
elseif Sticker_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل ستيكرات \n ✓',"md")
end
elseif Sticker_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل ستيكرات \n ✓',"md")
end
end
end
end 
if msg.via_bot_user_id ~= 0 and (not msg.Addictive or not msg.Mddictive) then  -- انلاين
local Inlen_Group = Redis:get(Zelzal.."Zelzal:Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الانلاين \n ✓',"md")
end
elseif Inlen_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الانلاين \n ✓',"md")
end
elseif Inlen_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الانلاين \n ✓',"md")
end
elseif Inlen_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل الانلاين \n ✓',"md")
end
end
end
if msg.content.luatele == "messageAnimation"  then  -- المتحركات
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Distinguished or msg.Mistinguished then
testmod = true
else
testmod = false
end
if testmod == false then
local Gif_group = Redis:get(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل متحركات \n ✓',"md")
end
elseif Gif_group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل متحركات \n ✓',"md")
end
elseif Gif_group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل متحركات \n ✓',"md")
end
elseif Gif_group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل متحركات \n ✓',"md")
end
end
end
end 
if text and (text:match("ژ") or text:match("چ") or text:match("۴") or text:match("عزیزم") or text:match("خوبی") or text:match("کی") or text:match("اومدی") or text:match("گ") or text:match("ڄ") or text:match("پ") or text:match("👙") or text:match("فیللم") or text:match("👅") or text:match("خوابیدین")) then 
local phshar_Group = Redis:get(Zelzal.."Zelzal:Lock:farsia"..msg_chat_id)
if phshar_Group then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع الكلام باللغة الفارسية هنا',"md")
end
end
end
if text and (text:match("كسمك") or text:match("منيوج") or text:match("عير") or text:match("منيوك") or text:match("طويز") or text:match("عيوره") or text:match("مناويج") or text:match("عيوره") or text:match("كسج") or text:match("نيج")  or text:match("كحاب")  or text:match("طيازه")or text:match("طيز")or text:match("كسختك") or text:match("زبي") or text:match("ايري") or text:match("انيك") or text:match("فرخ") or text:match("كحب") or text:match("قحب") or text:match("مخنوث") or text:match("خنث") or text:match("است ا") or text:match("انيكك") or text:match("منيوك") or text:match("بلاع") or text:match("فتال") or text:match("عرص") or text:match("كسك") or text:match("استك") or text:match("رهط") or text:match("مصي ") or text:match(" مص ") or text:match("اعرب")) and not msg.MalekAsase then
if text:match("معرص") or text:match("عيرض") or text:match("عيرا") or text:match("عينيك") then
return false
end
local phshar_Group = Redis:get(Zelzal.."Zelzal:Lock:phshar"..msg_chat_id)
if phshar_Group then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ لا تغلـط ياحمـار \n ✓',"md")
end
end
end
if text and (text:match("خره بالله") or text:match("خربربك") or text:match("كسدينربك") or text:match("خرب بالله") or text:match("خرب الله") or text:match("خره بربك") or text:match("الله الكواد") or text:match("خره بمحمد") or text:match("كسم الله") or text:match("كسم ربك") or text:match("كسربك") or text:match("كسختالله") or text:match("كسخت الله") or text:match("خره بدينك") or text:match("خرهبدينك") or text:match("كسالله") or text:match("خربالله")) and not msg.Distinguished then 
local phsharr_Group = not Redis:get(Zelzal.."Zelzal:Lock:alkfr"..msg_chat_id)
if phsharr_Group then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ لا تكفر ياحمار \n ✓',"md")
end
end
end
if text and (text:match("شيعي") or text:match("سني") or text:match("طائفه") or text:match("طائفتكم") or text:match("صابئي") or text:match("ضلع الزهراء") or text:match("الافك") or text:match("الشيعه") or text:match("الشيعة") or text:match("تسبون عائشه") or text:match("تسبون الصحابه") or text:match("تسبون الصحابة") or text:match("تسبون عائشة") or text:match("العن عمر") or text:match("العن عائشه") or text:match("العن عائشة") or text:match("ظلع الزهراء")) and not msg.MalekAsase then 
local phsharr_Group = Redis:get(Zelzal.."Lock:taifia"..msg_chat_id)
if phsharr_Group then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '*⇜ عـزيـزي ⇜* ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..msg.sender_id.user_id..')\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ يمنـع التكلـم بالطـائفيـه هنـا\n ✓*',"md")
end
end
end
if text and (string.match(text, "^%.كتم") or string.match(text, "^%.حظر") or string.match(text, "^%.ضيف") or string.match(text, "^%.مغادره") or string.match(text, "^%.انتحال") or string.match(text, "^%.كرر") or string.match(text, "^%.تكرار") or string.match(text, "^%.مكرر") or string.match(text, "^%.نشر")) then 
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
testmod = true
elseif msg.TheBasics or msg.TheMasics then
testmod = true
else
testmod = false
end
if testmod == false then
local Jm_group = Redis:get(Zelzal.."Zelzal:Lock:Jmthon"..msg_chat_id)
if Jm_group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ هييهه「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ مايمديك تستخدم تيليثون هنا🚷\n⇜ تم كتمك .. بنجاح ☑️',"md")
end
end
end
end

if msg.content.luatele == "messagePhoto" then  -- الصور
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Distinguished or msg.Mistinguished then
testmod = true
else
testmod = false
end
if testmod == false then
local Photo_Group = Redis:get(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ ممنوع ترسل صور هنا*\n ✓',"md")
end
elseif Photo_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ ممنوع ترسل صور هنا*\n ✓',"md")
end
elseif Photo_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ ممنوع ترسل صور هنا*\n ✓',"md")
end
elseif Photo_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ ممنوع ترسل صور هنا*\n ✓',"md")
end
end
end
end
if msg.content.photo and Redis:get(Zelzal.."Zelzal:Chat:Photo"..msg_chat_id..":"..msg.sender_id.user_id) then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local ChatPhoto = bot.setChatPhoto(msg_chat_id,idPhoto)
if (ChatPhoto.luatele == "error") then
Redis:del(Zelzal.."Zelzal:Chat:Photo"..msg_chat_id..":"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ لا استطيع تغيير صورة القروب لاني لست ادمن او ليست لدي الصلاحية*","md",true)    
end
Redis:del(Zelzal.."Zelzal:Chat:Photo"..msg_chat_id..":"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ تم تغيير صورة القروب*","md",true)    
end
if  (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]")  
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]")
or msg.content.luatele == "messageContact" 
or msg.content.luatele == "messageSticker"
or msg.content.luatele == "messageVideoNote" 
or msg.content.luatele == "messageDocument" 
or msg.content.luatele == "messageAudio" 
or msg.content.luatele == "messageVideo" 
or msg.content.luatele == "messageVoiceNote" 
or msg.content.luatele == "messageAnimation" 
or msg.content.luatele == "messagePhoto" then
local tphlesh_Group = Redis:get(Zelzal.."Zelzal:Lock:tphlesh"..msg_chat_id)
if (not msg.Distinguished or not msg.Mistinguished) and tphlesh_Group then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ الحماية مفعلة تم مسح ما ارسلته\n ✓',"md")
end
end
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = Redis:get(Zelzal.."Zelzal:Lock:Link"..msg_chat_id)  
if not msg.Addictive or not msg.Mddictive then
if link_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ ممنوع ترسل روابط هنا*\n ✓',"md")
end
elseif link_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ ممنوع ترسل روابط هنا*\n ✓',"md")
end
elseif link_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ ممنوع ترسل روابط هنا*\n ✓',"md")
end
elseif link_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ ممنوع ترسل روابط هنا*\n ✓',"md")
end
end
return false
end
end
if text and (text:match("شيعي") or text:match("سني") or text:match("طائفه") or text:match("طائفتكم") or text:match("صابئي") or text:match("ضلع الزهراء") or text:match("الافك") or text:match("الشيعه") or text:match("الشيعة") or text:match("تسبون عائشه") or text:match("تسبون الصحابه") or text:match("تسبون الصحابة") or text:match("تسبون عائشة") or text:match("العن عمر") or text:match("العن عائشه") or text:match("العن عائشة") or text:match("ظلع الزهراء")) then 
local taifia_Group = Redis:get(Zelzal.."Lock:Taifia"..msg_chat_id)  
if not msg.MalekAsase then
if taifia_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '*⇜ عـزيـزي ⇜* ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..msg.sender_id.user_id..')\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ يمنـع التكلـم بالطـائفيـه هنـا\n⇜ تم المسـح .. بنجـاح ✓*',"md")
end
elseif taifia_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '*⇜ عـزيـزي ⇜* ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..msg.sender_id.user_id..')\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ تم تقييـدك .. بنجـاح ✓\n⇜ الطـائفيـه مقفلـه بالتقييـد\n ✓*',"md")
end
elseif taifia_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '*⇜ عـزيـزي ⇜* ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..msg.sender_id.user_id..')\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ تم كتمـك .. بنجـاح ✓\n⇜ الطـائفيـه مقفلـه بالكتـم\n ✓*',"md")
end
elseif taifia_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '*⇜ عـزيـزي ⇜* ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..msg.sender_id.user_id..')\n'
return send(msg_chat_id,msg_id,Teext..'*⇜ تم طـردك .. بنجـاح ✓\n⇜ الطـائفيـه مقفلـه بالطـرد\n ✓*',"md")
end
end
return false
end
end
if text and text:match("@[%a%d_]+") then 
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Distinguished or msg.Mistinguished then
testmod = true
else
testmod = false
end
if testmod == false then
local UserName_Group = Redis:get(Zelzal.."Zelzal:Lock:User:Name"..msg_chat_id)
if UserName_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل يوزرات \n ✓',"md")
end
elseif UserName_Group == "ked" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل يوزرات \n ✓',"md")
end
elseif UserName_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل يوزرات \n ✓',"md")
end
elseif UserName_Group == "kick" then
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل يوزرات \n ✓',"md")
end
end
end
end
if text and text:match("#[%a%d_]+") and not msg.Distinguished then 
local Hashtak_Group = Redis:get(Zelzal.."Zelzal:Lock:hashtak"..msg_chat_id)
if Hashtak_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل هاشتاق \n ✓',"md")
end
elseif Hashtak_Group == "ked" then
 bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
 bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل هاشتاق \n ✓',"md")
end
elseif Hashtak_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل هاشتاق \n ✓',"md")
end
elseif Hashtak_Group == "kick" then
 bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
 bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل هاشتاق \n ✓',"md")
end
end
end
if text and text:match("/[%a%d_]+") and not msg.Distinguished then 
local comd_Group = Redis:get(Zelzal.."Zelzal:Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل اوامر بوتات ثانية \n ✓',"md")
end
elseif comd_Group == "ked" then
 bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
 bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل اوامر بوتات ثانية \n ✓',"md")
end
elseif comd_Group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل اوامر بوتات ثانية \n ✓',"md")
end
elseif comd_Group == "kick" then
 bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
 bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ ممنوع ترسل اوامر بوتات ثانية \n ✓',"md")
end
end
end
if (Redis:get(Zelzal..'Zelzal:FilterText'..msg_chat_id..':'..msg.sender_id.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(Zelzal.."Zelzal:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(Zelzal.."Zelzal:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(Zelzal.."Zelzal:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:set(Zelzal.."Zelzal:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(Zelzal.."Zelzal:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(Zelzal.."Zelzal:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(Zelzal.."Zelzal:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id, text)  
Redis:sadd(Zelzal.."Zelzal:List:Filter"..msg_chat_id,'text:'..text)
Filters = 'نص'
end
Redis:set(Zelzal..'Zelzal:FilterText'..msg_chat_id..':'..msg.sender_id.user_id,'true1')
return send(msg_chat_id,msg_id,"\n⇜ اعطني تحذير ( "..Filters.." ) عند ارساله","md",true)  
end
end
if text and (Redis:get(Zelzal..'Zelzal:FilterText'..msg_chat_id..':'..msg.sender_id.user_id) == 'true1') then
local Text_Filter = Redis:get(Zelzal.."Zelzal:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id)  
if Text_Filter then
Redis:set(Zelzal.."Zelzal:Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
Redis:del(Zelzal.."Zelzal:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id)  
Redis:del(Zelzal..'Zelzal:FilterText'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"\n⇜ تم اضافه رد التحذير","md",true)  
end
if (Redis:get(Zelzal..'Zelzal:FilterText'..msg_chat_id..':'..msg.sender_id.user_id) == 'DelFilter') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
Redis:srem(Zelzal.."Zelzal:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(Zelzal.."Zelzal:Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
Redis:srem(Zelzal.."Zelzal:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:del(Zelzal.."Zelzal:Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
Redis:srem(Zelzal.."Zelzal:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(Zelzal.."Zelzal:Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
Redis:srem(Zelzal.."Zelzal:List:Filter"..msg_chat_id,'text:'..text)  
Redis:del(Zelzal.."Zelzal:Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
Redis:del(Zelzal..'Zelzal:FilterText'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"⇜ لقد تم منع ("..Filters..") هنا\n✓","md",true)  
end
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(Zelzal.."Zelzal:Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Distinguished then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
return send(msg_chat_id,msg_id,"⇜ لقد تم منع ( "..statusfilter.." ) هنا\n✓"..ReplyFilters,"md",true)   
end
end
-----------------
if text and Redis:get(Zelzal..msg_chat_id..msg.sender_id.user_id.."replace") == "true1" then
Redis:del(Zelzal..msg_chat_id..msg.sender_id.user_id.."replace")
local word = Redis:get(Zelzal..msg_chat_id..msg.sender_id.user_id.."word")
Redis:set(Zelzal..msg_chat_id.."Word:Replace"..word,text)
Redis:sadd(Zelzal..msg_chat_id..'Words:r',word)  
send(msg_chat_id,msg_id,"⇜ تم حفظ الكلمة","md",true)  
return false 
end
if text and Redis:get(Zelzal..msg_chat_id..msg.sender_id.user_id.."replace") == "true" then
Redis:set(Zelzal..msg_chat_id..msg.sender_id.user_id.."word",text)
Redis:set(Zelzal..msg_chat_id..msg.sender_id.user_id.."replace","true1")
send(msg_chat_id,msg_id,'\n⇜ ارسل كلمة جديدة ليتم استبدالها مكان ( '..text..' )',"md",true)  
return false 
end
-----------------
if text and Redis:get(Zelzal.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender_id.user_id) == "true" then
if text == "الغاء" then 
Redis:del(Zelzal.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ تم الغاء الامر .. بنجاح*","md",true)   
end 
local NewCmmd = Redis:get(Zelzal.."All:Get:Reides:Commands:Group"..text)
if NewCmmd then
Redis:del(Zelzal.."All:Get:Reides:Commands:Group"..text)
Redis:del(Zelzal.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(Zelzal.."All:Command:List:Group",text)
send(msg_chat_id,msg_id,"*⇜ ابشر مسحت ( *"..text.."* )\n✓*","md",true)
else
send(msg_chat_id,msg_id,"*⇜ مافي امر عام بهذا الاسم\n✓*","md",true)
end
Redis:del(Zelzal.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender_id.user_id)
return false
end
if text and Redis:get(Zelzal.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender_id.user_id) == "true" then
Redis:set(Zelzal.."All:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(Zelzal.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender_id.user_id)
Redis:set(Zelzal.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender_id.user_id,"true1") 
return send(msg_chat_id,msg_id,"*⇜ ارسل الامر الجديد ليتم وضعه مكان القديم\n✓*","md",true)  
end
if text and Redis:get(Zelzal.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender_id.user_id) == "true1" then
local NewCmd = Redis:get(Zelzal.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:set(Zelzal.."All:Get:Reides:Commands:Group"..text,NewCmd)
Redis:sadd(Zelzal.."All:Command:List:Group",text)
Redis:del(Zelzal.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ ابشر حفظت الامر باسم ← ( *"..text.."* )\n ✓*","md",true)
end
if text and Redis:get(Zelzal.."Zelzal:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender_id.user_id) == "true" then
local NewCmmd = Redis:get(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
Redis:del(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
Redis:del(Zelzal.."Zelzal:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(Zelzal.."Zelzal:Command:List:Group"..msg_chat_id,text)
send(msg_chat_id,msg_id,"*⇜ تم ازالة الامر ← ( *"..text.."* )*","md",true)
else
send(msg_chat_id,msg_id,"*⇜ لا يوجد امر بهذا الاسم*","md",true)
end
Redis:del(Zelzal.."Zelzal:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender_id.user_id)
return false
end
if text and Redis:get(Zelzal.."Zelzal:Command:Reids:Group"..msg_chat_id..":"..msg.sender_id.user_id) == "true" then
Redis:set(Zelzal.."Zelzal:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(Zelzal.."Zelzal:Command:Reids:Group"..msg_chat_id..":"..msg.sender_id.user_id)
Redis:set(Zelzal.."Zelzal:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender_id.user_id,"true1") 
return send(msg_chat_id,msg_id,"*⇜ اعطني الامر الجديد ليتم وضعه مكان القديم*","md",true)  
end
if text and Redis:get(Zelzal.."Zelzal:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender_id.user_id) == "true1" then
local NewCmd = Redis:get(Zelzal.."Zelzal:Command:Reids:Group:New"..msg_chat_id)
Redis:set(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
Redis:sadd(Zelzal.."Zelzal:Command:List:Group"..msg_chat_id,text)
Redis:del(Zelzal.."Zelzal:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ تم حفظ الامر باسم ← ( *"..text.."* )*","md",true)
end
if Redis:get(Zelzal.."Zelzal:Set:Link"..msg_chat_id..""..msg.sender_id.user_id) then
if text == "الغاء" then
Redis:del(Zelzal.."Zelzal:Set:Link"..msg_chat_id..""..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id,"*⇜ تم الغاء حفظ الرابط*","md",true)         
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then  
local LinkGroup = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
Redis:set(Zelzal.."Zelzal:Group:Link"..msg_chat_id,LinkGroup)
Redis:del(Zelzal.."Zelzal:Set:Link"..msg_chat_id..""..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id,"*⇜ تم حفظ الرابط*","md",true)         
end
end 
if Redis:get(Zelzal.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender_id.user_id) then 
if text == "الغاء" then 
Redis:del(Zelzal.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender_id.user_id)  
return send(msg_chat_id,msg_id,"*⇜ تم الغاء حفظ الترحيب*","md",true)   
end 
Redis:del(Zelzal.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender_id.user_id)  
Redis:set(Zelzal.."Zelzal:Welcome:Group"..msg_chat_id,text) 
return send(msg_chat_id,msg_id,"*⇜ تم حفظ ترحيب القروب*","md",true)     
end
if Redis:get(Zelzal.."Zelzal:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender_id.user_id) then 
if text == "الغاء" then 
Redis:del(Zelzal.."Zelzal:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ تم الغاء حفظ القوانين*","md",true)   
end 
Redis:set(Zelzal.."Zelzal:Group:Rules" .. msg_chat_id,text) 
Redis:del(Zelzal.."Zelzal:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ تم حفظ قوانين القروب*","md",true)  
end  
if Redis:get(Zelzal.."Zelzal:Set:Description:" .. msg_chat_id .. ":" .. msg.sender_id.user_id) then 
if text == "الغاء" then 
Redis:del(Zelzal.."Zelzal:Set:Description:" .. msg_chat_id .. ":" .. msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ تم الغاء حفظ وصف القروب*","md",true)   
end 
bot.setChatDescription(msg_chat_id,text) 
Redis:del(Zelzal.."Zelzal:Set:Description:" .. msg_chat_id .. ":" .. msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ تم حفظ وصف القروب*","md",true)  
end
---- هنا تم حذف اضف رد وحذف رد ----
---- هنا تم حذف الردود العامة والعادية ----
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(Zelzal.."Zelzal:Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg_chat_id)
if Redis:get(Zelzal.."Zelzal:Set:Rd"..msg.sender_id.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Zelzal.."Zelzal:Set:Rd"..msg.sender_id.user_id..":"..msg_chat_id)
if msg.content.sticker then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Rd:caption:vico"..msg.content.voice_note.voice.remote.id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
end   
if msg.content.animation then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Rd:caption:gif"..msg.content.animation.animation.remote.id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
end  
if text then
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content.audio then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Rd:caption:audio"..msg.content.audio.audio.remote.id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..test, msg.content.audio.audio.remote.id)  
end
if msg.content.document then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:File"..test, msg.content.document.document.remote.id)  
end
if msg.content.video then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Rd:caption:video"..msg.content.video.video.remote.id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..test, msg.content.video.video.remote.id)  
end
if msg.content.video_note then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
end
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Rd:caption:Photo"..idPhoto, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..test, idPhoto)  
end
send(msg_chat_id,msg_id,"*「  *"..test.."*  」\nواضفنا الرد ياحلو 🌚\n✓*","md",true)
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Zelzal:Set:Rd"..msg.sender_id.user_id..":"..msg_chat_id) == "true" then
Redis:set(Zelzal.."Zelzal:Set:Rd"..msg.sender_id.user_id..":"..msg_chat_id, "true1")
Redis:set(Zelzal.."Zelzal:Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg_chat_id, text)
Redis:sadd(Zelzal.."Zelzal:List:Rd:Sudo", text)
send(msg_chat_id,msg_id,[[
*⇜ حلو , الحين ارسل جواب الرد*
*⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
 `{اليوزر}` *↬ يوزر المستخدم*
 `{الرسائل}` *↬ عدد الرسائل*
 `{الاسم}` *↬ اسم المستخدم*
 `{الايدي}` *↬ ايدي المستخدم*
 `{الرتبه}` *↬ رتبة المستخدم*
 `{التعديل}` *↬ عدد التعديلات*

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Zelzal:Set:On"..msg.sender_id.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
Redis:del(Zelzal..'Zelzal:'..v..text)
end
Redis:del(Zelzal.."Zelzal:Set:On"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:srem(Zelzal.."Zelzal:List:Rd:Sudo", text)
return send(msg_chat_id,msg_id,"*⇜ ابشر مسحت الرد من الردود العامة*","md",true)  
end
end
if Redis:get(Zelzal..'Set:array'..msg.sender_id.user_id..':'..msg_chat_id) == 'true1' then
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
local test = Redis:get(Zelzal..'Text:array'..msg.sender_id.user_id..':'..msg_chat_id..'')
Redis:sadd(Zelzal.."Add:Rd:array:Text"..test..msg_chat_id,text)  
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text="انهاء الاضافة",data="EndAddarray"..msg.sender_id.user_id},
},
}
}
send(msg_chat_id, msg_id, ' ⇜ تم حفظ الرد يمكنك ارسال رد اخر او اكمال العمليه من خلال الزر اسفل ', 'md', false, false, false, false, reply_markup)
return false  
end
if text then
if Redis:get(Zelzal.."Set:array:Ssd"..msg.sender_id.user_id..":"..msg_chat_id) == 'dttd' then
Redis:del(Zelzal.."Set:array:Ssd"..msg.sender_id.user_id..":"..msg_chat_id)
gery = Redis:get(Zelzal.."Set:array:addpu"..msg.sender_id.user_id..":"..msg_chat_id)
if not Redis:sismember(Zelzal.."Add:Rd:array:Text"..gery..msg_chat_id,text) then
send(msg_chat_id, msg_id,'*⇜ مافي رد ياعيني*',"md",true)
return false
end
Redis:srem(Zelzal.."Add:Rd:array:Text"..gery..msg_chat_id,text)
send(msg_chat_id, msg_id,' ⇜ ابشر حذفت الرد',"md",true)
end
end
if text then
if Redis:get(Zelzal.."Set:array:Ssd"..msg.sender_id.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(Zelzal.."Set:array:Ssd"..msg.sender_id.user_id..":"..msg_chat_id)
if not Redis:sismember(Zelzal..'List:array'..msg_chat_id,text) then
send(msg_chat_id, msg_id,'*⇜ مافي رد ياعيني*',"md",true)
return false
end
Redis:set(Zelzal.."Set:array:addpu"..msg.sender_id.user_id..":"..msg_chat_id,text)
Redis:set(Zelzal.."Set:array:Ssd"..msg.sender_id.user_id..":"..msg_chat_id,"dttd")
send(msg_chat_id, msg_id,' ⇜ تمام عيني \n⇜ الحين ارسل الرد عشان امسحه',"md",true)
return false
end
end
if text == "حذف رد من متعدد" or text == "مسح رد من متعدد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
send(msg_chat_id, msg_id, '⇜ تمام عيني \n⇜ الحين ارسل الرد عشان امسحه \n ✓', 'md', false, false, false, false, reply_markup)
Redis:set(Zelzal.."Set:array:Ssd"..msg.sender_id.user_id..":"..msg_chat_id,"delrd")
return false 
end
if text then
if Redis:get(Zelzal.."Set:array"..msg.sender_id.user_id..":"..msg_chat_id) == 'true' then
Redis:sadd(Zelzal..'List:array'..msg_chat_id, text)
Redis:set(Zelzal..'Text:array'..msg.sender_id.user_id..':'..msg_chat_id, text)
send(msg_chat_id, msg_id,'⇜ حلو ، الحين ارسل الكلمة',"md",true)
Redis:del(Zelzal.."Set:array"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:set(Zelzal..'Set:array'..msg.sender_id.user_id..':'..msg_chat_id,'true1')
Redis:del(Zelzal.."Add:Rd:array:Text"..text..msg_chat_id)   
return false
end
end
if text then
if Redis:get(Zelzal.."Set:array:rd"..msg.sender_id.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(Zelzal.."Set:array:rd"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:array:Text"..text..msg_chat_id)
Redis:srem(Zelzal..'List:array'..msg_chat_id, text)
send(msg_chat_id, msg_id,'⇜ ابشر مسحت الرد المتعدد ',"md",true)
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:array:rdd"..msg.sender_id.user_id..":"..msg.chat_id) == 'delrd' then
Redis:del(Zelzal.."Set:array:rdd"..msg.sender_id.user_id..":"..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:array:Textt"..text)
Redis:srem(Zelzal..'List:arrayy', text)
send(msg.chat_id,msg.id,"⇜ تم مسح الرد المتعدد عام ","md",true)  
return false
end
end
-----------------
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:array:Ssdd"..msg.sender_id.user_id..":"..msg.chat_id) == 'dttd' then
Redis:del(Zelzal.."Set:array:Ssdd"..msg.sender_id.user_id..":"..msg.chat_id)
gery = Redis:get(Zelzal.."Set:array:addpuu"..msg.sender_id.user_id..":"..msg.chat_id)
if not Redis:sismember(Zelzal.."Add:Rd:array:Textt"..gery,text) then
send(msg.chat_id,msg.id,"⇜ لا يوجد رد متعدد ","md",true)  
return false
end
Redis:srem(Zelzal.."Add:Rd:array:Textt"..gery,text)
send(msg.chat_id,msg.id,' ⇜ تم مسحه بنجاح ',"md",true)  
end
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:array:Ssdd"..msg.sender_id.user_id..":"..msg.chat_id) == 'delrd' then
Redis:del(Zelzal.."Set:array:Ssdd"..msg.sender_id.user_id..":"..msg.chat_id)
if not Redis:sismember(Zelzal..'List:arrayy',text) then
send(msg.chat_id,msg.id,"⇜ لا يوجد رد متعدد ","md",true)  
return false
end
Redis:set(Zelzal.."Set:array:addpuu"..msg.sender_id.user_id..":"..msg.chat_id,text)
Redis:set(Zelzal.."Set:array:Ssdd"..msg.sender_id.user_id..":"..msg.chat_id,"dttd")
send(msg.chat_id,msg.id,' ⇜ ارسل الرد الذي تريد مسحه منه ',"md",true)  
return false
end
end
if text and Redis:sismember(Zelzal..'List:arrayy',text) then
local list = Redis:smembers(Zelzal.."Add:Rd:array:Textt"..text)
return send(msg_chat_id,msg_id,"["..list[math.random(#list)].."]","md",true)  
end
-----------------
if Redis:get(Zelzal.."Zelzal:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ الغاء الاذاعه للقروبات*","md",true)  
end 
local list = Redis:smembers(Zelzal.."Zelzal:ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
bot.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
bot.sendPhoto(v, 0, idPhoto,'')
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
bot.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
bot.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
bot.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
bot.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
bot.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
bot.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
send(v,0,text,"html",true)
Redis:set(Zelzal.."Zelzal:PinMsegees:"..v,text)
end
end
send(msg_chat_id,msg_id,"*⇜ تمت الاذاعة الى (* "..#list.." *) مجموعة*","md",true)
Redis:del(Zelzal.."Zelzal:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Zelzal.."Zelzal:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء الاذاعه خاص*","md",true)  
end 
local list = Redis:smembers(Zelzal..'Zelzal:Num:User:Pv')  
if msg.content.video_note then
for k,v in pairs(list) do 
bot.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
bot.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
bot.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
bot.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
bot.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
bot.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
bot.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
bot.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
send(v,0,text,"html",true)
end
end
send(msg_chat_id,msg_id,"*⇜ تمت الاذاعه الى (* "..#list.." *) مشترك* ","md",true)
Redis:del(Zelzal.."Zelzal:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Zelzal.."Zelzal:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء الاذاعه للقروبات*","md",true)  
end 
local list = Redis:smembers(Zelzal.."Zelzal:ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
bot.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
bot.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
bot.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
bot.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
bot.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
bot.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
bot.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
bot.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
send(v,0,text,"html",true)
end
end
send(msg_chat_id,msg_id,"*⇜ تمت الاذاعه الى (* "..#list.." *) مجموعة*","md",true)
Redis:del(Zelzal.."Zelzal:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Zelzal.."Zelzal:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء الاذاعه بالتوجيه للقروبات*","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(Zelzal.."Zelzal:ChekBotAdd")   
send(msg_chat_id,msg_id,"*⇜ تم التوجيه الى (* "..#list.." *) مجموعة*","md",true)
for k,v in pairs(list) do  
bot.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(Zelzal.."Zelzal:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Zelzal.."Zelzal:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء الاذاعه بالتوجيه خاص*","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(Zelzal.."Zelzal:Num:User:Pv")   
send(msg_chat_id,msg_id,"*⇜ تم التوجيه الى (* "..#list.." *) مشترك في البوت*","md",true)
for k,v in pairs(list) do  
bot.forwardMessages(v, msg_chat_id, msg_id,0,1,msg.media_album_id,false,true)
end   
Redis:del(Zelzal.."Zelzal:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender_id.user_id) 
end 
return false
end
if text and Redis:get(Zelzal..'Zelzal:GetTexting:DevZelzal'..msg_chat_id..':'..msg.sender_id.user_id) then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then 
Redis:del(Zelzal..'Zelzal:GetTexting:DevZelzal'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء حفظ كليشة المطور')
end
Redis:set(Zelzal..'Zelzal:Texting:DevZelzal',text)
Redis:del(Zelzal..'Zelzal:GetTexting:DevZelzal'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم حفظ كليشة المطور')
end
if Redis:get(Zelzal.."Zelzal:Redis:Id:Group"..msg.chat_id..""..msg.sender_id.user_id) then 
if text == 'الغاء' then 
send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تعيين الايدي*","md",true)  
Redis:del(Zelzal.."Zelzal:Redis:Id:Group"..msg.chat_id..""..msg.sender_id.user_id) 
return false  
end 
Redis:del(Zelzal.."Zelzal:Redis:Id:Group"..msg.chat_id..""..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Set:Id:Group"..msg.chat_id,text:match("(.*)"))
send(msg_chat_id,msg_id,'*⇜ وسوينا الايدي \n⇜ يمديك تجرب شكل الايدي الجديد الحين \n ✓*',"md",true)  
end
if Redis:get(Zelzal.."Zelzal:Redis:Id:Groups"..msg.chat_id..""..msg.sender_id.user_id) then 
if text == 'الغاء' then 
send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تعيين الايدي*","md",true)  
Redis:del(Zelzal.."Zelzal:Redis:Id:Groups"..msg.chat_id..""..msg.sender_id.user_id) 
return false  
end 
Redis:del(Zelzal.."Zelzal:Redis:Id:Groups"..msg.chat_id..""..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Set:Id:Groups",text:match("(.*)"))
send(msg_chat_id,msg_id,'*⇜ وسوينا الايدي العام\n⇜ يمديك تجرب شكل الايدي الجديد الحين \n ✓*',"md",true)  
end
if Redis:get(Zelzal.."Zelzal:Change:Name:Bot"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Name:Bot"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تغير اسم البوت*","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Name:Bot"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Name:Bot",text) 
return send(msg_chat_id,msg_id, "*⇜ تم تغير اسم البوت الى* "..text,"md",true)
end 
if Redis:get(Zelzal.."Zelzal:Change:Start:Bot"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Start:Bot"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تغير كليشه start*","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Start:Bot"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Start:Bot",text) 
return send(msg_chat_id,msg_id, "*⇜ تم تغيير كليشه start الى*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Twassl:Bot"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Twassl:Bot"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تغير رد التواصل*","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Twassl:Bot"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Twassl:Bot",text) 
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رد التواصل الى :*\n"..text,"md",true)
end
------------------------------------ زلزال الهيبه ------------------------------------
if Redis:get(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id) == "true" then
Redis:del(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id)
Redis:set(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
if msg.content.text then 
Redis:set(Zelzal.."Add:Rd:Sorce:Text:inline", text)
elseif msg.content.sticker then 
Redis:set(Zelzal.."Add:Rd:Sorce:Stekrs:inline", msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then
Redis:set(Zelzal.."Add:Rd:Sorce:Vico:inline", msg.content.voice_note.voice.remote.id)
elseif msg.content.audio then
Redis:set(Zelzal.."Add:Rd:Sorce:Audio:inline", msg.content.audio.audio.remote.id)
Redis:set(Zelzal.."Add:Rd:Sorce:Audioc:inline", msg.content.caption.text)
elseif msg.content.document then
Redis:set(Zelzal.."Add:Rd:Sorce:File:inline", msg.content.document.document.remote.id)
elseif msg.content.animation then
Redis:set(Zelzal.."Add:Rd:Sorce:Gif:inline", msg.content.animation.animation.remote.id)
elseif msg.content.video_note then
Redis:set(Zelzal.."Add:Rd:Sorce:video_note:inline", msg.content.video_note.video.remote.id)
elseif msg.content.video then
Redis:set(Zelzal.."Add:Rd:Sorce:Video:inline", msg.content.video.video.remote.id)
Redis:set(Zelzal.."Add:Rd:Sorce:Videoc:inline", msg.content.caption.text)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal.."Add:Rd:Sorce:Photo:inline", idPhoto)
Redis:set(Zelzal.."Add:Rd:Sorce:Photoc:inline", msg.content.caption.text)
end
send(msg_chat_id,msg_id,"*⇜ الان ارسل الكلام داخل الزر*","md",true)
return false
end
end
if text and Redis:get(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id) == "set_inline" then
Redis:set(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id, "set_link")
Redis:set(Zelzal.."Rd:Sorce:inline:text", text)
send(msg_chat_id,msg_id,"*⇜ الان ارسل الرابط  \n⇜ مثال :* [https://t.me/z_zzz8]","md",true)
return false
end
if text and Redis:get(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id) == "set_link" then
Redis:del(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id)
Redis:set(Zelzal.."Rd:Sorce:inline:link", text)
Redis:set(Zelzal.."Sorce:Reply:inline", msg.sender_id.user_id)
send(msg_chat_id,msg_id,"*تم تغيير كليشة السورس .. بنجاح ✅*","md",true)
return false
end
------------------------------------ زلزال الهيبه ------------------------------------
if Redis:get(Zelzal.."Zelzal:Add:Thift:Bot"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Add:Thift:Bot"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تعطيل مانع الانتحال*","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Add:Thift:Bot"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Thift:Bot",text)
Redis:set(Zelzal.."thiftname","true")
return send(msg_chat_id,msg_id, "*⇜ تم اضافة الاسـم*  "..text.."\n*⇜ الى مانع الانتحال .. بنجـاح ✅*","md",true)
end
------------------------------------ زلزال الهيبه ------------------------------------
if text == 'تفعيل مانع انتحال المالك' or text == 'تفعيل كاشف انتحال المالك' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
SenderMalik = true
else
SenderMalik = false
end
if SenderMalik == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذرا هذا الامر يخص مالك القروب فقط*","md",true)  
end
Redis:setex(Zelzal..msg.chat_id.."Zelzal:Add:Thift:Group"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسم حسابك الان 🪪*\n\n*⇜ مثـال :*\n*⇜ اذا كان اسم حسابك هو 𝖹Ꭵᥣᴢᥲ️ᥣ </>*\n*⇜ ارسل لي الاسم هكذا فقط 𝖹Ꭵᥣᴢᥲ️ᥣ*\n*⇜ بدون رموز الاسم الاساسي فقط 🥷*","md",true)  
end
if text == 'تعطيل مانع انتحال المالك' or text == 'تعطيل كاشف انتحال المالك' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
SenderMalik = true
else
SenderMalik = false
end
if SenderMalik == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذرا هذا الامر يخص مالك القروب فقط*","md",true)  
end
Redis:del(Zelzal..msg.chat_id.."Zelzal:Thift:Group")
Redis:del(Zelzal..msg.chat_id.."thiftgname")
return send(msg_chat_id,msg_id,"*⇜ تم تعطيل مانع انتحال المالك*\n*⇜ ومسح الاسم .. بنجاح ✅*","md",true)   
end
------------------------------------ زلزال الهيبه ------------------------------------
if Redis:get(Zelzal..msg.chat_id.."Zelzal:Add:Thift:Group"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal..msg.chat_id.."Zelzal:Add:Thift:Group"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تعطيل مانع انتحال المالك*","md",true)  
end 
Redis:del(Zelzal..msg.chat_id.."Zelzal:Add:Thift:Group"..msg.sender_id.user_id) 
Redis:set(Zelzal..msg.chat_id.."Zelzal:Thift:Group",text)
Redis:set(Zelzal..msg.chat_id.."thiftgname",true)
return send(msg_chat_id,msg_id, "*⇜ تم اضافة الاسـم*  "..text.."\n*⇜ الى كاشف انتحال المالك .. بنجـاح ✅*","md",true)
end
------------------------------------ زلزال الهيبه ------------------------------------
if Redis:get(Zelzal.."Zelzal:Add:Loger:Bot"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Add:Loger:Bot"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تعطيل قروب السجل*","md",true)  
end
if text and text:match('^-100(%d+)$') then
chg = text
Redis:set(Zelzal.."Zelzal:Loger:Groub",chg)
Redis:set(Zelzal.."Zelzal:LogerBot",true)
send(msg_chat_id,msg_id,"*⇜ تم تفعيل جروب السجل .. بنجـاح ✅ *\n\n*⇜ قم برفع البوت في المجموعة*\n*⇜ ثم ارسـل تفعيـل*\n*⇜ سيتم حفظ كل اشعارات البوت في المجموعة*\n*⇜ من الان فصاعداً بدلاً من خاص البوت*","md",true)
elseif text and not text:match('^-100(%d+)$') then
send(msg_chat_id,msg_id,"*⇜ الايدي خطأ .. يجب ان يبدأ بـ -100*","md",true)  
end
Redis:del(Zelzal.."Zelzal:Add:Loger:Bot"..msg.sender_id.user_id) 
end
------------------------------------ زلزال الهيبه ------------------------------------
if Redis:get(Zelzal.."Zelzal:Add:Lock:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id) then
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Set:Add:Cmd"..msg.chat_id..msg.sender_id.user_id)
Redis:del(Zelzal.."Zelzal:Add:Lock:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id, "*⇜ تم الغـاء الامـر .. بنجـاح ☑️*","md",true)
end
local textlock = Redis:get(Zelzal.."Zelzal:Set:Add:Cmd"..msg.chat_id..msg.sender_id.user_id)
if textlock == "ايدي" or textlock == "ا" or textlock == " id" or textlock == "Id" or textlock == "ID" then
local textlook = "ايدي"
if text == "مطور" then
Redis:sadd(Zelzal.."Zelzal:Developers:Cmd:Lock"..msg_chat_id,textlook)
elseif text == "مالك المجموعة" or text == "مالك المجموعه" then
Redis:sadd(Zelzal.."Zelzal:Creator:Cmd:Lock"..msg_chat_id,textlook)
elseif text == "مالك اساسي" then
Redis:sadd(Zelzal.."Zelzal:MalekAsase:Cmd:Lock"..msg_chat_id,textlook)
elseif text == "مالك" then
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Cmd:Lock"..msg_chat_id,textlook)
elseif text == "منشئ اساسي" then
Redis:sadd(Zelzal.."Zelzal:TheBasics:Cmd:Lock"..msg_chat_id,textlook)
elseif text == "منشئ" then
Redis:sadd(Zelzal.."Zelzal:Originators:Cmd:Lock"..msg_chat_id,textlook)
elseif text == "مدير" then
Redis:sadd(Zelzal.."Zelzal:Managers:Cmd:Lock"..msg_chat_id,textlook)
elseif text == "ادمن" then
Redis:sadd(Zelzal.."Zelzal:Addictive:Cmd:Lock"..msg_chat_id,textlook)
elseif text == "مميز" then
Redis:sadd(Zelzal.."Zelzal:Distinguished:Cmd:Lock"..msg_chat_id,textlook)
else
Redis:del(Zelzal.."Zelzal:Set:Add:Cmd"..msg.chat_id..msg.sender_id.user_id)
Redis:del(Zelzal.."Zelzal:Add:Lock:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ عـذراً قم بارسـال الرتبة الصحيحة*\n*⇜ قم بالاعادة مـرة أخرى عبر (قفـل امر)*","md",true)
end
Redis:sadd(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,textlook)
else
if text == "مطور" then
Redis:sadd(Zelzal.."Zelzal:Developers:Cmd:Lock"..msg_chat_id,textlock)
elseif text == "مالك المجموعة" or text == "مالك المجموعه" then
Redis:sadd(Zelzal.."Zelzal:Creator:Cmd:Lock"..msg_chat_id,textlock)
elseif text == "مالك اساسي" then
Redis:sadd(Zelzal.."Zelzal:MalekAsase:Cmd:Lock"..msg_chat_id,textlock)
elseif text == "مالك" then
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Cmd:Lock"..msg_chat_id,textlock)
elseif text == "منشئ اساسي" then
Redis:sadd(Zelzal.."Zelzal:TheBasics:Cmd:Lock"..msg_chat_id,textlock)
elseif text == "منشئ" then
Redis:sadd(Zelzal.."Zelzal:Originators:Cmd:Lock"..msg_chat_id,textlock)
elseif text == "مدير" then
Redis:sadd(Zelzal.."Zelzal:Managers:Cmd:Lock"..msg_chat_id,textlock)
elseif text == "ادمن" then
Redis:sadd(Zelzal.."Zelzal:Addictive:Cmd:Lock"..msg_chat_id,textlock)
elseif text == "مميز" then
Redis:sadd(Zelzal.."Zelzal:Distinguished:Cmd:Lock"..msg_chat_id,textlock)
else
Redis:del(Zelzal.."Zelzal:Set:Add:Cmd"..msg.chat_id..msg.sender_id.user_id)
Redis:del(Zelzal.."Zelzal:Add:Lock:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ عـذراً قم بارسـال الرتبة الصحيحة*\n*⇜ قم بالاعادة مـرة أخرى عبر (قفـل امر)*","md",true)
end
Redis:sadd(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,textlock)
end
rootpa = text
send(msg_chat_id,msg_id,"*⇜ تم وضـع امـر ( *"..textlock.."* )\n⇜ للرتبه ( *"..rootpa.."* ) فقط ☑️*","md",true)
Redis:del(Zelzal.."Zelzal:Set:Add:Cmd"..msg.chat_id..msg.sender_id.user_id)
Redis:del(Zelzal.."Zelzal:Add:Lock:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id) 
end
------------------------------------ زلزال الهيبه ------------------------------------
if Redis:get(Zelzal.."Zelzal:Add:Loger:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id) then
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Add:Loger:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغـاء امـر تفعيـل الاشعـارات الذكيـه*","md",true)  
end
if text and text:match('^-100(%d+)$') then
chg = text
Redis:set(Zelzal.."Zelzal:Loger:BotGroub"..msg_chat_id,chg)
Redis:set(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id,true)
send(msg_chat_id,msg_id,"*⇜ تم تفعيل قروب الاشعارات الذكيه ✅ *\n\n*⇜ تأكد من ان البوت مشرفاً في قروب الاشعارات*\n*⇜ سيتم اشعـار المالك في القروب من الان*","md",true)
elseif text and not text:match('^-100(%d+)$') then
send(msg_chat_id,msg_id,"*⇜ الايدي خطأ .. يجب ان يبدأ بـ -100*","md",true)  
end
Redis:del(Zelzal.."Zelzal:Add:Loger:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id) 
end
------------------------------------ زلزال الهيبه ------------------------------------
if Redis:get(Zelzal.."Zelzal:Add:User:Dev"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Add:User:Dev"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n*⇜ تم الغاء امر تغيير كليشة المطور*","md",true)  
end
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = bot.searchPublicChat(text:gsub('@',''))
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n⇜ لا يوجد حساب بهذا اليوزر ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n⇜ هذا معرف قناة 🤡","md",true)  
end
if text and text:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n⇜ لا تستطيع استخدام يوزر بوت ","md",true)  
end
Redis:del(Zelzal.."Zelzal:Add:User:Dev"..msg.sender_id.user_id) 
Redis:set(Zelzal..'Zelzal:Text:Dev',text)
return send(msg_chat_id,msg_id,"*⇜ ابشر غيرت يوزر كليشه المطور*","md",true)
else
return send(msg_chat_id,msg_id,"*⇜ اليوزر خطأ*","md",true)
end
end
------------------------------------ زلزال الهيبه ------------------------------------
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Sudo1"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Sudo1"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المطـور الاسـاسـي  ","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Sudo1"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Sudo:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المطـور الاسـاسـي  الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Sudo2"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Sudo2"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المطـور الاسـاسـي 2 ","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Sudo2"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Sudo2:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المطـور الاسـاسـي 2  الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:DevQ"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:DevQ"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المطـور الثانـوي ","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:DevQ"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:DeveloperQ:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المطـور الثانـوي الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:MevQ"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:MevQ"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المطـوره الثانـويـه","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:MevQ"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:MeveloperQ:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المطـوره الثانـويـه الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Dev"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Dev"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المطـور","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Dev"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Developer:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المطـور الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mev"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mev"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المطـوره","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mev"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Meveloper:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المطـوره الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Pqq"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Pqq"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المـالك الاسـاسـي","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Pqq"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:PresidentQQ:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المـالك الاسـاسـي الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mqq"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mqq"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المـالكه الاسـاسـيه","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mqq"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:MresidentQQ:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المـالكه الاسـاسـيه الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Ppp"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Ppp"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المـالك","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Ppp"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:PresidentQ:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المـالك الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mpp"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mpp"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المـالكه","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mpp"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:MresidentQ:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المـالكه الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Prr"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Prr"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المنشئ الاساسي","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Prr"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:President:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المنشئ الاساسي الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mrr"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mrr"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المنشئه الاساسيه","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mrr"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Mresident:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المنشئه الاساسيه الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Crr"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Crr"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المنشـئ","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Crr"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Constructor:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المنشـئ الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mir"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mir"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المنشئـه","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mir"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Monstructor:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المنشئـه الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mod"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mod"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المديـر","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mod"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Manager:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المديـر الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mom"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mom"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المديـره","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mom"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Mamager:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المديـره الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Adm"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Adm"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة الادمـن","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Adm"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Admin:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة الادمـن الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mdm"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mdm"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة الادمـونـه","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mdm"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Mdmin:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة الادمـونـه الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Vip"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Vip"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المميـز","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Vip"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Vip:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المميـز الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mip"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mip"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة المميـزه","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mip"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Mip:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة المميـزه الى :*\n"..text,"md",true)
end
if Redis:get(Zelzal.."Zelzal:Change:Rotba:Mem"..msg.sender_id.user_id) then 
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mem"..msg.sender_id.user_id) 
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغير رتبـة العضـو","md",true)  
end 
Redis:del(Zelzal.."Zelzal:Change:Rotba:Mem"..msg.sender_id.user_id) 
Redis:set(Zelzal.."Zelzal:Mempar:General:Reply",text)
return send(msg_chat_id,msg_id, "*⇜ تم تغيير رتبـة العضـو الى :*\n"..text,"md",true)
end
-----------------
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."botss:zelzalx:Set:Rd"..msg.sender_id.user_id..":"..msg.chat_id) == "true" then
send(msg_chat_id,msg_id, '\n⇜ ارسل الجواب الاول للرد الان ')
Redis:set(Zelzal.."botss:zelzalx:Set:Rd"..msg.sender_id.user_id..":"..msg.chat_id, "true1")
Redis:set(Zelzal.."botss:zelzalx:Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg.chat_id, text)
Redis:sadd(Zelzal.."botss:zelzalx:List:Rd:Sudo"..msg.chat_id, text)
return false end
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."botss:zelzalx:Set:On"..msg.sender_id.user_id..":"..msg.chat_id) == "true" then
send(msg_chat_id,msg_id,"\n⇜ مسح الرد من الردود المتعدده")
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video"..text..msg.chat_id)  
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif"..text..msg.chat_id)  
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo"..text..msg.chat_id)  
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video1"..text..msg.chat_id)  
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif1"..text..msg.chat_id)  
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo1"..text..msg.chat_id)  
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video2"..text..msg.chat_id)  
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif2"..text..msg.chat_id)  
Redis:del(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo2"..text..msg.chat_id)  
Redis:del(Zelzal..'botss:zelzalx:Add:Rd:Sudo:Text'..text..msg.chat_id)
Redis:del(Zelzal..'botss:zelzalx:Add:Rd:Sudo:Text1'..text..msg.chat_id)
Redis:del(Zelzal..'botss:zelzalx:Add:Rd:Sudo:Text2'..text..msg.chat_id)
Redis:del(Zelzal.."botss:zelzalx:Set:On"..msg.sender_id.user_id..":"..msg.chat_id)
Redis:srem(Zelzal.."botss:zelzalx:List:Rd:Sudo"..msg.chat_id, text)
return false
end
end
if text or msg.content.video or msg.content.animation or msg.content.photo then
local test = Redis:get(Zelzal.."botss:zelzalx:Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg.chat_id)
if Redis:get(Zelzal.."botss:zelzalx:Set:Rd"..msg.sender_id.user_id..":"..msg.chat_id) == "true1" then
Redis:set(Zelzal.."botss:zelzalx:Set:Rd"..msg.sender_id.user_id..":"..msg.chat_id,'rd1')
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo"..test..msg.chat_id, idPhoto)  
elseif msg.content.animation then
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif"..test..msg.chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video then 
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video"..test..msg.chat_id, msg.content.video.video.remote.id)  
elseif text then
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:Text"..test..msg.chat_id, text)  
end  
send(msg_chat_id,msg_id,"\n⇜ تم الحفظ ارسل الجواب الثاني")
return false  
end  
end
if text or msg.content.video or msg.content.animation or msg.content.photo then
local test = Redis:get(Zelzal.."botss:zelzalx:Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg.chat_id)
if Redis:get(Zelzal.."botss:zelzalx:Set:Rd"..msg.sender_id.user_id..":"..msg.chat_id) == "rd1" then
Redis:set(Zelzal.."botss:zelzalx:Set:Rd"..msg.sender_id.user_id..":"..msg.chat_id,'rd2')
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo1"..test..msg.chat_id, idPhoto)  
elseif msg.content.animation then
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif1"..test..msg.chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video then 
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video1"..test..msg.chat_id, msg.content.video.video.remote.id)  
elseif text then
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:Text1"..test..msg.chat_id, text)  
end  
send(msg_chat_id,msg_id,"\n⇜ الحفظ ارسل الجواب الثالث")
return false  
end  
end
if text or msg.content.video or msg.content.animation or msg.content.photo then
local test = Redis:get(Zelzal.."botss:zelzalx:Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg.chat_id)
if Redis:get(Zelzal.."botss:zelzalx:Set:Rd"..msg.sender_id.user_id..":"..msg.chat_id) == "rd2" then
Redis:set(Zelzal.."botss:zelzalx:Set:Rd"..msg.sender_id.user_id..":"..msg.chat_id,'rd3')
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo2"..test..msg.chat_id, idPhoto)  
elseif msg.content.animation then
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif2"..test..msg.chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video then 
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video2"..test..msg.chat_id, msg.content.video.video.remote.id)  
elseif text then
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Zelzal.."botss:zelzalx:Add:Rd:Sudo:Text2"..test..msg.chat_id, text)  
end  
send(msg_chat_id,msg_id,"\n⇜ تم حفظ الرد المتعدد ")
return false  
end  
end
if text and not Redis:get(Zelzal..'lock_repleyadded'..msg.chat_id) then
local photo = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo"..text..msg.chat_id)   
local photo1 = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo1"..text..msg.chat_id)   
local photo2 = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:photo2"..text..msg.chat_id)   
if photo or photo1 or photo2 then 
local texting = {photo,photo1,photo2}
if texting[1] ~= nil or texting[2] ~= nil or texting[3] ~= nil then
bot.sendPhoto(msg_chat_id,msg_id, texting[math.random(#texting)],'')
end
end
local gif = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif"..text..msg.chat_id)   
local gif1 = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif1"..text..msg.chat_id)   
local gif2 = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:gif2"..text..msg.chat_id)   
if gif or gif1 or gif2 then 
local texting = {gif,gif1,gif2}
if texting[1] ~= nil or texting[2] ~= nil or texting[3] ~= nil then
bot.sendAnimation(msg_chat_id,msg_id, texting[math.random(#texting)], '', 'md')
end
end
local video = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video"..text..msg.chat_id)   
local video1 = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video1"..text..msg.chat_id)   
local video2 = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:video2"..text..msg.chat_id)   
if video or video1 or video2 then 
local texting = {video,video1,video2}
if texting[1] ~= nil or texting[2] ~= nil or texting[3] ~= nil then
bot.sendVideo(msg_chat_id,msg_id, texting[math.random(#texting)], '', "md")
end
end
local Text = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:Text"..text..msg.chat_id)   
local Text1 = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:Text1"..text..msg.chat_id)   
local Text2 = Redis:get(Zelzal.."botss:zelzalx:Add:Rd:Sudo:Text2"..text..msg.chat_id)   
if Text or Text1 or Text2 then 
local texting = {Text,Text1,Text2}
send(msg_chat_id,msg_id,texting[math.random(#texting)])
end
end
if text == "مسح قائمه المنع عام" then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:All:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:All:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:All:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:All:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Zelzal.."Zelzal:All:List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"⇜ لا يوجد كلمات ممنوعه عام ","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(Zelzal.."Zelzal:All:Filter:Group:"..v)  
Redis:srem(Zelzal.."Zelzal:All:List:Filter",v)  
end  
return send(msg_chat_id,msg_id,"⇜ تم مسح ("..#list..") كلمات ممنوعه عام ","md",true)   
end
if text == "قائمه المنع العام" or text == "قائمه منع عام" then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:All:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:All:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:All:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:All:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Zelzal.."Zelzal:All:List:Filter")  
if #list == 0 then  
return send(msg_chat_id,msg_id,"⇜ لا يوجد كلمات ممنوعه عام ","md",true)   
end  
Filter = '\n⇜ قائمة المنع عام \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(Zelzal.."Zelzal:All:Filter:Group:"..v)   
Filter = Filter..""..k.."- "..ver.." » ( "..Text_Filter.." )\n"    
end  
send(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع عام" then    
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:All:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:All:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:All:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:All:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Zelzal..'Zelzal:All:FilterText'..msg_chat_id..':'..msg.sender_id.user_id,'true')
return send(msg_chat_id,msg_id,'\n⇜ ارسل الان ( ملصق ,متحركه ,صوره ,رساله ) ',"md",true)  
end    
if text == "الغاء منع عام" then 
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:All:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:All:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:All:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:All:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Zelzal..'Zelzal:All:FilterText'..msg_chat_id..':'..msg.sender_id.user_id,'DelFilterq')
return send(msg_chat_id,msg_id,'\n⇜ ارسل الان ( ملصق ,متحركه ,صوره ,رساله ) ',"md",true)  
end
if (Redis:get(Zelzal..'Zelzal:All:FilterText'..msg_chat_id..':'..msg.sender_id.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(Zelzal.."Zelzal:All:List:Filter",'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(Zelzal.."Zelzal:All:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(Zelzal.."Zelzal:All:List:Filter",'animation:'..msg.content.animation.animation.id)  
Redis:set(Zelzal.."Zelzal:All:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(Zelzal.."Zelzal:All:List:Filter",'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(Zelzal.."Zelzal:All:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(Zelzal.."Zelzal:All:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id, text)  
Redis:sadd(Zelzal.."Zelzal:All:List:Filter",'text:'..text)  
Filters = 'نص'
end
Redis:set(Zelzal..'Zelzal:All:FilterText'..msg_chat_id..':'..msg.sender_id.user_id,'true1')
return send(msg_chat_id,msg_id,"\n⇜ ارسل تحذير ( "..Filters.." ) عند ارساله","md",true)  
end
end
if text and (Redis:get(Zelzal..'Zelzal:All:FilterText'..msg_chat_id..':'..msg.sender_id.user_id) == 'true1') then
local Text_Filter = Redis:get(Zelzal.."Zelzal:All:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id)  
if Text_Filter then
Redis:set(Zelzal.."Zelzal:All:Filter:Group:"..Text_Filter,text)  
end  
Redis:del(Zelzal.."Zelzal:All:Filter:Text"..msg.sender_id.user_id..':'..msg_chat_id)  
Redis:del(Zelzal..'Zelzal:All:FilterText'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"\n⇜ تم اضافة رد التحذير","md",true)  
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(Zelzal.."Zelzal:All:Filter:Group:"..DelFilters)
if ReplyFilters and (not msg.TheBasicsQ or not msg.TheMasicsQ) then
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
return send(msg_chat_id,msg_id,"⇜ لقد تم منع هذه ( "..statusfilter.." ) عام\n⇜ "..ReplyFilters,"md",true)   
end
end
if text == "تفعيل الوضع المدفوع" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
if not data.id then
send(msg_chat_id,msg_id,'⇜ لا يوجد قروب في البوت بهذا الايدي')
return false
end
Redis:sadd(Zelzal.."BotFree:Group:",msg_chat_id)
send(msg_chat_id,msg_id,'⇜ تم تفعيل الوضع المدفوع على : ['..Get_Chat.title..']')
end 
if text == "الغاء الوضع المدفوع" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:srem(Zelzal.."BotFree:Group:",msg_chat_id)
send(msg_chat_id,msg_id,'⇜ تم الغاء الوضع المدفوع عن المجموعه ')
end 
if text and text:match('^تفعيل الوضع المدفوع (-100%d+)$') then
local Chatid = text:match('^تفعيل الوضع المدفوع (-100%d+)$')
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Get_Chat = bot.getChat(Chatid)
if not data.id then
send(msg_chat_id,msg_id,'⇜ لا يوجد قروب في البوت بهذا الايدي')
return false
end
Redis:sadd(Zelzal.."BotFree:Group:",Chatid)
send(msg_chat_id,msg_id,'⇜ تم تفعيل الوضع المدفوع على : ['..Get_Chat.title..']')
end 
if text and text:match('^الغاء الوضع المدفوع (-100%d+)$') then
local Chatid = text:match('^الغاء الوضع المدفوع (-100%d+)$')
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:srem(Zelzal.."BotFree:Group:",Chatid)
send(msg_chat_id,msg_id,'⇜ تم الغاء الوضع المدفوع عن القروب ')
end 
if text and text:match("^حظر قناة @(%S+)$") or text and text:match("^حظر قناه @(%S+)$") then
local User = text:match("^حظر قناة @(%S+)$") or text:match("^حظر قناه @(%S+)$")
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local UserInfo = bot.searchPublicChat(User)
if not UserInfo.id then
send(msg.chat_id,msg.id,"\n⇜ اليوزر غير صحيح","md",true)  
end
if UserInfo.type.is_channel == true then
https.request("https://api.telegram.org/bot"..Token..'/banChatSenderChat?chat_id=' .. msg.chat_id .. '&sender_chat_id='..UserInfo.id)
send(msg.chat_id,msg.id,"\n⇜ تم حظر القناه ⇜ [@"..User.."] ","md",true)  
else
send(msg.chat_id,msg.id,"\n⇜ حدث خطأ ...","md",true)  
end
end
if text and text:match("^الغاء حظر قناة @(%S+)$") or text and text:match("^الغاء حظر قناه @(%S+)$") then
local User = text:match("^الغاء حظر قناة @(%S+)$") or text:match("^الغاء حظر قناه @(%S+)$")
local UserInfo = bot.searchPublicChat(User)
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not UserInfo.id then
send(msg.chat_id,msg.id,"\n⇜ اليوزر غير صحيح","md",true)  
end
if UserInfo.type.is_channel == true then
https.request("https://api.telegram.org/bot"..Token..'/unbanChatSenderChat?chat_id=' .. msg.chat_id .. '&sender_chat_id='..UserInfo.id)
send(msg.chat_id,msg.id,"\n⇜ تم الغاء حظر القناة ⇜ [@"..User.."] ","md",true)  
else
send(msg.chat_id,msg.id,"\n⇜ حدث خطأ ...","md",true)  
end
end
if text == ('حظر قناة') and msg.reply_to_message_id ~= 0 then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.sender_id.chat_id == "messageSenderChat" then
--var(Message_Reply.sender_id.chat_id)
https.request("https://api.telegram.org/bot"..Token..'/banChatSenderChat?chat_id=' .. msg.chat_id .. '&sender_chat_id='..Message_Reply.sender_id.chat_id)
return send(msg_chat_id,msg_id,"*⇜ تم حظر القناة من القروب*","md",true)  
else
send(msg.chat_id,msg.id,"\n⇜ حدث خطأ ...","md",true)  
end
end
if text == ('الغاء حظر قناة') and msg.reply_to_message_id ~= 0 then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(5).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.sender_id.chat_id == "messageSenderChat" then
--var(Message_Reply.sender_id.chat_id)
https.request("https://api.telegram.org/bot"..Token..'/unbanChatSenderChat?chat_id=' .. msg.chat_id .. '&sender_chat_id='..Message_Reply.sender_id.chat_id)
return send(msg_chat_id,msg_id,"*⇜ تم الغاء حظر القناة من القروب*","md",true)  
else
send(msg.chat_id,msg.id,"\n⇜ حدث خطا ...","md",true)  
end
end
RunGames(msg)
zhrfa(msg)
rdood(msg)
rotba(msg)
porn_d(msg)
locks(msg)
if text and text:match('^'..Bot_Name..' ') then
text = text:gsub('^'..Bot_Name..' ','')
end
if text then
local NewCmmd = Redis:get(Zelzal.."All:Get:Reides:Commands:Group"..text) or Redis:get(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if text == 'رفع النسخه الاحتياطيه' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه احتياطيه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(Zelzal) ~= tonumber(FilesJson.BotId) then
return send(msg_chat_id,msg_id,'⇜ عذراً هذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
send(msg_chat_id,msg_id,'⇜ جاري استرجاع المشتركين والقروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
Redis:sadd(Zelzal.."Zelzal:ChekBotAdd",GroupId) 
if ListGroup.President1 then
for k,v in pairs(ListGroup.President1) do
Redis:sadd(Zelzal.."Zelzal:MalekAsase:Group"..GroupId,v)
end
end
if ListGroup.President2 then
for k,v in pairs(ListGroup.President2) do
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..GroupId,v)
end
end
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
Redis:sadd(Zelzal.."Zelzal:TheBasics:Group"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
Redis:sadd(Zelzal.."Zelzal:Originators:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
Redis:sadd(Zelzal.."Zelzal:Managers:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
Redis:sadd(Zelzal.."Zelzal:Distinguished:Group"..GroupId,v)
end
end
if ListGroup.Mresident1 then
for k,v in pairs(ListGroup.Mresident1) do
Redis:sadd(Zelzal.."Zelzal:MalemAsase:Group"..GroupId,v)
end
end
if ListGroup.Mresident2 then
for k,v in pairs(ListGroup.Mresident2) do
Redis:sadd(Zelzal.."Zelzal:TheMasicsQ:Group"..GroupId,v)
end
end
if ListGroup.Mresident then
for k,v in pairs(ListGroup.Mresident) do
Redis:sadd(Zelzal.."Zelzal:TheMasics:Group"..GroupId,v)
end
end
if ListGroup.Monstructor then
for k,v in pairs(ListGroup.Monstructor) do
Redis:sadd(Zelzal.."Zelzal:Origimators:Group"..GroupId,v)
end
end
if ListGroup.Mamager then
for k,v in pairs(ListGroup.Mamager) do
Redis:sadd(Zelzal.."Zelzal:Mamagers:Group"..GroupId,v)
end
end
if ListGroup.Mdmin then
for k,v in pairs(ListGroup.Mdmin) do
Redis:sadd(Zelzal.."Zelzal:Mddictive:Group"..GroupId,v)
end
end
if ListGroup.Mips then
for k,v in pairs(ListGroup.Mips) do
Redis:sadd(Zelzal.."Zelzal:Mistinguished:Group"..GroupId,v)
end
end 
Redis:set(Zelzal.."Zelzal:Lock:tagservrbot"..GroupId,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(Zelzal..'Zelzal:'..lock..GroupId,"del")    
end
Redis:set(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id,"true")
Redis:set(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id,"true")
Redis:set(Zelzal..'tagallgroup'..msg.chat_id,'open') 
Redis:set(Zelzal.."Zelzal:Status:Link"..GroupId,true) 
Redis:set(Zelzal.."Zelzal:Status:Games"..GroupId,true) 
Redis:set(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id,"true")
Redis:set(Zelzal.."replayallbot"..msg.chat_id,true)
Redis:set(Zelzal.."Zelzal:Status:Welcome"..GroupId,true) 
Redis:set(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id,"true")
Redis:set(Zelzal..'tagall@all'..msg.chat_id,'open') 
Redis:set(Zelzal.."Zelzal:Status:IdPhoto"..GroupId,true) 
Redis:del(Zelzal.."spammkick"..msg.chat_id)
Redis:sadd(Zelzal.."Zelzal:ChekBotAdd",GroupId)
Redis:set(Zelzal.."Zelzal:Status:Id"..GroupId,true) 
Redis:set(Zelzal.."Zelzal:Status:Reply"..GroupId,true) 
Redis:set(Zelzal.."Zelzal:Status:ReplySudo"..GroupId,true) 
Redis:set(Zelzal.."Zelzal:Status:BanId"..GroupId,true) 
Redis:set(Zelzal.."Zelzal:Status:SetId"..GroupId,true) 
end
return send(msg_chat_id,msg_id,'⇜ تم استرجاع ( '..X..' ) قروب \n واسرجاع ( '..Y..' ) مشترك في البوت')
end
end
if text == 'رفع نسخه تشاكي' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(Zelzal) then 
return send(msg_chat_id,msg_id,'⇜ عذراً هذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
Redis:sadd(Zelzal.."Zelzal:ChekBotAdd",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
Redis:sadd(Zelzal.."Zelzal:Originators:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
Redis:sadd(Zelzal.."Zelzal:Managers:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
Redis:sadd(Zelzal.."Zelzal:TheBasics:Group"..idg,idASAS)
end;end
end
return send(msg_chat_id,msg_id,'⇜ تم استرجاع القروبات من نسخه تشاكي')
else
return send(msg_chat_id,msg_id,'⇜ الملف لا يدعم هذا البوت')
end
end
end
if (Redis:get(Zelzal..'Zelzal:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id) == 'true') then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then 
Redis:del(Zelzal..'Zelzal:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء حفظ قناة الاشتراك')
end
Redis:del(Zelzal..'Zelzal:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = bot.searchPublicChat(text)
if not UserId_Info.id then
Redis:del(Zelzal..'Zelzal:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
local ChannelUser = text:gsub('@','')
if UserId_Info.type.is_channel == true then
local StatusMember = bot.getChatMember(UserId_Info.id,Zelzal).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,"\n⇜ البوت عضو في القناة يرجى رفع البوت ادمن واعادة وضع الاشتراك ","md",true)
end
Redis:set(Zelzal..'Zelzal:Channel:Join',ChannelUser) 
Redis:set(Zelzal..'Zelzal:Channel:Join:Name',UserId_Info.title) 
return send(msg_chat_id,msg_id,"\n⇜ تم تعيين الاشتراك الاجباري على قناة : [@"..ChannelUser..']',"md",true)  
else
return send(msg_chat_id,msg_id,"\n⇜ هذا ليس معرف قناة يرجى ارسال معرف القناة الصحيح : [@"..ChannelUser..']',"md",true)  
end
end
end
if text == 'تفعيل الاشتراك الاجباري' or text == 'تفعيل الاشتراك الاجباري' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,"\n⇜ ارسل لي الان قناة الاشتراك ","md",true)  
end
if text == 'تعطيل الاشتراك الاجباري' or text == 'تعطيل الاشتراك الاجباري' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal..'Zelzal:Channel:Join')
return send(msg_chat_id,msg_id,"\n⇜ تم تعطيل الاشتراك الاجباري","md",true)  
end
if text == 'تغيير الاشتراك الاجباري' or text == 'تغير الاشتراك الاجباري' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,"\n⇜ ارسل لي الان قناة الاشتراك ","md",true)  
end
if text == 'الاشتراك الاجباري' or text == 'الاشتراك الاجباري' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Channel = Redis:get(Zelzal..'Zelzal:Channel:Join')
if Channel then
return send(msg_chat_id,msg_id,"\n⇜ الاشتراك الاجباري مفعل على : [@"..Channel..']',"md",true)  
else
return send(msg_chat_id,msg_id,"\n⇜ لا توجد قناة في الاشتراك ارسل تغيير الاشتراك الاجباري","md",true)  
end
end
-----------------
if (Redis:get(Zelzal..'Zelzal:Chat:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id) == 'true') then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then 
Redis:del(Zelzal..'Zelzal:Chat:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء حفظ قناة الاشتراك')
end
Redis:del(Zelzal..'Zelzal:Chat:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = bot.searchPublicChat(text)
if not UserId_Info.id then
Redis:del(Zelzal..'Zelzal:Chat:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
local ChannelUser = text:gsub('@','')
if UserId_Info.type.is_channel == true then
local StatusMember = bot.getChatMember(UserId_Info.id,Zelzal).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,"\n⇜ البوت عضو في القناة يرجى رفع البوت ادمن واعادة وضع الاشتراك ","md",true)  
end
Redis:set(Zelzal..'Zelzal:Chat:Channel:Join'..msg_chat_id,ChannelUser) 
Redis:set(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg_chat_id,UserId_Info.title) 
return send(msg_chat_id,msg_id,"\n⇜ تم تعيين الاشتراك الاجباري على قناة : [@"..ChannelUser..']',"md",true)  
else
return send(msg_chat_id,msg_id,"\n⇜ هذا ليس معرف قناة يرجى ارسال معرف القناة الصحيح: [@"..ChannelUser..']',"md",true)  
end
end
end
if text == 'تفعيل الاشتراك الاجباري للقروب' or text == 'تفعيل الاشتراك الاجباري للكروب' then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal..'Zelzal:Chat:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,"\n⇜ ارسلي قناة الاشتراك ","md",true)  
end
if text == 'تعطيل الاشتراك الاجباري للقروب' or text == 'تعطيل الاشتراك الاجباري للكروب' then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:del(Zelzal..'Zelzal:Chat:Channel:Join'..msg_chat_id)
return send(msg_chat_id,msg_id,"\n⇜ تم تعطيل الاشتراك الاجباري","md",true)  
end
if text == 'تغيير الاشتراك الاجباري للقروب' then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:Chat:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,"\n⇜ ارسل لي الان قناة الاشتراك ","md",true)  
end
if text == 'الاشتراك الاجباري للقروب' or text == 'الاشتراك الاجباري للكروب' then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
local Channel = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg_chat_id)
if Channel then
return send(msg_chat_id,msg_id,"\n⇜ الاشتراك الاجباري مفعل على : [@"..Channel..']',"md",true)  
else
return send(msg_chat_id,msg_id,"\n⇜ لا توجد قناة في الاشتراك ارسل تغيير الاشتراك الاجباري","md",true)  
end
end
if (Redis:get(Zelzal.."Zelzal:AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == "الغاء الامر" or text == "✦ الغـاء الامــر ✦" then
Redis:del(Zelzal.."Zelzal:AddSudosNew"..msg_chat_id)
return send(msg_chat_id,msg_id, "\n⇜ تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
Redis:del(Zelzal.."Zelzal:AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = bot.searchPublicChat(text)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
send(msg_chat_id,msg_id,"\n⇜ تم تغيير المطور الاساسي اصبح : [@"..text:gsub('@','').."]","md",true)  
dofile('Zelzal.lua')  
return false
end
end
if text == 'تغيير المطور الاساسي' or text == 'تغيير م' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:AddSudosNew"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"⇜ ارسل معرف المطور الاساسي مع @","md",true)
end
if text == 'تحديث السورس' or text == 'تحديث السورس' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
return send(msg_chat_id,msg_id,'\n⇜ تم تحديث السورس  ',"md",true)  
end
if text == "مسح تخزين البوت" or text == "مسح تخزين البوت" then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) then 
local keys = Redis:keys(Zelzal..'*')
for i = 1, #keys do
Redis:del(keys[i])
end
return send(msg_chat_id,msg_id,'\n⇜ تم مسح تخزين البوت بالكامل ',"md")
end
end
if text == 'معلومات التنصيب' or text == 'معلومات التنصيب' then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then 
usersend = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then 
usersend = true
else
usersend = false
end
if usersend ~= true then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local UserInfo = bot.getUser(Sudo_Id)
if UserInfo.username then
UserInfousername = '[@'..UserInfo.username..']'
else
UserInfousername = 'لا يوجد'
end
local Teext = '⇜ اسم المطور : ['..UserInfo.first_name..'](tg://user?id='..Sudo_Id..')\n'
print(Teext)
return send(msg_chat_id,msg_id,'\n\n*⇜ التوكن :* `'..Token..'`\n\n*⇜ معرف البوت :* [@'..UserBot..']\n\n*⇜  ايدي المطور :* `'..Sudo_Id..'`\n\n*⇜ معرف المطور :* '..UserInfousername..'\n\n'..Teext,"md",true) 
end
if text == "ضع صوره للترحيب" or text == "ضع صورة للترحيب" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local photo = bot.getUserProfilePhotos(Zelzal)
if photo.total_count > 0 then
Redis:set(Zelzal..':WELCOME_BOT',photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id)
return send(msg_chat_id,msg_id, '⇜ تم استدعاء صورة البوت ووضعها \n',"md",true)
else
Redis:setex(Zelzal..'welcom_ph:witting'..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id, '⇜ حسناً عزيزي \n⇜ الان قم بارسال صورة للترحيب \n',"md",true)
end 
end
if text == "ضع تاريخ الاشتراك" or text == "وضع تاريخ الاشتراك" then
if msg.sender_id.user_id ~= 1260465030 or msg.sender_id.user_id ~= 1260465030 then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( مطور السورس ) ',"md",true)  
end
Redis:set(Zelzal.."data:botsashtrak"..msg_chat_id..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,'\n*⇜ ارسل تاريخ الاشتراك*',"md",true)  
end
if Redis:get(Zelzal.."data:botsashtrak"..msg_chat_id..msg.sender_id.user_id) then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then
Redis:del(Zelzal.."data:botsashtrak"..msg_chat_id..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'\n*⇜ تم الغاء الامر*',"md",true)  
end
Redis:set(Zelzal.."data:bots:ashtrak",text)
Redis:del(Zelzal.."data:botsashtrak"..msg_chat_id..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'\n*⇜ تم تعيين تاريخ الاشتراك*',"md",true)  
end
if text == "اشتراك البوت" or text == "اشتراك بوت" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
return send(msg_chat_id,msg_id,'\n*⇜ UserDev: @'..UserSudo..'*\n*⇜ DateExp: '..(Redis:get(Zelzal.."data:bots:ashtrak") or 0)..'*',"md",true)  
end
if text == 'رفع سورس' and msg.reply_to_message_id ~= 0  then
if not msg.ControllerBot then 
return bot.sendText(msg_chat_id,msg_id,'\n*⇜ عذرا الامر يخص { المطور الاساسي } فقط*',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= 'Zelzal.lua' then
return bot.sendText(msg_chat_id,msg_id,'*• عذرا هذا الملف ليس سورسك*',"md",true)
end
os.execute('rm -rf Zelzal.lua')
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
return bot.sendText(msg_chat_id,msg_id,'*• تم رفع سورس اكتب تحديث*',"md",true)
end 
end
if text == 'جلب نسخه التقييم' or text == 'جلب نسخه التقيم' or text == '✦ جلب نسخه التقييم ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local ListStars = Redis:smembers(Zelzal..'List_Stars')  
local Takeem1 = Redis:get(Zelzal..'Zilzal:Takeem:T1') or 0
local Takeem2 = Redis:get(Zelzal..'Zilzal:Takeem:T2') or 0
local Takeem3 = Redis:get(Zelzal..'Zilzal:Takeem:T3') or 0
local Takeem4 = Redis:get(Zelzal..'Zilzal:Takeem:T4') or 0
local Takeem5 = Redis:get(Zelzal..'Zilzal:Takeem:T5') or 0
local Get_Json = '{"BotId": '..Zelzal..','  
if #ListStars ~= 0 then 
Get_Json = Get_Json..'"ListStars":['  
for k,v in pairs(ListStars) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"Takeem1":"'..Takeem1..'", "Takeem2":"'..Takeem2..'", "Takeem3":"'..Takeem3..'", "Takeem4":"'..Takeem4..'", "Takeem5":"'..Takeem5..'"}'
local File = io.open('./ListStars.json', "w")
File:write(Get_Json)
File:close()
return bot.sendDocument(msg_chat_id,msg_id,'./ListStars.json', '*⇜ تم جلب نسخه تقييم البوت آخر تحديث* ✅\n*⇜ تحتوي على التقييم التالي*\n\n*⇜ عدد* ( '..Takeem1..' ) 🌟\n*⇜ عدد* ( '..Takeem2..' ) 🌟🌟\n*⇜ عدد* ( '..Takeem3..' ) 🌟🌟🌟\n*⇜ عدد* ( '..Takeem4..' ) 🌟🌟🌟🌟\n*⇜ عدد* ( '..Takeem5..' ) 🌟🌟🌟🌟🌟\n', 'md')
end
if text == 'رفع نسخة التقييم' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه التقييم' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(Zelzal) ~= tonumber(FilesJson.BotId) then
return send(msg_chat_id,msg_id,'*⇜ عذراً هذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه*',"md",true)
end -- end botid
send(msg_chat_id,msg_id,'*⇜ جاري استرجاع التقييم ...*',"md",true)
Y = 0
for k,v in pairs(FilesJson.ListStars) do
Y = Y + 1
Redis:sadd(Zelzal..'List_Stars',v)
end
local Takeem1 = tonumber(FilesJson.Takeem1)
local Takeem2 = tonumber(FilesJson.Takeem2)
local Takeem3 = tonumber(FilesJson.Takeem3)
local Takeem4 = tonumber(FilesJson.Takeem4)
local Takeem5 = tonumber(FilesJson.Takeem5)
Redis:incrby(Zelzal..'Zilzal:Takeem:T1', Takeem1)
Redis:incrby(Zelzal..'Zilzal:Takeem:T2', Takeem2)
Redis:incrby(Zelzal..'Zilzal:Takeem:T3', Takeem3)
Redis:incrby(Zelzal..'Zilzal:Takeem:T4', Takeem4)
Redis:incrby(Zelzal..'Zilzal:Takeem:T5', Takeem5)
return send(msg_chat_id,msg_id,'*⇜ تم استرجاع تقييم البوت .. بنجاح ✅*',"md",true)
end
end
if text == 'جلب النسخه الاحتياطية' or text == 'جلب النسخه الاحتياطيه' or text == '✦ جلب نسخه احتياطيه ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Groups = Redis:smembers(Zelzal..'Zelzal:ChekBotAdd')  
local UsersBot = Redis:smembers(Zelzal..'Zelzal:Num:User:Pv')  
local Get_Json = '{"BotId": '..Zelzal..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President1 = Redis:smembers(Zelzal.."Zelzal:MalekAsase:Group"..v)
local President2 = Redis:smembers(Zelzal.."Zelzal:TheBasicsQ:Group"..v)
local President = Redis:smembers(Zelzal.."Zelzal:TheBasics:Group"..v)
local Constructor = Redis:smembers(Zelzal.."Zelzal:Originators:Group"..v)
local Manager = Redis:smembers(Zelzal.."Zelzal:Managers:Group"..v)
local Admin = Redis:smembers(Zelzal.."Zelzal:Addictive:Group"..v)
local Vips = Redis:smembers(Zelzal.."Zelzal:Distinguished:Group"..v)
local Mresident1 = Redis:smembers(Zelzal.."Zelzal:MalemAsase:Group"..v)
local Mresident2 = Redis:smembers(Zelzal.."Zelzal:TheMasicsQ:Group"..v)
local Mresident = Redis:smembers(Zelzal.."Zelzal:TheMasics:Group"..v)
local Monstructor = Redis:smembers(Zelzal.."Zelzal:Origimators:Group"..v)
local Mamager = Redis:smembers(Zelzal.."Zelzal:Mamagers:Group"..v)
local Mdmin = Redis:smembers(Zelzal.."Zelzal:Mddictive:Group"..v)
local Mips = Redis:smembers(Zelzal.."Zelzal:Mistinguished:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President1 ~= 0 then 
Get_Json = Get_Json..'"President1":['
for k,v in pairs(President1) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #President2 ~= 0 then 
Get_Json = Get_Json..'"President2":['
for k,v in pairs(President2) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mresident1 ~= 0 then 
Get_Json = Get_Json..'"Mresident1":['
for k,v in pairs(Mresident1) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mresident2 ~= 0 then 
Get_Json = Get_Json..'"Mresident2":['
for k,v in pairs(Mresident2) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mresident ~= 0 then 
Get_Json = Get_Json..'"Mresident":['
for k,v in pairs(Mresident) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Monstructor ~= 0 then
Get_Json = Get_Json..'"Monstructor":['
for k,v in pairs(Monstructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mamager ~= 0 then
Get_Json = Get_Json..'"Mamager":['
for k,v in pairs(Mamager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mdmin ~= 0 then
Get_Json = Get_Json..'"Mdmin":['
for k,v in pairs(Mdmin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mips ~= 0 then
Get_Json = Get_Json..'"Mips":['
for k,v in pairs(Mips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"F_L_J"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
Redis:setex(Zelzal.."Status:SendFile",86400,true)
Redis:setex(Zelzal.."Status:SendRododFile",86400,true)
Redis:setex(Zelzal.."Status:SendRodoodFile",86400,true)
return bot.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '*⇜ تم جلب النسخـة .. بنجـاح ✅*\n*⇜ النسخـة الاحتيـاطيـة (العامة) آخر تحديث*\n*⇜ عدد المجموعات* ( '..#Groups..' ) *مجموعة* \n*⇜ عدد المشتركين* ( '..#UsersBot..' ) *مشترك* \n', 'md')
end
if text == 'تفعيل جلب النسخ تلقائي' or text == 'تفعيل جلب النسخه تلقائيا' or text == '✦ تفعيل نسخه تلقائيه ✦' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Status:SendFile",86400,true)
Redis:setex(Zelzal.."Status:SendRododFile",86400,true)
Redis:setex(Zelzal.."Status:SendRodoodFile",86400,true)
--Redis:set(Zelzal.."Status:SendFile1",true)
return send(msg_chat_id,msg_id,"*⇜ تم تفعيل جلب نسخة القروبات التلقائيه*","md")
end
if text == 'تعطيل جلب النسخ تلقائي' or text == 'تعطيل جلب النسخه تلقائيا' or text == '✦ تعطيل نسخه تلقائيه ✦' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Status:SendFile")
Redis:del(Zelzal.."Status:SendRododFile")
Redis:del(Zelzal.."Status:SendRodoodFile") 
--Redis:del(Zelzal.."Status:SendFile1") 
return send(msg_chat_id,msg_id,"*⇜ تم تعطيل جلب نسخة القروبات التلقائيه*","md")
end
-----------------
if tonumber(Redis:ttl(Zelzal.."Status:SendFile")) <= 1 then
local Groups = Redis:smembers(Zelzal..'Zelzal:ChekBotAdd')  
local UsersBot = Redis:smembers(Zelzal..'Zelzal:Num:User:Pv')  
local Get_Json = '{"BotId": '..Zelzal..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President1 = Redis:smembers(Zelzal.."Zelzal:MalekAsase:Group"..v)
local President2 = Redis:smembers(Zelzal.."Zelzal:TheBasicsQ:Group"..v)
local President = Redis:smembers(Zelzal.."Zelzal:TheBasics:Group"..v)
local Constructor = Redis:smembers(Zelzal.."Zelzal:Originators:Group"..v)
local Manager = Redis:smembers(Zelzal.."Zelzal:Managers:Group"..v)
local Admin = Redis:smembers(Zelzal.."Zelzal:Addictive:Group"..v)
local Vips = Redis:smembers(Zelzal.."Zelzal:Distinguished:Group"..v)
local Mresident1 = Redis:smembers(Zelzal.."Zelzal:MalemAsase:Group"..v)
local Mresident2 = Redis:smembers(Zelzal.."Zelzal:TheMasicsQ:Group"..v)
local Mresident = Redis:smembers(Zelzal.."Zelzal:TheMasics:Group"..v)
local Monstructor = Redis:smembers(Zelzal.."Zelzal:Origimators:Group"..v)
local Mamager = Redis:smembers(Zelzal.."Zelzal:Mamagers:Group"..v)
local Mdmin = Redis:smembers(Zelzal.."Zelzal:Mddictive:Group"..v)
local Mips = Redis:smembers(Zelzal.."Zelzal:Mistinguished:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President1 ~= 0 then 
Get_Json = Get_Json..'"President1":['
for k,v in pairs(President1) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #President2 ~= 0 then 
Get_Json = Get_Json..'"President2":['
for k,v in pairs(President2) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mresident1 ~= 0 then 
Get_Json = Get_Json..'"Mresident1":['
for k,v in pairs(Mresident1) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mresident2 ~= 0 then 
Get_Json = Get_Json..'"Mresident2":['
for k,v in pairs(Mresident2) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mresident ~= 0 then 
Get_Json = Get_Json..'"Mresident":['
for k,v in pairs(Mresident) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Monstructor ~= 0 then
Get_Json = Get_Json..'"Monstructor":['
for k,v in pairs(Monstructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mamager ~= 0 then
Get_Json = Get_Json..'"Mamager":['
for k,v in pairs(Mamager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mdmin ~= 0 then
Get_Json = Get_Json..'"Mdmin":['
for k,v in pairs(Mdmin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Mips ~= 0 then
Get_Json = Get_Json..'"Mips":['
for k,v in pairs(Mips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"F_L_J"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
Redis:setex(Zelzal.."Status:SendFile",86400,true)
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
return bot.sendDocument(Loger_Id,0,'./'..UserBot..'.json', '*⇜ تم جلب النسخة اليومية .. تلقائياً ✅*\n*⇜ النسخـة الاحتيـاطيـة (العامة) آخر تحديث*\n*⇜ عدد المجموعات* ( '..#Groups..' ) *مجموعة* \n*⇜ عدد المشتركين* ( '..#UsersBot..' ) *مشترك* \n', 'md')
else
return bot.sendDocument(Sudo_Id,0,'./'..UserBot..'.json', '*⇜ تم جلب النسخة اليومية .. تلقائياً ✅*\n*⇜ النسخـة الاحتيـاطيـة (العامة) آخر تحديث*\n*⇜ عدد المجموعات* ( '..#Groups..' ) *مجموعة* \n*⇜ عدد المشتركين* ( '..#UsersBot..' ) *مشترك* \n', 'md')
end
end
if text == 'جلب نسخه الردود العامه' or text == 'جلب نسخه الردود عام' or text == '✦ جلب نسخه الردود عام ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Get_Json = '{"BotId": '..Zelzal..','  
Get_Json = Get_Json..'"GroupsBotreply":{'
listrep = Redis:smembers(Zelzal.."Zelzal:List:Rd:Sudo")
if #listrep >= 5 then
for k,v in pairs(listrep) do
if Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..v) then
db = "gif@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..v) then
db = "Vico@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..v) then
db = "Stekrs@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..v) then
db = "Text@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..v)
db = string.gsub(db,'"','')
db = string.gsub(db,"'",'')
db = string.gsub(db,'*','')
db = string.gsub(db,'`','')
db = string.gsub(db,'{','')
db = string.gsub(db,'}','')
db = string.gsub(db,'\n',' ')
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..v) then
db = "Photo@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..v) 
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..v) then
db = "Video@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:File"..v) then
db = "File@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:File"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..v) then
db = "Audio@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..v) then
db = "video_note@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..v)
end
v = string.gsub(v,'"','')
v = string.gsub(v,"'",'')
Get_Json = Get_Json..'"'..v..'":"'..db..'",'
end   
Get_Json = Get_Json..'"taha":"ok"'
end
Get_Json = Get_Json..'}}'
local File = io.open('./Groups_all.json', "w")
File:write(Get_Json)
File:close()
Redis:setex(Zelzal.."Status:SendFile",86400,true)
Redis:setex(Zelzal.."Status:SendRododFile",86400,true)
Redis:setex(Zelzal.."Status:SendRodoodFile",86400,true)
return bot.sendDocument(msg_chat_id,msg_id,'./Groups_all.json', '', 'md')
end
---- جلب نسخة الردود العامة تلقائياً ----
if tonumber(Redis:ttl(Zelzal.."Status:SendRodoodFile")) <= 1 then
local Get_Json = '{"BotId": '..Zelzal..','  
Get_Json = Get_Json..'"GroupsBotreply":{'
listrep = Redis:smembers(Zelzal.."Zelzal:List:Rd:Sudo")
if #listrep >= 5 then
for k,v in pairs(listrep) do
if Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..v) then
db = "gif@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..v) then
db = "Vico@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..v) then
db = "Stekrs@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..v) then
db = "Text@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..v)
db = string.gsub(db,'"','')
db = string.gsub(db,"'",'')
db = string.gsub(db,'*','')
db = string.gsub(db,'`','')
db = string.gsub(db,'{','')
db = string.gsub(db,'}','')
db = string.gsub(db,'\n',' ')
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..v) then
db = "Photo@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..v) 
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..v) then
db = "Video@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:File"..v) then
db = "File@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:File"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..v) then
db = "Audio@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..v)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..v) then
db = "video_note@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..v)
end
v = string.gsub(v,'"','')
v = string.gsub(v,"'",'')
Get_Json = Get_Json..'"'..v..'":"'..db..'",'
end   
Get_Json = Get_Json..'"taha":"ok"'
end
Get_Json = Get_Json..'}}'
local File = io.open('./Groups_all.json', "w")
File:write(Get_Json)
File:close()
Redis:setex(Zelzal.."Status:SendRodoodFile",86400,true)
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
return bot.sendDocument(Loger_Id,0,'./Groups_all.json', '*⇜ نسخة الردود العامة آخر تحديث*\n*⇜ تم جلب النسخه اليومية .. تلقائيـاً ✅*', 'md')
else
return bot.sendDocument(Sudo_Id,0,'./Groups_all.json', '*⇜ نسخة الردود العامة آخر تحديث*\n*⇜ تم جلب النسخه اليومية .. تلقائيـاً ✅*', 'md')
end
end
if text == 'رفع نسخه الردود العامه' or text == 'رفع نسخه الردود عام' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local Reply_Groups = JSON.decode(Get_Info) 
for k,v in pairs(Reply_Groups.GroupsBotreply) do
Redis:sadd(Zelzal.."Zelzal:List:Rd:Sudo",k)
if v and v:match('gif@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..k,v:match('gif@(.*)'))
elseif v and v:match('Vico@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..k,v:match('Vico@(.*)'))
elseif v and v:match('Stekrs@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..k,v:match('Stekrs@(.*)'))
elseif v and v:match('Text@(.*)') then
print('&&&')
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..k,v:match('Text@(.*)'))
elseif v and v:match('Photo@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..k,v:match('Photo@(.*)'))
elseif v and v:match('Video@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..k,v:match('Video@(.*)'))
elseif v and v:match('File@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:File"..k,v:match('File@(.*)') )
elseif v and v:match('Audio@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..k,v:match('Audio@(.*)'))
elseif v and v:match('video_note@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..k,v:match('video_note@(.*)') )
end
end
return send(msg_chat_id,msg_id,'\n*⇜ تم استرجاع الردود العامه*',"md",true)  
end
end
if text == 'جلب نسخه الردود' or text == '✦ جلب نسخة الردود ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Get_Json = '{"BotId": '..Zelzal..','  
Get_Json = Get_Json..'"GroupsBotreply":{'
local Groups = Redis:smembers(Zelzal..'Zelzal:ChekBotAdd')  
for k,ide in pairs(Groups) do   
listrep = Redis:smembers(Zelzal.."Zelzal:List:Manager"..ide.."")
if k == 1 then
Get_Json = Get_Json..'"'..ide..'":{'
else
Get_Json = Get_Json..',"'..ide..'":{'
end
if #listrep >= 5 then
for k,v in pairs(listrep) do
if Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Gif"..v..ide) then
db = "gif@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Gif"..v..ide)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Vico"..v..ide) then
db = "Vico@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Vico"..v..ide)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Stekrs"..v..ide) then
db = "Stekrs@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Stekrs"..v..ide)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Text"..v..ide) then
db = "Text@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Text"..v..ide)
db = string.gsub(db,'"','')
db = string.gsub(db,"'",'')
db = string.gsub(db,'*','')
db = string.gsub(db,'`','')
db = string.gsub(db,'{','')
db = string.gsub(db,'}','')
db = string.gsub(db,'\n',' ')
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Photo"..v..ide) then
db = "Photo@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Photo"..v..ide) 
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Video"..v..ide) then
db = "Video@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Video"..v..ide)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:File"..v..ide) then
db = "File@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:File"..v..ide)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Audio"..v..ide) then
db = "Audio@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Audio"..v..ide)
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:video_note"..v..ide) then
db = "video_note@"..Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:video_note"..v..ide)
end
v = string.gsub(v,'"','')
v = string.gsub(v,"'",'')
Get_Json = Get_Json..'"'..v..'":"'..db..'",'
end   
Get_Json = Get_Json..'"taha":"ok"'
end
Get_Json = Get_Json..'}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./ReplyGroups.json', "w")
File:write(Get_Json)
File:close()
Redis:setex(Zelzal.."Status:SendFile",86400,true)
Redis:setex(Zelzal.."Status:SendRododFile",86400,true)
Redis:setex(Zelzal.."Status:SendRodoodFile",86400,true)
return bot.sendDocument(msg_chat_id,msg_id,'./ReplyGroups.json', '', 'md')
end
---- جلب نسخة الردود تلقائياً ----
if text == 'رفع نسخه الردود' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local Reply_Groups = JSON.decode(Get_Info) 
for GroupId,ListGroup in pairs(Reply_Groups.GroupsBotreply) do
if ListGroup.taha == "ok" then
for k,v in pairs(ListGroup) do
Redis:sadd(Zelzal.."Zelzal:List:Manager"..GroupId,k)
if v and v:match('gif@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:Gif"..k..GroupId,v:match('gif@(.*)'))
elseif v and v:match('Vico@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:Vico"..k..GroupId,v:match('Vico@(.*)'))
elseif v and v:match('Stekrs@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:Stekrs"..k..GroupId,v:match('Stekrs@(.*)'))
elseif v and v:match('Text@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:Text"..k..GroupId,v:match('Text@(.*)'))
elseif v and v:match('Photo@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:Photo"..k..GroupId,v:match('Photo@(.*)'))
elseif v and v:match('Video@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:Video"..k..GroupId,v:match('Video@(.*)'))
elseif v and v:match('File@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:File"..k..GroupId,v:match('File@(.*)') )
elseif v and v:match('Audio@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:Audio"..k..GroupId,v:match('Audio@(.*)'))
elseif v and v:match('video_note@(.*)') then
Redis:set(Zelzal.."Zelzal:Add:Rd:Manager:video_note"..k..GroupId,v:match('video_note@(.*)') )
end
end
end
end
return send(msg_chat_id,msg_id,'\n*⇜ تم استرجاع ردود القروبات*',"md",true)  
end
end
if text and text:match("^تعيين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:Num:Add:Bot',text:match("تعيين عدد الاعضاء (%d+)$") ) 
send(msg_chat_id,msg_id,'⇜ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعيين عدد الاعضاء (%d+)$")..' عضو ',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
send(msg_chat_id,msg_id,'⇜ عدد احصائيات البوت \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n⇜ عدد القروبات : '..(Redis:scard(Zelzal..'Zelzal:ChekBotAdd') or 0)..'\n⇜ عدد المشتركين : '..(Redis:scard(Zelzal..'Zelzal:Num:User:Pv') or 0)..'',"md",true)  
end
if text == 'الالوان' or text == 'تحليل الشخصيه' or text == 'الوان' or text == '★ شخصيتك من لونك المفضـل ★' then
local ban = bot.getUser(msg.sender_id.user_id)
local t = "*- مرحبًـا عـزيـزي*["..ban.first_name.."](tg://user?id="..ban.id..") \n*- لمعرفة شخصيتك من لونك المفضل\n- اختـر لونـك من الازرار التاليـه*" 
local m = "https://t.me/msmswork/63" 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'الابيض', callback_data=msg.sender_id.user_id..'/whitee'},{text = 'الاسود', callback_data=msg.sender_id.user_id..'/blackk'},{text = 'الرمادي', callback_data=msg.sender_id.user_id..'/ramad'},},
{{text = 'الازرق', callback_data=msg.sender_id.user_id..'/blue'},{text = 'الاخضر', callback_data=msg.sender_id.user_id..'/green'},{text = 'الاصفر', callback_data=msg.sender_id.user_id..'/yelow'},},
{{text = 'الوردي', callback_data=msg.sender_id.user_id..'/pink'},{text = 'الاحمر', callback_data=msg.sender_id.user_id..'/redd'},{text = 'البرتقالي', callback_data=msg.sender_id.user_id..'/portg'},},
{{text = 'البني', callback_data=msg.sender_id.user_id..'/brown'},{text = 'البنفسجي', callback_data=msg.sender_id.user_id..'/banafsg'},{text = 'الفضي', callback_data=msg.sender_id.user_id..'/fiidi'},},
{{text = 'الذهبي', callback_data=msg.sender_id.user_id..'/goold'},},}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&photo="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown&reply_markup="..JSON.encode(keyboard))
end
if text == '★ لعبـة سيارتـي ★' then
local ban = bot.getUser(msg.sender_id.user_id)
local Name = '['..ban.first_name..'](tg://user?id='..ban.id..')' or 'لا يوجد اسم'
local Zilzal = '*⇜ مرحبًـا عـزيـزي ⇜ *'..Name..'\n*⇜ قم بالضغـط ع الـزر لعـرض سيارتـك 🚘*'
local photo = "https://t.me/syzedrattt/13"
local msg_reply = msg.id/2097152/0.5
local keyboard = {}
keyboard.inline_keyboard = {
{
{text = '• اضغـط هنـا •', callback_data=msg.sender_id.user_id.."/mysysr"},
},
}
return https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..msg_reply.."&photo="..photo.."&caption="..URL.escape(Zilzal).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'مريم' or text == 'لعبة مريم' or text == 'لعبه مريم' or text == '★ لعبـة مريـم ★'  then
local ban = bot.getUser(msg.sender_id.user_id)
local t = "*- مرحبًـا بـك عـزيـزي*["..ban.first_name.."](tg://user?id="..ban.id..") \n*- في لعبـة مريـم 🙋🏻‍♀\n- اضغـط الـزر لـ بـدء اللعبـه🥤*"
local m = "https://telegra.ph/file/3cd5c4f33dbbb399fab44.jpg" 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'بـدء اللعبـه🙅🏻‍♀', callback_data=msg.sender_id.user_id..'/mariam'},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&photo="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown&reply_markup="..JSON.encode(keyboard))
end
if text == "✦ تعيين نـوع البوت ✦" or text == "تعيين نوع البوت" or text == "تعين نوع البوت" or text == "تغيير نوع البوت" or text == "تغير نوع البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local ban = bot.getUser(msg.sender_id.user_id)
local t = "*- مرحبًـا مطـوري*["..ban.first_name.."](tg://user?id="..ban.id..") \n*- حسنـاً .. قـم بـ اختيـار نـوع البـوت*" 
local m = "https://t.me/RR_U_RR/33"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '✦ بوتـه 🙋🏻‍♀ ✦', callback_data=msg.sender_id.user_id..'/girlls'},{text = '✦ بـوت 🙋🏻‍♂ ✦', callback_data=msg.sender_id.user_id..'/booys'},},}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&photo="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown&reply_markup="..JSON.encode(keyboard))
end
if text == 'ثيمات' or text == 'ثيم' then
local ban = bot.getUser(msg.sender_id.user_id)
local Name = '['..ban.first_name..'](tg://user?id='..ban.id..')'
local Zilzal = '*⇜ مرحبًـا عـزيـزي ⇜ *'..Name..',\n*⇜ في متجـر ثيمـات سـورس 𝙈𝘼𝙏𝙍𝙄𝙓\n⇜ يوجـد في البـوت اكثـر من 100 ثيـم مميـز*'
local m = "https://t.me/Z_ZZZ8/71"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'اضغـط هنـا', callback_data=msg.sender_id.user_id.."/NoThim1"},},}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg_chat_id.."&caption="..URL.escape(Zilzal).."&photo="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown&reply_markup="..JSON.encode(keyboard))
end
if text == 'تفعيل' and (msg.Developers or msg.Mevelopers) then
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه وتفعيل الصلاحيات له*","md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local names = Get_Chat.title
local UserInfo = bot.getUser(msg.sender_id.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
if names and (names:match("سكس ") or names:match(" سكس") or names:match("sex") or names:match("porn") or names:match("كحاب") or names:match("قحاب") or names:match("كحب") or names:match("قحب") or names:match("ورعان") or names:match("سوالب") or names:match("سالب") or names:match("دياث") or names:match("ديوث") or names:match("محارم") or names:match("فضائح") or names:match("عراب") or names:match("👅")) then
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ محـاولة تفعيـل قـروب إباحـي فاشلـه 🔞*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ معلـومـات القـروب :*\n*⇜ الرابـط :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ ايـدي القـروب :* `'..msg_chat_id..'`',"md",true, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ محـاولة تفعيـل قـروب إباحـي فاشلـه 🔞*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ معلـومـات القـروب :*\n*⇜ الرابـط :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ ايـدي القـروب :* `'..msg_chat_id..'`',"md",true, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,"\n*⇜ عذراً .. لا يمكنك تفعيـل البـوت فـي مجموعـات اباحيـة 🔞\n⇜ سـوف اقـوم بالمغـادرة .. فـوراً\n⇜ والتبليـغ عـن مجموعتـك 🛃\n\n⇜ الا تخـاف الله رب العالميـن ؟!*","md",true)
bot.leaveChat(msg_chat_id)
return false
end
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(Zelzal..'Zelzal:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return send(msg_chat_id,msg_id,'*⇜ عدد الاعضاء قليل لا يمكن تفعيل القروب يجب ان يكون اكثر من : *'..Redis:get(Zelzal..'Zelzal:Num:Add:Bot'),"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id) then
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
return send(msg_chat_id,msg_id,'\n*⇜ القروب :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ تم تفعيله مسبقاً*\n ✓',"md",true)  
else
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '• تفعيـل ردود البـوت ⛄️ •', data = msg.sender_id.user_id..'/listallRodood'..msg_chat_id},
},
{
{text = '• الإشعـارات الذكيـه 💡 •', data = msg.sender_id.user_id..'/helpmalk'},
},
}
}
if not msg.ControllerBot then
local UserInfo = bot.getUser(msg.sender_id.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ تم تفعيل قروب جديد*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') \n*⇜ معلومات القروب :*\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count..'\n*⇜ عدد الادمنيه :* '..Info_Chats.administrator_count..'\n*⇜ عدد المطرودين :* '..Info_Chats.banned_count..'\n*⇜ عدد المقيدين :* '..Info_Chats.restricted_count..'\n*⇜ الرابط :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ ايدي القروب :* `'..msg_chat_id..'`',"md",true, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ تم تفعيل قروب جديد*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') \n*⇜ معلومات القروب :*\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count..'\n*⇜ عدد الادمنيه :* '..Info_Chats.administrator_count..'\n*⇜ عدد المطرودين :* '..Info_Chats.banned_count..'\n*⇜ عدد المقيدين :* '..Info_Chats.restricted_count..'\n*⇜ الرابط :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ ايدي القروب :* `'..msg_chat_id..'`',"md",true, false, false, false, reply_markup)
end
end
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id)
if (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
if StatusMember.status.can_change_info == true and
StatusMember.status.can_delete_messages == true and
StatusMember.status.can_invite_users == true and
StatusMember.status.can_pin_messages == true and
StatusMember.status.can_promote_members == true and
StatusMember.status.can_restrict_members == true then
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,msg.sender_id.user_id) 
end
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
UserIdMalek = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
UserIdMalek = v.member_id.user_id
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,v.member_id.user_id)
Redis:sadd(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id,v.member_id.user_id) 
else
local StatusMember = bot.getChatMember(msg_chat_id,v.member_id.user_id)
if (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
if StatusMember.status.can_change_info == true and
StatusMember.status.can_delete_messages == true and
StatusMember.status.can_invite_users == true and
StatusMember.status.can_pin_messages == true and
StatusMember.status.can_promote_members == true and
StatusMember.status.can_restrict_members == true then
print(v.member_id.user_id)
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,v.member_id.user_id)
end
end
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,v.member_id.user_id) 
end
end
end
Redis:set(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id,"true")
Redis:set(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id,"true")
Redis:set(Zelzal..'tagallgroup'..msg.chat_id,'open') 
Redis:set(Zelzal.."Zelzal:Status:Link"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:Games"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id,"true")
Redis:set(Zelzal.."replayallbot"..msg.chat_id,true)
Redis:set(Zelzal.."rebomsg"..msg.chat_id,true)
Redis:set(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id,"true")
Redis:set(Zelzal..'tagall@all'..msg.chat_id,'open') 
Redis:set(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id,true) 
Redis:del(Zelzal.."spammkick"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:vico"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Video"..msg_chat_id)  
Redis:set(Zelzal.."Zelzal:Lock:phshar"..msg_chat_id,true)
Redis:sadd(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id)
Redis:set(Zelzal.."Zelzal:Status:Id"..msg_chat_id,true) ;Redis:set(Zelzal.."Zelzal:Status:Reply"..msg_chat_id,true) ;Redis:set(Zelzal.."Zelzal:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(Zelzal.."Zelzal:Status:BanId"..msg_chat_id,true) ;Redis:set(Zelzal.."Zelzal:Status:SetId"..msg_chat_id,true) 
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local UserInfo = bot.getUser(UserIdMalek)
local textadd = '\n*⇜ ابشر فعلت القروب* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')'..
'\n*⇜ المالك :* ['..UserInfo.first_name..'](tg://user?id='..UserIdMalek..')'..
'\n*⇜ عدد المشرفين :* '..Info_Chats.administrator_count..
'\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '• تفعيـل ردود البـوت ⛄️ •', data = msg.sender_id.user_id..'/listallRodood'..msg_chat_id},
},
{
{text = '• الإشعـارات الذكيـه 💡 •', data = msg.sender_id.user_id..'/helpmalk'},
},
}
}
return send(msg_chat_id,msg_id,textadd,'md', true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and (not msg.Developers or not msg.Mevelopers) then
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه وتفعيل الصلاحيات له*","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:sismember(Zelzal..'Black:listBan:',msg_chat_id) then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً القروب محظور من قبل المطور*","md",true)  
end
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذرا انت لست مشرف او مالك القروب*","md",true)  
end
if not Redis:get(Zelzal.."Zelzal:BotFree") then
return send(msg_chat_id,msg_id,"\n*⇜ الوضع الخدمي تم تعطيله من قبل مطور البوت*","md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local names = Get_Chat.title
local UserInfo = bot.getUser(msg.sender_id.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
if names and (names:match("سكس ") or names:match(" سكس") or names:match("sex") or names:match("porn") or names:match("كحاب") or names:match("قحاب") or names:match("كحب") or names:match("قحب") or names:match("ورعان") or names:match("سوالب") or names:match("سالب") or names:match("دياث") or names:match("ديوث") or names:match("محارم") or names:match("فضائح") or names:match("عراب") or names:match("👅")) then
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ محـاولة تفعيـل قـروب إباحـي فاشلـه 🔞*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ معلـومـات القـروب :*\n*⇜ الرابـط :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ ايـدي القـروب :* `'..msg_chat_id..'`',"md",true, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ محـاولة تفعيـل قـروب إباحـي فاشلـه 🔞*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ معلـومـات القـروب :*\n*⇜ الرابـط :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ ايـدي القـروب :* `'..msg_chat_id..'`',"md",true, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,"\n*⇜ عذراً .. لا يمكنك تفعيـل البـوت فـي مجموعـات اباحيـة 🔞\n⇜ سـوف اقـوم بالمغـادرة .. فـوراً\n⇜ والتبليـغ عـن مجموعتـك 🛃\n\n⇜ الا تخـاف الله رب العالميـن ؟!*","md",true)
bot.leaveChat(msg_chat_id)
return false
end
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(Zelzal..'Zelzal:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return send(msg_chat_id,msg_id,'*⇜ عدد الاعضاء قليل لا يمكن تفعيل القروب يجب ان يكون اكثر من : *'..Redis:get(Zelzal..'Zelzal:Num:Add:Bot'),"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id) then
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
return send(msg_chat_id,msg_id,'\n*⇜ القروب :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ تم تفعيله مسبقاً*\n ✓',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = bot.getUser(msg.sender_id.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ تم تفعيل قروب جديد*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ معلومات القروب :*\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count..'\n*⇜ عدد الادمنيه :* '..Info_Chats.administrator_count..'\n*⇜ عدد المطرودين :* '..Info_Chats.banned_count..'\n*⇜ عدد المقيدين :* '..Info_Chats.restricted_count..'\n*⇜ الرابط :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ ايدي القروب :* `'..msg_chat_id..'`',"md",true, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ تم تفعيل قروب جديد*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ معلومات القروب :*\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count..'\n*⇜ عدد الادمنيه :* '..Info_Chats.administrator_count..'\n*⇜ عدد المطرودين :* '..Info_Chats.banned_count..'\n*⇜ عدد المقيدين :* '..Info_Chats.restricted_count..'\n*⇜ الرابط :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ ايدي القروب :* `'..msg_chat_id..'`',"md",true, false, false, false, reply_markup)
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '• تفعيـل ردود البـوت ⛄️ •', data = msg.sender_id.user_id..'/listallRodood'..msg_chat_id},
},
{
{text = '• الإشعـارات الذكيـه 💡 •', data = msg.sender_id.user_id..'/helpmalk'},
},
}
}
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id)
if (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
if StatusMember.status.can_change_info == true and
StatusMember.status.can_delete_messages == true and
StatusMember.status.can_invite_users == true and
StatusMember.status.can_pin_messages == true and
StatusMember.status.can_promote_members == true and
StatusMember.status.can_restrict_members == true then
print(msg.sender_id.user_id)
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,msg.sender_id.user_id) 
end
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
UserIdMalek = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
UserIdMalek = v.member_id.user_id
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,v.member_id.user_id)
Redis:sadd(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id,v.member_id.user_id) 
else
local StatusMember = bot.getChatMember(msg_chat_id,v.member_id.user_id)
if (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
if StatusMember.status.can_change_info == true and
StatusMember.status.can_delete_messages == true and
StatusMember.status.can_invite_users == true and
StatusMember.status.can_pin_messages == true and
StatusMember.status.can_promote_members == true and
StatusMember.status.can_restrict_members == true then
print(v.member_id.user_id)
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,v.member_id.user_id) 
end
end
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,v.member_id.user_id) 
end
end
end
Redis:set(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id,"true")
Redis:set(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id,"true")
Redis:set(Zelzal..'tagallgroup'..msg.chat_id,'open') 
Redis:set(Zelzal.."Zelzal:Status:Link"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:Status:Games"..msg_chat_id,true) 
Redis:set(Zelzal.."replayallbot"..msg.chat_id,true)
Redis:set(Zelzal.."rebomsg"..msg.chat_id,true)
Redis:set(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id,"true")
Redis:set(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id,true) 
Redis:set(Zelzal.."Zelzal:AlThther:Chat"..msg.chat_id,"true")
Redis:set(Zelzal..'tagall@all'..msg.chat_id,'open') 
Redis:set(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id,true) 
Redis:del(Zelzal.."spammkick"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:Lock:Animation"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Photo"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:vico"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Audio"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Sticker"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:Video"..msg_chat_id)  
Redis:set(Zelzal.."Zelzal:Lock:phshar"..msg_chat_id,true)
Redis:sadd(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id)
Redis:set(Zelzal.."Zelzal:Status:Id"..msg_chat_id,true) ;Redis:set(Zelzal.."Zelzal:Status:Reply"..msg_chat_id,true) ;Redis:set(Zelzal.."Zelzal:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(Zelzal.."Zelzal:Status:BanId"..msg_chat_id,true) ;Redis:set(Zelzal.."Zelzal:Status:SetId"..msg_chat_id,true) 
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local UserInfo = bot.getUser(UserIdMalek)
local textadd = '\n*⇜ ابشر فعلت القروب* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..') '..
'\n*⇜ المالك :* ['..UserInfo.first_name..'](tg://user?id='..UserIdMalek..')'..
'\n*⇜ عدد المشرفين :* '..Info_Chats.administrator_count..
'\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '• تفعيـل ردود البـوت ⛄️ •', data = msg.sender_id.user_id..'/listallRodood'..msg_chat_id},
},
{
{text = '• الإشعـارات الذكيـه 💡 •', data = msg.sender_id.user_id..'/helpmalk'},
},
}
}
return send(msg_chat_id,msg_id,textadd,'md', true, false, false, false, reply_markup)
end
end
-----------------
if text == 'تعطيل' and (msg.Developers or msg.Mevelopers) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id) then
return send(msg_chat_id,msg_id,'\n*⇜ القروب* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ تم تعطيله مسبقاً*\n ✓',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = bot.getUser(msg.sender_id.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ تم تعطيل قروب جديد*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count..'\n*⇜ عدد الادمنيه :* '..Info_Chats.administrator_count..'\n*⇜ عدد المطرودين :* '..Info_Chats.banned_count..'\n*⇜ عدد المقيدين :* '..Info_Chats.restricted_count..'',"md",true, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ تم تعطيل قروب جديد*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count..'\n*⇜ عدد الادمنيه :* '..Info_Chats.administrator_count..'\n*⇜ عدد المطرودين :* '..Info_Chats.banned_count..'\n*⇜ عدد المقيدين :* '..Info_Chats.restricted_count..'',"md",true, false, false, false, reply_markup)
end
end
Redis:del(Zelzal.."Zelzal:Status:Games"..msg_chat_id) 
Redis:del(Zelzal..'tagallgroup'..msg.chat_id,'open') 
Redis:del(Zelzal..'tagall@all'..msg.chat_id,'open') 
Redis:del(Zelzal.."Zelzal:Status:Link"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:ReplySudo"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:Reply"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:Id"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:KickMe"..msg_chat_id) 
Redis:del(Zelzal.."replayallbot"..msg.chat_id)
Redis:del(Zelzal.."rebomsg"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:Lock:aluasate"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:tagservrbot"..msg_chat_id)  
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(Zelzal..'Zelzal:'..lock..msg_chat_id)    
end
Redis:srem(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id)
return send(msg_chat_id,msg_id,'\n*⇜ القروب :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ تم تعطيله*\n ✓','md',true)
end
end
-----------------
if text == 'تعطيل' and (not msg.Developers or not msg.Mevelopers) then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(8).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
AddedBot = true
else
AddedBot = false
end
if AddedBot == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذرا انت لست مشرف او مالك القروب*","md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id) then
return send(msg_chat_id,msg_id,'\n*⇜ القروب* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ تم تعطيله مسبقاً*\n ✓',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = bot.getUser(msg.sender_id.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ تم تعطيل قروب جديد*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count..'\n*⇜ عدد الادمنيه :* '..Info_Chats.administrator_count..'\n*⇜ عدد المطرودين :* '..Info_Chats.banned_count..'\n*⇜ عدد المقيدين :* '..Info_Chats.restricted_count..'',"md",true, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ تم تعطيل قروب جديد*\n*⇜ من قبل :* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n*⇜ عدد الاعضاء :* '..Info_Chats.member_count..'\n*⇜ عدد الادمنيه :* '..Info_Chats.administrator_count..'\n*⇜ عدد المطرودين :* '..Info_Chats.banned_count..'\n*⇜ عدد المقيدين :* '..Info_Chats.restricted_count..'',"md",true, false, false, false, reply_markup)
end
end
Redis:del(Zelzal.."Zelzal:Status:Games"..msg_chat_id) 
Redis:del(Zelzal..'tagallgroup'..msg.chat_id,'open') 
Redis:del(Zelzal..'tagall@all'..msg.chat_id,'open') 
Redis:del(Zelzal.."Zelzal:Status:Link"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:ReplySudo"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:Reply"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:Id"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:SetId"..msg_chat_id) 
Redis:del(Zelzal.."Zelzal:Status:KickMe"..msg_chat_id) 
Redis:del(Zelzal.."replayallbot"..msg.chat_id)
Redis:del(Zelzal.."rebomsg"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:Alzwag:Chat"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:Aldel:Chat"..msg.chat_id)
Redis:del(Zelzal.."Zelzal:Lock:aluasate"..msg_chat_id)  
Redis:del(Zelzal.."Zelzal:Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(Zelzal..'Zelzal:'..lock..msg_chat_id)    
end
Redis:srem(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id)
return send(msg_chat_id,msg_id,'\n*⇜ القروب :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n*⇜ تم تعطيله*\n ✓','md',true)
end
end
if text == 'تعطيل نداء المطور' or text == '✦ تعطيل نداء المطور ✦' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Status:tagdev",true) 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تعطيـل نـداء المطـور  .. بنجـاح*","md",true )
end
if text == 'تفعيل نداء المطور' or text == '✦ تفعيل نداء المطور ✦' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Status:tagdev") 
return send(msg_chat_id,msg_id,GetByName(msg).."*⇜ تم تفعيـل نـداء المطـور  .. بنجـاح*","md",true )
end
if chat_type(msg.chat_id) == "GroupBot" and Redis:sismember(Zelzal.."Zelzal:ChekBotAdd",msg_chat_id) then
Redis:incr(Zelzal..'Zelzal:Num:Message:User'..msg.chat_id..':'..msg.sender_id.user_id) 

if text and text:match('^انذار @(%S+)$') then
local UserName = text:match('^انذار @(%S+)$')
if Redis:get(Zelzal.."lock_inthare"..msg.chat_id) then
return false
end
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if StatusCanOrNotCanin(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId_Info.id).." ) ","md",true)  
end  
Redis:incrby(Zelzal.."inthar:UserNum"..msg.chat_id..UserId_Info.id,1)
local Numinthar = Redis:get(Zelzal.."inthar:UserNum"..msg.chat_id..UserId_Info.id)
local UserInfo = bot.getUser(UserId_Info.id)
local Name = '['..UserInfo.first_name..'](tg://user?id='..UserId_Info.id..')'
local Total_Numinthar = 3
if tonumber(Numinthar) >= tonumber(Total_Numinthar) then
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'كتم', data = UserId_Info.id..'/iktm/'..msg.sender_id.user_id},{text = 'حظر', data = UserId_Info.id..'/iban/'..msg.sender_id.user_id},
},
{
{text = 'تقييد', data = UserId_Info.id..'/ikide/'..msg.sender_id.user_id}, {text = 'طرد', data = UserId_Info.id..'/ikick/'..msg.sender_id.user_id}, 
},
{
{text = 'تنزيل الرتب', data = UserId_Info.id..'/iTnzelall/'..msg.sender_id.user_id},{text = 'رفع القيود', data = UserId_Info.id..'/rafaall/'..msg.sender_id.user_id}, 
},
}
}
Redis:del(Zelzal.."inthar:UserNum"..msg.chat_id..UserId_Info.id)
return send(msg.chat_id,msg.id,"*⇜ المستخدم : *"..Name.."\n*⇜ تم انذاره 3 مرات والان يمكنك اختيار العقوبه*","md",false, false, false, false, reply_markup)
end
local repply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'مسح الانذار', data = UserId_Info.id..'/dllenthar/'..msg.sender_id.user_id}
},
}
}
return send(msg.chat_id,msg.id,"*⇜ المستخـدم : *"..Name.."\n*⇜ تم اعطائه الإنذار رقم : *"..Numinthar.."\n*⇜ متبقي لديه* "..(tonumber(Total_Numinthar) - tonumber(Numinthar)).." *انذارات*","md",false, false, false, false, repply_markup)
end
if text== "انذار" and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."lock_inthare"..msg.chat_id) then
return false
end
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n*⇜ هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if StatusCanOrNotCanin(msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,Message_Reply.sender_id.user_id).." ) ","md",true)  
end  
Redis:incrby(Zelzal.."inthar:UserNum"..msg.chat_id..Message_Reply.sender_id.user_id,1)
local Numinthar = Redis:get(Zelzal.."inthar:UserNum"..msg.chat_id..Message_Reply.sender_id.user_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
local Name = '['..UserInfo.first_name..'](tg://user?id='..Message_Reply.sender_id.user_id..')'
local Total_Numinthar = 3
if tonumber(Numinthar) >= tonumber(Total_Numinthar) then
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'كتم', data = Message_Reply.sender_id.user_id..'/iktm/'..msg.sender_id.user_id},{text = 'حظر', data = Message_Reply.sender_id.user_id..'/iban/'..msg.sender_id.user_id},
},
{
{text = 'تقييد', data = Message_Reply.sender_id.user_id..'/ikide/'..msg.sender_id.user_id}, {text = 'طرد', data = Message_Reply.sender_id.user_id..'/ikick/'..msg.sender_id.user_id}, 
},
{
{text = 'تنزيل الرتب', data = Message_Reply.sender_id.user_id..'/iTnzelall/'..msg.sender_id.user_id},{text = 'رفع القيود', data = Message_Reply.sender_id.user_id..'/rafaall/'..msg.sender_id.user_id}, 
},
}
}
Redis:del(Zelzal.."inthar:UserNum"..msg.chat_id..Message_Reply.sender_id.user_id)
return send(msg.chat_id,msg.id,"*⇜ المستخدم : *"..Name.."\n*⇜ تم انذاره 3 مرات والان يمكنك اختيار العقوبه*","md",false, false, false, false, reply_markup)
end
local repply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'مسح الانذار', data = Message_Reply.sender_id.user_id..'/dllenthar/'..msg.sender_id.user_id}
},
}
}
return send(msg.chat_id,msg.id,"*⇜ المستخـدم : *"..Name.."\n*⇜ تم اعطائه الإنذار رقم : *"..Numinthar.."\n*⇜ متبقي لديه* "..(tonumber(Total_Numinthar) - tonumber(Numinthar)).." *انذارات*","md",false, false, false, false, repply_markup)
end
----- قفل اي شي خاص بسـورس زلــزال -----
if text and text:match('^قفل امر (.*)$') then
local TextMsg = text:match('^قفل امر (.*)$')
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
Redis:set(Zelzal.."Zelzal:Set:Add:Cmd"..msg.chat_id..msg.sender_id.user_id, TextMsg)
Redis:set(Zelzal.."Zelzal:Add:Lock:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,"*⇜ حسنـاً عـزيـزي اختـر نـوع الـرتبـه :*\n\n𝟭 - `مطور`\n𝟮 - `مالك المجموعة`\n𝟯 - `مالك اساسي`\n𝟰 - `مالك`\n𝟱 - `منشئ اساسي`\n𝟲 - `منشئ`\n𝟳- `مدير`\n𝟳 - `ادمن`\n𝟴 - `مميز`\n\n\n*- سيتم وضع امر ( *"..TextMsg.."* ) له فقط\n- لـ الالغـاء ارسـل الامـر ( الغاء )*","md",true)
end
if text and text:match('^فتح امر (.*)$') then
local TextMsg = text:match('^فتح امر (.*)$')
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
if TextMsg == "ايدي" or TextMsg == "ا" or TextMsg == " id" or TextMsg == "Id" or TextMsg == "ID" then
local textlook = "ايدي"
Redis:srem(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,textlook)
else
Redis:srem(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,TextMsg)
end
if Redis:sismember(Zelzal.."Zelzal:Developers:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:Developers:Cmd:Lock"..msg_chat_id,TextMsg) 
elseif Redis:sismember(Zelzal.."Zelzal:Creator:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:Creator:Cmd:Lock"..msg_chat_id,TextMsg) 
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:MalekAsase:Cmd:Lock"..msg_chat_id,TextMsg) 
elseif Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Cmd:Lock"..msg_chat_id,TextMsg) 
elseif Redis:sismember(Zelzal.."Zelzal:TheBasics:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:TheBasics:Cmd:Lock"..msg_chat_id,TextMsg) 
elseif Redis:sismember(Zelzal.."Zelzal:Originators:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:Originators:Cmd:Lock"..msg_chat_id,TextMsg) 
elseif Redis:sismember(Zelzal.."Zelzal:Managers:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:Managers:Cmd:Lock"..msg_chat_id,TextMsg) 
elseif Redis:sismember(Zelzal.."Zelzal:Addictive:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:Addictive:Cmd:Lock"..msg_chat_id,TextMsg) 
elseif Redis:sismember(Zelzal.."Zelzal:Distinguished:Cmd:Lock"..msg_chat_id,TextMsg) then
Redis:srem(Zelzal.."Zelzal:Distinguished:Cmd:Lock"..msg_chat_id,TextMsg) 
else
return send(msg_chat_id,msg_id,"*⇜ لا يوجد امـر بـ اسـم ( *"..TextMsg.."* ) مغـلق ؟!*","md",true)
end
return send(msg_chat_id,msg_id,"*⇜ تم فتـح امـر ( *"..TextMsg.."* ) .. بنجـاح\n⇜ رجعتـه زي مـا كـان ☑️*","md",true)
end
----- قفل اي شي خاص بسـورس زلــزال -----
if msg.Managers or msg.Mamagers then
if text and (text:match("^ضع الشعار (.*)$") or text:match("^ضع شعار (.*)$") or text:match("^وضع الشعار (.*)$") or text:match("^وضع شعار (.*)$") or text:match("^تعيين شعار (.*)$")) then
if Redis:get(Zelzal.."Bots:Lock:ProNames"..msg.chat_id) then
local Txt = text:match("^ضع الشعار (.*)$") or text:match("^ضع شعار (.*)$") or text:match("^وضع الشعار (.*)$") or text:match("^وضع شعار (.*)$") or text:match("^تعيين شعار (.*)$")
send(msg.chat_id, msg.id, '⇜ تم تعيين ( '..Txt..' ) كشعار للقروب')
Redis:set(Zelzal.."Bots:ProNames:Txt"..msg.chat_id,Txt)
else
send(msg.chat_id, msg.id, '⇜ ميزة الشعار معطله يرجى تفعيلها')
end
end
if text and (text:match("^ضع التوحيد (.*)$") or text:match("^ضع توحيد (.*)$") or text:match("^وضع التوحيد (.*)$") or text:match("^وضع توحيد (.*)$") or text:match("^تعيين توحيد (.*)$")) then
if Redis:get(Zelzal.."Bots:Lock:ProNames"..msg.chat_id) then
local Txt = text:match("^ضع التوحيد (.*)$") or text:match("^ضع توحيد (.*)$") or text:match("^وضع التوحيد (.*)$") or text:match("^وضع توحيد (.*)$") or text:match("^تعيين توحيد (.*)$")
send(msg.chat_id, msg.id, '⇜ تم تعيين ( '..Txt..' ) كتوحيد للقروب')
Redis:set(Zelzal.."Bots:ProNames:Txt"..msg.chat_id,Txt)
else
send(msg.chat_id, msg.id, '⇜ ميزة التوحيد معطله يرجى تفعيلها')
end
end
if text == "مسح الشعار" or text == "مسح التوحيد" then
Redis:del(Zelzal.."Bots:ProNames:Txt"..msg.chat_id)
send(msg.chat_id, msg.id,"⇜ تم مسح الشعار ")
end
if text and (text:match("^تعين عدد الكتم (.*)$") or text:match("^تعيين عدد الكتم (.*)$")) then
if Redis:get(Zelzal.."Bots:Lock:ProNames"..msg.chat_id) then
local Num = text:match("^تعين عدد الكتم (.*)$") or text:match("^تعيين عدد الكتم (.*)$")
send(msg.chat_id, msg.id, '⇜ تم تعيين عدد الكتم '..Num..' ')
Redis:set(Zelzal.."Bots:ProNames:Num"..msg.chat_id,Num)
else
send(msg.chat_id, msg.id, '⇜ ميزة الشعار معطله يرجى تفعيلها')
end
end
end
if text == "الشعار" or text == "شعار" or text == "التوحيد" or text == "توحيد" then
if Redis:get(Zelzal.."Bots:ProNames:Txt"..msg.chat_id) then
local ProNamesTxt = Redis:get(Zelzal.."Bots:ProNames:Txt"..msg.chat_id)
local ProNamesNum = Redis:get(Zelzal.."Bots:ProNames:Num"..msg.chat_id) or 5
send(msg.chat_id, msg.id, '⇜ شعار القروب ( `'..ProNamesTxt..'` )\n⇜ عدد المحاولات للكتم ↫ '..ProNamesNum,"md")
else
send(msg.chat_id, msg.id, '⇜ لم يتم تعيين شعار للقروب')
end
end
if text and (not msg.Originators or not msg.Origimators) then
if Redis:get(Zelzal.."Bots:Lock:ProNames"..msg.chat_id) and Redis:get(Zelzal.."Bots:ProNames:Txt"..msg.chat_id) then 
local UserInfo = bot.getUser(msg.sender_id.user_id)
if UserInfo and UserInfo.first_name then 
local last_ = UserInfo.last_name or ""
local first_ = UserInfo.first_name or ""
local Namer = (first_..""..last_)
if Namer:match("(.*)"..Redis:get(Zelzal.."Bots:ProNames:Txt"..msg.chat_id).."(.*)") then 
Redis:srem(Zelzal..'Bots:Muted:'..msg.chat_id, msg.sender_id.user_id)
else
local ProNamesTxt = Redis:get(Zelzal.."Bots:ProNames:Num"..msg.chat_id) or 5
local UserNum = Redis:get(Zelzal.."Bots:ProNames:UserNum"..msg.chat_id..msg.sender_id.user_id) or 0
if (tonumber(UserNum) == tonumber(ProNamesTxt) or tonumber(UserNum) > tonumber(ProNamesTxt)) then 
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
Redis:del(Zelzal.."Bots:ProNames:UserNum"..msg.chat_id..msg.sender_id.user_id)
if UserInfo.username then
UserInfousername = ''..UserInfo.username..''
else
UserInfousername = 'z_zzz8'
end
send(msg.chat_id, msg.id, " ["..UserInfo.first_name.."](https://t.me/"..(UserInfousername or "z_zzz8")..")\nكتمتك لانك مو حاط شعار لقروب باسمك ","md",true)
else 
Redis:incrby(Zelzal.."Bots:ProNames:UserNum"..msg.chat_id..msg.sender_id.user_id,1)
send(msg.chat_id, msg.id,  " ["..UserInfo.first_name.."](https://t.me/"..(UserInfousername or "z_zzz8")..")\n⇜ ضع الشعار ( `"..Redis:get(Zelzal.."Bots:ProNames:Txt"..msg.chat_id).."` ) بجانب اسمك\n⇜ عدد المحاولات المتبقيه لديك ↫ "..(tonumber(ProNamesTxt) - tonumber(UserNum)).."","md",true)
end
end
end
end
end
-----------------
if text == "التفاعل" and not Redis:get(Zelzal..'lock_altfael'..msg.chat_id) then
local Namdaysmsg = Redis:get(Zelzal.."Num:MssEgeS:Days"..msg.chat_id..os.date("%d")) or 0
local Namdayspin =Redis:get(Zelzal.."Num:PinMsg:Days"..msg.chat_id..os.date("%d")) or 0
local Namdaysjoine =Redis:get(Zelzal.."Num:joinlink:Days"..msg.chat_id..os.date("%d")) or 0
local NamdaysaddMember =Redis:get(Zelzal.."Num:AddMempber:Days"..msg.chat_id..os.date("%d")) or 0
local msg_id = msg.id/2097152/0.5
return send(msg_chat_id,msg_id,
'\n*⇜ تفاعل القروب اليومي :* \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'..
'\n*⇜ رسائل المجموعه :* '..Namdaysmsg..
'\n*⇜ الرسائل المثبته :* '..Namdayspin..
'\n*⇜ اضافة الاعضاء :* '..NamdaysaddMember..
'\n*⇜ دخول الاعضاء :* '..Namdaysjoine..
'\n*⇜ نسبه التفاعل :* '..TotalNsba(Namdaysmsg).." %"..
'',"md",true) 
end
if text == "ارفعني مالك" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id)
if (StatusMember.status.luatele == "chatMemberStatusCreator") then
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,msg.sender_id.user_id) 
return send(msg_chat_id,msg_id,'\n*⇜ انت مالك القروب تم ترقيتك*',"md",true)  
elseif (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
if StatusMember.status.can_change_info == true and
StatusMember.status.can_delete_messages == true and
StatusMember.status.can_invite_users == true and
StatusMember.status.can_pin_messages == true and
StatusMember.status.can_promote_members == true and
StatusMember.status.can_restrict_members == true then
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,msg.sender_id.user_id) 
return send(msg_chat_id,msg_id,'\n*⇜ ابشر رفعتك مالك*',"md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ لا تمتلك صلاحيات*',"md",true)  
end
else
return send(msg_chat_id,msg_id,'\n*⇜ انت عضو في القروب*',"md",true)  
end
end
if text == "تصفير الترند" or text == "تصفير ترند" or text == "تصفير المتفاعلين" or text == "مسح المتفاعلين" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
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
GroupAllRtba = Redis:hgetall(Zelzal..':GroupUserCountMsgg:'..msg.chat_id)
GroupAllRtbaL = {}
for k,v in pairs(GroupAllRtba) do
table.insert(GroupAllRtbaL,{v,k})
end
Count,Kount,i = 10 , 0 , 1
for _ in pairs(GroupAllRtbaL) do 
Kount = Kount + 1 
end
table.sort(GroupAllRtbaL,function(a, b)
return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then
Count = Kount 
end
for k,v in ipairs(GroupAllRtbaL) do
if i <= Count then
Redis:del(Zelzal..'Zelzal:Num:Message:User'..msg.chat_id..':'..v[2])
end
i=i+1
end
Redis:del(Zelzal..':GroupUserCountMsgg:'..msg.chat_id)
Redis:del(Zelzal..':GroupNameUser:'..msg.chat_id)
return send(msg.chat_id,msg.id,'\n*⇜ تم تصفيـر قائمـة المتفاعليـن*',"md",true)
end
if text and (text ~= "تصفير الترند" or text ~= "تصفير ترند" or text ~= "تصفير المتفاعلين" or text ~= "مسح المتفاعلين") then
Redis:incr(Zelzal..'Zelzal:Num:Message:User'..msg.chat_id..':'..msg.sender_id.user_id)
local GetMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg.chat_id..':'..msg.sender_id.user_id) or 1
Redis:hset(Zelzal..':GroupUserCountMsgg:'..msg.chat_id,msg.sender_id.user_id,GetMsg)
local UserInfo = bot.getUser(msg.sender_id.user_id) 
if UserInfo.first_name then
NameLUser = UserInfo.first_name or ''
else
NameLUser = UserInfo.first_name or ''
end
NameLUser = NameLUser
NameLUser = NameLUser:gsub("]","")
NameLUser = NameLUser:gsub("[[]","")
Redis:hset(Zelzal..':GroupNameUser:'..msg.chat_id,msg.sender_id.user_id,NameLUser)
end
if text == "ترند" or text == "المتفاعلين" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
GroupAllRtba = Redis:hgetall(Zelzal..':GroupUserCountMsgg:'..msg.chat_id)
GetAllNames = Redis:hgetall(Zelzal..':GroupNameUser:'..msg.chat_id)
GroupAllRtbaL = {}
for k,v in pairs(GroupAllRtba) do
table.insert(GroupAllRtbaL,{v,k})
end
Count,Kount,i = 10 , 0 , 1
for _ in pairs(GroupAllRtbaL) do 
Kount = Kount + 1 
end
table.sort(GroupAllRtbaL,function(a, b)
return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then
Count = Kount 
end
Text = "*⇜ أكثر "..Count.." أعضاء تفاعلاً في القروب*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in ipairs(GroupAllRtbaL) do
if i <= Count then
if i==1 then 
t="🏆"
elseif i==2 then
t="🥈" 
elseif i==3 then
t="🥉" 
elseif i==4 then
t="🏅" 
else 
t="🎖" 
end 
Text = Text..i..") : *"..v[1].."* l  ["..(GetAllNames[v[2]] or "خطأ بالاسم").."](tg://user?id="..v[2]..") "..t.."\n"
end
i=i+1
end
return send(msg.chat_id,msg.id,Text,"md",true)
end
---------------------- Dev ZilZal ----------------------
if text == "تصفير ترند اليوم" or text == "تصفير المتفاعلين اليوم" or text == "مسح المتفاعلين اليوم" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
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
GroupAllRtba = Redis:hgetall(Zelzal..':GroupUserCountDayMsgg:'..msg.chat_id)
GroupAllRtbaL = {}
for k,v in pairs(GroupAllRtba) do
table.insert(GroupAllRtbaL,{v,k})
end
Count,Kount,i = 10 , 0 , 1
for _ in pairs(GroupAllRtbaL) do 
Kount = Kount + 1 
end
table.sort(GroupAllRtbaL,function(a, b)
return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then
Count = Kount 
end
for k,v in ipairs(GroupAllRtbaL) do
if i <= Count then
Redis:del(Zelzal..'msg:match:'..msg.chat_id..':'..v[2])
end
i=i+1
end
Redis:del(Zelzal..':GroupUserCountDayMsgg:'..msg.chat_id)
Redis:del(Zelzal..':GroupNameDayUser:'..msg.chat_id)
return send(msg.chat_id,msg.id,'\n*⇜ تم تصفيـر قائمـة المتفاعليـن اليـوم*',"md",true) 
end
if text and (text ~= "تصفير ترند اليوم" or text ~= "تصفير المتفاعلين اليوم" or text ~= "مسح المتفاعلين اليوم") then
get_msg = Redis:get(Zelzal.."msg:match:"..msg.chat_id..":"..msg.sender_id.user_id) or 0
gms = get_msg + 1
Redis:setex(Zelzal..'msg:match:'..msg.chat_id..":"..msg.sender_id.user_id,86400,gms)
local GetMsg = Redis:get(Zelzal.."msg:match:"..msg.chat_id..":"..msg.sender_id.user_id) or 0
GetMsg = math.floor(GetMsg) -- تقريب العدد لأقرب عدد صحيح أصغر منه
Redis:hset(Zelzal..':GroupUserCountDayMsgg:'..msg.chat_id,msg.sender_id.user_id,GetMsg)
local UserInfo = bot.getUser(msg.sender_id.user_id) 
if UserInfo.first_name then
NameLUser = UserInfo.first_name or ''
else
NameLUser = UserInfo.first_name or ''
end
NameLUser = NameLUser
NameLUser = NameLUser:gsub("]","")
NameLUser = NameLUser:gsub("[[]","")
Redis:hset(Zelzal..':GroupNameDayUser:'..msg.chat_id,msg.sender_id.user_id,NameLUser)
end
if text == "ترند اليوم" or text == "المتفاعلين اليوم" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
GroupAllRtba = Redis:hgetall(Zelzal..':GroupUserCountDayMsgg:'..msg.chat_id)
GetAllNames = Redis:hgetall(Zelzal..':GroupNameDayUser:'..msg.chat_id)
GroupAllRtbaL = {}
for k,v in pairs(GroupAllRtba) do
table.insert(GroupAllRtbaL,{v,k})
end
Count,Kount,i = 10 , 0 , 1
for _ in pairs(GroupAllRtbaL) do 
Kount = Kount + 1 
end
table.sort(GroupAllRtbaL,function(a, b)
return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then
Count = Kount 
end
Text = "*⇜ أكثر "..Count.." أعضاء تفاعـلاً اليـوم في المجمـوعة*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in ipairs(GroupAllRtbaL) do
if i <= Count then
if i==1 then 
t="🏆"
elseif i==2 then
t="🥈" 
elseif i==3 then
t="🥉" 
elseif i==4 then
t="🏅" 
else 
t="🎖" 
end 
Text = Text..i..") الرسائل *"..v[1].."* l  ["..(GetAllNames[v[2]] or "خطأ بالاسم").."](tg://user?id="..v[2]..") "..t.."\n"
end
i=i+1
end
return send(msg.chat_id,msg.id,Text,"md",true)
end
---------------------- Dev ZilZal ----------------------
if msg.content.luatele then
get_msg = Redis:get(Zelzal.."msg:match:"..msg.chat_id..":"..msg.sender_id.user_id) or 0
gms = get_msg + 1
Redis:setex(Zelzal..'msg:match:'..msg.chat_id..":"..msg.sender_id.user_id,86400,gms)
end
if text == "تفاعلي اليوم" and msg.reply_to_message_id == 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local total_msgs = Redis:get(Zelzal..'msg:match:'..msg.chat_id..':'..msg.sender_id.user_id) or 0
total_msgs = math.floor(total_msgs) -- تقريب العدد لأقرب عدد صحيح أصغر منه
send(msg_chat_id, msg_id, '*⇜ عـدد رسـائلك الكلـي اليـوم هنـا ⇜ '..total_msgs..'*', "md", true)
end
if text == "تفاعله اليوم" and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local total_msgs = Redis:get(Zelzal..'msg:match:'..msg.chat_id..':'..Message_Reply.sender_id.user_id) or 0
total_msgs = math.floor(total_msgs) -- تقريب العدد لأقرب عدد صحيح أصغر منه
send(msg_chat_id, msg_id, '*⇜ عـدد رسائلـه اليـوم هنـا ⇜ '..total_msgs..'*', "md", true)
end
---------------------- Dev ZilZal ----------------------
if text == 'يوميات' or text == "اليوميات" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = bot.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = 'نعم' else web = 'لا'
end
if Get_Chat.permissions.can_change_info then
info = 'نعم' else info = 'لا'
end
if Get_Chat.permissions.can_invite_users then
invite = 'نعم' else invite = 'لا'
end
if Get_Chat.permissions.can_pin_messages then
pin = 'نعم' else pin = 'لا'
end
if Get_Chat.permissions.can_send_media_messages then
media = 'نعم' else media = 'لا'
end
if Get_Chat.permissions.can_send_messages then
messges = 'نعم' else messges = 'لا'
end
if Get_Chat.permissions.can_send_other_messages then
other = 'نعم' else other = 'لا'
end
if Get_Chat.permissions.can_send_polls then
polls = 'نعم' else polls = 'لا'
end
local Namdaysmsg = Redis:get(Zelzal.."Num:MssEgeS:Days"..msg.chat_id..os.date("%d")) or 0
local Namdayspin =Redis:get(Zelzal.."Num:PinMsg:Days"..msg.chat_id..os.date("%d")) or 0
local Namdaysjoine =Redis:get(Zelzal.."Num:joinlink:Days"..msg.chat_id..os.date("%d")) or 0
local NamdaysaddMember =Redis:get(Zelzal.."Num:AddMempber:Days"..msg.chat_id..os.date("%d")) or 0
local tfaol = '\n🛗 تفاعل المجموعة اليومي : \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n💌 الرسائل اليوم ⇜ '..Namdaysmsg..'\n⇜ 📨 الرسائل المثبته اليوم ⇜ '..Namdayspin..'\n🧜‍♀ اعضاء مضافين ⇜ '..NamdaysaddMember..'\n🧚‍♀ اعضاء جدد ⇜ '..Namdaysjoine..'\n👫 نسبه التفاعل ⇜ '..TotalNsba(Namdaysmsg)..' %'
local permissions = '\n⇜ صلاحيات القروب :\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..'\n⇜ ارسال الويب : '..web..'\n⇜ تغيير معلومات القروب : '..info..'\n⇜ اضافه مستخدمين : '..invite..'\n⇜ تثبيت الرسائل : '..pin..'\n⇜ ارسال الميديا : '..media..'\n⇜ ارسال الرسائل : '..messges..'\n⇜ اضافه البوتات : '..other..'\n⇜ ارسال استفتاء : '..polls..'\n\n'
local TextChat = '\n⇜ معلومات القروب :\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..' \n⇜ اسم المجموعة :  ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..') \n⇜ عدد الادمنيه : '..Info_Chats.administrator_count..' \n⇜ عدد الاعضاء : '..Info_Chats.member_count..'` \n'
if Info_Chats.photo then
bot.sendPhoto(msg.chat_id, msg.id, Info_Chats.photo.sizes[1].photo.remote.id,TextChat..permissions..tfaol, "md")
else
return send(msg_chat_id,msg_id, TextChat..permissions..tfaol,"md",true)
end
end
---------------------- Dev ZilZal ----------------------
if text == 'ملصق' and tonumber(msg.reply_to_message_id) > 0 and not Redis:get(Zelzal..'kadmeat'..msg.chat_id)   then
local data = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if data.content.photo then
if data.content.photo.sizes[1].photo.remote.id then
idPhoto = data.content.photo.sizes[1].photo.remote.id
elseif data.content.photo.sizes[2].photo.remote.id then
idPhoto = data.content.photo.sizes[2].photo.remote.id
elseif data.content.photo.sizes[3].photo.remote.id then
idPhoto = data.content.photo.sizes[3].photo.remote.id
end
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..idPhoto) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id..'.webp') 
bot.sendSticker(msg.chat_id, msg.id, Name_File)
os.execute('rm -rf '..Name_File) 
else
send(msg_chat_id,msg_id,'⇜ هذه ليست صوره')
end
end
if text == 'صوره' and tonumber(msg.reply_to_message_id) > 0 and not Redis:get(Zelzal..'kadmeat'..msg.chat_id) then
local data = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if data.content.sticker then 
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content.sticker.sticker.remote.id) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id..'.jpg') 
bot.sendPhoto(msg.chat_id, msg.id, Name_File,'')
os.execute('rm -rf '..Name_File) 
else
send(msg_chat_id,msg_id,'⇜ هذا ليس ملصق')
end
end
if text == 'بصمه' and tonumber(msg.reply_to_message_id) > 0 and not Redis:get(Zelzal..'kadmeat'..msg.chat_id)   then
local data = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if data.content.audio then 
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content.audio.audio.remote.id) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id..'.ogg') 
bot.sendVoiceNote(msg.chat_id, msg.id, Name_File, '', 'md')
os.execute('rm -rf '..Name_File) 
else
send(msg_chat_id,msg_id,'⇜ هذا ليس ملف صوتي')
end
end
if text == 'صوت' and tonumber(msg.reply_to_message_id) > 0 and not Redis:get(Zelzal..'kadmeat'..msg.chat_id)   then
local data = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if data.content.voice_note then
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content.voice_note.voice.remote.id) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, msg.id..'.mp3') 
bot.sendAudio(msg.chat_id, msg.id, Name_File, '', "md") 
os.execute('rm -rf '..Name_File) 
else
send(msg_chat_id,msg_id,'⇜ هذا ليس بصمه')
end
end
if text == 'mp3' and tonumber(msg.reply_to_message_id) > 0 and not Redis:get(Zelzal..'kadmeat'..msg.chat_id)   then
local data = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if data.content.video then
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content.video.video.remote.id) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, msg.id..'.mp3') 
return bot.sendAudio(msg.chat_id, msg.id, Name_File, '', "md") 
--os.execute('rm -rf '..Name_File) 
else
send(msg_chat_id,msg_id,'⇜ هذا ليس فيديو')
end
end
if text == 'متحركه' and tonumber(msg.reply_to_message_id) > 0 and not Redis:get(Zelzal..'kadmeat'..msg.chat_id)   then
local data = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if data.content.video then
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content.video.video.remote.id) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, msg.id..'.gif.mp4') 
bot.sendAnimation(msg.chat_id,msg.id, Name_File, '', 'md')
--os.execute('rm -rf '..Name_File) 
else
send(msg_chat_id,msg_id,'⇜ هذا ليس فيديو')
end
end
-----------------
if text and text:match("^انطق (.*)$") and not Redis:get(Zelzal..'intg'..msg.chat_id) then 
Text = text:match("^انطق (.*)$") 
msg_id = msg.id/2097152/0.5  
https.request("https://api.telegram.org/bot"..Token.. 
"/sendaudio?chat_id="..msg.chat_id.."&caption=الكلمة ".. 
URL.escape(Text).."&audio=http://".. 
URL.escape('translate.google.com/translate_tts?q='..Text.. 
'&tl=ar&client=duncan3dc-speaker').. 
"&reply_to_message_id="..msg_id.. 
"&disable_web_page_preview=true") 
end
-----------------
if text == 'الاصدار' then
send(msg_chat_id,msg_id,'*⇜ Source Zelzal 64 : 8.4.9*',"md",true)  
end
if text == 'مسح صوت' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."zelzal:Add:audio:Games"..msg.sender_id.user_id..":"..msg.chat_id,'startdel')
return send(msg_chat_id,msg_id,'*⇜ ارسل اسم الصوت*',"md")
end
if text== 'اضف صوت' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."zelzal:Add:audio:Games"..msg.sender_id.user_id..":"..msg.chat_id,'start')
return send(msg_chat_id,msg_id, '*⇜ ارسل اسم الصوت الان ...*',"md")
end
if text== ("الصوتيات") then
local list = Redis:smembers(Zelzal.."zelzal:text:Games:Bot"..msg.chat_id)
if #list == 0 then
send(msg_chat_id,msg_id, "⇜ لا يوجد صوتيات")
return false
end
message = '⇜ قائمه الصوتيات :\n     للتشغيل اختر اسم من الاتي:\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k,v in pairs(list) do
message = message..""..k.."- ("..v..")\n"
end
send(msg_chat_id,msg_id,message)
end
if text== ("مسح الصوتيات") then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local list = Redis:smembers(Zelzal.."zelzal:text:Games:Bot"..msg.chat_id)
if #list == 0 then
send(msg_chat_id,msg_id, "⇜ لا يوجد صوتيات ")
return false
end
for k,v in pairs(list) do
Redis:srem(Zelzal.."zelzal:text:Games:Bot"..msg.chat_id,v)
Redis:del(Zelzal.."zelzal:audio:Games"..msg.chat_id..v)
end
send(msg_chat_id,msg_id, "⇜ تم مسح جميع الصوتيات")
end
if text == 'مسح صوت عام' or text == "مسح الصوت عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."zelzal:All:Add:audio:Games"..msg.sender_id.user_id..":"..msg.chat_id,'startdel')
send(msg_chat_id,msg_id, '*⇜ ارسل اسم الصوت*',"md")
end
if text== 'اضف صوت عام' then
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."zelzal:All:Add:audio:Games"..msg.sender_id.user_id..":"..msg.chat_id,'start')
send(msg_chat_id,msg_id, '*⇜ ارسل اسم الصوت الان ...*',"md")
end
if text== ("الصوتيات العامه") or text== ("الصوت عام") or text== ("الاغاني") then
local list = Redis:smembers(Zelzal.."zelzal:All:text:Games:Bot")
if #list == 0 then
send(msg_chat_id,msg_id, "⇜ لا يوجد صوتيات عامه")
return false
end
message = '⇜ قائمه الصوتيات العامه:\n     للتشغيل اختر اسم من الاتي:\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k,v in pairs(list) do
message = message..""..k.."- ("..v..")\n"
end
send(msg_chat_id,msg_id,message)
end
if text== ("مسح الصوتيات العامه") or text== ("مسح الصوت عام") then
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."zelzal:All:text:Games:Bot")
if #list == 0 then
send(msg_chat_id,msg_id, "⇜ لا يوجد صوتيات")
return false
end
for k,v in pairs(list) do
Redis:srem(Zelzal.."zelzal:All:text:Games:Bot",v)
Redis:del(Zelzal.."zelzal:All:audio:Games"..v)
end
send(msg_chat_id,msg_id, "⇜ تم مسح جميع الصوتيات")
end
if text == ('الإنشاء') and msg.reply_to_message_id == 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local creationdate = request("http://145.223.80.56:5016/date?id="..URL.escape(msg.sender_id.user_id))
return send(msg_chat_id,msg_id,'\n*تاريـخ إنشـاء حسـاب تيليـجـرام🗓 :*\n- تاريخ الإنشاء ⤎  ( '..creationdate..' ) ',"md",true)  
end
if text and text:match('^الإنشاء @(%S+)$') then
local UserName = text:match('^الإنشاء @(%S+)$')
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local creationdate = request("https://sero-bots.ml/API/DatTele.php?ID="..URL.escape(UserName))
return send(msg_chat_id,msg_id,'\n*تاريـخ إنشـاء حسـاب تيليـجـرام🗓 :*\n- تاريخ الإنشاء ⤎  ( '..creationdate..' ) ',"md",true)  
end
if text and text:match('^الإنشاء (%d+)$') then
local UserId = text:match('^الإنشاء (%d+)$')
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
local creationdate = request("https://sero-bots.ml/API/DatTele.php?ID="..URL.escape(UserId))
return send(msg_chat_id,msg_id,'\n*تاريـخ إنشـاء حسـاب تيليـجـرام🗓 :*\n- تاريخ الإنشاء ⤎  ( '..creationdate..' ) ',"md",true)  
end
if text == ('الإنشاء') and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
local creationdate = request("https://sero-bots.ml/API/DatTele.php?ID="..URL.escape(Message_Reply.sender_id.user_id))
return send(msg_chat_id,msg_id,'\n*تاريـخ إنشـاء حسـاب تيليـجـرام🗓 :*\n- تاريخ الإنشاء ⤎  ( '..creationdate..' ) ',"md",true)  
end
if text and text:match('^كتم عام @(%S+)$') then
local UserName = text:match('^كتم عام @(%S+)$')
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if Controllerbanall(msg_chat_id,UserId_Info.id) == true then 
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId_Info.id).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:KtmAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ⇜ تم كتمه عام مسبقاًً ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:KtmAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ⇜ تم كتمه عام ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم عام @(%S+)$') then
local UserName = text:match('^الغاء كتم عام @(%S+)$')
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:KtmAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ⇜ تم الغاء كتمه عام مسبقاًً ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:KtmAll:Groups",UserId_Info.id) 
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ⇜ تم الغاء كتمه عام ").Reply,"md",true)  
end
end
if text == ('كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if Controllerbanall(msg_chat_id,Message_Reply.sender_id.user_id) == true then 
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,Message_Reply.sender_id.user_id).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:KtmAll:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ تم كتمه عام مسبقاًً ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:KtmAll:Groups",Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ تم كتمه عام ").Reply,"md",true)  
end
end
if text == ('الغاء كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:KtmAll:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ تم الغاء كتمه عام مسبقاًً ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:KtmAll:Groups",Message_Reply.sender_id.user_id) 
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ تم الغاء كتمه عام  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام (%d+)$') then
local UserId = text:match('^كتم عام (%d+)$')
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if Controllerbanall(msg_chat_id,UserId) == true then 
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:KtmAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId," ⇜ تم كتمه عام مسبقاًً").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:KtmAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId," ⇜ تم كتمه عام ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم عام (%d+)$') then
local UserId = text:match('^الغاء كتم عام (%d+)$')
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:KtmAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId," ⇜ تم الغاء كتمه عام مسبقاًً ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:KtmAll:Groups",UserId) 
bot.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId," ⇜ تم الغاء كتمه عام ").Reply,"md",true)  
end
end
-----------------
if text == 'مسح المكتومين عام' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:KtmAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id," *⇜ لا يوجد مكتومين عام , *","md",true)  
end
Redis:del(Zelzal.."Zelzal:KtmAll:Groups") 
return send(msg_chat_id,msg_id," ⇜ تم مسح ( "..#Info_Members.." ) من المكتومين عام ","md",true)
end
if text == 'المكتومين عام' or text == 'قائمه المكتومين عام' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:KtmAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"* ⇜ لا يوجد مكتومين عام , *","md",true)  
end
ListMembers = '\n*⇜ قائمة المكتومين عام*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
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
data = {{{text = 'مسح المكتومين عام', data = msg.sender_id.user_id..'/KtmAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text and text:match('^رفع مطور اساسي @(%S+)$') then
local UserName = text:match('^رفع مطور اساسي @(%S+)$')
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ⇜ هو من قبل مطور اساسي🎖 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:ControlAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ⇜ ابشر رفعته مطور اساسي🎖 ").Reply,"md",true)  
end
end
if text and text:match('^تنزيل مطور اساسي @(%S+)$') then
local UserName = text:match('^تنزيل مطور اساسي @(%S+)$')
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ⇜ هو من قبل مو مطور اساسي🎖 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:ControlAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ⇜ ابشر نزلته من المطورين الاساسيين🎖").Reply,"md",true)  
end
end
if text == ('رفع مطور اساسي') and msg.reply_to_message_id ~= 0 then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ هو من قبل مطور اساسي🎖 ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:ControlAll:Groups",Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ ابشر رفعته مطور اساسي🎖 ").Reply,"md",true)
end
end
if text == ('تنزيل مطور اساسي') and msg.reply_to_message_id ~= 0 then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ هو من قبل مو مطور اساسي🎖 ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:ControlAll:Groups",Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ ابشر نزلته من المطورين الاساسيين🎖").Reply,"md",true)  
end
end
if text and text:match('^رفع مطور اساسي (%d+)$') then
local UserId = text:match('^رفع مطور اساسي (%d+)$')
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId," ⇜ هو من قبل مطور اساسي🎖").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:ControlAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId," ⇜ ابشر رفعته مطور اساسي🎖️ ").Reply,"md",true)  
end
end
if text and text:match('^تنزيل مطور اساسي (%d+)$') then
local UserId = text:match('^تنزيل مطور اساسي (%d+)$')
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:ControlAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId," ⇜ هو من قبل مو مطور اساسي🎖").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:ControlAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId," ⇜ ابشر نزلته من المطورين الاساسيين🎖").Reply,"md",true)  
end
end
if text == 'مسح المطورين الاساسيين' then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:ControlAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id," ⇜ لا يوجد مطورين اساسيين🎖 , ","md",true)  
end
Redis:del(Zelzal.."Zelzal:ControlAll:Groups") 
return send(msg_chat_id,msg_id,"* ⇜ ابشر مسحت ( "..#Info_Members.." ) من مطورين اساسيين🎖*","md",true)
end
if text == 'المطورين الاساسيين' then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:ControlAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"* ⇜ مافي مطورين اساسيين🎖 , *","md",true)  
end
ListMembers = '\n*⇜ قائمة مطورين اساسيين🎖*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
return send(msg_chat_id, msg_id, ListMembers, 'md', true)
end
if text == 'نادي المطور' or text == 'بدي مساعدة' or text == 'بدي مساعده' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."Status:tagdev") then
send(msg_chat_id,msg_id,"⇜ نداء المطـور معطـل من قبل مطـور البـوت .")
return false
end
send(msg_chat_id,msg_id,"⇜ تم إرسال طلبك للمطور سيتم الرد عليك قريباً .")
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
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
local current_time = os.time() + 3600 -- إضافة ساعة واحدة
local id = tostring(msg.chat_id)
gt = string.upper(id:gsub('-100',''))
gtr = math.floor(msg.id/2097152/0.5)
telink = "https://t.me/c/"..gt.."/"..gtr..""
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
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ مرحباً عزيزي المطور*\n*⇜ شخص ما يحتاج مساعدتك*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n*⇜ الوقت :* '..os.date("%I:%M %p", current_time)..'\n*⇜ التاريخ :* '..os.date("%Y/%m/%d")..'\n\n*⇜ رابط الرسالة :*'..telink..'',"md",false, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ مرحباً عزيزي المطور*\n*⇜ شخص ما يحتاج مساعدتك*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n*⇜ الوقت :* '..os.date("%I:%M %p", current_time)..'\n*⇜ التاريخ :* '..os.date("%Y/%m/%d")..'\n\n*⇜ رابط الرسالة :*'..telink..'',"md",false, false, false, false, reply_markup)
end
end
if text == 'المطور' or text == 'مطور البوت' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local NamesBot = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "لايوجد")
local GetEr = Redis:get(Zelzal..'Zelzal:Text:Dev')
if GetEr then
local UserId_Info = bot.searchPublicChat(GetEr:gsub('@',''))
local UserInfo = bot.getUser(UserId_Info.id)
if UserInfo.username and UserInfo.username ~= "" then
t = '['..UserInfo.first_name..'](t.me/'..UserInfo.username..')'
ban = ' '..UserInfo.first_name..' '
u = '[@'..UserInfo.username..']'
else
t = '['..UserInfo.first_name..'](tg://user?id='..UserInfo.id..')'
u = 'لا يوجد'
end
Bio = getbio(UserInfo.id)
local photo = bot.getUserProfilePhotos(UserInfo.id)
if photo.total_count > 0 then
local TestText = "*• Name Bot ↦ *"..NamesBot.."\n*━━━━━━━━━━━━*\n*• Dev ↦ *"..(t).."\n*• Bio ↦ "..Bio.."*"
keyboardd = {}
keyboardd.inline_keyboard = {
{
{text = ban, url = "https://t.me/"..UserInfo.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg_chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
send(msg_chat_id,msg_id,"المطور 𖦹 "..(t).." ","md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
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
local current_time = os.time() + 3600 -- إضافة ساعة واحدة
local id = tostring(msg.chat_id)
gt = string.upper(id:gsub('-100',''))
gtr = math.floor(msg.id/2097152/0.5)
telink = "https://t.me/c/"..gt.."/"..gtr..""
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
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ مرحباً عزيزي المطور*\n*⇜ شخص ما يحتاج مساعدتك*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n*⇜ الوقت :* '..os.date("%I:%M %p", current_time)..'\n*⇜ التاريخ :* '..os.date("%Y/%m/%d")..'\n\n*⇜ رابط الرسالة :*'..telink..'',"md",false, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ مرحباً عزيزي المطور*\n*⇜ شخص ما يحتاج مساعدتك*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n*⇜ الوقت :* '..os.date("%I:%M %p", current_time)..'\n*⇜ التاريخ :* '..os.date("%Y/%m/%d")..'\n\n*⇜ رابط الرسالة :*'..telink..'',"md",false, false, false, false, reply_markup)
end
else
local UserInfo = bot.getUser(Sudo_Id)
if UserInfo.username and UserInfo.username ~= "" then
t = '['..UserInfo.first_name..'](t.me/'..UserInfo.username..')'
ban = ' '..UserInfo.first_name..' '
u = '[@'..UserInfo.username..']'
else
t = '['..UserInfo.first_name..'](tg://user?id='..UserInfo.id..')'
u = 'لا يوجد'
end
Bio = getbio(UserInfo.id)
local photo = bot.getUserProfilePhotos(UserInfo.id)
if photo.total_count > 0 then
local TestText = "*• Name Bot ↦ *"..NamesBot.."\n*━━━━━━━━━━━━*\n*• Dev ↦ *"..(t).."\n*• Bio ↦ "..Bio.."*"
keyboardd = {}
keyboardd.inline_keyboard = {
{
{text = ban, url = "https://t.me/"..UserInfo.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg_chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
send(msg_chat_id,msg_id,"المطور 𖦹 "..(t).." ","md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
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
local current_time = os.time() + 3600 -- إضافة ساعة واحدة
local id = tostring(msg.chat_id)
gt = string.upper(id:gsub('-100',''))
gtr = math.floor(msg.id/2097152/0.5)
telink = "https://t.me/c/"..gt.."/"..gtr..""
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
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'\n*⇜ مرحباً عزيزي المطور*\n*⇜ شخص ما يحتاج مساعدتك*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n*⇜ الوقت :* '..os.date("%I:%M %p", current_time)..'\n*⇜ التاريخ :* '..os.date("%Y/%m/%d")..'\n\n*⇜ رابط الرسالة :*'..telink..'',"md",false, false, false, false, reply_markup)
else
send(Sudo_Id,0,'\n*⇜ مرحباً عزيزي المطور*\n*⇜ شخص ما يحتاج مساعدتك*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n*⇜ الوقت :* '..os.date("%I:%M %p", current_time)..'\n*⇜ التاريخ :* '..os.date("%Y/%m/%d")..'\n\n*⇜ رابط الرسالة :*'..telink..'',"md",false, false, false, false, reply_markup)
end
end
end
if text == "حذف رد متعدد" or text == "مسح رد متعدد" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
send(msg_chat_id, msg_id, '*⇜ تمام عيني \n⇜ الحين ارسل الرد عشان امسحه \n ✓*', 'md', false, false, false, false, reply_markup)
Redis:set(Zelzal.."Set:array:rd"..msg.sender_id.user_id..":"..msg_chat_id,"delrd")
return false 
end
if text then
if Redis:sismember(Zelzal..'List:array'..msg_chat_id,text) then
local list = Redis:smembers(Zelzal.."Add:Rd:array:Text"..text..msg_chat_id)
quschen = list[math.random(#list)]
send(msg_chat_id, msg_id,'['..quschen..']',"md",true)
end
end
if text == ("الردود المتعدده") then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local list = Redis:smembers(Zelzal..'List:array'..msg_chat_id)
text = "*⇜ قائمة الردود المتعددة* \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
text = text..""..k.." - ( "..v.." ) ࿓ ( رسالة )\n"
end
if #list == 0 then
text = "*⇜ لا يوجد ردود متعدده ياحلو*"
end
send(msg_chat_id, msg_id,'['..text..']',"md",true)
end
if text == ("مسح الردود المتعدده") then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local list = Redis:smembers(Zelzal..'List:array'..msg_chat_id)
for k,v in pairs(list) do
Redis:del(Zelzal.."Add:Rd:array:Text"..v..msg_chat_id)   
Redis:del(Zelzal.."List:array"..msg_chat_id)
end
send(msg_chat_id, msg_id,"*⇜ ابشر مسحت الردود المتعدده\n✓*","md",true)
end
if text == "اضف رد متعدد" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
send(msg_chat_id, msg_id, '*⇜ حلو ، الحين ارسل الكلمة اللي تبيها*', 'md', false, false, false, false, reply_markup)
Redis:set(Zelzal.."Set:array"..msg.sender_id.user_id..":"..msg_chat_id,true)
return false
end
-----------------
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:arrayy"..msg.sender_id.user_id..":"..msg.chat_id) == 'true' then
Redis:set(Zelzal..'Set:arrayy'..msg.sender_id.user_id..':'..msg.chat_id,'true1')
Redis:set(Zelzal..'Text:arrayy'..msg.sender_id.user_id, text)
Redis:del(Zelzal.."Add:Rd:array:Textt"..text)   
Redis:sadd(Zelzal..'List:arrayy', text)
send(msg.chat_id,msg.id,"*⇜ ارسل كلمة الرد الذي تريد اضافتها*","md",true)
return false
end
end
if text and Redis:get(Zelzal..'Set:arrayy'..msg.sender_id.user_id..':'..msg.chat_id) == 'true1' then
local test = Redis:get(Zelzal..'Text:arrayy'..msg.sender_id.user_id)
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
Redis:sadd(Zelzal.."Add:Rd:array:Textt"..test,text)  
reply_ad = bot.replyMarkup{
type = 'inline',data = {
{{text="انهاء الاضافة",data="EndAddarrayy"..msg.sender_id.user_id}},
}
}
return send(msg.chat_id,msg.id,' *⇜ تم حفظ الرد يمكنك ارسال رد اخر او الانهاء من خلال الزر بالاسفل*',"md",true, false, false, false, reply_ad)
end
-----------------
if text == "مسح رد من متعدد عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Set:array:Ssdd"..msg.sender_id.user_id..":"..msg.chat_id,"delrd")
send(msg.chat_id,msg.id,"*⇜ ارسل كلمة الرد *","md",true)  
return false
end
-----------------
if text == "مسح رد متعدد عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Set:array:rdd"..msg.sender_id.user_id..":"..msg.chat_id,"delrd")
send(msg.chat_id,msg.id,"*⇜ ارسل الان الكلمه لمسحها من الردود*","md",true)  
return false
end
if text == ("الردود المتعدده عام") then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal..'List:arrayy')
t = "*⇜ قائمه الردود المتعدده عام*\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆* \n\n"
for k,v in pairs(list) do
t = t..""..k.." - ( "..v.." ) ࿓ ( رسالة )\n"
end
if #list == 0 then
t = "*⇜ لا يوجد ردود متعدده عام*"
end
send(msg.chat_id,msg.id,t,"md",true)  
end
if text == ("مسح الردود المتعدده عام") then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal..'List:arrayy')
for k,v in pairs(list) do
Redis:del(Zelzal.."Add:Rd:array:Textt"..v)   
Redis:del(Zelzal..'List:arrayy')
end
send(msg.chat_id,msg.id,"*⇜ تم مسح الردود المتعدده عام*","md",true)  
end
if text == "اضف رد متعدد عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg.chat_id,msg.id,"*⇜ ارسل الان الكلمه لاضافتها في الردود*","md",true)
Redis:set(Zelzal.."Set:arrayy"..msg.sender_id.user_id..":"..msg.chat_id,true)
return false 
end
if text == 'السيرفر' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
send(msg_chat_id,msg_id, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '⇜  •⊱ { نظام التشغيل } ⊰•\n*»» '"$linux_version"'*' 
echo '*------------------------------\n*⇜  •⊱ { الذاكره العشوائيه } ⊰•\n*»» '"$memUsedPrc"'%}*'
echo '*------------------------------\n*⇜  •⊱ { وحـده الـتـخـزيـن } ⊰•\n*»» '"$HardDisk"'*'
echo '*------------------------------\n*⇜  •⊱ { الـمــعــالــج } ⊰•\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*------------------------------\n*⇜  •⊱ { الــدخــول } ⊰•\n*»» '`whoami`'*'
echo '*------------------------------\n*⇜  •⊱ { مـده تـشغيـل الـسـيـرفـر } ⊰•  \n*»» '"$uptime"'*'
]]):read('*all'),"md")
end
if text == 'صلاحياتي' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return send(msg_chat_id,msg_id,"⇜ انتا صاحب القروب","md",true) 
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف'
else
return send(msg_chat_id,msg_id,"*⇜ عضو فقط*" ,"md",true) 
end
if StatusMember == "chatMemberStatusAdministrator" then 
local GetMemberStatus = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.rights
if GetMemberStatus.can_change_info then
change_info = 'نعم' else change_info = 'لا'
end
if GetMemberStatus.can_delete_messages then
delete_messages = 'نعم' else delete_messages = 'لا'
end
if GetMemberStatus.can_invite_users then
invite_users = 'نعم' else invite_users = 'لا'
end
if GetMemberStatus.can_pin_messages then
pin_messages = 'نعم' else pin_messages = 'لا'
end
if GetMemberStatus.can_restrict_members then
restrict_members = 'نعم' else restrict_members = 'لا'
end
if GetMemberStatus.can_promote_members then
promote = 'نعم' else promote = 'لا'
end
local PermissionsUserr = '\n*⇜ صلاحياتك :*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..'\n*⇜ تغيير المعلومات :* '..change_info..'\n*⇜ تثبيت الرسائل :* '..pin_messages..'\n*⇜ اضافه مستخدمين :* '..invite_users..'\n*⇜ مسح الرسائل :* '..delete_messages..'\n*⇜ حظر المستخدمين :* '..restrict_members..'\n*⇜ اضافه المشرفين :* '..promote..'\n\n'
return send(msg_chat_id,msg_id,"*⇜ رتبتك في القروب : مشرف *"..(PermissionsUserr or '') ,"md",true) 
end
end
if text == 'صلاحياته' and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local StatusMember = bot.getChatMember(msg_chat_id,Message_Reply.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return send(msg_chat_id,msg_id,"*⇜ صاحب القروب*","md",true) 
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف'
else
return send(msg_chat_id,msg_id,"*⇜ عضو فقط*" ,"md",true) 
end
if StatusMember == "chatMemberStatusAdministrator" then 
local GetMemberStatus = bot.getChatMember(msg_chat_id,Message_Reply.sender_id.user_id).status.rights
if GetMemberStatus.can_change_info then
change_info = 'نعم' else change_info = 'لا'
end
if GetMemberStatus.can_delete_messages then
delete_messages = 'نعم' else delete_messages = 'لا'
end
if GetMemberStatus.can_invite_users then
invite_users = 'نعم' else invite_users = 'لا'
end
if GetMemberStatus.can_pin_messages then
pin_messages = 'نعم' else pin_messages = 'لا'
end
if GetMemberStatus.can_restrict_members then
restrict_members = 'نعم' else restrict_members = 'لا'
end
if GetMemberStatus.can_promote_members then
promote = 'نعم' else promote = 'لا'
end
local PermissionsUserr = '\n*⇜ صلاحياته :*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..'\n*⇜ تغيير المعلومات :* '..change_info..'\n*⇜ تثبيت الرسائل :* '..pin_messages..'\n*⇜ اضافه مستخدمين :* '..invite_users..'\n*⇜ مسح الرسائل :* '..delete_messages..'\n*⇜ حظر المستخدمين :* '..restrict_members..'\n*⇜ اضافه المشرفين :* '..promote..'\n\n'
return send(msg_chat_id,msg_id,"*⇜ رتبته في القروب : مشرف *"..(PermissionsUserr or '') ,"md",true) 
end
end
if text and text:match('^صلاحياته @(%S+)$') then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local UserName = text:match('^صلاحياته @(%S+)$') 
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local StatusMember = bot.getChatMember(msg_chat_id,UserId_Info.id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return send(msg_chat_id,msg_id,"⇜ صاحب القروب","md",true) 
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف'
else
return send(msg_chat_id,msg_id,"⇜ عضو فقط" ,"md",true) 
end
if StatusMember == "chatMemberStatusAdministrator" then 
local GetMemberStatus = bot.getChatMember(msg_chat_id,UserId_Info.id).status.rights
if GetMemberStatus.can_change_info then
change_info = 'نعم' else change_info = 'لا'
end
if GetMemberStatus.can_delete_messages then
delete_messages = 'نعم' else delete_messages = 'لا'
end
if GetMemberStatus.can_invite_users then
invite_users = 'نعم' else invite_users = 'لا'
end
if GetMemberStatus.can_pin_messages then
pin_messages = 'نعم' else pin_messages = 'لا'
end
if GetMemberStatus.can_restrict_members then
restrict_members = 'نعم' else restrict_members = 'لا'
end
if GetMemberStatus.can_promote_members then
promote = 'نعم' else promote = 'لا'
end
local PermissionsUserr = '\n⇜ صلاحياته :\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..'\n⇜ تغيير المعلومات : '..change_info..'\n⇜ تثبيت الرسائل : '..pin_messages..'\n⇜ اضافه مستخدمين : '..invite_users..'\n⇜ مسح الرسائل : '..delete_messages..'\n⇜ حظر المستخدمين : '..restrict_members..'\n⇜ اضافه المشرفين : '..promote..'\n\n'
return send(msg_chat_id,msg_id,"⇜ رتبته في القروب : مشرف "..(PermissionsUserr or '') ,"md",true) 
end
end
if text and text:match('^تفاعله @(%S+)$') then
local UserName = text:match('^تفاعله @(%S+)$') 
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
TotalMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..UserId_Info.id) or 0
TotalMsgT = Total_message(TotalMsg) 
return send(msg_chat_id,msg_id,"⇜ تفاعله : "..TotalMsgT, "md")
end
if text == 'تفاعله' and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
TotalMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..Message_Reply.sender_id.user_id) or 0
TotalMsgT = Total_message(TotalMsg) 
return send(msg_chat_id,msg_id,"*⇜ تفاعله : *"..TotalMsgT, "md")
end
if text == 'نبذه' or text == 'نبذة' or text == 'بايو عشوائي' or text == 'اعطني بايو' and not Redis:get(Zelzal.."Zelzal:biousers"..msg.chat_id) then
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'شباب', data = msg.sender_id.user_id..'/bioold'},{text = 'بنات', data = msg.sender_id.user_id..'/biobnt'},
},
}
}
return send(msg_chat_id, msg_id, '*⇜ اختر نوع البايو*', 'md', false, false, false, false, reply_markup)
end
if text == 'معرفي' or text == 'يوزري' or text == 'ايديي' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
if UserInfo.username then
UserInfousername = '[@'..UserInfo.username..']'
else
UserInfousername = 'لا يوجد'
end
return send(msg_chat_id,msg_id,'\n*• يوزرك ⇜ '..UserInfousername..'\n• ايديك ⇜ '..msg.sender_id.user_id..'*', "md")
end
if text == 'اسمي' and not Redis:get(Zelzal..'idnotmemname'..msg.chat_id)  then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'\n*⇜ اسمك : '..FlterBio(UserInfo.first_name)..'*', "md")
end
if text and text:match('^الرتبه @(%S+)$') then
local UserName = text:match('^الرتبه @(%S+)$') 
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
return send(msg_chat_id,msg_id,"*⇜ الرتبه : *"..RinkBot, "md")
end
if text == 'الرتبه' or text == 'رتبته' and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local RinkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ رتبته : *"..RinkBot, "md")
end
if text == 'جهاته' and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
send(msg_chat_id,msg_id,'*⇜ عدد جهاته : *'..(Redis:get(Zelzal.."Zelzal:Num:Add:Memp"..msg.chat_id..":"..Message_Reply.sender_id.user_id) or 0)..' ',"md",true)  
end
if text and text:match('^جهاته @(%S+)$') then
local UserName = text:match('^جهاته @(%S+)$') 
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
send(msg_chat_id,msg_id,'*⇜ عدد جهاته : *'..(Redis:get(Zelzal.."Zelzal:Num:Add:Memp"..msg.chat_id..":"..UserId_Info.id) or 0)..' ',"md",true)  
end
if text == "تخ" or text == "اقتلو" or text == "قتل" or text == "طخ" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = bot.getUser(Message_Reply.sender_id.user_id)
local bain = bot.getUser(msg.sender_id.user_id)
if tonumber(Message_Reply.sender_id.user_id) == tonumber(msg.sender_id.user_id) then
return send(msg_chat_id,msg_id,"*- ايا مطـي .. تريـد تنتحـر ؟!*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030) or tonumber(Message_Reply.sender_id.user_id) == tonumber(925972505) then
return send(msg_chat_id,msg_id,"*يحمـار دا مبرمج السورس ممكن يفشخني انا وانتـه 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030322) or tonumber(Message_Reply.sender_id.user_id) == tonumber(5280339206) or tonumber(Message_Reply.sender_id.user_id) == tonumber(1985225531) or tonumber(Message_Reply.sender_id.user_id) == tonumber(Sudo_Id) then
return send(msg_chat_id,msg_id,"*يحمـار ده مطـور البـوت .. تاج راسـك 😹😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(Zelzal) then
return send(msg_chat_id,msg_id,"*يخربيت الضحك عاوز يقتل البوت 🙂😂😂*","md",true)  
end
if ban.first_name then
baniusername = '*⇜ المستخـدم ⇜ *['..bain.first_name..'](tg://user?id='..bain.id..')*\n⇜ قـام بقتـل المجـرم 😹🙀 ⇜ *['..ban.first_name..'](tg://user?id='..ban.id..')*\n⇜ انـا لله وانـا اليـه راجعـون ⚰🥲\n*'
else
baniusername = 'لا يوجد'
end
 keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'المقتول 🔪', url = "https://t.me/"..ban.username..""},
},
}
local msgg = msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendvideo?chat_id=" .. msg_chat_id .. "&video=https://t.me/WhatsBot_AR/5&caption=".. URL.escape(baniusername).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == "تف" or text == "اتفو" or text == "تفف" or text == "تفو" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = bot.getUser(Message_Reply.sender_id.user_id)
local bain = bot.getUser(msg.sender_id.user_id)
if tonumber(Message_Reply.sender_id.user_id) == tonumber(msg.sender_id.user_id) then
return send(msg_chat_id,msg_id,"*- ايا مطـي .. تريـد البـوت يتفل عليـك ؟!*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030) or tonumber(Message_Reply.sender_id.user_id) == tonumber(925972505) then
return send(msg_chat_id,msg_id,"*يحمـار دا مبرمج السورس ممكن يفشخني انا وانتـه 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030432) or tonumber(Message_Reply.sender_id.user_id) == tonumber(5280339206) or tonumber(Message_Reply.sender_id.user_id) == tonumber(1985225531) or tonumber(Message_Reply.sender_id.user_id) == tonumber(Sudo_Id) then
return send(msg_chat_id,msg_id,"*يحمـار ده مطـور البـوت .. تاج راسـك 😹😞 تفو عليك انته*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(Zelzal) then
return send(msg_chat_id,msg_id,"*يخربيت الضحك عاوز يتف علي البوت 🙂😂😂*","md",true)  
end
if ban.first_name then
baniusername = '*⇜ المستخـدم ⇜ *['..bain.first_name..'](tg://user?id='..bain.id..')*\n⇜ قـام بتفـل الشخص 😹🤢 ⇜ *['..ban.first_name..'](tg://user?id='..ban.id..')*\n⇜ اععـع الله يقـرفـك 🥲\n*'
else
baniusername = 'لا يوجد'
end
 keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'المتفـول 😹💦', url = "https://t.me/"..ban.username..""},
},
}
local msgg = msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendvideo?chat_id=" .. msg_chat_id .. "&video=https://t.me/apqiy/132&caption=".. URL.escape(baniusername).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
---------------------- Dev ZilZal ----------------------
if text == "صيح" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
local Get_Chat = bot.getChat(msg.chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg.chat_id)
local bains = bot.getUser(msg.sender_id.user_id)
if bains.first_name then
klajq = ' ['..bains.first_name..'](tg://user?id='..bains.id..') '
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ''..bains.username..' '
else
basgk = 'لا يوجد'
end
local seha = {
"* تعــاال وجـه الطـاوه .. ينـادوك 🌚😹*",
"*يمعوود تعاال يريدوكك🤕♥️*",
"*تعــااال وليــدي 😒🔪*",
"*تعال يولل استاذكك ايريدككك😒🔪*"
}
local saihh = seha[math.random(#seha)]
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link},},
}
}
send(UserInfo.id,0,"-"..saihh.."\n*هـذا يصيحـك ->* "..klajq.."","md",true, false, false, false, reply_markup)
send(msg_chat_id,msg_id, "*⇜ ابشـر سيـدي سـوف اقـوم بازعاجـه خـاص*","md",true)
end
end
---------------------- Dev ZilZal ----------------------
if text and text:match('^صيح @(%S+)$') then
local UserName = {text:match('^صيح @(%S+)$')}
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. استخـدم الامـر هكـذا\n⇜ صيح + ايـدي الشخـص*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"*\n ⇜ عذرآ لا تستطيع استخدام معرف قناة او جروب *","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"*\n ⇜ عذرآ لا تستطيع استخدام معرف البوت *","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Get_Chat = bot.getChat(msg.chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg.chat_id)
local bains = bot.getUser(msg.sender_id.user_id)
if bains.first_name then
klajq = ' ['..bains.first_name..'](tg://user?id='..bains.id..') '
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ''..bains.username..' '
else
basgk = 'لا يوجد'
end
local UserInfo = bot.getUser(UserId_Info.id)
local seha = {
"* تعــاال وجـه الطـاوه .. ينـادوك 🌚😹*",
"*يمعوود تعاال يريدوكك🤕♥️*",
"*تعــااال وليــدي 😒🔪*",
"*تعال يولل استاذكك ايريدككك😒🔪*"
}
local saihh = seha[math.random(#seha)]
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link},},
}
}
send(UserId_Info.id,0,"-"..saihh.."\n*هـذا يصيحـك ->* "..klajq.."","md",true, false, false, false, reply_markup)
send(msg_chat_id,msg_id, "*⇜ ابشـر سيـدي سـوف اقـوم بازعاجـه خـاص*","md",true)
end
---------------------- Dev ZilZal ----------------------
if text and text:match('^صيح (%d+)$') then
local UserId = text:match('^صيح (%d+)$')
local Get_Chat = bot.getChat(msg.chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg.chat_id)
local bains = bot.getUser(msg.sender_id.user_id)
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if bains.first_name then
klajq = ' ['..bains.first_name..'](tg://user?id='..bains.id..') '
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ''..bains.username..' '
else
basgk = 'لا يوجد'
end
local UserInfo = bot.getUser(UserId)
local seha = {
"* تعــاال وجـه الطـاوه .. ينـادوك 🌚😹*",
"*يمعوود تعاال يريدوكك🤕♥️*",
"*تعــااال وليــدي 😒🔪*",
"*تعال يولل استاذكك ايريدككك😒🔪*"
}
local saihh = seha[math.random(#seha)]
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link},},
}
}
send(UserId,0,"-"..saihh.."\n*هـذا يصيحـك ->* "..klajq.."","md",true, false, false, false, reply_markup)
send(msg_chat_id,msg_id, "*⇜ ابشـر سيـدي سـوف اقـوم بازعاجـه خـاص*","md",true)
end
---------------------- Dev ZilZal ----------------------
local Bot_Name = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "فولت")
if text and  text:match("^"..Bot_Name.." اتفل(.*)$") and msg.Managers then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030) or tonumber(Message_Reply.sender_id.user_id) == tonumber(925972505) or tonumber(Message_Reply.sender_id.user_id) == tonumber(2095357462) then
return send(msg.chat_id,msg.id,"*يحمـار دا مبرمج السورس ممكن يفشخني انا وانتـه 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030532) or tonumber(Message_Reply.sender_id.user_id) == tonumber(5280339206) or tonumber(Message_Reply.sender_id.user_id) == tonumber(1985225531) or tonumber(Message_Reply.sender_id.user_id) == tonumber(Sudo_Id) then
return send(msg.chat_id,msg.id,"*يحمـار ده مطـور البـوت .. تاج راسـك 😹😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(Zelzal) then
return send(msg.chat_id,msg.id,"*يخربيت الضحك عاوز يتفل البوت 🙂😂😂*","md",true)  
end
if msg.reply_to_message_id then
send(msg.chat_id,msg.id,'*⇜ ابشـرر بعـزك سيـدي 🌝*', "md") 
send(msg.chat_id,msg.reply_to_message_id,'*لك شنو هـذه ويهك ختفوووووووووو💦💦️️ بنص ويهك 😹*', "md") 
else
end
end
if text and  text:match("^صيحه$") and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
local FlterName = UserInfo.first_name
local seha = {
"* تعــاال وجـه الطـاوه .. ينـادوك 🌚😹*",
"*يمعوود تعاال يريدوكك🤕♥️*",
"*تعــااال وليــدي 😒🔪*",
"*تعال يولل استاذكك ايريدككك😒🔪*"
}
local msg_id = msg.reply_to_message_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..Message_Reply.sender_id.user_id..')'..'\n'..seha[math.random(#seha)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
return false
end
end
-----------------
if text and  text:match("^نادي$") and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
local FlterName = UserInfo.first_name
local seha = {
"* تعــاال وجـه الطـاوه .. ينـادوك 🌚😹*",
"*تتعــال يانخسـي وشمـي 🤭♥️*",
"*تعــااال وليــدي 😒🔪*"
}
local msg_id = msg.reply_to_message_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..Message_Reply.sender_id.user_id..')'..'\n'..seha[math.random(#seha)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
return false
end
end
-----------------
if text and  text:match("^رزله$") and msg.reply_to_message_id and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then 
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender_id.user_id) == tonumber(msg.sender_id.user_id) then
return send(msg.chat_id,msg.id,"*ايا مطـي .. تريـد تـرزل نفسـك ؟!*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030) or tonumber(Message_Reply.sender_id.user_id) == tonumber(925972505) or tonumber(Message_Reply.sender_id.user_id) == tonumber(2095357462) then
return send(msg.chat_id,msg.id,"*يحمـار دا مبرمج السورس ممكن يفشخني انا وانتـه 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030542) or tonumber(Message_Reply.sender_id.user_id) == tonumber(5280339206) or tonumber(Message_Reply.sender_id.user_id) == tonumber(1985225531) or tonumber(Message_Reply.sender_id.user_id) == tonumber(Sudo_Id) then
return send(msg.chat_id,msg.id,"*يحمـار ده مطـور البـوت .. تاج راسـك 😹😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(Zelzal) then
return send(msg.chat_id,msg.id,"*يخربيت الضحك عاوز يرزل البوت 🙂😂😂*","md",true)  
end
local tzl = {
"*ميستاهل اتعب روحي ويا لانه عار 😐*",
"*ولك هيو لتندك بسيادك لو بهاي 👈👞 انت شايف وجهك تكول فحمايه 🌚 وجه الطاوه يلا دي منا🏌️😡*",
"*عوفه حبيبي هذا جاهل يضل يبجي🤣*",
"*لك حيوان ادبسز انت شدخلك \nانت حياتك كلهه تروح تاكلك ماعون تمن وتشريب ولحم وتكعد وتسكت 😕🚶*",
"*شوف هذا العار يريدني ارزلك يروحلك فدوه 🥰💖*",
"*لك دي وتفو بعد لتندك بتاج راسك خوش حمبقلبي 🏌️*",
"*تعال هيوو ✊😏 شو طالعه عينك ولسانك طويل سربوت  اشو تعال بله شنو هذا ويهك هاذ 😳 كول بلعباس😅*",
"*روح من يمي لا الطمك سطره اكلب جهرتك 🤬بعدك كتكوت روح العب بعيد ابني🧑‍🦯*",
"*لك شلون ارزل تاج راسك يا غبي يلا درمـل من هـون 🌚👈*",
"*شبيك انت تظل ملطلط شكدك بعد تصير شايلين عقلك مخلين مكانه قندره😹👊 *",
"*لتحجي ولا حرف فهمت ترا بالنعال واكطعه ع راسك وجه الصخل🐐😡 *",
"*انت طيب وغالي عليه وهذا يكولي رزله روح طيح حظه😅 *",
}
return send(msg.chat_id,msg.reply_to_message_id,tzl[math.random(#tzl)],"md",true)  
end 
-----------------
if text and  text:match("^هينه$") and msg.reply_to_message_id and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then 
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender_id.user_id) == tonumber(msg.sender_id.user_id) then
return send(msg.chat_id,msg.id,"*ايا مطـي .. تريـد تـرزل نفسـك ؟!*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030) or tonumber(Message_Reply.sender_id.user_id) == tonumber(925972505) or tonumber(Message_Reply.sender_id.user_id) == tonumber(2095357462) then
return send(msg.chat_id,msg.id,"*يحمـار دا مبرمج السورس ممكن يفشخني انا وانتـه 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030544) or tonumber(Message_Reply.sender_id.user_id) == tonumber(5280339206) or tonumber(Message_Reply.sender_id.user_id) == tonumber(1985225531) or tonumber(Message_Reply.sender_id.user_id) == tonumber(Sudo_Id) then
return send(msg.chat_id,msg.id,"*يحمـار ده مطـور البـوت .. تاج راسـك 😹😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(Zelzal) then
return send(msg.chat_id,msg.id,"*يخربيت الضحك عاوز يرزل البوت 🙂😂😂*","md",true)  
end
local tzl = {
"*ميستاهل اتعب روحي ويا لانه عار 😐*",
"*ولك هيو لتندك بسيادك لو بهاي 👈👞 انت شايف وجهك تكول فحمايه 🌚 وجه الطاوه يلا دي منا🏌️😡*",
"*عوفه حبيبي هذا جاهل يضل يبجي🤣*",
"*لك حيوان ادبسز انت شدخلك \nانت حياتك كلهه تروح تاكلك ماعون تمن وتشريب ولحم وتكعد وتسكت 😕🚶*",
"*شوف هذا العار يريدني ارزلك يروحلك فدوه 🥰💖*",
"*لك دي وتفو بعد لتندك بتاج راسك خوش حمبقلبي 🏌️*",
"*تعال هيوو ✊😏 شو طالعه عينك ولسانك طويل سربوت  اشو تعال بله شنو هذا ويهك هاذ 😳 كول بلعباس😅*",
"*روح من يمي لا الطمك سطره اكلب جهرتك بعدك كتكوت روح العب بعيد ابني🧑‍🦯*",
"*لك شلون ارزل تاج راسك يا غبي يلا درمـل من هـون 🌚👈*",
"*شبيك انت تظل ملطلط شكدك بعد تصير شايلين عقلك مخلين مكانه قندره😹👊 *",
"*لتحجي ولا حرف فهمت ترا بالنعال واكطعه ع راسك وجه الصخل🐐😡 *",
"*انت طيب وغالي عليه وهذا يكولي رزله روح طيح حظه😅 *",
}
return send(msg.chat_id,msg.reply_to_message_id,tzl[math.random(#tzl)],"md",true)  
end 
-----------------
if text and  text:match("^بوسه$") and msg.reply_to_message_id and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.reply_to_message_id then
local bos = {
"*امممووااهحح شهلعسل🥺🍯💘*",
"*مابوس واحد خايس مثلك 😁*",
"*يععع تلعب نفسي 😷*",
"*مابوس خدك مالح 😹*",
"*امممووااهحح شهلعسل🥺🍯💘*",
"*ولي مابوس واحد عاوي مثلك☹️*",
"*ممممح😘ححح😍😍💋*",
"*ممممح💋ححح مو خدود ضيم🥰*",
}
return send(msg.chat_id,msg.reply_to_message_id,bos[math.random(#bos)],"md",true)  
end
end
-----------------
if text and  text:match("^بوسه$") and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) or text and  text:match("^بوسني$")  and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
local bos = {
"*امممووااهحح شهلعسل🥺🍯💘*",
"*مابوس واحد خايس مثلك 😁*",
"*يععع تلعب نفسي 😷*",
"*مابوس خدك مالح 😹👌*",
"*امممووااهحح شهلعسل🥺🍯💘*",
"*ولي مابوس واحد عاوي مثلك☹️*",
"*ممممح😘ححح😍😍💋*",
"*ممممح💋ححح مو خدود ضيم🥰*",
}
return send(msg.chat_id,msg.id,bos[math.random(#bos)],"md",true)  
end
if text== "شنو رئيك بهذا" or text== "شنو رئيك بي" or text== "شنو رئيك بهـذه" or text== "رأيك بهذا" or text== "شنو رأيك بهذا" or text== "شنو رايك بهذا" or text== "رايك بهذا" or text== "وش رايك بهذا" or text== "وش رايك به" or text== "وش رأيك بهذا" or text== "وش رأيك به" or text== "تحبه" then
if msg.reply_to_message_id then
if not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then 
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
local FlterName = UserInfo.first_name
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030) or tonumber(Message_Reply.sender_id.user_id) == tonumber(925972505) or tonumber(Message_Reply.sender_id.user_id) == tonumber(2095357462) then
return send(msg.chat_id,msg.id,"*يحمـار دا مبرمج السورس ممكن يفشخني انا وانتـه 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030543) or tonumber(Message_Reply.sender_id.user_id) == tonumber(5280339206) or tonumber(Message_Reply.sender_id.user_id) == tonumber(1985225531) or tonumber(Message_Reply.sender_id.user_id) == tonumber(Sudo_Id) then
return send(msg.chat_id,msg.id,"*يحمـار ده مطـور البـوت .. تاج راسـك 😹😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(Zelzal) then
return send(msg.chat_id,msg.id,"*يخربيت الضحك عاوز يقيم البوت 🙂😂😂*","md",true)  
end
if msg.reply_to_message_id then
local he = {"*هـذا شـخص حـباب بـس وكـح وشـويـه زاحـف 😂 عـمريي كـله لـيضل يـزحف تـرا فـضـحنا 😂💔*","*هذا الحلو ..شخـص ايـجابـي ومـحبـوب🥺واللي ميـحبه ادكـه بالنـعال 🤭😂صـح مـرات يـجفـص بـس يـبقـى مـحبوب 🥺♥️*","*لوكي وزاحف قبل شويه زحفلي وحضرتـه 🤪*","*خــوش ولـد و ورده مـال الله 💖*","*يلعـــب ع البنـــات 🙄*","*واحـــد زايعتــه الكـــاع 😶😁*","*صــاك يخبــل وشخصيــه😘*","*محلــو وشواربــه جنها مكناسـه*","*لـك ضلعــي هــذا امــوت عليـه 🌝*","*هــو غيــر الحب مـال انــي 🤓❤️*","*مــو خــوش ولــد صراحــه ☹️*","*ادبســز وميحتــرم البنــات😏*","*فــد واحـــد قـــذر 😁*","*ماطيقــه كل ما الزمـه ريحتــه  تكتــل 😂🤪*","*ولـد طيـب مـن اهــل اللـه 😁*",
}
local msg_id = msg.reply_to_message_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..Message_Reply.sender_id.user_id..')'..'\n'..he[math.random(#he)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
end
if text== "انطي هديه" and not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.reply_to_message_id then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
local FlterName = UserInfo.first_name
local geft = {
"*الف مبروك 👏 هديتك بيذنجان🍆سوي تبسي واندعيلي 🤲😹*",
"*الف مبروك 👏 هديتك نوتيلا  \nيا كيكه انت 🥰😹*",
"*الف مبروك 🥰 هديتك شفقه 🧢 البسهه الشمس تسمط راسك 😁😹*",
"*الف مبروك 👏 هديتك راس بصل 🧅 اكله وابجي الدموع تريح القلب 😁😹*",
"*الف مبروك 👏 هديتك حذاء 👞 تلبسهه لو اكطعهه على راسك 🥰😹*",
"*الف مبروك 👏 هديتك شده 💸\n بس مو تتكبر على اصدقائك 😁😹*",
"*الف مبروك 👏 هديتك تاج ذهب 👑\n يا تاج وباج انت 😉🥰*",
"*الف مبروك 🥰 هديتك ساعه 🕰  بيها\nمنبه تكعدك الصبح 😁😹*",
"*الف مبروك 👏 هديتك خاتم 💍 \nواعزمنه بعرسك 💃😹*",
"*الف مبروك 👏 هديتك صابونه 🧼 والمي بلاش وروح اسبح يالوصخ 😁😹*"
}
local msg_id = msg.reply_to_message_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..Message_Reply.sender_id.user_id..')'..'\n'..geft[math.random(#geft)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
return false
end
end
if text== "شنو رئيك بهاي" or text=="شنو رئيك بيه" or text== "رأيك بهاي" or text== "شنو رأيك بهاي" or text== "شنو رايك بهاي" or text== "رايك بهاي" or text== "وش رايك بهذه" or text== "وش رايك بها" or text== "وش رأيك بهذه" or text== "وش رأيك بها" or text== "تحبها" then 
if msg.reply_to_message_id then
if not Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then  
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
local FlterName = UserInfo.first_name
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030) or tonumber(Message_Reply.sender_id.user_id) == tonumber(925972505) or tonumber(Message_Reply.sender_id.user_id) == tonumber(2095357462) then
return send(msg.chat_id,msg.id,"*يحمـار دا مبرمج السورس ممكن يفشخني انا وانتـه 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030432) or tonumber(Message_Reply.sender_id.user_id) == tonumber(5280339206) or tonumber(Message_Reply.sender_id.user_id) == tonumber(1985225531) or tonumber(Message_Reply.sender_id.user_id) == tonumber(Sudo_Id) then
return send(msg.chat_id,msg.id,"*يحمـار ده مطـور البـوت .. تاج راسـك 😹😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(Zelzal) then
return send(msg.chat_id,msg.id,"*يخربيت الضحك عاوز يقيم البوت 🙂😂😂*","md",true)  
end
local she = {"*الكبـد مــال اني هيـه🥰*","*ختولـي محبهــه جنهه فخريـه🤣*","*خانتنـــي ويـــا صديقـــي 😔*","*بس لــو الكفها الا اعضهــا 💔*","*خــوش بنيــه بس عـدهه سوالــف  ماصخــه وهيـه تــدري بنفسها 😁🤪*","*جذابــه ومنافقــه سوتلـي مشكله ويـا الحـب مالتـي😑*","*اووووووووف امـــوت  عليهـه💖*","*ديــرو بالكــم منها تلعــب ع الشبـاب 😶 ضحكـت ع واحـد قطتــه ايفــون 11 بـــرو☹*","*صديقتـي واختـي وروحـــي وحياتـي 🌚💞*","*فــد وحــده خبــله ولسانهه متبـري منهه😁*","*معـــدله ونازكــهه وعيونهـه تمــوت 😊*","*ام سحــوره سحـرت اخويــه وطيـرت عقلــه😭*","*حبيبــة كلبـي هايـه العشـق🥰*","*بلــه هـايـه هــم جهــره تسأل عليها ؟🤣*","*بربــك انت والله فــارغ وبطـــران ومعنـدك شي تسوي جـاي تسأل ع بنــات العالم ولــي يله ☹️*","*يااخــي بنيه حبوبــه وكلبهــه طيــب فديتهــه😍*","*هــاي البقـره مقدسـه مجرد ماتكلهه بس يجونـك بالتفـك منيـن ويـن ليـش بيـش عيـش طيـط طيـط طيـط 🤣🏃‍♂️*",
}
local msg_id = msg.reply_to_message_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..Message_Reply.sender_id.user_id..')'..'\n'..she[math.random(#she)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
if text=="اتفل" or text=="تفل" or text =="تف" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.reply_to_message_id then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender_id.user_id) == tonumber(1260465030) or tonumber(Message_Reply.sender_id.user_id) == tonumber(925972505) or tonumber(Message_Reply.sender_id.user_id) == tonumber(2095357462) then
return send(msg.chat_id,msg.id,"*يحمـار دا مبرمج السورس ممكن يفشخني انا وانتـه 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(574641234092) or tonumber(Message_Reply.sender_id.user_id) == tonumber(5280339206) or tonumber(Message_Reply.sender_id.user_id) == tonumber(1985225531) or tonumber(Message_Reply.sender_id.user_id) == tonumber(Sudo_Id) then
return send(msg.chat_id,msg.id,"*يحمـار ده مطـور البـوت .. تاج راسـك 😹😞*","md",true)  
end
if tonumber(Message_Reply.sender_id.user_id) == tonumber(Zelzal) then
return send(msg.chat_id,msg.id,"*يخربيت الضحك عاوز يقيم البوت 🙂😂😂*","md",true)  
end
if msg.Addictive or msg.Mddictive then 
return send(msg.chat_id,msg.id,'*ختفوووووووووو💦💦️️*',"md",true)  
else 
return send(msg.chat_id,msg.id,"*⇜ انجب ما اتفل عيب 😼🙌🏿*","md",true)  
end
end
end
---------------------- Dev ZilZal ----------------------
if text == ('لايك') and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عذرآ تستطيع فقط استخدام الامر على المستخدمين* ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا تستطيـع استخـدام الامـر علـى البــوت* ","md",true)  
end
if Redis:sismember(Zelzal.."List_Like"..Message_Reply.sender_id.user_id,msg.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ انت معجـب بهـذا الشخـص مسبقـاً ⇜ ♥️").Reply,"md",true)  
else
Redis:sadd(Zelzal.."List_Like"..Message_Reply.sender_id.user_id,msg.sender_id.user_id)
local GetLike = Redis:incrby(Zelzal.."Zilzal:Message:Like"..Message_Reply.sender_id.user_id, 1) 
Redis:hset(Zelzal..':GroupUserCountLike:'..msg.chat_id,Message_Reply.sender_id.user_id,GetLike)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id) 
if UserInfo.first_name then
NameLUser = UserInfo.first_name
else
NameLUser = UserInfo.first_name
end
NameLUser = NameLUser
NameLUser = NameLUser:gsub("]","")
NameLUser = NameLUser:gsub("[[]","")
Redis:hset(Zelzal..':GroupLikeNameUser:'..msg.chat_id,Message_Reply.sender_id.user_id,NameLUser)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id," ⇜ ابشـر .. ضفتلـه اعجابـك ⇜ ♥️").Reply,"md",true)  
end
end
---------------------- Dev ZilZal ----------------------
if text == "المعجبين" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local like_list = Redis:smembers(Zelzal.."List_Like"..Message_Reply.sender_id.user_id) 
if #like_list == 0 then
return send(msg_chat_id,msg_id,"*⇜ مـاعنـدك معجبيـن يلا درمـل من هـون 🌚👈🚪*","md")
elseif #like_list > 0 then
your_likes = "*⇜ قـائمـة النـاس الي معجبـه فيـك :\nٴ••┉┉┉┉┉┉┉••♥️••┉┉┉┉┉┉┉••\n*"
for k,v in pairs(like_list) do
local user_info = bot.getUser(v)
local name = user_info.first_name
your_likes = your_likes..k.." - ["..name.."](tg://user?id="..v..")\n"
end
return send(msg_chat_id,msg_id,your_likes,"md")
end
end
---------------------- Dev ZilZal ----------------------
if text == "توب لايك" or text == "المشاهير" or text == "ترند لايك" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
GroupAlllRtba = Redis:hgetall(Zelzal..':GroupUserCountLike:'..msg.chat_id)
GetAlllNames  = Redis:hgetall(Zelzal..':GroupLikeNameUser:'..msg.chat_id)
GroupAlllRtbaL = {}
for k,v in pairs(GroupAlllRtba) do table.insert(GroupAlllRtbaL,{v,k}) end
Count,Kount,i = 8 , 0 , 1
for _ in pairs(GroupAlllRtbaL) do Kount = Kount + 1 end
table.sort(GroupAlllRtbaL, function(a, b) return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then Count = Kount end
Text = "*⇜ قائمـة اكثـر مشـاهيـر حصـدو لايكـات هنـا 🏆:\n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n\n"
for k,v in ipairs(GroupAlllRtbaL) do
if i <= Count then  Text = Text..i.."ٴ*-* ["..(GetAlllNames[v[2]] or "المستخـدم").."](tg://user?id="..v[2]..") * ⇜  *لايكـات ( "..v[1].." ) \n" end ; i=i+1
end
return send(msg.chat_id,msg.id,Text,"md")
end
---------------------- Dev ZilZal ----------------------
if text == 'بايو' or text == 'البايو' or text == 'النبذه' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not Redis:get(Zelzal..'idnotmembio'..msg.chat_id)  then
send(msg_chat_id, msg_id, '*'..FlterBio(getbio(msg.sender_id.user_id))..'*', 'md')
end
end
if (text == "ايدي" or text == "id" or text == 'Id' or text == 'ID' or text == 'ا') and msg.reply_to_message_id == 0 then
textlook = "ايدي"
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,textlook) then
if Locks_Status(msg.sender_id.user_id,msg,textlook) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,textlook),"md",true)
end
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if (not msg.Distinguished or not msg.Mistinguished) and Redis:get(Zelzal..'idnotmem'..msg.chat_id)  then
return send(msg.chat_id,msg.id,'\n⇜ امـر ايدي معطـل لـ الاعضـاء*\n*⇜ مسمـوح لـ اصحـاب الـرتب فقـط 🤷🏻‍♀*',"md")
end
if not Redis:get(Zelzal.."Zelzal:Status:Id"..msg_chat_id) then
return false
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local InfoUser = bot.getUserFullInfo(msg.sender_id.user_id)
local nameuser = FlterBio(UserInfo.first_name)
local Bio = getbio(msg.sender_id.user_id)
local photo = bot.getUserProfilePhotos(msg.sender_id.user_id)
local UserId = msg.sender_id.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..msg.sender_id.user_id) or 0
local DayMsg = Redis:get(Zelzal..'msg:match:'..msg.chat_id..':'..msg.sender_id.user_id) or 0
DayMsg = math.floor(DayMsg) -- تقريب العدد لأقرب عدد صحيح أصغر منه
local TotalPhoto = photo.total_count or 0
local TotalEdit = Redis:get(Zelzal..'Zelzal:Num:Message:Edit'..msg_chat_id..msg.sender_id.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = Redis:get(Zelzal.."Zelzal:Num:Add:Games"..msg.chat_id..msg.sender_id.user_id) or 0
local NumAdd = Redis:get(Zelzal.."Zelzal:Num:Add:Memp"..msg.chat_id..":"..msg.sender_id.user_id) or 0
local Texting = {"يالبيـه والايـدي 🥺🤍 ","ءاެطلـق ، مـטּ كتب اެيدي 🥺💞","وجودك جبـر لـ قلـبي 💞","عِمـَݛي شهَݪ اެلوسامة 🦋🤍","وانك نعمة اهداها الله لمن حولك 🍂","- مَن بيّن عَادية الأمُور أنت الدهَشة ✨","أنا في رفقتك اتغنى بك حباً سروراً 🤍🫶","إنما الارواح على صفاء نواياها تتلاقى ..🤍🫶","أجمل مافي الصدفة شوفتك 🎼♥️","بالمختصر  انتِ شي حلو محد يشبهه💕 🫶","‏ان النظر إليك طمأنينه 😶♥","‏مَا يشبهك إلا المطر ⛄️ وكل المطر خير و حياة ♥","‏جَبَـرَ الله قلبـكُ ، وقَلبِـي 🥺❤️‍🩹","انك الجميع و كل من احتل قلبي🫀🤍","‏لقـد تعمـقت بِـكَ كَثيـراً والمِيـمُ لام ♥️🙊"}
local Description = Texting[math.random(#Texting)]
local Likes = Redis:get(Zelzal..'Zilzal:Message:Like'..msg.sender_id.user_id) or 0
local creationdate = request("https://sero-bots.ml/API/DatTele.php?ID="..URL.escape(msg.sender_id.user_id))
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id)
if StatusMember.status.custom_title ~= "" then
Lakb = StatusMember.status.custom_title
else
Lakb = 'مشرف'
end
if (StatusMember.status.luatele == "chatMemberStatusCreator") then
Lakb = 'مالك القروب' 
elseif (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
Lakb = 'مشرف'  
else
Lakb = 'لايوجـد 🎗'
end
local Tahses = Redis:get(Zelzal..'Zelzal:SetLkb'..msg_chat_id..':'..msg.sender_id.user_id) or Lakb
-----------------
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد يوزر'
end
if UserInfo.first_name then
namz = "["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")"
else
namz = " لا يوجد اسم"
end
local DevZilzal = '\n*'..Description..'*\n𓄼 𝐍𝐀𝐌 ⤏   '..namz..'\n𓄼 𝐔𝐒𝐄  ⤏   *'..UserInfousername..'*\n𓄼 𝐈𝐃     ⤏  `'..UserId..'`\n𓄼 𝐒𝐓𝐀  ⤏  '..RinkBot..'\n𓄼 𝐖𝐇𝐎⤏  '..Lakb..'\n𓄼 𝐌𝐒𝐆 ⤏  '..TotalMsg..' - '..TotalMsgT..'\n𓄼 𝐄𝐃𝐓  ⤏  '..TotalEdit..'\n*'..FlterBio(getbio(UserId))..'*'
Get_Is_Id = Redis:get(Zelzal.."Zelzal:Set:Id:Groups") or Redis:get(Zelzal.."Zelzal:Set:Id:Group"..msg_chat_id)
if Redis:get(Zelzal.."Zelzal:Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('{الجهات}',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('{الايدي}',msg.sender_id.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('{اليوزر}',UserInfousername)
local Get_Is_Id = Get_Is_Id:gsub('{الاسم}',UserInfo.first_name) 
local Get_Is_Id = Get_Is_Id:gsub('{الرسائل}',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('{التعديل}',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('{الرتبه}',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('{التفاعل}',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('{تعليق}',Description) 
local Get_Is_Id = Get_Is_Id:gsub('{النقاط}',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('{الصور}',TotalPhoto) 
local Get_Is_Id = Get_Is_Id:gsub('{البايو}',Bio) 
if photo.total_count > 0 then
if photo.photos[1].animation then
if Redis:get(Zelzal..'porn'..msg.chat_id) then
local thumb_id = photo.photos[1].animation.file.remote.id
local idd = photo.photos[1].animation.file.id
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num..".mp4")
return false 
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
local File = request("https://api.telegram.org/bot" .. Token .. "/getfile?file_id="..photo.photos[1].animation.file.remote.id) 
local fc = JSON.decode(File)
local Name_File = download("https://api.telegram.org/file/bot"..Token.."/"..JSON.decode(File).result.file_path, "./id.mp4") 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return bot.sendAnimation(msg.chat_id, msg.id, Name_File, Get_Is_Id, "html", true, nil, nil, nil, nil, nil, nil, nil, nil, keyboard)
else
local num = math.random(99999)
local Fille = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..thumb_id))
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..Fille.result.file_path,""..num..".mp4")
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num..".mp4")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
os.remove(""..num..".mp4")
return false 
end
end
end
local File = request("https://api.telegram.org/bot" .. Token .. "/getfile?file_id="..photo.photos[1].animation.file.remote.id) 
local fc = JSON.decode(File)
local Name_File = download("https://api.telegram.org/file/bot"..Token.."/"..JSON.decode(File).result.file_path, "./id.mp4") 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return bot.sendAnimation(msg.chat_id, msg.id, Name_File, Get_Is_Id, "html", true, nil, nil, nil, nil, nil, nil, nil, nil, keyboard)
else
if Redis:get(Zelzal..'porn'..msg.chat_id) then
local thumb_id = photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id
local idd = photo.photos[1].sizes[#photo.photos[1].sizes].photo.id
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num..".jpg")
return false 
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&caption="..URL.escape(Get_Is_Id).."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&reply_to_message_id="..rep.."&parse_mode=html&reply_markup="..JSON.encode(keyboard))
else
local num = math.random(99999)
local Fille = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..thumb_id))
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..Fille.result.file_path,""..num..".jpg")
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num..".jpg")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
os.remove(""..num..".jpg")
return false 
end
end
end
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&caption="..URL.escape(Get_Is_Id).."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&reply_to_message_id="..rep.."&parse_mode=html&reply_markup="..JSON.encode(keyboard))
end
else
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..msg.chat_id.."&text="..URL.escape(Get_Is_Id).."&reply_to_message_id="..rep..'&parse_mode=html&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))
end
else
if photo.total_count > 0 then
if photo.photos[1].animation then
if Redis:get(Zelzal..'porn'..msg.chat_id) then
local thumb_id = photo.photos[1].animation.file.remote.id
local idd = photo.photos[1].animation.file.id
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num..".mp4")
return false 
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
local File = request("https://api.telegram.org/bot" .. Token .. "/getfile?file_id="..photo.photos[1].animation.file.remote.id) 
local fc = JSON.decode(File)
local Name_File = download("https://api.telegram.org/file/bot"..Token.."/"..JSON.decode(File).result.file_path, "./id.mp4") 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return bot.sendAnimation(msg.chat_id, msg.id, Name_File, DevZilzal, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, keyboard)
else
local num = math.random(99999)
local Fille = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..thumb_id))
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..Fille.result.file_path,""..num..".mp4")
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num..".mp4")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
os.remove(""..num..".mp4")
return false 
end
end
end
local File = request("https://api.telegram.org/bot" .. Token .. "/getfile?file_id="..photo.photos[1].animation.file.remote.id) 
local fc = JSON.decode(File)
local Name_File = download("https://api.telegram.org/file/bot"..Token.."/"..JSON.decode(File).result.file_path, "./id.mp4") 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return bot.sendAnimation(msg.chat_id, msg.id, Name_File, DevZilzal, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, keyboard)
else
if Redis:get(Zelzal..'porn'..msg.chat_id) then
local thumb_id = photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id
local idd = photo.photos[1].sizes[#photo.photos[1].sizes].photo.id
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num..".jpg")
return false 
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&caption="..URL.escape(DevZilzal).."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&reply_to_message_id="..rep.."&parse_mode=markdown&reply_markup="..JSON.encode(keyboard))
else
local num = math.random(99999)
local Fille = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..thumb_id))
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..Fille.result.file_path,""..num..".jpg")
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num..".jpg")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
os.remove(""..num..".jpg")
return false 
end
end
end
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&caption="..URL.escape(DevZilzal).."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&reply_to_message_id="..rep.."&parse_mode=markdown&reply_markup="..JSON.encode(keyboard))
end
else
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..msg.chat_id.."&text="..URL.escape(DevZilzal).."&reply_to_message_id="..rep..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))
end
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('{الجهات}',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('{الايدي}',msg.sender_id.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('{اليوزر}',UserInfousername)
local Get_Is_Id = Get_Is_Id:gsub('{الاسم}',UserInfo.first_name) 
local Get_Is_Id = Get_Is_Id:gsub('{الرسائل}',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('{التعديل}',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('{الرتبه}',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('{التفاعل}',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('{تعليق}',Description) 
local Get_Is_Id = Get_Is_Id:gsub('{النقاط}',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('{الصور}',TotalPhoto) 
local Get_Is_Id = Get_Is_Id:gsub('{البايو}',Bio) 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..msg.chat_id.."&text="..URL.escape(Get_Is_Id).."&reply_to_message_id="..rep..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))
else
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ʟɪᴋᴇ ♥️ ⤑ '..Likes, callback_data='/Liikee'..msg.sender_id.user_id},{text = 'ʟɪᴋᴇʀѕ  🤳', callback_data='/Liiker'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..msg.chat_id.."&text="..URL.escape(DevZilzal).."&reply_to_message_id="..rep..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))
end
end
end
-------------------------------------------------------------------------------------------
if text and text:match('^تحكم @(%S+)$') then
local UserName = text:match('^تحكم @(%S+)$') 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local U = bot.getUser(UserId_Info.id)
if U.first_name then
news = "["..U.first_name.."](tg://user?id="..UserId_Info.id..")"
else
news = " لا يوجد اسم"
end
local reply_markup = bot.replyMarkup{type = 'inline',data = {
{{text = 'صلاحيات الاشراف', data = msg.sender_id.user_id..'/groupNumseteng//'..UserId_Info.id},},
{{text = 'رفع وتنزيل', data = msg.sender_id.user_id..'/rankup//'..UserId_Info.id},},
{{text = 'كتم وطرد', data = msg.sender_id.user_id..'/sting//'..UserId_Info.id},},
{{text = 'إخفـاء الامـر -', data ='/delAmr1'}}}}
return bot.sendText(msg.chat_id,msg.id,'- تستطيع التحكم في '..news..' من خلال الازرار',"md",false, false, false, false, reply_markup)
end
if text == 'تحكم' and msg.reply_to_message_id ~= 0 then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n⇜ لا تستطيع استخدام الامر على البوت","md",true)  
end
if UserInfo.first_name then
news = "["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")"
else
news = " لا يوجد اسم"
end
local reply_markup = bot.replyMarkup{type = 'inline',data = {
{{text = 'صلاحيات الاشراف', data = msg.sender_id.user_id..'/groupNumseteng//'..Message_Reply.sender_id.user_id},},
{{text = 'رفع وتنزيل', data = msg.sender_id.user_id..'/rankup//'..Message_Reply.sender_id.user_id},},
{{text = 'كتم وطرد', data = msg.sender_id.user_id..'/sting//'..Message_Reply.sender_id.user_id},},
{{text = 'إخفـاء الامـر -', data ='/delAmr1'}}}}
return bot.sendText(msg.chat_id,msg.id,'- تستطيع التحكم في '..news..' من خلال الازرار',"md",false, false, false, false, reply_markup)
end
------------------------------------------------------------------------------------------------------------------------------------------------
if text == "اهمس" or text == "همسة" or text == "همسه" and msg.reply_to_message_id ~= 0 then
if Redis:get(Zelzal.."zed:hms"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*⇜ امـر همسـه معطـل من قبـل المنشئيـن*',"md",true) 
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المدير واعلى*","md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local zillzall = math.random(1,9999999999999)
Redis:set(Zelzal.."hms:"..zillzall.."chat_id", msg_chat_id)
Redis:set(Zelzal.."hms:"..zillzall.."to", Message_Reply.sender_id.user_id)
Redis:set(Zelzal.."hms:"..zillzall.."msg_id",msg.reply_to_message_id)
local ban = bot.getUser(Message_Reply.sender_id.user_id)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد اسم"
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'اضغط هنا', url = 't.me/'..UserBot..'?start=hhms'..zillzall..'from_id'..msg.sender_id.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id,"*⇜ تم تحديد الهمسه لـ* "..news.."\n*⇜ اضغط الزر لكتابة الهمسة*\n✓","md",true,false,false,false,reply_markup) 
end
-- همسه ميديا تست --
if (text == "همسه ميديا" or text == "همسة ميديا") and msg.reply_to_message_id ~= 0 then
if Redis:get(Zelzal.."zed:hms"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*⇜ امـر همسـه معطـل من قبـل المنشئيـن*',"md",true) 
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:HmsId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الهمسه معطله من قبـل المالك الاساسي\n⇜ مخصصه فقـط لـ المدير واعلى*","md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local zillzall = math.random(1,9999999999999)
Redis:set(Zelzal.."hmms:"..zillzall.."chat_id", msg_chat_id)
Redis:set(Zelzal.."hmms:"..zillzall.."to", Message_Reply.sender_id.user_id)
Redis:set(Zelzal.."hmms:"..zillzall.."msg_id",msg.reply_to_message_id)
local ban = bot.getUser(Message_Reply.sender_id.user_id)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد اسم"
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'اضغط هنا', url = 't.me/'..UserBot..'?start=hmms'..zillzall..'from_id'..msg.sender_id.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id,"*⇜ تم تحديـد همسـة ميـديـا لـ* "..news.."\n*⇜ اضغـط الـزر لـ ارسـال الهمسـة*\n✓","md",true,false,false,false,reply_markup) 
end
------------------------------------------------------------------------------------------------------------------------------------------------
if text == "اهمسلي" then
if Redis:get(Zelzal.."zed:ehmsli"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*⇜ امـر اهمسلي معطـل من قبـل المـدراء*',"md",true) 
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local list = {
"‏ انك الجميع و كل من احتل قلبي 🫀🤍",
"‏لقـد تعمـقت بِـكَ كَثيـراً والمِيـمُ لام ♥️",
"‏ كُنت أرقّ من أن أتحمّل كُل تلك القَسوة من عَينيك  🍍",
"‏أجبني بربـك .. أَكَـان علـي أَن أغـرس انيابـي فِـي قَلْبِـك لتشعـر بِـي ❤️‍🩹 ؟!",
"‏كُلمـا أتبــع قلبـي يدلـني إليك 🧑🏻‍🦯💓 ",
"‏رغبتي في مُعانقتك عميقة جداً 🫂",
"‏ ‏كل العالم يهون بس الدنيا بيننا تصفى  💙",
"‏هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك🚶‍♂",
"‏جَبَـرَ الله قلبـكُ ، وقَلبِـي ❤️‍🩹",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب",
"تحمل كل هذا الجمال، ‏ألا تتعب ؟!"
}
local ehmsa = list[math.random(#list)]
Redis:set(Zelzal.."Zilzal:Ehms:Hmsa"..msg_chat_id..msg.sender_id.user_id,ehmsa)
local UserInfo = bot.getUser(msg.sender_id.user_id)
local NamesBot = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "لايوجد")
local BotAname = '['..NamesBot..'](t.me/'..UserBot..')'
local EmZilzal = "*⇜ عمࢪي* 「 ["..UserInfo.first_name.."](tg://user?id="..msg.sender_id.user_id..") 」\n*⇜ لديك همسة سرية من*「 "..BotAname.." 」\n*⇜ انت فقط من يستطيع رؤيتها*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'فتـح الهمسـة 🗳', callback_data='/Ehmsli'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..msg.chat_id.."&text="..URL.escape(EmZilzal).."&reply_to_message_id="..rep..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))
end
------------------------------------------------------------------------------------------------------------------------------------------------
if text == "زاجل" then
if Redis:get(Zelzal.."zed:zagel"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*⇜ امـر زاجـل معطـل من قبـل المـدراء*',"md",true) 
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local list = {
"‏ انك الجميع و كل من احتل قلبي 🫀🤍",
"‏لقـد تعمـقت بِـكَ كَثيـراً والمِيـمُ لام ♥️",
"‏ كُنت أرقّ من أن أتحمّل كُل تلك القَسوة من عَينيك  🍍",
"‏أجبني بربـك .. أَكَـان علـي أَن أغـرس انيابـي فِـي قَلْبِـك لتشعـر بِـي ❤️‍🩹 ؟!",
"‏كُلمـا أتبــع قلبـي يدلـني إليك 🧑🏻‍🦯💓 ",
"‏رغبتي في مُعانقتك عميقة جداً 🫂",
"‏ ‏كل العالم يهون بس الدنيا بيننا تصفى  💙",
"‏هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك🚶‍♂",
"‏جَبَـرَ الله قلبـكُ ، وقَلبِـي ❤️‍🩹",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب",
"تحمل كل هذا الجمال، ‏ألا تتعب ؟!"
}
local ehmsa = list[math.random(#list)]
local Info_Members = bot.searchChatMembers(msg.chat_id, "*", 50)
local List_Members = Info_Members.members
local NumRand1 = math.random(1, #List_Members); 
local user1 = List_Members[NumRand1].member_id.user_id
local UserInfo = bot.getUser(user1)
Redis:set(Zelzal.."Zilzal:Zagel:Hmsa"..msg_chat_id..UserInfo.id,ehmsa)
Redis:set(Zelzal..msg_chat_id..msg.sender_id.user_id.."in_zagel:", UserInfo.id)
local UserSender = bot.getUser(msg.sender_id.user_id)
local NamesBot = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "البوت")
local BotAname = '['..NamesBot..'](t.me/'..UserBot..')'
local Zagel = "*⇜ عمࢪي* 「 ["..UserSender.first_name.."](tg://user?id="..msg.sender_id.user_id..") 」\n*⇜ عمࢪي*「 ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..") 」\n*⇜ لديكما همسة زاجل مشتركه 🕊*\n*⇜ لا احد غيركما يستطيع رؤيتها 📬*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'فتـح الهمسـة 🗳', callback_data='/Zageel'..msg.sender_id.user_id},},}
local rep = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..msg.chat_id.."&text="..URL.escape(Zagel).."&reply_to_message_id="..rep..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))
end
------------------------------------------------------------------------------------------------------------------------------------------------
if text == ("مسح الردود الانلاين") or text == ("مسح ردود الانلاين") then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."List:Manager:inline"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(Zelzal.."Add:Rd:Manager:Gif:inline"..v..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Vico:inline"..v..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Stekrs:inline"..v..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Text:inline"..v..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Photo:inline"..v..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Photoc:inline"..v..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Video:inline"..v..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Videoc:inline"..v..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:File:inline"..v..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:video_note:inline"..v..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Audio:inline"..v..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Audioc:inline"..v..msg_chat_id)
Redis:del(Zelzal.."Rd:Manager:inline:v"..v..msg_chat_id)
Redis:del(Zelzal.."Rd:Manager:inline:link"..v..msg_chat_id)
Redis:del(Zelzal.."List:Manager:inline"..msg_chat_id)
end
return send(msg_chat_id,msg_id,"*⇜ تم مسح قائمة الردود الانلاين*","md",true)
end
if text == "اضف رد انلاين" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ حلو ، الحين ارسل الكلمة اللي تبيها*","md",false, false, false, false, reply_markup)
end
if text and text:match("^(.*)$") and tonumber(msg.sender_id.user_id) ~= tonumber(Zelzal) then
if Redis:get(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id) == "true" then
Redis:set(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id,"true1")
Redis:set(Zelzal.."Text:Manager:inline"..msg.sender_id.user_id..":"..msg_chat_id, text)
Redis:del(Zelzal.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Text:inline"..text..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Rd:Manager:inline:text"..text..msg_chat_id)
Redis:del(Zelzal.."Rd:Manager:inline:link"..text..msg_chat_id)
Redis:sadd(Zelzal.."List:Manager:inline"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,[[
*⇜ حلو , الحين ارسل جواب الرد*
*⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
 `{اليوزر}` *↬ يوزر المستخدم*
 `{الرسائل}` *↬ عدد الرسائل*
 `{الاسم}` *↬ اسم المستخدم*
 `{الايدي}` *↬ ايدي المستخدم*
 `{الرتبه}` *↬ رتبة المستخدم*
 `{التعديل}` *↬ عدد التعديلات*

*- اضغـط على الاختصـارات لـ النسـخ .*
]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id.."") == "true2" then
Redis:del(Zelzal.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Text:inline"..text..msg_chat_id) 
Redis:del(Zelzal.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
Redis:del(Zelzal.."Rd:Manager:inline:text"..text..msg_chat_id)
Redis:del(Zelzal.."Rd:Manager:inline:link"..text..msg_chat_id)
Redis:del(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id.."")
Redis:srem(Zelzal.."List:Manager:inline"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,"*⇜ ابشر مسحت الرد من قائمة الانلاين*","md",true)
return false
end
end
if Redis:get(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id) == "true1" and tonumber(msg.sender_id.user_id) ~= tonumber(Zelzal) then
Redis:del(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:set(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local zillzall = Redis:get(Zelzal.."Text:Manager:inline"..msg.sender_id.user_id..":"..msg_chat_id)
if msg.content.text then 
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Zelzal.."Add:Rd:Manager:Text:inline"..zillzall..msg_chat_id, text)
elseif msg.content.sticker then 
Redis:set(Zelzal.."Add:Rd:Manager:Stekrs:inline"..zillzall..msg_chat_id, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then
Redis:set(Zelzal.."Add:Rd:Manager:Vico:inline"..zillzall..msg_chat_id, msg.content.voice_note.voice.remote.id)
elseif msg.content.audio then
Redis:set(Zelzal.."Add:Rd:Manager:Audio:inline"..zillzall..msg_chat_id, msg.content.audio.audio.remote.id)
Redis:set(Zelzal.."Add:Rd:Manager:Audioc:inline"..zillzall..msg_chat_id, msg.content.caption.text)
elseif msg.content.document then
Redis:set(Zelzal.."Add:Rd:Manager:File:inline"..zillzall..msg_chat_id, msg.content.document.document.remote.id)
elseif msg.content.animation then
Redis:set(Zelzal.."Add:Rd:Manager:Gif:inline"..zillzall..msg_chat_id, msg.content.animation.animation.remote.id)
elseif msg.content.video_note then
Redis:set(Zelzal.."Add:Rd:Manager:video_note:inline"..zillzall..msg_chat_id, msg.content.video_note.video.remote.id)
elseif msg.content.video then
Redis:set(Zelzal.."Add:Rd:Manager:Video:inline"..zillzall..msg_chat_id, msg.content.video.video.remote.id)
Redis:set(Zelzal.."Add:Rd:Manager:Videoc:inline"..zillzall..msg_chat_id, msg.content.caption.text)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal.."Add:Rd:Manager:Photo:inline"..zillzall..msg_chat_id, idPhoto)
Redis:set(Zelzal.."Add:Rd:Manager:Photoc:inline"..zillzall..msg_chat_id, msg.content.caption.text)
end
send(msg_chat_id,msg_id,"*⇜ الان ارسل الكلام داخل الزر*","md",true)
return false
end
end
if text and Redis:get(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id) == "set_inline" then
Redis:set(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id, "set_link")
local zillzall = Redis:get(Zelzal.."Text:Manager:inline"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:set(Zelzal.."Rd:Manager:inline:text"..zillzall..msg_chat_id, text)
send(msg_chat_id,msg_id,"*⇜ الان ارسل الرابط  \n⇜ مثال :* [https://t.me/z_zzz8]","md",true)
return false
end
if text and Redis:get(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id) == "set_link" then
Redis:del(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id)
local zillzall = Redis:get(Zelzal.."Text:Manager:inline"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:set(Zelzal.."Rd:Manager:inline:link"..zillzall..msg_chat_id, text)
send(msg_chat_id,msg_id,"*「  *"..zillzall.."*  」\nواضفنا الرد ياحلو 🌚\n✓*","md",true)
return false
end
if text and not Redis:get(Zelzal.."Status:Reply:inline"..msg_chat_id) then
local btext = Redis:get(Zelzal.."Rd:Manager:inline:text"..text..msg_chat_id)
local blink = Redis:get(Zelzal.."Rd:Manager:inline:link"..text..msg_chat_id)
local anemi = Redis:get(Zelzal.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id) 
local veico = Redis:get(Zelzal.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id) 
local stekr = Redis:get(Zelzal.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id) 
local Texingt = Redis:get(Zelzal.."Add:Rd:Manager:Text:inline"..text..msg_chat_id) 
local photo = Redis:get(Zelzal.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
local photoc = Redis:get(Zelzal.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
local video = Redis:get(Zelzal.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
local videoc = Redis:get(Zelzal.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)
local document = Redis:get(Zelzal.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
local audio = Redis:get(Zelzal.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
local audioc = Redis:get(Zelzal.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
local video_note = Redis:get(Zelzal.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = btext , url = blink},
},
}
}
if Texingt then 
local UserInfo = bot.getUser(msg.sender_id.user_id)
local NumMsg = Redis:get(Zelzal..'Num:Message:User'..msg_chat_id..':'..msg.sender_id.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Zelzal..'Num:Message:Edit'..msg_chat_id..msg.sender_id.user_id) or 0
local Texingt = Texingt:gsub('{المعرف}',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('{الاسم}',UserInfo.first_name)
local Texingt = Texingt:gsub('{الايدي}',msg.sender_id.user_id)
local Texingt = Texingt:gsub('{التعديل}',NumMessageEdit)
local Texingt = Texingt:gsub('{الرسائل}',NumMsg)
local Texingt = Texingt:gsub('{الرتبه}',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)
end
if video_note then
bot.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
bot.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end
if stekr then 
bot.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
bot.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
bot.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
bot.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
bot.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end
if audio then
bot.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
end
if text == "حذف رد انلاين" or text == "مسح رد انلاين" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
Redis:set(Zelzal.."Set:Manager:rd:inline"..msg.sender_id.user_id..":"..msg_chat_id,"true2")
return send(msg_chat_id,msg_id,"*⇜ تمام عيني  \n⇜ الحين ارسل الرد عشان امسحه \n✓*","md",false, false, false, false, reply_markup)
end 

if text == ("الردود الانلاين") then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."List:Manager:inline"..msg_chat_id.."")
text = "*⇜ قائمة الردود الانلاين* \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
if Redis:get(Zelzal.."Add:Rd:Manager:Gif:inline"..v..msg_chat_id) then
db = "متحركة"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Vico:inline"..v..msg_chat_id) then
db = "فويس"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Stekrs:inline"..v..msg_chat_id) then
db = "ملصق"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Text:inline"..v..msg_chat_id) then
db = "رسالة"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Photo:inline"..v..msg_chat_id) then
db = "صورة"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Video:inline"..v..msg_chat_id) then
db = "فيديو"
elseif Redis:get(Zelzal.."Add:Rd:Manager:File:inline"..v..msg_chat_id) then
db = "ملف"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Audio:inline"..v..msg_chat_id) then
db = "اغنية"
elseif Redis:get(Zelzal.."Add:Rd:Manager:video_note:inline"..v..msg_chat_id) then
db = "بصمة فيديو"
end
text = text..""..k.." - ( "..v.." ) ࿓ ( "..db.." )\n"
end
if #list == 0 then
text = "*⇜ عذرا لا يوجد ردود انلاين في القروب*"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)
end
------------------------------------------------------------------------------------------------------------------------------------------------
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender_id.user_id ~= Zelzal then
local test = Redis:get(Zelzal.."Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg_chat_id)
if Redis:get(Zelzal.."Set:Rd:mz"..msg.sender_id.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Zelzal.."Set:Rd:mz"..msg.sender_id.user_id..":"..msg_chat_id)
if msg.content.text then
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Zelzal.."Add:Rd:Sudo:mz:Text"..test, text)  
elseif msg.content.sticker then
Redis:set(Zelzal.."Add:Rd:Sudo:mz:stekr"..test, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(Zelzal.."Add:Rd:Sudo:mz:vico"..test, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then
Redis:set(Zelzal.."Add:Rd:Sudo:mz:Gif"..test, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(Zelzal.."Add:Rd:Sudo:mz:Audio"..test, msg.content.audio.audio.remote.id)  
Redis:set(Zelzal.."Add:Rd:Sudo:mz:Audioc"..test, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(Zelzal.."Add:Rd:Sudo:mz:File"..test, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(Zelzal.."Add:Rd:Sudo:mz:Video"..test, msg.content.video.video.remote.id)  
Redis:set(Zelzal.."Add:Rd:Sudo:mz:Videoc"..test, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(Zelzal.."Add:Rd:Sudo:mz:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal.."Add:Rd:Sudo:mz:Photo"..test, idPhoto)  
Redis:set(Zelzal.."Add:Rd:Sudo:mz:Photoc"..test, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"*「  *"..test.."*  」\nواضفنا الرد ياحلو 🌚\n✓*","md",true)
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:Rd:mz"..msg.sender_id.user_id..":"..msg_chat_id) == "true" then
Redis:set(Zelzal.."Set:Rd:mz"..msg.sender_id.user_id..":"..msg_chat_id, "true1")
Redis:set(Zelzal.."Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg_chat_id, text)
Redis:sadd(Zelzal.."List:Rd:Sudo:mz", text)
send(msg_chat_id,msg_id,[[
*⇜ حلو , الحين ارسل جواب الرد*
*⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
 `{اليوزر}` *↬ يوزر المستخدم*
 `{الرسائل}` *↬ عدد الرسائل*
 `{الاسم}` *↬ اسم المستخدم*
 `{الايدي}` *↬ ايدي المستخدم*
 `{الرتبه}` *↬ رتبة المستخدم*
 `{التعديل}` *↬ عدد التعديلات*

*- اضغـط على الاختصـارات لـ النسـخ .*
]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:On:mz"..msg.sender_id.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:mz:video_note","Add:Rd:Sudo:mz:Audio","Add:Rd:Sudo:mz:Audioc","Add:Rd:Sudo:mz:File","Add:Rd:Sudo:mz:Video","Add:Rd:Sudo:mz:Videoc","Add:Rd:Sudo:mz:Photo","Add:Rd:Sudo:mz:Photoc","Add:Rd:Sudo:mz:Text","Add:Rd:Sudo:mz:stekr","Add:Rd:Sudo:mz:vico","Add:Rd:Sudo:mz:Gif"}
for k,v in pairs(list) do
Redis:del(Zelzal..''..v..text)
end
Redis:del(Zelzal.."Set:On:mz"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:srem(Zelzal.."List:Rd:Sudo:mz", text)
return send(msg_chat_id,msg_id,"*⇜ ابشر مسحت الرد من الردود المميزه العامه*","md",true)  
end
end
if text and text ~= "مسح رد مميز عام" and text ~= "اضف رد مميز عام" and text ~= "مسح الردود المميزه العامه" and text ~= "الردود المميزه العامه" and not Redis:get(Zelzal.."Status:ReplySudo"..msg_chat_id) and not Redis:get(Zelzal.."tf:rmz:d"..msg.chat_id) then
if not Redis:sismember(Zelzal..'Spam:Group'..msg.sender_id.user_id,text) then
local listmz = Redis:smembers(Zelzal.."List:Rd:Sudo:mz")
for k,v in pairs(listmz) do
i ,j  = string.find(text, v)
if j and i then
local x = string.sub(text, i,j)
if x then
local anemi = Redis:get(Zelzal.."Add:Rd:Sudo:mz:Gif"..x)   
local veico = Redis:get(Zelzal.."Add:Rd:Sudo:mz:vico"..x)   
local stekr = Redis:get(Zelzal.."Add:Rd:Sudo:mz:stekr"..x)     
local Text = Redis:get(Zelzal.."Add:Rd:Sudo:mz:Text"..x)   
local photo = Redis:get(Zelzal.."Add:Rd:Sudo:mz:Photo"..x)
local photoc = Redis:get(Zelzal.."Add:Rd:Sudo:mz:Photoc"..x)
local video = Redis:get(Zelzal.."Add:Rd:Sudo:mz:Video"..x)
local videoc = Redis:get(Zelzal.."Add:Rd:Sudo:mz:Videoc"..x)
local document = Redis:get(Zelzal.."Add:Rd:Sudo:mz:File"..x)
local audio = Redis:get(Zelzal.."Add:Rd:Sudo:mz:Audio"..x)
local audioc = Redis:get(Zelzal.."Add:Rd:Sudo:mz:Audioc"..x)
local video_note = Redis:get(Zelzal.."Add:Rd:Sudo:mz:video_note"..x)
if Text then 
local UserInfo = bot.getUser(msg.sender_id.user_id)
local NumMsg = Redis:get(Zelzal..'Num:Message:User'..msg_chat_id..':'..msg.sender_id.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Zelzal..'Num:Message:Edit'..msg_chat_id..msg.sender_id.user_id) or 0
local Text = Text:gsub('{اليوزر}',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('{الاسم}',UserInfo.first_name)
local Text = Text:gsub('{الايدي}',msg.sender_id.user_id)
local Text = Text:gsub('{التعديل}',NumMessageEdit)
local Text = Text:gsub('{الرسائل}',NumMsg)
local Text = Text:gsub('{الرتبه}',Status_Gps)
send(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
bot.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if photo then
bot.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end  
if stekr then 
bot.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if veico then 
bot.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if video then 
bot.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if anemi then 
bot.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if document then
bot.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end  
if audio then
bot.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
end
end
end
end
end
if text == "اضف رد مميز عام" then 
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Set:Rd:mz"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ حلو ، الحين ارسل الكلمة اللي تبيها*","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد مميز عام" or text == "مسح رد مميز عام" then 
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Set:On:mz"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ تمام عيني  \n⇜ الحين ارسل الرد عشان امسحه \n✓*","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) then
Redis:del(Zelzal.."Spam:Group"..msg.sender_id.user_id) 
end
if text == "مسح الردود المميزه العامه" or text == "مسح الردود المميزه عام" then 
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."List:Rd:Sudo:mz")
for k,v in pairs(list) do
Redis:del(Zelzal.."Add:Rd:Sudo:mz:Gif"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:vico"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:stekr"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:Text"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:Photo"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:Photoc"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:Video"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:Videoc"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:File"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:Audio"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:Audioc"..v)
Redis:del(Zelzal.."Add:Rd:Sudo:mz:video_note"..v)
Redis:del(Zelzal.."List:Rd:Sudo:mz")
end
send(msg_chat_id,msg_id,"*⇜ ابشر مسحت قائمه الردود المميزه العامه*","md",true)  
end
if text == ("الردود المميزه العامه") then 
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."List:Rd:Sudo:mz")
text = "\n*⇜ قائمة الردود المميزه العامه*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
if Redis:get(Zelzal.."Add:Rd:Sudo:mz:Gif"..v) then
db = "متحركة"
elseif Redis:get(Zelzal.."Add:Rd:Sudo:mz:vico"..v) then
db = "فويس"
elseif Redis:get(Zelzal.."Add:Rd:Sudo:mz:stekr"..v) then
db = "ملصق"
elseif Redis:get(Zelzal.."Add:Rd:Sudo:mz:Text"..v) then
db = "رسالة"
elseif Redis:get(Zelzal.."Add:Rd:Sudo:mz:Photo"..v) then
db = "صورة"
elseif Redis:get(Zelzal.."Add:Rd:Sudo:mz:Video"..v) then
db = "فيديو"
elseif Redis:get(Zelzal.."Add:Rd:Sudo:mz:File"..v) then
db = "ملف"
elseif Redis:get(Zelzal.."Add:Rd:Sudo:mz:Audio"..v) then
db = "اغنية"
elseif Redis:get(Zelzal.."Add:Rd:Sudo:mz:video_note"..v) then
db = "بصمة فيديو"
end
text = text..""..k.." - ( "..v.." ) ࿓ ( "..db.." )\n"
end
if #list == 0 then
text = "*⇜ مافيه ردود مميزة عامة !*"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
-------رد مميز عام 
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender_id.user_id ~= Zelzal then
local test = Redis:get(Zelzal.."Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg_chat_id)
if Redis:get(Zelzal.."Set:Rdmzch"..msg.sender_id.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Zelzal.."Set:Rdmzch"..msg.sender_id.user_id..":"..msg_chat_id)
if msg.content.text then
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Zelzal.."Add:Rd:Sudomzch:Text"..test..msg.chat_id, text)  
elseif msg.content.sticker then
Redis:set(Zelzal.."Add:Rd:Sudomzch:stekr"..test..msg.chat_id, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(Zelzal.."Add:Rd:Sudomzch:vico"..test..msg.chat_id, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then
Redis:set(Zelzal.."Add:Rd:Sudomzch:Gif"..test..msg.chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(Zelzal.."Add:Rd:Sudomzch:Audio"..test..msg.chat_id, msg.content.audio.audio.remote.id)  
Redis:set(Zelzal.."Add:Rd:Sudomzch:Audioc"..test..msg.chat_id, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(Zelzal.."Add:Rd:Sudomzch:File"..test..msg.chat_id, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(Zelzal.."Add:Rd:Sudomzch:Video"..test..msg.chat_id, msg.content.video.video.remote.id)  
Redis:set(Zelzal.."Add:Rd:Sudomzch:Videoc"..test..msg.chat_id, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(Zelzal.."Add:Rd:Sudomzch:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal.."Add:Rd:Sudomzch:Photo"..test..msg.chat_id, idPhoto)  
Redis:set(Zelzal.."Add:Rd:Sudomzch:Photoc"..test..msg.chat_id, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"*「  *"..test.."*  」\nواضفنا الرد ياحلو 🌚\n✓*","md",true)
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:Rdmzch"..msg.sender_id.user_id..":"..msg_chat_id) == "true" then
Redis:set(Zelzal.."Set:Rdmzch"..msg.sender_id.user_id..":"..msg_chat_id, "true1")
Redis:set(Zelzal.."Text:Sudo:Bot"..msg.sender_id.user_id..":"..msg_chat_id, text)
Redis:sadd(Zelzal.."List:Rd:Sudomzch"..msg.chat_id, text)
send(msg_chat_id,msg_id,[[
*⇜ حلو , الحين ارسل جواب الرد*
*⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
 `{اليوزر}` *↬ يوزر المستخدم*
 `{الرسائل}` *↬ عدد الرسائل*
 `{الاسم}` *↬ اسم المستخدم*
 `{الايدي}` *↬ ايدي المستخدم*
 `{الرتبه}` *↬ رتبة المستخدم*
 `{التعديل}` *↬ عدد التعديلات*

*- اضغـط على الاختصـارات لـ النسـخ .*
]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:Onmzch"..msg.sender_id.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudomzch:video_note","Add:Rd:Sudomzch:Audio","Add:Rd:Sudomzch:Audioc","Add:Rd:Sudomzch:File","Add:Rd:Sudomzch:Video","Add:Rd:Sudomzch:Videoc","Add:Rd:Sudomzch:Photo","Add:Rd:Sudomzch:Photoc","Add:Rd:Sudomzch:Text","Add:Rd:Sudomzch:stekr","Add:Rd:Sudomzch:vico","Add:Rd:Sudomzch:Gif"}
for k,v in pairs(list) do
Redis:del(Zelzal..''..v..text..msg.chat_id)
end
Redis:del(Zelzal.."Set:Onmzch"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:srem(Zelzal.."List:Rd:Sudomzch"..msg.chat_id, text)
return send(msg_chat_id,msg_id,"*⇜ ابشر مسحت الرد من الردود المميزه*","md",true)  
end
end
if text and text ~= "مسح رد مميز" and text ~= "اضف رد مميز" and text ~= "مسح الردود المميزه" and text ~= "الردود المميزه" and not Redis:get(Zelzal.."Status:ReplySudo"..msg_chat_id) and not Redis:get(Zelzal.."tf:rmz:d"..msg.chat_id) then
if not Redis:sismember(Zelzal..'Spam:Group'..msg.sender_id.user_id,text) then
local listmz = Redis:smembers(Zelzal.."List:Rd:Sudomzch"..msg.chat_id)
for k,v in pairs(listmz) do
i ,j  = string.find(text, v)
if j and i then
local x = string.sub(text, i,j)
if x then
local anemi = Redis:get(Zelzal.."Add:Rd:Sudomzch:Gif"..x..msg.chat_id)   
local veico = Redis:get(Zelzal.."Add:Rd:Sudomzch:vico"..x..msg.chat_id)   
local stekr = Redis:get(Zelzal.."Add:Rd:Sudomzch:stekr"..x..msg.chat_id)     
local Text = Redis:get(Zelzal.."Add:Rd:Sudomzch:Text"..x..msg.chat_id)   
local photo = Redis:get(Zelzal.."Add:Rd:Sudomzch:Photo"..x..msg.chat_id)
local photoc = Redis:get(Zelzal.."Add:Rd:Sudomzch:Photoc"..x..msg.chat_id)
local video = Redis:get(Zelzal.."Add:Rd:Sudomzch:Video"..x..msg.chat_id)
local videoc = Redis:get(Zelzal.."Add:Rd:Sudomzch:Videoc"..x..msg.chat_id)
local document = Redis:get(Zelzal.."Add:Rd:Sudomzch:File"..x..msg.chat_id)
local audio = Redis:get(Zelzal.."Add:Rd:Sudomzch:Audio"..x..msg.chat_id)
local audioc = Redis:get(Zelzal.."Add:Rd:Sudomzch:Audioc"..x..msg.chat_id)
local video_note = Redis:get(Zelzal.."Add:Rd:Sudomzch:video_note"..x..msg.chat_id)
if Text then 
local UserInfo = bot.getUser(msg.sender_id.user_id)
local NumMsg = Redis:get(Zelzal..'Num:Message:User'..msg_chat_id..':'..msg.sender_id.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Zelzal..'Num:Message:Edit'..msg_chat_id..msg.sender_id.user_id) or 0
local Text = Text:gsub('{اليوزر}',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('{الاسم}',UserInfo.first_name)
local Text = Text:gsub('{الايدي}',msg.sender_id.user_id)
local Text = Text:gsub('{التعديل}',NumMessageEdit)
local Text = Text:gsub('{الرسائل}',NumMsg)
local Text = Text:gsub('{الرتبه}',Status_Gps)
send(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
bot.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if photo then
bot.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end  
if stekr then 
bot.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if veico then 
bot.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if video then 
bot.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if anemi then 
bot.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
if document then
bot.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end  
if audio then
bot.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) 
end
end
end
end
end
end
if text == "اضف رد مميز" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Set:Rdmzch"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ حلو ، الحين ارسل الكلمة اللي تبيها*","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد مميز" or text == "مسح رد مميز" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
Redis:set(Zelzal.."Set:Onmzch"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ تمام عيني  \n⇜ الحين ارسل الرد عشان امسحه \n✓*","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(Zelzal.."Spam:Group"..msg.sender_id.user_id,text) then
Redis:del(Zelzal.."Spam:Group"..msg.sender_id.user_id) 
end
if text == "مسح الردود المميزه" or text == "مسح الردود المميزة" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local list = Redis:smembers(Zelzal.."List:Rd:Sudomzch"..msg.chat_id)
for k,v in pairs(list) do
Redis:del(Zelzal.."Add:Rd:Sudomzch:Gif"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:vico"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:stekr"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:Text"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:Photo"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:Photoc"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:Video"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:Videoc"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:File"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:Audio"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:Audioc"..v..msg.chat_id)
Redis:del(Zelzal.."Add:Rd:Sudomzch:video_note"..v..msg.chat_id)
Redis:del(Zelzal.."List:Rd:Sudomzch"..msg.chat_id)
end
send(msg_chat_id,msg_id,"*⇜ ابشر مسحت قائمه الردود المميزه*","md",true)  
end
if text == ("الردود المميزه") then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local list = Redis:smembers(Zelzal.."List:Rd:Sudomzch"..msg.chat_id)
text = "\n*⇜ قائمة الردود المميزه*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
if Redis:get(Zelzal.."Add:Rd:Sudomzch:Gif"..v..msg.chat_id) then
db = "متحركة"
elseif Redis:get(Zelzal.."Add:Rd:Sudomzch:vico"..v..msg.chat_id) then
db = "فويس"
elseif Redis:get(Zelzal.."Add:Rd:Sudomzch:stekr"..v..msg.chat_id) then
db = "ملصق"
elseif Redis:get(Zelzal.."Add:Rd:Sudomzch:Text"..v..msg.chat_id) then
db = "رسالة"
elseif Redis:get(Zelzal.."Add:Rd:Sudomzch:Photo"..v..msg.chat_id) then
db = "صورة"
elseif Redis:get(Zelzal.."Add:Rd:Sudomzch:Video"..v..msg.chat_id) then
db = "فيديو"
elseif Redis:get(Zelzal.."Add:Rd:Sudomzch:File"..v..msg.chat_id) then
db = "ملف"
elseif Redis:get(Zelzal.."Add:Rd:Sudomzch:Audio"..v..msg.chat_id) then
db = "اغنية"
elseif Redis:get(Zelzal.."Add:Rd:Sudomzch:video_note"..v..msg.chat_id) then
db = "بصمة فيديو"
end
text = text..""..k.." - ( "..v.." ) ࿓ ( "..db.." )\n"
end
if #list == 0 then
text = "*⇜ مافيه ردود مميزة ! *"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
------------------------------------------------------------------------------------------------------------------------------------------------
if text and text:match('^يوزراته @(%S+)$') or text and text:match('^يوزرات @(%S+)$') then
local UseriName = text:match('^يوزراته @(%S+)$') or text:match('^يوزرات @(%S+)$')
local UserId_Info = bot.searchPublicChat(UseriName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local usernames = getuser(UserId_Info.id)
if type(LuaProjects) == "table" then
 usernames = LuaProjects
else
 usernames = {LuaProjects}
end
local Text = '*🛎 يوزرات الشخص المعروضه ع المـزاد هي:*\n'
if #usernames == 1 then
names_text = 'لا يوجد لديه اي يوزرات معروضه ع المزاد حبي'
else
for i, name in pairs(usernames) do
names_text = '@'.. name .. '\n'
end
end
send(msg_chat_id, msg_id, Text..names_text, 'md')
end
if text == 'يوزراته' and msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local usernames = getuser(Message_Reply.sender_id.user_id)
local Text = '*🛎 يوزرات الشخص المعروضه ع المـزاد هي:*\n'
if #usernames == 1 then
names_text = 'لا يوجد لديه اي يوزرات معروضه ع المزاد حبي'
else
for i, name in ipairs(usernames) do
names_text = '@'.. name .. '\n'
end
end
send(msg_chat_id, msg_id, Text..names_text, 'md')
end
if text == 'يوزراتي' then
local usernames = getuser(msg.sender_id.user_id)
local Text = '*🛎 يوزراتك المعروضه ع المـزاد هي:*\n'
if #usernames == 1 then
names_text = 'لا يوجد لديك اي يوزرات معروضه ع المزاد حبي'
else
for i, name in ipairs(usernames) do
names_text = '@'.. name .. '\n'
end
end
send(msg_chat_id, msg_id, Text..names_text, 'md')
end
if text == "تنظيف التعديل" or text == "مسح التعديل" or text == "امسحح" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
send(msg.chat_id,msg.id,"*⇜ اصبر ابحثلك عن الرسائل المعدله*","md",true)
msgid = (msg.id - (1048576*250))
y = 0
r = 1048576
for i=1,250 do
r = r + 1048576
Delmsg = bot.getMessage(msg.chat_id,msgid + r)
if Delmsg and Delmsg.edit_date and Delmsg.edit_date ~= 0 then
bot.deleteMessages(msg.chat_id,{[1]= Delmsg.id}) 
y = y + 1
end
end
if y == 0 then 
t = "*⇜ مالقيت رسائل معدله*"
else
t = "*⇜ ابشر مسحت ( "..y.." ) من الرسائل المعدلة*"
end
send(msg.chat_id,msg.id,t,"md",true)  
end
if (text == 'كشف' or text == 'ايدي' or text == 'ا') and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد يوزر'
end
local photo = bot.getUserProfilePhotos(Message_Reply.sender_id.user_id)
local UserId = Message_Reply.sender_id.user_id
local RinkBot = Controller(msg_chat_id,Message_Reply.sender_id.user_id)
local Likes = Redis:get(Zelzal..'Zilzal:Message:Like'..Message_Reply.sender_id.user_id) or 0
local TotalMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..Message_Reply.sender_id.user_id) or 0
local DayMsg = Redis:get(Zelzal..'msg:match:'..msg.chat_id..':'..Message_Reply.sender_id.user_id) or 0
DayMsg = math.floor(DayMsg) -- تقريب العدد لأقرب عدد صحيح أصغر منه
local TotalEdit = Redis:get(Zelzal..'Zelzal:Num:Message:Edit'..msg_chat_id..Message_Reply.sender_id.user_id) or 0
local TotalMsgT = Total_message(TotalMsg)
local StatusMember = bot.getChatMember(msg_chat_id,Message_Reply.sender_id.user_id)
if StatusMember.status.custom_title ~= "" then
Lakb = StatusMember.status.custom_title
else
Lakb = 'مشرف'
end
if (StatusMember.status.luatele == "chatMemberStatusCreator") then
Lakb = 'مالك القروب' 
elseif (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
Lakb = 'مشرف'  
else
Lakb = 'لايوجـد 🎗'
end
return send(msg_chat_id,msg_id,
'\n*✦ الاسـم ⇜ '..UserInfo.first_name..
'\n✦ الايـدي ⇜* `'..UserId..'`'..
'\n*✦ اليـوزر ⇜ '..UserInfousername..
'\n✦ الرتبـه ⇜ '..RinkBot..
'\n✦ اللقـب ⇜ '..Lakb..
'\n✦ الرسـائل ⇜ '..TotalMsg..
'\n✦ رسائله اليوم ⇜ '..DayMsg..
'\n✦ السحكـات ⇜ '..TotalEdit..
'\n✦ الإعجـابات ⇜ '..Likes..'♥️'..
'\n✦ البايـو ⇜ '..FlterBio(getbio(UserId))..'*'..
'\n*✦ نـوع الكشـف ⇜ بالـرد\n༄*',"md",true) 
end
-----------------
if text and text:match('^كشف (%d+)$') then
local UserId = text:match('^كشف (%d+)$')
local UserInfo = bot.getUser(UserId)
if UserInfo.username then
UserName = '@'..UserInfo.username..''
else
UserName = 'لا يوجد يوزر'
end
local Name_User = UserInfo.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local Likes = Redis:get(Zelzal..'Zilzal:Message:Like'..UserId) or 0
local TotalMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..UserId) or 0
local DayMsg = Redis:get(Zelzal..'msg:match:'..msg.chat_id..':'..UserId) or 0
DayMsg = math.floor(DayMsg) -- تقريب العدد لأقرب عدد صحيح أصغر منه
local TotalEdit = Redis:get(Zelzal..'Zelzal:Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg)
local StatusMember = bot.getChatMember(msg_chat_id,UserId)
if StatusMember.status.custom_title ~= "" then
Lakb = StatusMember.status.custom_title
else
Lakb = 'مشرف'
end
if (StatusMember.status.luatele == "chatMemberStatusCreator") then
Lakb = 'مالك القروب' 
elseif (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
Lakb = 'مشرف'  
else
Lakb = 'لايوجـد 🎗'
end
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً الايدي خطأ ","md",true)  
end 
return send(msg_chat_id,msg_id,
'*✦ الاسـم ⇜ '..Name_User..
'\n✦ الايـدي ⇜ '..UserId..
'\n✦ اليـوزر ⇜ '..UserName..
'\n✦ الرتبـه ⇜ '..RinkBot..
'\n✦ اللقـب ⇜ '..Lakb..
'\n✦ الرسـائل ⇜ '..TotalMsg..
'\n✦ رسائله اليوم ⇜ '..DayMsg..
'\n✦ السحكـات ⇜ '..TotalEdit..
'\n✦ الإعجـابات ⇜ '..Likes..'♥️'..
'\n✦ البايـو ⇜ '..FlterBio(getbio(UserId))..'*'..
'\n*✦ نـوع الكشـف ⇜ بالايـدي\n༄*',"md",true) 
end
-----------------
if text and text:match('^ايدي @(%S+)$') or text and text:match('^كشف @(%S+)$') then
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local U = bot.getUser(UserId_Info.id)
local Name_User = U.first_name 
local UserId = UserId_Info.id
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local Likes = Redis:get(Zelzal..'Zilzal:Message:Like'..UserId_Info.id) or 0
local TotalMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..UserId_Info.id) or 0
local TotalEdit = Redis:get(Zelzal..'Zelzal:Num:Message:Edit'..msg_chat_id..UserId_Info.id) or 0
local TotalMsgT = Total_message(TotalMsg)
local StatusMember = bot.getChatMember(msg_chat_id,UserId_Info.id)
if StatusMember.status.custom_title ~= "" then
Lakb = StatusMember.status.custom_title
else
Lakb = 'مشرف'
end
if (StatusMember.status.luatele == "chatMemberStatusCreator") then
Lakb = 'مالك القروب' 
elseif (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
Lakb = 'مشرف'  
else
Lakb = 'لايوجـد 🎗'
end
return send(msg_chat_id,msg_id,
'\n*✦ الاسـم ⇜ '..Name_User..
'\n✦ الايـدي ⇜ '..UserId..
'\n✦ اليـوزر ⇜ @'..UserName..
'\n✦ الرتبـه ⇜ '..RinkBot..
'\n✦ اللقـب ⇜ '..Lakb..
'\n✦ الرسـائل ⇜ '..TotalMsg..
'\n✦ السحكـات ⇜ '..TotalEdit..
'\n✦ الإعجـابات ⇜ '..Likes..'♥️'..
'\n✦ البايـو ⇜ '..FlterBio(getbio(UserId_Info.id))..'*'..
'\n*✦ نـوع الكشـف ⇜ بالمعـرف\n༄*',"md",true) 
end
if text == 'رتبتي' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك اساسي'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف'
else
StatusMemberChat = 'عضو'
end
local Tahses = Redis:get(Zelzal..'Zelzal:SetLkb'..msg_chat_id..':'..msg.sender_id.user_id) or StatusMemberChat
return send(msg_chat_id,msg_id,'\n*- رتبتك في البوت ↤* '..msg.Name_Controller..'\n*- رتبتك في القروب ↤* '..StatusMemberChat..'',"md",true)  
end
if text == 'معلوماتي' or text == 'موقعي' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك اساسي'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف'
else
StatusMemberChat = 'عضو'
end
local UserId = msg.sender_id.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..msg.sender_id.user_id) or 0
local DayMsg = Redis:get(Zelzal..'msg:match:'..msg.chat_id..':'..msg.sender_id.user_id) or 0
local TotalEdit = Redis:get(Zelzal..'Zelzal:Num:Message:Edit'..msg_chat_id..msg.sender_id.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد يوزر'
end
if StatusMemberChat == 'مشرف' then 
local GetMemberStatus = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '\n*⇜ صلاحياتك :*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..'\n*⇜ تغيير المعلومات :* '..change_info..'\n*⇜ تثبيت الرسائل :* '..pin_messages..'\n*⇜ اضافه مستخدمين :* '..invite_users..'\n*⇜ مسح الرسائل :* '..delete_messages..'\n*⇜ حظر المستخدمين :* '..restrict_members..'\n*⇜ اضافه المشرفين :* '..promote..'\n\n'
end
return send(msg_chat_id,msg_id,
'\n*• اسمـك ⇜ '..UserInfo.first_name..
'\n• ايـديك ⇜ '..UserId..
'\n• يـوزرك ⇜ '..UserInfousername..
'\n• رتبتـك ⇜ '..RinkBot..
'\n• رتبـه المجموعـه ⇜ '..StatusMemberChat..
'\n• رسـائلك ⇜ '..TotalMsg..
'\n• رسـائلك اليـوم ⇜ '..DayMsg..
'\n• سحكـاتك ⇜ '..TotalEdit..
'\n• تفـاعلك ⇜ '..TotalMsgT..
'*'..(PermissionsUser or '') ,"md",true) 
end
if text == 'لقبي' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id)
if StatusMember.status.custom_title ~= "" then
Lakb = StatusMember.status.custom_title
else
Lakb = 'مشرف'
end
local Tahses = Redis:get(Zelzal..'Zelzal:SetLkb'..msg_chat_id..':'..msg.sender_id.user_id) or Lakb
if (StatusMember.status.luatele == "chatMemberStatusCreator") then
return send(msg_chat_id,msg_id,'\n*- لقبك ↤ '..Lakb..'*',"md",true)  
elseif (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,'\n*- لقبك ↤ '..Lakb..'*',"md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ انت عضو بالقروب*',"md",true)  
end
end
if text == 'لقبه' and msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local StatusMember = bot.getChatMember(msg_chat_id,Message_Reply.sender_id.user_id)
if StatusMember.status.custom_title ~= "" then
Lakb = StatusMember.status.custom_title
else
Lakb = 'مشرف'
end
local Tahses = Redis:get(Zelzal..'Zelzal:SetLkb'..msg_chat_id..':'..Message_Reply.sender_id.user_id) or Lakb
if (StatusMember.status.luatele == "chatMemberStatusCreator") then
return send(msg_chat_id,msg_id,'\n*- لقبـه ↤ '..Lakb..'*',"md",true)  
elseif (StatusMember.status.luatele == "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,'\n*- لقبـه ↤ '..Lakb..'*',"md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ لقبه عضو بالقروب*',"md",true)  
end
end
if text == "تفاعلي" then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local TotalMsg = Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..msg.sender_id.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
return send(msg_chat_id,msg_id,'\n*⇜ تفاعلك ↤ '..TotalMsgT..'*',"md",true)  
end
if text == 'فحص البوت' or text == 'كشف البوت' or text == 'صلاحيات البوت' then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local StatusMember = bot.getChatMember(msg_chat_id,Zelzal).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,'⇜ البوت عضو في القروب ',"md",true) 
end
local GetMemberStatus = bot.getChatMember(msg_chat_id,Zelzal).status
if GetMemberStatus.can_change_info then
change_info = 'نعم' else change_info = 'لا'
end
if GetMemberStatus.can_delete_messages then
delete_messages = 'نعم' else delete_messages = 'لا'
end
if GetMemberStatus.can_invite_users then
invite_users = 'نعم' else invite_users = 'لا'
end
if GetMemberStatus.can_pin_messages then
pin_messages = 'نعم' else pin_messages = 'لا'
end
if GetMemberStatus.can_restrict_members then
restrict_members = 'نعم' else restrict_members = 'لا'
end
if GetMemberStatus.can_promote_members then
promote = 'نعم' else promote = 'لا'
end
PermissionsUser = '\n*⇜ صلاحيات البوت : مشرف في القروب :*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..'\n*⇜ تغيير المعلومات :* '..change_info..'\n*⇜ تثبيت الرسائل :* '..pin_messages..'\n*⇜ اضافه مستخدمين :* '..invite_users..'\n*⇜ مسح الرسائل :* '..delete_messages..'\n*⇜ حظر المستخدمين :* '..restrict_members..'\n*⇜ اضافه المشرفين :* '..promote..'\n\n'
return send(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local GetMemberStatus = bot.getChatMember(msg_chat_id,Message_Reply.sender_id.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender_id.user_id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(Zelzal.."Zelzal:BanAll:Groups",Message_Reply.sender_id.user_id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender_id.user_id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender_id.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
else
SilentGroup = ''
end
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,"\n*⇜ ابشر رفعت القيود عنه*\n( "..BanAll..BanGroup..SilentGroup..Restricted..' )\n ✓',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local GetMemberStatus = bot.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(Zelzal.."Zelzal:BanAll:Groups",UserId_Info.id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,"\n*⇜ ابشر رفعت القيود عنه *\n( "..BanAll..BanGroup..SilentGroup..Restricted..' )\n ✓',"md",true)  
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",Message_Reply.sender_id.user_id) then
devQ = "المطور الثانوي🎖️ ، " 
else 
devQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",Message_Reply.sender_id.user_id) then
mevQ = "المطوره الثانويه🎖️ ، " 
else 
mevQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:Developers:Groups",Message_Reply.sender_id.user_id) then
dev = "مطور ، " 
else 
dev = "" 
end
if Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",Message_Reply.sender_id.user_id) then
mev = "مطوره ، " 
else 
mev = "" 
end
if Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
cc = "مالك اساسي ،" 
else
cc = "" 
end
if Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
ccc = "مالكه اساسيه ،" 
else
ccc = "" 
end
if Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
crrQ = "المالك ، " 
else 
crrQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
mrrQ = "المالكه ، " 
else 
mrrQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
crr = "منشئ اساسي ، " 
else 
crr = "" 
end
if Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
mrr = "منشئه اساسيه ، " 
else 
mrr = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Originators:Group'..msg_chat_id, Message_Reply.sender_id.user_id) then
cr = "منشئ ، " 
else 
cr = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Origimators:Group'..msg_chat_id, Message_Reply.sender_id.user_id) then
mr = "منشئه ، " 
else 
mr = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Managers:Group'..msg_chat_id, Message_Reply.sender_id.user_id) then
own = "مدير ، " 
else 
own = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Mamagers:Group'..msg_chat_id, Message_Reply.sender_id.user_id) then
omn = "مديره ، " 
else 
omn = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Addictive:Group'..msg_chat_id, Message_Reply.sender_id.user_id) then
mod = "ادمن ، " 
else 
mod = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Mddictive:Group'..msg_chat_id, Message_Reply.sender_id.user_id) then
mmd = "ادمونه ، " 
else 
mmd = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Distinguished:Group'..msg_chat_id, Message_Reply.sender_id.user_id) then
vip = "مميز ، " 
else 
vip = ""
end
if Redis:sismember(Zelzal..'Zelzal:Mistinguished:Group'..msg_chat_id, Message_Reply.sender_id.user_id) then
mip = "مميزه ، " 
else 
mip = ""
end
if The_ControllerAll(Message_Reply.sender_id.user_id) == true then
Rink = 1
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",Message_Reply.sender_id.user_id)  then
Rink = 2
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",Message_Reply.sender_id.user_id)  then
Rink = 3
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
Rink = 3.5
elseif Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
Rink = 4
elseif Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
Rink = 5
elseif Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
Rink = 6
elseif Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
Rink = 7
elseif Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
Rink = 8
elseif Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id) or Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id) then
Rink = 9
else
Rink = 10
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender_id.user_id) == false then
return send(msg_chat_id,msg_id,"\n*⇜ ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:DevelopersQ:Groups",Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Developers:Groups",Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:MevelopersQ:Groups",Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mevelopers:Groups",Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
elseif msg.DevelopersQ or msg.MevelopersQ then
if Rink == 2 or Rink < 2 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Developers:Groups",Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mevelopers:Groups",Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
elseif msg.Developers or msg.Mevelopers then
if Rink == 3 or Rink < 3 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
elseif msg.MalekAsase or msg.MalemAsase then
if Rink == 3.5 or Rink < 3.5 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
elseif msg.TheBasicsQ or msg.TheMasicsQ then
if Rink == 4 or Rink < 4 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
elseif msg.TheBasics or msg.TheMasics then
if Rink == 5 or Rink < 5 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
elseif msg.Originators or msg.Origimators then
if Rink == 6 or Rink < 6 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
elseif msg.Managers or msg.Mamagers then
if Rink == 7 or Rink < 7 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
elseif msg.Addictive or msg.Mddictive then
if Rink == 8 or Rink < 8 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, Message_Reply.sender_id.user_id)
end
return send(msg_chat_id,msg_id,"\n*⇜ تم تنزيله من الرتب التاليه *( "..devQ..""..mevQ..""..dev..""..mev..""..cc..""..ccc..""..crrQ..""..mrrQ..""..crr..""..mrr..""..cr..""..mr..""..own..""..omn..""..mod..""..mmd..""..vip..""..mip.." )","md",true)  
end
if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId_Info.id) then
devQ = "المطور الثانوي ،" 
else 
devQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId_Info.id) then
mevQ = "المطوره الثانويه ،" 
else 
mevQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId_Info.id) then
dev = "المطور ،" 
else 
dev = "" 
end
if Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId_Info.id) then
mev = "المطوره ،" 
else 
mev = "" 
end
if Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, UserId_Info.id) then
ccQ = "مالك اساسي ،" 
else 
ccQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, UserId_Info.id) then
ccc = "مالكه اساسيه ،" 
else 
ccc = "" 
end
if Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, UserId_Info.id) then
crrQ = "المالك ،" 
else 
crrQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, UserId_Info.id) then
mrrQ = "المالكه ،" 
else 
mrrQ = "" 
end
if Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي ،" 
else 
crr = "" 
end
if Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, UserId_Info.id) then
mrr = "منشئه اساسيه ،" 
else 
mrr = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Originators:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ ،" 
else 
cr = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Origimators:Group'..msg_chat_id, UserId_Info.id) then
mr = "منشئه ،" 
else 
mr = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Managers:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير ،" 
else 
own = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Mamagers:Group'..msg_chat_id, UserId_Info.id) then
mwn = "مديره ،" 
else 
mwn = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Addictive:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن ،" 
else 
mod = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Mddictive:Group'..msg_chat_id, UserId_Info.id) then
mmd = "ادمونه ،" 
else 
mmd = "" 
end
if Redis:sismember(Zelzal..'Zelzal:Distinguished:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز ،" 
else 
vip = ""
end
if Redis:sismember(Zelzal..'Zelzal:Mistinguished:Group'..msg_chat_id, UserId_Info.id) then
mip = "مميزه ،" 
else 
mip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif Redis:sismember(Zelzal.."Zelzal:DevelopersQ:Groups",UserId_Info.id) or Redis:sismember(Zelzal.."Zelzal:MevelopersQ:Groups",UserId_Info.id) then
Rink = 2
elseif Redis:sismember(Zelzal.."Zelzal:Developers:Groups",UserId_Info.id)  or Redis:sismember(Zelzal.."Zelzal:Mevelopers:Groups",UserId_Info.id) then
Rink = 3
elseif Redis:sismember(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, UserId_Info.id) or Redis:sismember(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, UserId_Info.id) then
Rink = 3.5
elseif Redis:sismember(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, UserId_Info.id) or Redis:sismember(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif Redis:sismember(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, UserId_Info.id) or Redis:sismember(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif Redis:sismember(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, UserId_Info.id) or Redis:sismember(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif Redis:sismember(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, UserId_Info.id) or Redis:sismember(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
elseif Redis:sismember(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id) or Redis:sismember(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id) then
Rink = 8
elseif Redis:sismember(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id) or Redis:sismember(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id) then
Rink = 9
else
Rink = 10
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return send(msg_chat_id,msg_id,"\n*⇜ ليس لديه اي رتبه*","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:DevelopersQ:Groups",UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Developers:Groups",UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:MevelopersQ:Groups",UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mevelopers:Groups",UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.DevelopersQ or msg.MevelopersQ then
if Rink == 2 or Rink < 2 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Developers:Groups",UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mevelopers:Groups",UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Developers or msg.Mevelopers then
if Rink == 3 or Rink < 3 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.MalekAsase or msg.MalemAsase then
if Rink == 3.5 or Rink < 3.5 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.TheBasicsQ or msg.TheMasicsQ then
if Rink == 4 or Rink < 4 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.TheBasics or msg.TheMasics then
if Rink == 5 or Rink < 5 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Originators or msg.Origimators then
if Rink == 6 or Rink < 6 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Managers or msg.Mamagers then
if Rink == 7 or Rink < 7 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Addictive or msg.Mddictive then
if Rink == 8 or Rink < 8 then
return send(msg_chat_id,msg_id,"\n*⇜ لايمكنـك تنزيـل رتبـه نفـس او اعلـى مـن رتبتـك*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id, UserId_Info.id)
end
return send(msg_chat_id,msg_id,"\n*⇜ تم تنزيله من الرتب التالية* ( "..devQ..""..mevQ..""..dev..""..mev..""..ccQ..""..ccc..""..crrQ..""..mrrQ..""..crr..""..mrr..""..cr..""..mr..""..own..""..mwn..""..mod..""..mmd..""..vip..""..mip.." )","md",true)  
end
if text and text:match('^مسح (%d+)$') then
local NumMessage = text:match('^مسح (%d+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه مسح الرسائل ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return send(msg_chat_id,msg_id,'\n⇜ لا تستطيع مسح اكثر من 1000 رسالة',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = bot.deleteMessages(msg.chat_id,{[1]= Message})
var(deleteMessages)
Message = Message - 1048576
end
send(msg_chat_id, msg_id, "*⇜ تم مسح "..NumMessage.. ' رسالة 🗑*', 'md')
end
if (text == '.ازعاج' or text == '،ازعاج' or text == '-ازعاج' or text == '.تقليد' or text == '،تقليد' or text == '-تقليد') and msg.reply_to_message_id ~= 0 then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
testmod = true
elseif msg.Developers or msg.Mevelopers then
testmod = true
else
testmod = false
end
if testmod == false then
local Tk_group = Redis:get(Zelzal.."Zelzal:Lock:Takleed"..msg_chat_id)
if Tk_group == "ktm" then
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg.chat_id,msg.sender_id.user_id) 
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
if Redis:get(Zelzal..'Zelzal:AlThther:Chat'..msg.chat_id)  then
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ هييهه「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,msg_id,Teext..'⇜ مايمديك تستخدم التقليد هنا🚷\n⇜ تم كتمك .. بنجاح ☑️',"md")
end
end
end
end
if text == '.تفليش' or text == '،تفليش' or text == '-تفليش' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusAdministrator") then
testmod = false
else
testmod = true
end
if testmod == false then
if not Redis:get(Zelzal.."spammkick"..msg_chat_id) then 
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,0,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,0,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين*',"md",true)  
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local SetAdmin = bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,0,"\n*⇜ لست انا من قام برفعه مشرف*","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,0,"\n*⇜ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
local Teext = '⇜ مشرف خاين「 ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..') 」\n'
return send(msg_chat_id,0,Teext..'⇜ قام بمحاولة تفليش فاشلـه 🚷\n⇜ تم تنزيلـه مـن الاشـراف .. بنجاح ☑️',"md")
end
end
end
if (text == 'رفع مشرف بكل الصلاحيات' or text == 'رفع مشرف كامل الصلاحيات' or text == 'رفع مشرف بكامل الصلاحيات' or text == 'رفع مشرف كامل الصلاحيه') and msg.reply_to_message_id ~= 0 then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك الاسـاسي )*',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين*',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg.chat_id .. "&user_id=" ..Message_Reply.sender_id.user_id.."&&can_manage_voice_chats=true&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
return send(msg_chat_id, msg_id, "*⇜ تم رفعه مشرف بكافة الصلاحيات ✅*", 'md')
end
if text and text:match('^رفع مشرف بكل الصلاحيات @(%S+)$') or text and text:match('^رفع مشرف كامل الصلاحيات @(%S+)$') then
local UserName = text:match('^رفع مشرف بكل الصلاحيات @(%S+)$') or text:match('^رفع مشرف كامل الصلاحيات @(%S+)$')
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك الاسـاسي )*',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين*',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg.chat_id .. "&user_id=" ..UserId_Info.id.."&&can_manage_voice_chats=true&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
return send(msg_chat_id, msg_id, "*⇜ تم رفعه مشرف بكافة الصلاحيات ✅*", 'md')
end
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك الاسـاسي )*',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين*',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
local SetAdmin = bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n⇜ لا يمكنني رفعه ليس لدي صلاحيات ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg.chat_id .. "&user_id=" ..Message_Reply.sender_id.user_id.."&&can_manage_voice_chats=true&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_pin_messages=True")
return send(msg_chat_id, msg_id, "*⇜ تم رفعه مشرف .. بنجاح ✅*", 'md')
end 
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.MalekAsase or msg.MalemAsase then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك الاسـاسي )*',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين*',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local SetAdmin = bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n⇜ لا يمكنني رفعه ليس لدي صلاحيات ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg.chat_id .. "&user_id=" ..UserId_Info.id.."&&can_manage_voice_chats=true&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_pin_messages=True")
return send(msg_chat_id, msg_id, "*⇜ تم رفعه مشرف .. بنجاح ✅*", 'md')
end
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.MalekAsase or not msg.MalemAsase then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك الاسـاسي )*',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين*',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
local SetAdmin = bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,msg_id,"\n*⇜ لست انا من قام برفعه مشرف*","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*⇜ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.MalekAsase or not msg.MalemAsase then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( المـالك الاسـاسي )*',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين*',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local SetAdmin = bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,msg_id,"\n*⇜ لست انا من قام برفعه مشرف *","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*⇜ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == ('رفع مالك اساسي') and msg.reply_to_message_id ~= 0 then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه وتفعيل الصلاحيات له*","md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:sadd(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته مالك اساسي ").Reply,"md",true)  
end
if text and text:match('^رفع مالك اساسي @(%S+)$') then
local UserName = text:match('^رفع مالك اساسي @(%S+)$')
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه وتفعيل الصلاحيات له*","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
Redis:sadd(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته مالك اساسي ").Reply,"md",true)  
end 
if text == ('تنزيل مالك اساسي') and msg.reply_to_message_id ~= 0 then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه وتفعيل الصلاحيات له*","md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيله مالك اساسي ").Reply,"md",true)  
end
if text and text:match('^تنزيل مالك اساسي @(%S+)$') then
local UserName = text:match('^تنزيل مالك اساسي @(%S+)$')
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه وتفعيل الصلاحيات له*","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ تم تنزيله مالك اساسي ").Reply,"md",true)  
end 
if text == 'المالكين الاساسيين' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مالكين اساسيين , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المالكين الاساسيين *\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
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
data = {{{text = '- مسح المالكين الاساسيين', data = msg.sender_id.user_id..'/MalekAsase'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'مسح المالكين الاساسيين' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
local Info_Memberss = Redis:smembers(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id) 
if #Info_Memberss == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مالكين اساسيين , *","md",true)  
end
Redis:del(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id) 
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id,v.member_id.user_id) 
end
end
end
return send(msg_chat_id,msg_id,"*⇜ تم مسح ( "..#Info_Memberss.." ) من المالكين الاساسيين *","md",true)
end
if text == ('رفع مالكه اساسيه') and msg.reply_to_message_id ~= 0 then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n⇜ عذراً البوت ليس ادمن في القروب يرجى رفعها وتفعيل الصلاحيات له ","md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:sadd(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته مالكه اساسيه ").Reply,"md",true)  
end
if text and text:match('^رفع مالكه اساسيه @(%S+)$') then
local UserName = text:match('^رفع مالكه اساسيه @(%S+)$')
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n⇜ عذراً البوت ليس ادمن في القروب يرجى رفعها وتفعيل الصلاحيات له ","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
Redis:sadd(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته مالكه اساسيه ").Reply,"md",true)  
end 
if text == ('تنزيل مالكه اساسيه') and msg.reply_to_message_id ~= 0 then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n⇜ عذراً البوت ليس ادمن في القروب يرجى رفعها وتفعيل الصلاحيات له ","md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم تنزيلها مالكه اساسيه ").Reply,"md",true)  
end
if text and text:match('^تنزيل مالكه اساسيه @(%S+)$') then
local UserName = text:match('^تنزيل مالكه اساسيه @(%S+)$')
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n⇜ عذراً البوت ليس ادمن في القروب يرجى رفعها وتفعيل الصلاحيات له ","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ تم تنزيلها مالكه اساسيه ").Reply,"md",true)  
end 
if text == 'المالكات الاساسيات' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مالكات اساسيات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة المالكات الاساسيات *\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
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
data = {{{text = '- مسح المالكات الاساسيات', data = msg.sender_id.user_id..'/MalemAsase'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'مسح المالكات الاساسيات' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.Developers or msg.Mevelopers then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) فقـط*',"md",true)
end
local Info_Memberss = Redis:smembers(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id) 
if #Info_Memberss == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مالكات اساسيات , *","md",true)  
end
Redis:del(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id) 
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id,v.member_id.user_id) 
end
end
end
return send(msg_chat_id,msg_id,"*⇜ تم مسح ( "..#Info_Memberss.." ) من المالكات الاساسيات *","md",true)
end
if text == ('رفع مدير عام') and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:sadd(Zelzal.."Zelzal:Distinguishedall:Group",Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر رفعته مدير عام ").Reply,"md",true)  
end
if text and text:match('^رفع مدير عام @(%S+)$') then
local UserName = text:match('^رفع مدير عام @(%S+)$')
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
Redis:sadd(Zelzal.."Zelzal:Distinguishedall:Group",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر رفعته مدير عام ").Reply,"md",true)  
end 
if text == ('تنزيل مدير عام') and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Distinguishedall:Group",Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر نزلته مدير عام ").Reply,"md",true)  
end
if text and text:match('^تنزيل مدير عام @(%S+)$') then
local UserName = text:match('^تنزيل مدير عام @(%S+)$')
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
Redis:srem(Zelzal.."Zelzal:Distinguishedall:Group",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر نزلته مدير عام ").Reply,"md",true)  
end 
-----------------------------------------------------------------------------
if text == ('حذف تقييم') and msg.reply_to_message_id ~= 0 then
if tonumber(msg.sender_id.user_id) == tonumber(1895219306) or tonumber(msg.sender_id.user_id) == tonumber(925972505) or tonumber(msg.sender_id.user_id) == tonumber(5280339206) then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:srem(Zelzal.."List_Stars",Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم حذفـه من قائمـة التقييـم ").Reply,"md",true)  
end
end
if text and text:match('^حذف تقييم @(%S+)$') then
local UserName = text:match('^حذف تقييم @(%S+)$')
if tonumber(msg.sender_id.user_id) == tonumber(1895219306) or tonumber(msg.sender_id.user_id) == tonumber(925972505) or tonumber(msg.sender_id.user_id) == tonumber(5280339206) then
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه وتفعيل الصلاحيات له*","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
Redis:srem(Zelzal.."List_Stars",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ تم حذفـه من قائمـة التقييـم ").Reply,"md",true)  
end
end
if text and text:match("^تغيير رد المطور (.*)$") then
local Teext = text:match("^تغيير رد المطور (.*)$") 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Developer:Bot:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"⇜ تم تغيير رد المطور الى : "..Teext)
elseif text and text:match("^تغيير رد المالك الاساسي (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Teext = text:match("^تغيير رد المالك الاساسي (.*)$") 
Redis:set(Zelzal.."Zelzal:PresidentQQ:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"⇜  تم تغيير رد المالك الاساسي الى : "..Teext)
elseif text and text:match("^تغيير رد المنشئ الاساسي (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
elseif text and text:match("^تغيير رد المالك (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Teext = text:match("^تغيير رد المالك (.*)$") 
Redis:set(Zelzal.."Zelzal:PresidentQ:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"⇜  تم تغيير رد المالك الى : "..Teext)
elseif text and text:match("^تغيير رد المنشئ الاساسي (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ الاساسي (.*)$") 
Redis:set(Zelzal.."Zelzal:President:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"⇜ تم تغيير رد المنشئ الاساسي الى "..Teext)
elseif text and text:match("^تغيير رد المنشئ (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ (.*)$") 
Redis:set(Zelzal.."Zelzal:Constructor:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"⇜ تم تغيير رد المنشئ الى : "..Teext)
elseif text and text:match("^تغيير رد المدير (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Teext = text:match("^تغيير رد المدير (.*)$") 
Redis:set(Zelzal.."Zelzal:Manager:Group:Reply"..msg.chat_id,Teext) 
return send(msg_chat_id,msg_id,"⇜ تم تغيير رد المدير الى : "..Teext)
elseif text and text:match("^تغيير رد الادمن (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Teext = text:match("^تغيير رد الادمن (.*)$") 
Redis:set(Zelzal.."Zelzal:Admin:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"⇜ تم تغيير رد الادمن الى : "..Teext)
elseif text and text:match("^تغيير رد المميز (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Teext = text:match("^تغيير رد المميز (.*)$") 
Redis:set(Zelzal.."Zelzal:Vip:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"⇜ تم تغيير رد المميز الى : "..Teext)
elseif text and text:match("^تغيير رد العضو (.*)$") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Teext = text:match("^تغيير رد العضو (.*)$") 
Redis:set(Zelzal.."Zelzal:Mempar:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"⇜ تم تغيير رد العضو الى : "..Teext)
elseif text == 'مسح رد المطور' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Developer:Bot:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"⇜ تم مسح رد المطور")
elseif text == 'مسح رد المالك الاساسي' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:PresidentQQ:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"⇜ تم مسح رد المالك الاساسي")
elseif text == 'مسح رد المالك' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:PresidentQ:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"⇜ تم مسح رد المالك ")
elseif text == 'مسح رد المنشئ الاساسي' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:President:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"⇜ تم مسح رد المنشئ الاساسي ")
elseif text == 'مسح رد المنشئ' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Constructor:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"⇜ تم مسح رد المنشئ ")
elseif text == 'مسح رد المدير' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Manager:Group:Reply"..msg.chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح رد المدير ")
elseif text == 'مسح رد الادمن' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Admin:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"⇜ تم مسح رد الادمن ")
elseif text == 'مسح رد المميز' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Vip:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"⇜ تم مسح رد المميز")
elseif text == 'مسح رد العضو' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Mempar:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"⇜ تم مسح رد العضو")
end 
----- ردود رفـع لقب اي شي خاص بسـورس زلــزال -----
if text and text:match('^ررفع (.*)$') and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match('^ررفع (.*)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n* هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
return send(msg_chat_id,msg_id,"*⇜ التسليـه معطلـه من قبـل المـدراء*","md",true)
end
if TextMsg == "مطور ثانوي" or TextMsg == "مطور" or TextMsg == "مالك" or TextMsg == "منشئ اساسي" or TextMsg == "منشئ" or TextMsg == "مدير" or TextMsg == "ادمن" or TextMsg == "مميز" or TextMsg == "مطوره ثانويه" or TextMsg == "مطوره" or TextMsg == "مالكه" or TextMsg == "منشئه اساسيه" or TextMsg == "منشئه" or TextMsg == "مديره" or TextMsg == "ادمونه" or TextMsg == "مميزه" then
return
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
Redis:set(Zelzal..'Zelzal:SetLkb'..msg_chat_id..':'..Message_Reply.sender_id.user_id,text:match('^ررفع (.*)$'))
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜  تـم رفعـه  "..text:match('^ررفع (.*)$')," .. بنجـاح ✓").Reply,"md",true)
end
if text and text:match('^تنززيل (.*)$') and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match('^تنززيل (.*)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,"\n* هـذا الامـر يخـص* ( "..Controller_Num(7).." ) ","md",true)  
end
if Redis:get(Zelzal.."amrthshesh"..msg.chat_id) then
return send(msg_chat_id,msg_id,"*⇜ التسليـه معطلـه من قبـل المـدراء*","md",true)
end
if TextMsg == "مطور ثانوي" or TextMsg == "مطور" or TextMsg == "مالك" or TextMsg == "منشئ اساسي" or TextMsg == "منشئ" or TextMsg == "مدير" or TextMsg == "ادمن" or TextMsg == "مميز" or TextMsg == "مطوره ثانويه" or TextMsg == "مطوره" or TextMsg == "مالكه" or TextMsg == "منشئه اساسيه" or TextMsg == "منشئه" or TextMsg == "مديره" or TextMsg == "ادمونه" or TextMsg == "مميزه" then
return
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
Redis:del(Zelzal..'Zelzal:SetLkb'..msg_chat_id..':'..Message_Reply.sender_id.user_id,text:match('^تنززيل (.*)$'))
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜  تـم تنزيلـه  "..text:match('^تنززيل (.*)$')," .. بنجـاح ✓").Reply,"md",true)
end
----- ردود رفـع لقب اي شي خاص بسـورس زلــزال -----
if text == 'تاك ايموجي' or text == 'منشن ايموجي' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info = bot.searchChatMembers(msg.chat_id, "*", 100)
local members = Info.members
ls = '\n\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆* \n'
for k, v in pairs(members) do
local Textingt = {"❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😙", "😚", "😋", "😛", "😝", "😜", "🤪", "🤨", "🧐", "🤓", "😎", "🤩", "🥳", "😏", "😒", "😞", "😟", "😕", "🙁", "😣", "😖", "😫", "😩", "🥺", "😢", "😭", "😤", "😠", "😡", "🤯", "😳", "🥵", "🥶", "😱", "😨", "😥", "😓", "🤗", "🤔", "🤭", "🤫", "🤥", "😶", "😐", "😑", "😬", "🙄", "😯", "😦", "😧", "😮", "😲", "🥱", "😴", "🤤", "😪", "😵", "🤐", "🥴", "🤢", "🤮", "🤧", "😷", "🤒", "🤕", "🤑", "🤠", "😈", "👹", "👺", "🤡",}
local Descriptiont = Textingt[math.random(#Textingt)]
ls = ls..' ['..Descriptiont..'](tg://user?id='..v.member_id.user_id..')\n'
end
send(msg.chat_id,msg.id,ls,"md",true)  
end
if text == 'تاك للكل' or text == "تاق للكل" or text == "منشن للكل" and (Redis:get(Zelzal..'tagallgroup'..msg.chat_id) == "open") then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.first_name ~= "" then
if UserInfo.username then
Creator = "⇜ مالك القروب : [@"..UserInfo.username.."]\n"
else
Creator = "⇜ مالك القروب : ["..FlterBio(UserInfo.first_name).."](tg://user?id="..UserInfo.id..")\n"
end
send(msg_chat_id,msg_id,Creator,"md",true)
end
end
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المالكين الاساسيين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:MalemAsase:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المالكات الاساسيات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المالكين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheMasicsQ:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المالكات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المنشئين الاساسيين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المنشئات الاساسيات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Originators:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المنشئين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المنشئات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Managers:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المدراء* \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المديرات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة الادمنيه* \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة الادمونات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المميزين *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Mistinguished:Group"..msg_chat_id) 
if #Info_Members ~= 0 then
local ListMembers = '\n*⇜ قائمة المميزات *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
send(msg_chat_id, msg_id, ListMembers, 'md')
end
local Info_Members = bot.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
listall = '\n*⇜ قائمة الاعضاء *\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(List_Members) do
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listall = listall..""..k.." - [@"..UserInfo.username.."]\n"
else
listall = listall..""..k.." - ["..UserInfo.id.."](tg://user?id="..UserInfo.id..")\n"
end
end
send(msg_chat_id,msg_id,listall,"md",true)  
end
if msg.content.sticker then
Redis:sadd(Zelzal.."Zelzal:all:sticker"..msg.chat_id, msg.id)
Redis:scard(Zelzal.."Zelzal:all:sticker"..msg.chat_id)  
end
if msg.content.video_note or msg.content.video then
Redis:sadd(Zelzal.."Zelzal:all:video"..msg.chat_id, msg.id)
Redis:scard(Zelzal.."Zelzal:all:video"..msg.chat_id)  
end
if msg.content.document then
Redis:sadd(Zelzal.."Zelzal:all:docu"..msg.chat_id, msg.id)
Redis:scard(Zelzal.."Zelzal:all:docu"..msg.chat_id)  
end
if msg.content.audio then
Redis:sadd(Zelzal.."Zelzal:all:audio"..msg.chat_id, msg.id)
Redis:scard(Zelzal.."Zelzal:all:audio"..msg.chat_id)  
end
if msg.content.voice_note then
Redis:sadd(Zelzal.."Zelzal:all:voice"..msg.chat_id, msg.id)
Redis:scard(Zelzal.."Zelzal:all:voice"..msg.chat_id)  
end
if msg.content.photo then
Redis:sadd(Zelzal.."Zelzal:all:photo"..msg.chat_id, msg.id)
Redis:scard(Zelzal.."Zelzal:all:photo"..msg.chat_id)  
end
if msg.content.animation then
Redis:sadd(Zelzal.."Zelzal:all:anim"..msg.chat_id, msg.id)
Redis:scard(Zelzal.."Zelzal:all:anim"..msg.chat_id)  
end
if msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then   
Redis:sadd(Zelzal.."Zelzal:allM"..msg.chat_id, msg.id)
if Redis:get(Zelzal.."Zelzal:Status:Del:Media"..msg.chat_id) then 
local Numbardel = Redis:get(Zelzal.."Zelzal:allM:numdel"..msg.chat_id) or 200
local gmedia = Redis:scard(Zelzal.."Zelzal:allM"..msg.chat_id)  
if tonumber(gmedia) >= tonumber(Numbardel) then
local liste = Redis:smembers(Zelzal.."Zelzal:allM"..msg.chat_id)
for k,v in pairs(liste) do
local Mesge = v
if Mesge then
t = "⇜ تم مسح ( "..k.." ) من الوسائط تلقائياً\n⇜ يمكنك تعطيل الميزة باستخدام الامر ( `تعطيل المسح التلقائي` )"
bot.deleteMessages(msg.chat_id,{[1]= Mesge})
end
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ من ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
send(msg.chat_id,msg.id, Teext..t,"md",true)
Redis:del(Zelzal.."Zelzal:allM"..msg.chat_id)
end
end
end
if text and text:match("^ضع وقت المسح التلقائي (%d+)$") or text and text:match("^ضع وقت التنظيف التلقائي (%d+)$") then
local Numbardel = text:match("^ضع وقت المسح التلقائي (%d+)$") or text:match("^ضع وقت التنظيف التلقائي (%d+)$")
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
return send(msg_chat_id,msg_id, "*⇜ استعمل الامر هكذا بالعدد وليس بالوقت*\n*⇜ ضع عدد التنظيف + رقم*\n*⇜ مثـال :*\n*⇜ ضع عدد التنظيف 5*","md",true)
end
if text and text:match("^ضع عدد المسح (%d+)$") or text and text:match("^ضع عدد التنظيف (%d+)$") or text and text:match("^ضع عدد التنضيف (%d+)$") then 
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
local Numbardel = text:match("^ضع عدد المسح (%d+)$") or text:match("^ضع عدد التنظيف (%d+)$") or text:match("^ضع عدد التنضيف (%d+)$")
Redis:set(Zelzal.."Zelzal:allM:numdel"..msg.chat_id,Numbardel)
Redis:set(Zelzal.."Zelzal:Status:Del:Media"..msg.chat_id,true)
send(msg_chat_id,msg_id, "*⇜ تم تعيين عدد التنظيف التلقائي لـ الوسائط الى : "..Numbardel.."*","md",true)
end
if text == ("امسح") or text == ("مسح الميديا") or text == ("تنظيف الميديا") or text == ("مسح الوسائط") or text == ("تنظيف الوسائط") and Redis:get(Zelzal..'Zelzal:Aldel:Chat'..msg.chat_id) then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local list = Redis:smembers(Zelzal.."Zelzal:allM"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "*⇜ تم مسح ( "..k.." ) من الميديا ...🗑*\n"
bot.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Zelzal.."Zelzal:allM"..msg.chat_id)
end
end
if #list == 0 then
nont = "*⇜ لا يوجد ميديا مخزنة في المجموعة حالياً ؟!*"
return send(msg.chat_id,msg.id, nont,"md",true)
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '*⇜ بواسطـة* ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n☑️'
send(msg.chat_id,msg.id, t..Teext,"md",true)
end
if text == ("الميديا") or text == ("الوسائط") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local gmria = Redis:scard(Zelzal.."Zelzal:allM"..msg.chat_id)  
send(msg_chat_id,msg_id,"*⇜ عدد الميديا الموجودة ( "..gmria.." )*","md")
end
if text == ("مسح الملصقات") or text == ("مسح ملصقات") or text == ("تنظيف الملصقات") or text == ("تنظيف ملصقات") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:all:sticker"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "⇜ ابشر مسحت ( "..k.." ) من الملصقات"
bot.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Zelzal.."Zelzal:all:sticker"..msg.chat_id)
end
end
if #list == 0 then
t = "⇜ لا يوجد ملصقات في القروب"
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ من ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
send(msg.chat_id,msg.id, Teext..t,"md",true)
end
if text == ("مسح الفيديو") or text == ("مسح فيديو") or text == ("تنظيف الفيديو") or text == ("تنظيف فيديو") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:all:video"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "⇜ ابشر مسحت ( "..k.." ) فيديو"
bot.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Zelzal.."Zelzal:all:video"..msg.chat_id)
end
end
if #list == 0 then
t = "⇜ لا يوجد فيديو في القروب"
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ من ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
send(msg.chat_id,msg.id, Teext..t,"md",true)
end
if text == ("مسح الملفات") or text == ("مسح ملفات") or text == ("تنظيف الملفات") or text == ("تنظيف ملفات") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:all:docu"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "⇜ ابشر مسحت ( "..k.." ) من الملفات"
bot.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Zelzal.."Zelzal:all:docu"..msg.chat_id)
end
end
if #list == 0 then
t = "⇜ لا يوجد ملفات في القروب"
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ من ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
send(msg.chat_id,msg.id, Teext..t,"md",true)
end
if text == ("مسح الصوت") or text == ("مسح صوت") or text == ("تنظيف الصوت") or text == ("تنظيف صوت") or text == ("مسح الصوتيات") or text == ("تنظيف الصوتيات") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:all:audio"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "⇜ ابشر مسحت ( "..k.." ) من الصوتيات"
bot.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Zelzal.."Zelzal:all:audio"..msg.chat_id)
end
end
if #list == 0 then
t = "⇜ لا يوجد صوتيات في القروب"
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ من ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
send(msg.chat_id,msg.id, Teext..t,"md",true)
end
if text == ("مسح الفويسات") or text == ("مسح البصمات") or text == ("تنظيف الفويسات") or text == ("تنظيف البصمات") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:all:voice"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "⇜ ابشر مسحت ( "..k.." ) من الفويسات"
bot.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Zelzal.."Zelzal:all:voice"..msg.chat_id)
end
end
if #list == 0 then
t = "⇜ لا يوجد فويسات في القروب"
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ من ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
send(msg.chat_id,msg.id, Teext..t,"md",true)
end
if text == ("مسح الصور") or text == ("مسح صور") or text == ("تنظيف الصور") or text == ("تنظيف صور") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:all:photo"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "⇜ ابشر مسحت ( "..k.." ) من الصور"
bot.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Zelzal.."Zelzal:all:photo"..msg.chat_id)
end
end
if #list == 0 then
t = "⇜ لا يوجد صور في القروب"
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ من ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
send(msg.chat_id,msg.id, Teext..t,"md",true)
end
if text == ("مسح القيفات") or text == ("مسح المتحركات") or text == ("تنظيف القيفات") or text == ("تنظيف المتحركات") or text == ("مسح متحركات") or text == ("مسح المتحركة") or text == ("مسح المتحركه") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:all:anim"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "⇜ ابشر مسحت ( "..k.." ) من القيفات"
bot.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Zelzal.."Zelzal:all:anim"..msg.chat_id)
end
end
if #list == 0 then
t = "⇜ لا يوجد قيفات في القروب"
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local Teext = '⇜ من ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')\n'
send(msg.chat_id,msg.id, Teext..t,"md",true)
end
if text and text:match("^برج (.*)$") and not Redis:get(Zelzal.."brjj"..msg.chat_id) then
local Textbrj = text:match("^برج (.*)$")
gk = io.popen('curl -s "https://api-jack.ml/api15.php?Text='..URL.escape(Textbrj)..'"'):read('*a')
send(msg_chat_id,msg_id, gk, "md",true)
end
if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if Controllerbanall(msg_chat_id,UserId_Info.id) == true then 
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId_Info.id).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:BanAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل محظور عام ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:BanAll:Groups",UserId_Info.id) 
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر حظرته عام ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر عام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')or text:match('^الغاء حظر عام @(%S+)$')
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:BanAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو محظور عام ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:BanAll:Groups",UserId_Info.id) 
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر الغيت حظره عام ").Reply,"md",true)  
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Addictive or msg.Mddictive then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId_Info.id).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل محظور ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر حظرته ").Reply,"md",true)  
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local twond = bot.searchPublicChat(UserName)
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بـ حظر احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المحظور :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Addictive or msg.Mddictive then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو محظور ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر الغيت حظره").Reply,"md",true)  
end
end
if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه مسح الرسائل ',"md",true)  
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n⇜ هييه مايمديك تستخدم الامر على "..Controller(msg_chat_id,UserId_Info.id).." ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مكتوم").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر كتمته ").Reply,"md",true)  
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local twond = bot.searchPublicChat(UserName)
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بـ كتم احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المكتوم :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ من قبل مو مكتوم").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر الغيت كتمه").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end 
local UserId_Info = bot.searchPublicChat(UserName[3])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n⇜ هييه مايمديك تستخدم الامر على "..Controller(msg_chat_id,UserId_Info.id).." ","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 60
end
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر قيدته \n⇜ لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end
if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end 
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,"\n⇜ هييه مايمديك تستخدم الامر على "..Controller(msg_chat_id,Message_Reply.sender_id.user_id).." ","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 60
end
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر قيدته \n⇜ لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end
if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end 
local UserInfo = bot.getUser(UserId[3])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return send(msg_chat_id,msg_id,"\n⇜ هييه مايمديك تستخدم الامر على "..Controller(msg_chat_id,UserId[3]).." ","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 60
end
bot.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n⇜ ابشر قيدته \n⇜ لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end 
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId_Info.id).." ) ","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر قيدته ").Reply,"md",true) 
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local twond = bot.searchPublicChat(UserName)
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بـ تقييـد احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المقيـد :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر الغيت تقييده").Reply,"md",true)  
end
if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId_Info.id).." ) ","md",true)  
end 
bot.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⇜ ابشر طردته ").Reply,"md",true)  
end
if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if Controllerbanall(msg_chat_id,Message_Reply.sender_id.user_id) == true then 
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,Message_Reply.sender_id.user_id).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:BanAll:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل محظور عام").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:BanAll:Groups",Message_Reply.sender_id.user_id) 
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر حظرته عام ").Reply,"md",true)  
end
end
if text == ('الغاء العام') or text == ('الغاء حظر عام') or text == ('الغاء الحظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:BanAll:Groups",Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو محظور عام ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:BanAll:Groups",Message_Reply.sender_id.user_id) 
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر الغيت حظره عام").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Addictive or msg.Mddictive then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الحظـر معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,Message_Reply.sender_id.user_id).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل محظور ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'banned',0)
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر حظرته ").Reply,"md",true)  
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بحظر احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المحظور :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text == ('الغاء حظر') or text == ('الغاء الحظر') and msg.reply_to_message_id ~= 0 then
if Redis:sismember(Zelzal.."Zelzal:Distinguishedall:Group",msg.sender_id.user_id) then
testmod = true
elseif msg.Addictive or msg.Mddictive then
testmod = true
else
testmod = false
end
if testmod == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if not Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو محظور ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر الغيت حظره").Reply,"md",true)  
end
end
if text == ('كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه مسح الرسائل ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.sender_id.luatele == "messageSenderChat" then
--var(Message_Reply.sender_id.chat_id)
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,Message_Reply.sender_id.chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم كتم القناة من القروب ","md",true)  
end
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,Message_Reply.sender_id.user_id).." ) ","md",true)  
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:MuteId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الكتـم معطـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مكتوم ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر كتمته ").Reply,"md",true)  
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بكتم احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المكتوم :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text == ('الغاء كتم') or text == ('الغاء الكتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
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
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.sender_id.luatele == "messageSenderChat" then
--var(Message_Reply.sender_id.chat_id)
Redis:srem(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,Message_Reply.sender_id.chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم الغاء كتم القناة من القروب  ","md",true)  
end
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ من قبل مو مكتوم ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر الغيت كتمه ").Reply,"md",true)  
end
end
if text == ('تقييد') or text == ("تقيد") and msg.reply_to_message_id ~= 0 then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,Message_Reply.sender_id.user_id).." ) ","md",true)  
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بـ تقييـد احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المقيـد :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..Message_Reply.sender_id.user_id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر قيدته ").Reply,"md",true)  
end
if text == ('الغاء التقييد') or text == ('الغاء تقييد') or text == ('الغاء التقيد') or text == ('الغاء تقيد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر الغيت تقييده").Reply,"md",true)  
end
if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender_id.user_id) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,Message_Reply.sender_id.user_id).." ) ","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,Message_Reply.sender_id.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ ابشر طردته ").Reply,"md",true)  
end
if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if Controllerbanall(msg_chat_id,UserId) == true then 
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:BanAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل محظور عام").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:BanAll:Groups",UserId) 
bot.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر حظرته عام ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
if not Redis:sismember(Zelzal.."Zelzal:BanAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل مو محظور عام").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:BanAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر الغيت حظره عام ").Reply,"md",true)  
end
end
if text and text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end 
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل محظور ").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId) 
bot.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر حظرته ").Reply,"md",true)  
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local twond = bot.getUser(UserId)
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بحظر احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المحظور :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
if not Redis:sismember(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل مو محظور ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id,UserId) 
send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر الغيت حظره ").Reply,"md",true)
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local twond = bot.getUser(UserId)
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بالغاء حظر احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص الملغي حظره :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه مسح الرسائل ',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId).." ) ","md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل مكتوم").Reply,"md",true)  
else
Redis:sadd(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId) 
send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر كتمته").Reply,"md",true)  
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local twond = bot.getUser(UserId)
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بكتم احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المكتوم :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ من قبل مو مكتوم ").Reply,"md",true)  
else
Redis:srem(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id,UserId) 
send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر الغيت كتمه").Reply,"md",true)  
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local twond = bot.getUser(UserId)
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بالغاء كتم احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص الملغي كتمه :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end 
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId).." ) ","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر قيدته ").Reply,"md",true)
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
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
local twond = bot.getUser(UserId)
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
send(Loger_Id,0,'\n*- مرحباً عزيزي المالك 🧚‍♀*\n*- هناك شخص قام بتقييد احد من القروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..zname..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..zuser..'\n*⇜ رتبتـه :* '..RinkBot..'\n\n*- معلومـات الشخص المقيد :*\n*⇜ اسمه :* '..zzname..' \n*⇜ ايديه :* '..twond.id..'\n*⇜ يوزره :* @'..zzuser..'',"md",false, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر الغيت تقييده").Reply,"md",true)  
end
if text and text:match('^طرد (%d+)$') then
local UserId = text:match('^طرد (%d+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not Redis:get(Zelzal.."Zelzal:Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"⇜ ( الحظر - الطرد - التقييد ) معطل من قبل المنشئين","md",true)
end 
local UserInfo = bot.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*⇜ هييـه مايمديك تستخـدم هـذا الامـر علـى* ( "..Controller(msg_chat_id,UserId).." ) ","md",true)  
end
bot.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"⇜ ابشر طردته").Reply,"md",true)  
end
if text == "اطردني" then
if not Redis:get(Zelzal.."Zelzal:Status:KickMe"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ امر اطردني معطل من قبل المدراء*","md",true)
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if StatusCanOrNotCan(msg_chat_id,msg.sender_id.user_id) then
return send(msg_chat_id,msg_id,"\n⇜ عذراً لا استطيع استخدام الامر على ( "..Controller(msg_chat_id,msg.sender_id.user_id).." ) ","md",true)  
end
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
KickMe = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
KickMe = true
else
KickMe = false
end
if KickMe == true then
return send(msg_chat_id,msg_id,"*⇜ عـذراً .. عـزيـزي ❌*\n*⇜ لا استطيع طرد مالك المجموعة او المشرفين 🤷🏻‍♀*","md",true)
end
bot.setChatMemberStatus(msg.chat_id,msg.sender_id.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم طردك من القروب").Reply,"md",true)
end
if text == 'ادمنيه القروب' or text == 'المشرفين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n*⇜ قائمـة مشـرفيـن المجمـوعـة🎖*\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→ المالك '
else
Creator = ""
end
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listAdmin = listAdmin..""..k.." - [@"..UserInfo.username.."] "..Creator.."\n"
else
listAdmin = listAdmin..""..k.." - ["..UserInfo.id.."](tg://user?id="..UserInfo.id..") "..Creator.."\n"
end
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
if Info_Chats.photo then
return bot.sendPhoto(msg.chat_id, msg.id, Info_Chats.photo.sizes[1].photo.remote.id,listAdmin,"md")
else
send(msg_chat_id,msg_id,listAdmin,"md",true)  
end
end
if text == 'رفع الادمنيه' or text == 'رفع المشرفين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
Redis:sadd(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
send(msg_chat_id,msg_id,'\n*⇜ تم رفـع (* '..y..' *) ادمنيـه .. بنجـاح 🎖*',"md",true)
end
-----------------
if text == 'تغيير كليشه المالك' or text == 'تغيير كليشة المالك' or text == 'تغيير يوزر المالك' or text == 'تغيير المالك' or text == 'تغير يوزر المالك' then
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
Redis:set(Zelzal..'Zelzal:GetTextMalek'..msg_chat_id..':'..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,'*⇜ ارسـل الان يـوزر المـالك الجديد 🎖*',"md",true)
end
if text == 'مسح كليشه المالك' or text == 'مسح كليشة المالك' or text == 'مسح يوزر المالك' then
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
Redis:del(Zelzal..'Zelzal:Text:malek'..msg.chat_id)
return send(msg_chat_id,msg_id,'*⇜ تم مسح كليشـة المـالك .. بنجـاح ✅*',"md",true)
end
if text and Redis:get(Zelzal..'Zelzal:GetTextMalek'..msg_chat_id..':'..msg.sender_id.user_id) then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then 
Redis:del(Zelzal..'Zelzal:GetTextMalek'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء حفظ كليشة المالك')
end
Redis:del(Zelzal..'Zelzal:GetTextMalek'..msg_chat_id..':'..msg.sender_id.user_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = bot.searchPublicChat(text:gsub('@',''))
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ لا يوجد حساب بهذا اليوزر*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ هذا معرف قناة 🤡*","md",true)  
end
if text and text:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ لا تستطيع استخدام يوزر بوت*","md",true)  
end
Redis:set(Zelzal..'Zelzal:Text:malek'..msg.chat_id,text)
return send(msg_chat_id,msg_id,'*⇜ ابشر غيرت كليشه المالك ✅*',"md",true)
else
return send(msg_chat_id,msg_id,'*⇜ اليوزر خطأ*',"md",true)
end
end
if text == 'المالك' or text == 'مالك القروب' or text == 'صاحب القروب' then
if Redis:get(Zelzal..'lock_getadmin'..msg.chat_id) then
return send(msg_chat_id,msg_id,"*⇜ نداء المالك معطل من قبل المالكين ؟!*","md",true)
end 
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n⇜ عذراً البوت ليس ادمن في القروب يرجى رفعه واعطائه الصلاحيات ","md",true)  
end
local GetEr = Redis:get(Zelzal..'Zelzal:Text:malek'..msg.chat_id)
if GetEr then
local UserId_Info = bot.searchPublicChat(GetEr:gsub('@',''))
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"*⇜ المالك حسابه محذوف*","md",true)  
end
local UserInfo = bot.getUser(UserId_Info.id)
if UserInfo.first_name == "" then
return send(msg_chat_id,msg_id,"*⇜ المالك حسابه محذوف*","md",true)  
end 
local photo = bot.getUserProfilePhotos(UserInfo.id)
local InfoUser = bot.getUserFullInfo(UserInfo.id)
if UserInfo.username then
UserInfousername = '[@'..UserInfo.username..']'
else
UserInfousername = 'لا يوجد يوزر'
end
if photo.total_count > 0 then
local TestText = "\n*• Name ↦ *["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n*• Bio ↦ "..getbio(UserInfo.id).."*"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown')
else
local TestText = "\n*• Name ↦ *["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n*• Bio ↦ "..getbio(UserInfo.id).."*"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
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
local current_time = os.time() + 3600 -- إضافة ساعة واحدة
local id = tostring(msg.chat_id)
gt = string.upper(id:gsub('-100',''))
gtr = math.floor(msg.id/2097152/0.5)
telink = "https://t.me/c/"..gt.."/"..gtr..""
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
send(Loger_Id,0,'\n*⇜ مرحباً عزيزي المالك 🧚‍♀*\n*⇜ شخص ما منشـن لك في القـروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n\n*⇜ رابط الرسالة :*'..telink..'',"md",false, false, false, false, reply_markup)
end
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.first_name == "" then
send(msg_chat_id,msg_id,"*⇜ المالك حسابه محذوف*","md",true)  
return false
end 
if UserInfo.username and UserInfo.username ~= "" then
t = '['..UserInfo.first_name..'](t.me/'..UserInfo.username..')'
ban = ' '..UserInfo.first_name..' '
u = '[@'..UserInfo.username..']'
else
t = '['..UserInfo.first_name..'](tg://user?id='..UserInfo.id..')'
u = 'لا يوجد'
end
local photo = bot.getUserProfilePhotos(UserInfo.id)
local InfoUser = bot.getUserFullInfo(UserInfo.id)
if photo.total_count > 0 then
local TestText = "\n*• Name ↦ *["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n*• Bio ↦ "..getbio(UserInfo.id).."*"
keyboardd = {}
keyboardd.inline_keyboard = {
{
{text = ban, url = "https://t.me/"..UserInfo.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg_chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "\n*• Name ↦ *["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n*• Bio ↦ "..getbio(UserInfo.id).."*"
local msg_id = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id='..msg_chat_id..'&text='..URL.escape(TestText)..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
if Redis:get(Zelzal.."Zelzal:LogerGroupBot"..msg.chat_id) then
local Get_Chat = bot.getChat(msg_chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
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
local current_time = os.time() + 3600 -- إضافة ساعة واحدة
local id = tostring(msg.chat_id)
gt = string.upper(id:gsub('-100',''))
gtr = math.floor(msg.id/2097152/0.5)
telink = "https://t.me/c/"..gt.."/"..gtr..""
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
send(Loger_Id,0,'\n*⇜ مرحباً عزيزي المالك 🧚‍♀*\n*⇜ شخص ما منشـن لك في القـروب 🤔*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ اسمه :* '..klajq..' \n*⇜ ايديه :* '..msg.sender_id.user_id..'\n*⇜ يوزره :* @'..basgk..'\n\n*⇜ رابط الرسالة :*'..telink..'',"md",false, false, false, false, reply_markup)
end
end
end
end
if text == 'رفع المالك' then
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.first_name == "" then
send(msg_chat_id,msg_id,"*⇜ المالك حسابه محذوف*","md",true)  
return false
end 
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,v.member_id.user_id) 
send(msg_chat_id,msg_id,"*⇜ ابشر رفعت المالك*","md",true)  
return false
end
end
end
if text == 'صنع كود' then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,'⇜ ارسلي الرابط ')
end
if text and Redis:get(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id) == "true" then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then 
Redis:del(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء صنع الكود')
end
Redis:set(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id,"true1")
Redis:set(Zelzal..'Zelzal:Getcode:'..msg_chat_id..':'..msg.sender_id.user_id,text)
return send(msg_chat_id,msg_id,'⇜ الان ارسل النص الي تريده')
end
if text and Redis:get(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id) == "true1" then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then 
Redis:del(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء صنع الكود')
end
Redis:set(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id,"true2")
Redis:set(Zelzal..'Zelzal:Getcode:text'..msg_chat_id..':'..msg.sender_id.user_id,text)
return send(msg_chat_id,msg_id,'⇜ الان ارسل اسم الزر')
end
if text and Redis:get(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id) == "true2" then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then 
Redis:del(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء صنع الكود')
end
Redis:del(Zelzal..'Zelzal:Getcode'..msg_chat_id..':'..msg.sender_id.user_id)
local get1 = Redis:get(Zelzal..'Zelzal:Getcode:text'..msg_chat_id..':'..msg.sender_id.user_id)
local get2 = Redis:get(Zelzal..'Zelzal:Getcode:'..msg_chat_id..':'..msg.sender_id.user_id)
local reply_markup = bot.replyMarkup{type = 'inline',
data = {
{
{text = text, url = get2}, 
},
}
}
Redis:del(Zelzal..'Zelzal:Getcode:text'..msg_chat_id..':'..msg.sender_id.user_id)
Redis:del(Zelzal..'Zelzal:Getcode:'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg.chat_id,msg.id,'['..get1..']('..get2..')',"md",true, false, false, false, reply_markup)
end
if text == 'كشف البوتات' or text == 'كشف بوتات' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n⇜ قائمة البوتات \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
x = 0
for k, v in pairs(List_Members) do
local UserInfo = bot.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
x = x + 1
Admin = ' ←〘  مشرف 〙'
else
Admin = ""
end
listBots = listBots..""..k.." - @"..UserInfo.username.." "..Admin.."\n"
end
send(msg_chat_id,msg_id,listBots.."\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n⇜ عـدد البوتات التي هي إشـراف ( "..x.." )","md",true)  
end
if text == 'المقيدين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
local y = false
restricted = '\n⇜ قائمة المقيديين \n ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
restricted = restricted..""..x.." - @"..UserInfo.username.."\n"
else
restricted = restricted..""..x.." - "..UserInfo.id.."\n"
end
end
end
if y == true then
send(msg_chat_id,msg_id,restricted,"html",true)  
else
send(msg_chat_id,msg_id,'*⇜ مافي مقيدين* ',"md",true)
end
end
if text == (Bot_Name.." غادر") or text == (Bot_Name.." غادري") or text == "غادر" or text == "غادري" then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
local Malath = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "لا يوجد اسم")
local Zilzal = bot.getUser(Zelzal)
local bain = bot.getUser(msg.sender_id.user_id)
local photo = bot.getUserProfilePhotos(Zelzal)
news = '*⇜ عـزيـزي ⇜ *['..bain.first_name..'](tg://user?id='..bain.id..')*\n⇜ هـل تريـد بـوت  *['..Malath..'](tg://user?id='..Zilzal.id..')*\n⇜ ان يغـادر القـروب ؟!\n*'
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• نعم •', callback_data=msg.sender_id.user_id..'/Zxchq'..msg_chat_id},{text = '• لا •', callback_data = msg.sender_id.user_id..'/Redis'..msg_chat_id},
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(news).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text and text:match('^غادر (-100%d+)$') then
local Chatid = text:match('^غادر (-100%d+)$')
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
bot.leaveChat(Chatid)
send(msg_chat_id,msg_id,'*⇜ ابشـر مطـوري .. غادرتُ المجمـوعـة 🏃🏻*',"md",true)
end
if not Redis:get(Zelzal.."AutoTagTime"..msg_chat_id) and Redis:get(Zelzal.."AutoTag"..msg_chat_id) then
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local chat_Members = bot.searchChatMembers(msg_chat_id, "*", Info_Chats.member_count).members
local rand_members = math.random(#chat_Members)
local member_id = chat_Members[rand_members].member_id.user_id
local member_name = bot.getUser(chat_Members[rand_members].member_id.user_id).first_name
local mem_tag = "["..member_name.."](tg://user?id="..member_id..")"
local rdod = {"*‏من ترك أمرهُ لله، أعطاه الله فوق ما يتمنَّاه💙 *", 
"*‏ انك الجميع و كل من احتل قلبي🫀🤍*",
"*‏ ‏ لقد تْعَمقتُ بكَ كَثيراً والمِيمُ لام .♥️*",
"*‏ كُنت أرقّ من أن أتحمّل كُل تلك القَسوة من عَينيك .🍍*",
"*‏أَكَان عَلَيَّ أَنْ أغْرَس انيابي فِي قَلْبِك لتشعر بِي ؟.*",
"*‏- كُلمـا أتبـع قلبـي يدلنـي إليـك .*",
"*‏ : أيا ليت من تَهواه العينُ تلقاهُ .*",
"*‏ ‏: رغبتي في مُعانقتك عميقة جداً .*",
"*ويُرهقني أنّي مليء بما لا أستطيع قوله.✨*",
"*‏ من مراتب التعاسه إطالة الندم ع شيء إنتهى. ︙ *",
"*‏ ‏كل العالم يهون بس الدنيا بينا تصفي 💙*",
"*‏ بعض الاِعتذارات يجب أن تُرفَضّ.*",
"*‏ ‏تبدأ حياتك محاولاً فهم كل شيء، وتنهيها محاولاً النجاة من كل ما فهمت.*",
"*‏ إن الأمر ينتهي بِنا إلى أعتياد أي شيء.*",
"*‏ هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك.*",
"*‏ جَبَرَ الله قلبكُ ، وقَلبِي .🍫*",
"*‏ ‏مقدرش عالنسيان ولو طال الزمن 🖤*",
"*‏ لسان حالك يقول أنا لستُ لأحد ولا احد لي ، أنا إنسان غريب أساعد من يحتاجني واختفي.*",
"*‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟*",
"*‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ*",
"*‏ وانتهت صداقة الخمس سنوات بموقف.*",
"*‏ ‏لا تحب أحداً لِدرجة أن تتقبّل أذاه.*",
"*‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار.*",
"*فـ بالله صبر  وبالله يسر وبالله عون وبالله كل شيئ ♥️. *",
"*المشكله مش اني باخد قررات غلط المشكله اني بفكر كويس فيها قبل ما اخدها .. *",
"*تخيل وانت قاعد مخنوق كدا بتفكر فالمزاكره اللي مزكرتهاش تلاقي قرار الغاء الدراسه .. *",
"*‏جمل فترة في حياتي، كانت مع اكثر الناس الذين أذتني نفسيًا. *",
"* ‏إحنا ليه مبنتحبش يعني فينا اي وحش!*",
"*أيام مُمله ومستقبل مجهول ونومٌ غير منتظموالأيامُ تمرُ ولا شيَ يتغير *", 
"*عندما تهب ريح المصلحه سوف ياتي الجميع راكدون تحت قدمك ❤️. *",
"*- ‏تجري حياتنا بما لاتشتهي أحلامنا ! *",
"*تحمل كل هذا الجمال، ‏ألا تتعب؟!*",
"*البدايات للكل ، والثبات للصادقين *",
"*مُؤخرًا اقتنعت بالجملة دي جدا : Private life always wins. *",
"* الافراط في التسامح يخلي الناس تستهين فيك🍍*",
"*مهما كنت كويس فـَ إنت معرض لـِ الاستبدال.. *",
} 
local rd = rdod[math.random(#rdod)]
send(msg_chat_id,false,rd.." "..mem_tag,"md")
Redis:setex(Zelzal.."AutoTagTime"..msg_chat_id,150,true) 
end
if text == 'المتفائل' or text == 'تفائل' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info = bot.searchChatMembers(msg.chat_id, "*", 10)
local members = Info.members
ls = '\n*✦┊الشخصيـه المتفـائلـه 😇✌️\n ٴ••┉┉┉┉┉┉┉••🝢••┉┉┉┉┉┉┉••*\n'
for k, v in pairs(members) do
local Textingt = {"🥵", "🥶", "😭", "🤢", "🤮", "😇", "😈", "👹", "👺", "🤡",}
local Descriptiont = Textingt[math.random(#Textingt)]
ls = ls..' ['..Descriptiont..'](tg://user?id='..v.member_id.user_id..')\n\n'
end
send(msg.chat_id,msg.id,ls,"md",true)  
end
if text then
if text:match("^all (.*)$") or text:match("^@all (.*)$") or text:match("^نداء (.*)$") then 
local ttag = text:match("^all (.*)$") or text:match("^@all (.*)$") or text:match("^نداء (.*)$") 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local Info_Members = bot.searchChatMembers(msg_chat_id, "*", 200)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = bot.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
send(msg.chat_id, 0, Text,"md")
end 
end 
end 
end
local nnbot = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "زلزال")
if text == "@all" or text == "تاك عام" or text == "all" or text == "نداء" or text == nnbot.." تاك عام" or text == nnbot.." نداء" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Redis:get(Zelzal.."tagall@all"..msg_chat_id) == "open" then
local Info_Members = bot.searchChatMembers(msg_chat_id, "*", 200)
x = 0
tags = 0
local list = Info_Members.members
for k, v in pairs(list) do
local UserInfo = bot.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then
tags = x + 5
listall = ""
end
x = x + 1
if UserInfo.first_name ~= '' then
listall = listall.." ["..FlterBio(UserInfo.first_name).."](tg://user?id="..UserInfo.id.."),"
end
if x == 5 or x == tags or k == 0 then
send(msg_chat_id,msg_id,listall,"md",true)  
end
end
end
end
if text and text:match("@all (.*)")  then
textee = text:match("@all (.*)") 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:get(Zelzal.."tagall@all"..msg_chat_id) == "open" then
local Info_Members = bot.searchChatMembers(msg_chat_id, "*", 200)
x = 0
tags = 0
local list = Info_Members.members
for k, v in pairs(list) do
local UserInfo = bot.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then
tags = x + 5
listall = ""
end
x = x + 1
if UserInfo.first_name ~= '' then
listall = listall.." ["..FlterBio(UserInfo.first_name).."](tg://user?id="..UserInfo.id.."),"
end
if x == 5 or x == tags or k == 0 then
send(msg_chat_id,msg_id,textee.."\n"..listall,"md",true)  
end
end
end
end
if text == 'تاك' and (Redis:get(Zelzal..'tagallgroup'..msg.chat_id) == "open") then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local Info_Members = bot.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
listall = '\n⇜ قائمة الاعضاء \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(List_Members) do
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listall = listall..""..k.." - [@"..UserInfo.username.."]\n"
else
listall = listall..""..k.." - ["..UserInfo.id.."](tg://user?id="..UserInfo.id..")\n"
end
end
send(msg_chat_id,msg_id,listall,"md",true)  
end
if text and text:match('^حظر جروب (-100%d+)$') or text and text:match('^حظر قروب (-100%d+)$') or text and text:match('^حظر كروب (-100%d+)$') or text and text:match('^حظر مجموعه (-100%d+)$') then
local Chatid = text:match('^حظر جروب (-100%d+)$') or text:match('^حظر قروب (-100%d+)$') or text:match('^حظر كروب (-100%d+)$') or text:match('^حظر مجموعه (-100%d+)$')
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if Chatid and not Chatid:match("-100") then
return send(msg_chat_id,msg_id,"*⇜ الايدي خطأ .. يجب ان يبدأ بـ -100*","md",true)  
end
local Get_Chat = bot.getChat(Chatid)
if not data.id then
send(msg_chat_id,msg_id,'*- لا توجد مجموعة في البوت بهذا الايدي*',"md",true)
return false
end
bot.leaveChat(Chatid)
Redis:sadd(Zelzal.."Black:listBan:",Chatid)
send(msg_chat_id,msg_id,'*- تم حظر المجموعة  :* ['..Get_Chat.title..']\n*- وتم مغادره البوت من المجموعة*',"md",true)
end 
if text and text:match('^الغاء حظر جروب (-100%d+)$') or text and text:match('^الغاء حظر قروب (-100%d+)$') or text and text:match('^الغاء حظر كروب (-100%d+)$') or text and text:match('^الغاء حظر مجموعه (-100%d+)$') then
local Chatid = text:match('^الغاء حظر جروب (-100%d+)$') or text:match('^الغاء حظر قروب (-100%d+)$') or text:match('^الغاء حظر كروب (-100%d+)$') or text:match('^الغاء حظر مجموعه (-100%d+)$')
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if Chatid and not Chatid:match("-100") then
return send(msg_chat_id,msg_id,"*⇜ الايدي خطأ .. يجب ان يبدأ بـ -100*","md",true)  
end
Redis:srem(Zelzal.."Black:listBan:",Chatid)
send(msg_chat_id,msg_id,'*- تم الغاء حظر المجموعة .. بنجاح ✅*',"md",true)
end
if text == 'نزلني' and not Redis:get(Zelzal..'Zelzal:Nzlne:Abs'..msg.chat_id) then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if Controllerbanall(msg_chat_id,msg.sender_id.user_id) == true then 
return send(msg_chat_id,msg_id,"\n*⇜ مايمديني انزل *"..Controller(msg_chat_id,msg.sender_id.user_id).." ","md",true)  
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'نعم ', data = msg.sender_id.user_id..'/Nzlne'},{text = 'لا', data = msg.sender_id.user_id..'/noNzlne'},
},
}
}
return send(msg_chat_id,msg_id,'*⇜ متأكد انزلك ؟*',"md",false, false, false, false, reply_markup)
end
if text =="صورتي" or text == "افتاري" then
if not Redis:get(Zelzal..'myphoto'..msg.chat_id) then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local photo = bot.getUserProfilePhotos(msg.sender_id.user_id)
local TotalPhoto = photo.total_count or 0
if photo.total_count > 0 then
if photo.photos[1].animation then
if Redis:get(Zelzal..'porn'..msg.chat_id) then
local thumb_id = photo.photos[1].animation.file.remote.id
local idd = photo.photos[1].animation.file.id
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num..".mp4")
return false 
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
local File = request("https://api.telegram.org/bot" .. Token .. "/getfile?file_id="..photo.photos[1].animation.file.remote.id) 
local fc = JSON.decode(File)
local Name_File = download("https://api.telegram.org/file/bot"..Token.."/"..JSON.decode(File).result.file_path, "./id.mp4") 
return bot.sendAnimation(msg.chat_id, msg.id, Name_File,
"\nعدد صورك : "..TotalPhoto..
"") 
else
local num = math.random(99999)
local Fille = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..thumb_id))
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..Fille.result.file_path,""..num..".mp4")
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num..".mp4")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
os.remove(""..num..".mp4")
return false 
end
end
end
local File = request("https://api.telegram.org/bot" .. Token .. "/getfile?file_id="..photo.photos[1].animation.file.remote.id) 
local fc = JSON.decode(File)
local Name_File = download("https://api.telegram.org/file/bot"..Token.."/"..JSON.decode(File).result.file_path, "./id.mp4") 
return bot.sendAnimation(msg.chat_id, msg.id, Name_File,
"\nعدد صورك : "..TotalPhoto..
"") 
else
if Redis:get(Zelzal..'porn'..msg.chat_id) then
local thumb_id = photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id
local idd = photo.photos[1].sizes[#photo.photos[1].sizes].photo.id
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num..".jpg")
return false 
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
return bot.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,
"\nعدد صورك : "..TotalPhoto..
"") 
else
local num = math.random(99999)
local Fille = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..thumb_id))
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..Fille.result.file_path,""..num..".jpg")
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num..".jpg")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
os.remove(""..num..".jpg")
return false 
end
end
end
return bot.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,
"\nعدد صورك : "..TotalPhoto..
"") 
end
end
end
end
if text and text:match('^صورتي (%d+)$') or text and text:match('^افتاري (%d+)$') then
numbermyphh = text:match('^صورتي (%d+)$') or text:match('^افتاري (%d+)$')
numbermyph = math.floor(numbermyphh)
if numbermyph then
numbermypho = numbermyph
else
numbermypho = 1
end
local photo = bot.getUserProfilePhotos(msg.sender_id.user_id)
if photo.total_count < numbermyph then
return send(msg_chat_id, msg_id , "⇜ عدد صورك "..photo.total_count.." وليس "..numbermyph.."")
end
if not Redis:get(Zelzal..'myphoto'..msg.chat_id) then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
local photo = bot.getUserProfilePhotos(msg.sender_id.user_id)
local TotalPhoto = photo.total_count or 0
if photo.total_count > 0 then
if photo.photos[numbermypho].animation then
if Redis:get(Zelzal..'porn'..msg.chat_id) then
local thumb_id = photo.photos[numbermypho].animation.file.remote.id
local idd = photo.photos[numbermypho].animation.file.id
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num..".mp4")
return false 
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
local File = request("https://api.telegram.org/bot" .. Token .. "/getfile?file_id="..photo.photos[numbermypho].animation.file.remote.id) 
local fc = JSON.decode(File)
local Name_File = download("https://api.telegram.org/file/bot"..Token.."/"..JSON.decode(File).result.file_path, "./id.mp4") 
return bot.sendAnimation(msg.chat_id, msg.id, Name_File,
"صورتك رقم : "..numbermyph..
"\nعدد صورك : "..TotalPhoto..
"") 
else
local num = math.random(99999)
local Fille = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..thumb_id))
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..Fille.result.file_path,""..num..".mp4")
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num..".mp4")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
os.remove(""..num..".mp4")
return false 
end
end
end
local File = request("https://api.telegram.org/bot" .. Token .. "/getfile?file_id="..photo.photos[numbermypho].animation.file.remote.id) 
local fc = JSON.decode(File)
local Name_File = download("https://api.telegram.org/file/bot"..Token.."/"..JSON.decode(File).result.file_path, "./id.mp4") 
return bot.sendAnimation(msg.chat_id, msg.id, Name_File,
"صورتك رقم : "..numbermyph..
"\nعدد صورك : "..TotalPhoto..
"") 
else
if Redis:get(Zelzal..'porn'..msg.chat_id) then
local thumb_id = photo.photos[numbermypho].sizes[#photo.photos[1].sizes].photo.remote.id
local idd = photo.photos[numbermypho].sizes[#photo.photos[1].sizes].photo.id
if Redis:sismember(Zelzal.."sex_ids",idd) then
os.remove(""..num..".jpg")
return false 
end
if Redis:sismember(Zelzal.."not_sex_ids",idd) then
return bot.sendPhoto(msg.chat_id, msg.id, photo.photos[numbermypho].sizes[#photo.photos[1].sizes].photo.remote.id,
"صورتك رقم : "..numbermyph..
"\nعدد صورك : "..TotalPhoto..
"") 
else
local num = math.random(99999)
local Fille = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..thumb_id))
local dw = download('https://api.telegram.org/file/bot'..Token..'/'..Fille.result.file_path,""..num..".jpg")
local out = io.popen("python3.8 ./detect.py '"..dw.."'"):read('*a')
print(out)
if string.find(out, "NONPORN") then
Redis:sadd(Zelzal.."not_sex_ids",idd)
os.remove(""..num..".jpg")
else
Redis:sadd(Zelzal.."sex_ids",idd) 
os.remove(""..num..".jpg")
return false 
end
end
end
return bot.sendPhoto(msg.chat_id, msg.id, photo.photos[numbermypho].sizes[#photo.photos[1].sizes].photo.remote.id,
"صورتك رقم : "..numbermyph..
"\nعدد صورك : "..TotalPhoto..
"") 
end
end
end
end
if text and text:match("^قول (.*)$") and Redis:get(Zelzal..'kolklma'..msg.chat_id) then
local txt = {string.match(text, "^(قول) (.*)$")}
return send(msg_chat_id,msg_id, txt[2], 'md')
end
if text and text:match("^قولي (.*)$") and Redis:get(Zelzal..'kolklma'..msg.chat_id) then
local txt = {string.match(text, "^(قولي) (.*)$")}
return send(msg_chat_id,msg_id, txt[2], 'md')
end
if text and text:match("^كول (.*)$") and Redis:get(Zelzal..'kolklma'..msg.chat_id) then
local txt = {string.match(text, "^(كول) (.*)$")}
return send(msg_chat_id,msg_id, txt[2], 'md')
end
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Set:Link"..msg_chat_id..""..msg.sender_id.user_id,120,true) 
return send(msg_chat_id,msg_id,"⇜ ارسل رابط القروب او رابط قناة القروب","md",true)  
end
if text == "مسح الرابط" or text == "مسح رابط" or text == "حذف الرابط" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Group:Link"..msg_chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح الرابط ","md",true)             
end
if text == "الرابط" or text == "رابط" then
if not Redis:get(Zelzal.."Zelzal:Status:Link"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ جلب الرابـط معطـل من قبـل الادارة ❌*","md",true)
end
local UserInfo = bot.getUser(msg.sender_id.user_id)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '✦ اضغـط هنـا ✦', url = 't.me/'..UserBot..'?start=liink'..msg_chat_id..'u'..msg.sender_id.user_id..''}, 
},
}
} 
return send(msg_chat_id,msg_id,'\n*⇜ عـزيـزي :*  ['..UserInfo.first_name..'](tg://user?id='..msg.sender_id.user_id..')  \n\n*⇜ تم ارسـال رابـط المجمـوعـه اليـك بخـاص البـوت *','md', true, false, false, false, reply_markup)
end
if text == "انشاء رابط" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
local LinkGroup = bot.generateChatInviteLink(msg_chat_id,'am',tonumber(msg.date+864000),100,false)
if LinkGroup.code == 3 then
return send(msg_chat_id,msg_id,"⇜ لا استطيع انشاء الرابط ليس لدي صلاحية دعوة المستخدمين من خلال الرابط ","md",true)
end
Redis:set(Zelzal.."Zelzal:Group:Link"..msg_chat_id,LinkGroup.invite_link) 
local reply_markup = bot.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return send(msg_chat_id, msg_id, "Link Group : \n["..LinkGroup.invite_link.. "]", 'md', true, false, false, false, reply_markup)
end
if text == "انشاء رابط خاص" or text == "رابط خاص" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
local LinkGroup = bot.generateChatInviteLink(msg_chat_id,'Bob',tonumber(msg.date+864000),nil,true)
if LinkGroup.code == 3 then
return send(msg_chat_id,msg_id,"*⇜ لا استطيع انشاء الرابط ليس لدي صلاحية دعوة المستخدمين من خلال الرابط* ","md",true)
end
local reply_markup = bot.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return send(msg_chat_id, msg_id, "Link Group : \n["..LinkGroup.invite_link.. "]", 'md', true, false, false, false, reply_markup)
end
------------------------------------ زلزال الهيبه ------------------------------------
if text == 'تفعيل جروب اشعارات المالك' or text == 'تفعيل مجموعه اشعارات المالك' or text == 'تفعيل قروب اشعارات المالك' or text == 'تفعيل كروب اشعارات المالك' or text == 'تفعيل اشعارات المالك' or text == 'تفعيل الاشعارات الذكيه' or text == 'تفعيل الاشعارات الذكية' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مـالك المجموعة ) فقـط*',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Add:Loger:Groupbot"..msg_chat_id..":"..msg.sender_id.user_id,true) 
return send(msg_chat_id,msg_id,"*⇜ اتبـع الخطـوات التاليـه ليعمـل البـوت بشكـل صحيـح في المجموعـة :*\n\n❶*⇜ قم باضافة البوت لمجموعة الاشعارات وارفعه كامل الصلاحيات*\n❷*⇜ قم بجعل سجل المجموعة ظاهراً*\n❸*⇜ ارسـل الان ايـدي مجمـوعـة الاشعـارات مبدوء بـ -100*\n\n*⇜ لـ الالغـاء ارسـل (الغاء)*","md",true)  
end
if text == 'تعطيل جروب اشعارات المالك' or text == 'تعطيل مجموعه اشعارات المالك' or text == 'تعطيل قروب اشعارات المالك' or text == 'تعطيل كروب اشعارات المالك' or text == 'تعطيل اشعارات المالك' or text == 'تعطيل الاشعارات الذكيه' or text == 'تعطيل الاشعارات الذكية' then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( مـالك المجموعة ) فقـط*',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Loger:BotGroub"..msg_chat_id)
Redis:del(Zelzal.."Zelzal:LogerGroupBot"..msg_chat_id)
return send(msg_chat_id,msg_id,"*⇜ تم تعطيل قروب الاشعارات الذكيه ✅ *","md",true)
end
------------------------------------ زلزال الهيبه ------------------------------------
if text == "ضع الترحيب عام" or text == "وضع الترحيب عام" or text == "ضع ترحيب عام" or text == "وضع ترحيب عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Welcome:Group:Set" .. msg_chat_id .. "" .. msg.sender_id.user_id, 120, true)  
local textett =[[
*⇜ ارسل لي الترحيب عام الان
⇜ تستطيع اضافة مايلي*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
*- عرض اسم الشخص :*  `{الاسم}`
*- عرض يوزر الشخص :*  `{اليوزر}`
*- عرض اسم المجموعه :*  `{المجموعه}`
*- عرض عدد الاعضاء :*  `{الاعضاء}`
*- عرض عدد الادمنيه :*  `{الادمنيه}`
*- عرض الوقت :*  `{الوقت}`
*- عرض التاريخ :*  `{التاريخ}`
]]
return send(msg_chat_id,msg_id,textett,"md",true)   
end
if text == "الترحيب عام" or text == "الترحيب العام" or text == "ترحيب العام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Welcome = Redis:get(Zelzal.."Zelzal:Welcome:Groups")
if Welcome then 
return send(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return send(msg_chat_id,msg_id,"⇜ لم يتم تعيين ترحيب عام","md",true)   
end 
end
if text == "مسح الترحيب عام" or text == "مسح ترحيب عام" or text == "حذف الترحيب عام" or text == "حذف ترحيب عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Welcome:Groups") 
return send(msg_chat_id,msg_id,"⇜ تم مسح الترحيب العـام .. بنجـاح","md",true)   
end
if Redis:get(Zelzal.."Zelzal:Welcome:Group:Set" .. msg_chat_id .. "" .. msg.sender_id.user_id) then 
if text == "الغاء" then 
Redis:del(Zelzal.."Zelzal:Welcome:Group:Set" .. msg_chat_id .. "" .. msg.sender_id.user_id)  
return send(msg_chat_id,msg_id,"⇜ تم الغاء حفظ الترحيب عام","md",true)   
end 
Redis:del(Zelzal.."Zelzal:Welcome:Group:Set" .. msg_chat_id .. "" .. msg.sender_id.user_id)  
Redis:set(Zelzal.."Zelzal:Welcome:Groups",text) 
return send(msg_chat_id,msg_id,"⇜ تم حفظ الترحيب عام","md",true)
end
if text == "ضع الترحيب" or text == "وضع الترحيب" or text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender_id.user_id, 120, true)  
local textett =[[
*⇜ ارسـل نص الترحيب الان
⇜ تستطيع اضافة مايلي*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
*- عرض اسم الشخص :*  `{الاسم}`
*- عرض يوزر الشخص :*  `{اليوزر}`
*- عرض اسم المجموعه :*  `{المجموعه}`
*- عرض عدد الاعضاء :*  `{الاعضاء}`
*- عرض عدد الادمنيه :*  `{الادمنيه}`
*- عرض الوقت :*  `{الوقت}`
*- عرض التاريخ :*  `{التاريخ}`
]]
return send(msg_chat_id,msg_id,textett,"md",true)   
end
if text == "الترحيب" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if not Redis:get(Zelzal.."Zelzal:Status:Welcome"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ تم تعطيل الترحيب من قبل الادمنيه*","md",true)
end 
local Welcome = Redis:get(Zelzal.."Zelzal:Welcome:Group"..msg_chat_id)
if Welcome then 
return send(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return send(msg_chat_id,msg_id,"*⇜ لم يتم تعيين ترحيب للقروب*","md",true)   
end 
end
if text == "مسح الترحيب" or text == "مسح ترحيب" or text == "حذف الترحيب" or text == "حذف ترحيب" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Welcome:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*⇜ تم ازالة ترحيب القروب*","md",true)   
end
-------------------------------------------------------------------------------------------
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender_id.user_id, 600, true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي القوانين*","md",true)  
end
if text == "مسح القوانين" or text == "مسح قوانين" or text == "حذف القوانين" or text == "حذف قوانين" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Group:Rules"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*⇜ تم مسح قوانين القروب*","md",true)    
end
if text == "القوانين" and msg_chat_id ~= "-1001935599871" then
local Rules = Redis:get(Zelzal.."Zelzal:Group:Rules" .. msg_chat_id)   
if Rules then
return send(msg_chat_id,msg_id,Rules,"md",true)
else
return send(msg_chat_id,msg_id,"*⇜ لا يوجد قوانين*","md",true)
end
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية تغيير المعلومات ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Set:Description:" .. msg_chat_id .. ":" .. msg.sender_id.user_id, 600, true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي وصف القروب*","md",true)  
end
if text == "مسح الوصف" or text == "مسح وصف" or text == "حذف الوصف" or text == "حذف وصف" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية تغيير المعلومات ',"md",true)  
end
bot.setChatDescription(msg_chat_id, '') 
return send(msg_chat_id,msg_id,"*⇜ تم مسح قوانين القروب*","md",true)    
end
if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحية تغيير المعلومات *',"md",true)  
end
bot.setChatTitle(msg_chat_id,NameChat)
return send(msg_chat_id,msg_id,"*⇜ تم تغيير اسم القروب الى : *"..NameChat,"md",true)    
end
if text == ("ضع صوره") or text == ("وضع صوره") or text == ("ضع صورة") or text == ("وضع صورة") then  
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية تغيير المعلومات ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Chat:Photo"..msg_chat_id..":"..msg.sender_id.user_id,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل الصوره لوضعها للقروب*","md",true)    
end
if text == "مسح قائمه المنع" or text == "مسح قائمة المنع" or text == "حذف قائمه المنع" or text == "حذف قائمة المنع" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"*⇜ لا يوجد كلمات ممنوعة *","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(Zelzal.."Zelzal:Filter:Group:"..v..msg_chat_id)  
Redis:srem(Zelzal.."Zelzal:List:Filter"..msg_chat_id,v)  
end  
return send(msg_chat_id,msg_id,"*⇜ تم مسح ( *"..#list.."* ) كلمة ممنوعة *","md",true)   
end
if text == "قائمه المنع" or text == "قائمة المنع" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"*⇜ لا يوجد كلمات ممنوعة*","md",true)   
end  
Filter = '\n⇜ قائمة المنع \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صورة'
elseif v:match('animation:(.*)') then
ver = 'متحركة'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(Zelzal.."Zelzal:Filter:Group:"..v..msg_chat_id)   
Filter = Filter..""..k.."- "..ver.." ← ( "..Text_Filter.." )\n"    
end  
send(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then    
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:FilterText'..msg_chat_id..':'..msg.sender_id.user_id,'true')
return send(msg_chat_id,msg_id,'\n*⇜ ارسل الان ( ملصق ,متحركة ,صورة ,رسالة ) *',"md",true)  
end    
if text == "الغاء منع" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:FilterText'..msg_chat_id..':'..msg.sender_id.user_id,'DelFilter')
return send(msg_chat_id,msg_id,'\n*⇜ ارسل الان ( ملصق ,متحركة ,صورة,رسالة ) *',"md",true)  
end
if text == "اضف امر عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' )',"md",true)  
end
Redis:set(Zelzal.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender_id.user_id,"true") 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي الامر القديم ...*","md",true)
end
if text == "حذف امر عام" or text == "مسح امر عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' )',"md",true)  
end
Redis:set(Zelzal.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender_id.user_id,"true") 
return send(msg_chat_id,msg_id,"*⇜ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم*","md",true)
end
if text == "حذف الاوامر المضافه العامه" or text == "مسح الاوامر المضافه العامه" or text == "مسح الاوامر المضافه عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' )',"md",true)  
end
local list = Redis:smembers(Zelzal.."All:Command:List:Group")
for k,v in pairs(list) do
Redis:del(Zelzal.."All:Get:Reides:Commands:Group"..v)
Redis:del(Zelzal.."All:Command:List:Group")
end
return send(msg_chat_id,msg_id,"*⇜ ابشر مسحت جميع الاوامر التي تم اضافتها في العام*","md",true)
end
if text == "الاوامر المضافه العامه" or text == "الاوامر المضافه عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' )',"md",true)  
end
local list = Redis:smembers(Zelzal.."All:Command:List:Group")
Command = "*⇜ قائمة الاوامر المضافه عام* \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
Commands = Redis:get(Zelzal.."All:Get:Reides:Commands:Group"..v)
if Commands then 
Command = Command..""..k.." - ( "..v.." ) ࿓ ( "..Commands.." )\n"
else
Command = Command..""..k.." - ( "..v.." ) \n"
end
end
if #list == 0 then
Command = "*⇜ مافي اوامر اضافية عامة*"
end
return send(msg_chat_id,msg_id,Command,"md",true)
end
if text == "اضف امر" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Command:Reids:Group"..msg_chat_id..":"..msg.sender_id.user_id,"true") 
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر ', data =msg.sender_id.user_id..'/cancelamr'}
},
}
}
return send(msg_chat_id,msg_id,"*⇜ ارسل لي الامر القديم ...*", 'md', false, false, false, false, reply_markup)
end
if text == "مسح امر" or text == "حذف امر" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender_id.user_id,"true") 
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر ', data =msg.sender_id.user_id..'/cancelamr'}
},
}
}
return send(msg_chat_id,msg_id,"*⇜ ارسل الامر الذي قمت بوضعه مكان الامر القديم*", 'md', false, false, false, false, reply_markup)
end
if text == "مسح الاوامر المضافه" or text == "مسح الاوامر المضافة" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
Redis:del(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
Redis:del(Zelzal.."Zelzal:Command:List:Group"..msg_chat_id)
end
return send(msg_chat_id,msg_id,"⇜ تم مسح جميع الاوامر المضافة","md",true)
end
if text == "الاوامر المضافه" or text == "الاوامر المضافة" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:Command:List:Group"..msg_chat_id.."")
Command = "*⇜ قائمـة الاوامـر المضافة في المجموعـة* \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
Commands = Redis:get(Zelzal.."Zelzal:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ( "..v.." ) ← ( "..Commands.." )\n"
else
Command = Command..""..k..": ( "..v.." ) \n"
end
end
if #list == 0 then
Command = "⇜ لا يوجد اوامر مضافة"
end
return send(msg_chat_id,msg_id,Command,"md",true)
end
-------------------------------------------------------------------------------------------
if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:PinId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ التثبيت مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:PinId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ التثبيت مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:PinId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ التثبيت مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:PinId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ التثبيت مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:PinId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ التثبيت مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحية تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n*⇜ تم تثبيت الرسالة*","md",true)
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = bot.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end
if text == 'الغاء التثبيت' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحية تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n*⇜ تم الغاء تثبيت الرسالة*","md",true)
bot.unpinChatMessage(msg.chat_id,bot.getChatPinnedMessage(msg.chat_id).id) 
end
if text == 'الغاء تثبيت الكل' then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحية تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n*⇜ تم الغاء تثبيت جميع الرسائل*","md",true)
for i=0, 20 do
local UnPin = bot.unpinChatMessage(msg_chat_id) 
if not bot.getChatPinnedMessage(msg_chat_id).id then
break
end
end
end
if text == "ردود البوت" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'تغييـر الـردود عراقيـة 🇮🇶', data = msg.sender_id.user_id..'/'.. 'zelzal_iraq'},},
{{text = 'تغييـر الـردود يمنيـة 🇾🇪', data = msg.sender_id.user_id..'/'.. 'zelzal_yemen'},},
{{text = 'تغييـر الـردود مصريـة 🇪🇬', data = msg.sender_id.user_id..'/'.. 'zelzal_egibt'},},
{{text = 'تغييـر الـردود سوريـة 🇸🇾', data = msg.sender_id.user_id..'/'.. 'zelzal_syria'},},
{{text = 'تغييـر الـردود خليجيـة 🇸🇦', data = msg.sender_id.user_id..'/'.. 'zelzal_ksa'},},
{{text = 'تعطيل ردود البـوت', data = msg.sender_id.user_id..'/'.. 'zilzal_zizo'},},
{{text = '✦ اخفاء الامر ✦', data =msg.sender_id.user_id..'/'.. 'delAmr'}},}}
return send(msg_chat_id, msg_id, '*⇜ لـوحـة تحكـم اوامـر ردود البـوت ع حسب اللهجــه ✓*', 'md', false, false, false, false, reply_markup)
end  
if text == "الحمايه" or text == "الحماية" then 
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender_id.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender_id.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender_id.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender_id.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'تعطيل الايدي', data = msg.sender_id.user_id..'/'.. 'unmute_Id'},{text = 'تفعيل الايدي', data = msg.sender_id.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender_id.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender_id.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = msg.sender_id.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = msg.sender_id.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = msg.sender_id.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = msg.sender_id.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = msg.sender_id.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender_id.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender_id.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender_id.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender_id.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender_id.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender_id.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender_id.user_id..'/'.. 'mute_kickme'},
},
{
{text = 'تعطيل التسليه', data = msg.sender_id.user_id..'/'.. 'unmute_thshesh'},{text = 'تفعيل التسليه', data = msg.sender_id.user_id..'/'.. 'mute_thshesh'},
},
{
{text = 'تعطيل الحظر المحدود', data = msg.sender_id.user_id..'/'.. 'unmute_kicknum'},{text = 'تفعيل الحظر المحدود', data = msg.sender_id.user_id..'/'.. 'mute_kicknum'},
},
{
{text = 'تعطيل الصيغ', data = msg.sender_id.user_id..'/'.. 'unmute_seck'},{text = 'تفعيل الصيغ', data = msg.sender_id.user_id..'/'.. 'mute_seck'},
},
{
{text = 'تعطيل غنيلي', data = msg.sender_id.user_id..'/'.. 'unmute_knile'},{text = 'تفعيل غنيلي', data = msg.sender_id.user_id..'/'.. 'mute_knile'},
},
{
{text = 'تعطيل الابراح', data = msg.sender_id.user_id..'/'.. 'unmute_brj'},{text = 'تفعيل الابراج', data = msg.sender_id.user_id..'/'.. 'mute_brj'},
},
{
{text = 'تعطيل الصوتيات', data = msg.sender_id.user_id..'/'.. 'unmute_audio'},{text = 'تفعيل الصوتيات', data = msg.sender_id.user_id..'/'.. 'mute_audio'},
},
{
{text = 'تعطيل الصوتيات العامه', data = msg.sender_id.user_id..'/'.. 'unmute_audioall'},{text = 'تفعيل الصوتيات العامه', data = msg.sender_id.user_id..'/'.. 'mute_audioall'},
},
{
{text = 'تعطيل تاك عام', data = msg.sender_id.user_id..'/'.. 'unmute_takall'},{text = 'تفعيل تاك عام', data = msg.sender_id.user_id..'/'.. 'mute_takall'},
},
{
{text = 'تعطيل التنبيه', data = msg.sender_id.user_id..'/'.. 'unmute_namemy'},{text = 'تفعيل التنبيه', data = msg.sender_id.user_id..'/'.. 'mute_namemy'},
},
{
{text = 'إخفـاء الامـر ', data ='/delAmr'}
},
}
}
return send(msg_chat_id, msg_id, '⇜ اوامر التفعيل والتعطيل ', 'md', false, false, false, false, reply_markup)
end 
if text == 'اعدادات الحمايه' or text == "اعدادات الحماية" then 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if Redis:get(Zelzal.."Zelzal:Status:Link"..msg.chat_id) then
Statuslink = 'نعم' else Statuslink = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:Welcome"..msg.chat_id) then
StatusWelcome = 'نعم' else StatusWelcome = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:Id"..msg.chat_id) then
StatusId = 'نعم' else StatusId = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = 'نعم' else StatusIdPhoto = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:Reply"..msg.chat_id) then
StatusReply = 'نعم' else StatusReply = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = 'نعم' else StatusReplySudo = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:BanId"..msg.chat_id)  then
StatusBanId = 'نعم' else StatusBanId = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:SetId"..msg.chat_id) then
StatusSetId = 'نعم' else StatusSetId = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:Games"..msg.chat_id) then
StatusGames = 'نعم' else StatusGames = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:KickMe"..msg.chat_id) then
Statuskickme = 'نعم' else Statuskickme = 'لا'
end
if Redis:get(Zelzal.."Zelzal:Status:AddMe"..msg.chat_id) then
StatusAddme = 'نعم' else StatusAddme = 'لا'
end
local protectionGroup = '\n⇜ اعدادات حماية القروب\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
..'\n⇜ جلب الرابط ← '..Statuslink
..'\n⇜ جلب الترحيب ← '..StatusWelcome
..'\n⇜ الايدي ← '..StatusId
..'\n⇜ الايدي بالصوره ← '..StatusIdPhoto
..'\n⇜ الردود ← '..StatusReply
..'\n⇜ الردود العامه ← '..StatusReplySudo
..'\n⇜ الرفع ← '..StatusSetId
..'\n⇜ الحظر - الطرد ← '..StatusBanId
..'\n⇜ الالعاب ← '..StatusGames
..'\n⇜ امر اطردني ← '..Statuskickme..'\n\n.'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = '˹𓌗 قنـاة البـوت 𓌗.',url="t.me/"..chsource..""}},
}
}
return send(msg_chat_id, msg_id,protectionGroup,'md', false, false, false, false, reply_markup)
end
if text == "الاعدادات" or text == "اعدادات القروب" or text == "اعدادات الجروب" or text == "اعدادات الكروب" or text == "اعدادات المجموعة" or text == "اعدادات المجموعه" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Text = "\n⇜ اعدادات القروب ".."\n⇜ نعم تعني - مقفل".."\n⇜ لا تعني - مفتوح\n✓"
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data =msg.sender_id.user_id..'/'.. 'Status_link'},{text = 'الروابط : ', data =msg.sender_id.user_id..'/'.. 'Status_link'},
{text = GetSetieng(msg_chat_id).lock_spam, data =msg.sender_id.user_id..'/'.. 'Status_spam'},{text = 'السبام : ', data =msg.sender_id.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data =msg.sender_id.user_id..'/'.. 'Status_keypord'},{text = 'الكيبورد : ', data =msg.sender_id.user_id..'/'.. 'Status_keypord'},
{text = GetSetieng(msg_chat_id).lock_vico, data =msg.sender_id.user_id..'/'.. 'Status_voice'},{text = 'الاغاني : ', data =msg.sender_id.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data =msg.sender_id.user_id..'/'.. 'Status_gif'},{text = 'المتحركه : ', data =msg.sender_id.user_id..'/'.. 'Status_gif'},
{text = GetSetieng(msg_chat_id).lock_file, data =msg.sender_id.user_id..'/'.. 'Status_files'},{text = 'الملفات : ', data =msg.sender_id.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data =msg.sender_id.user_id..'/'.. 'Status_text'},{text = 'الشات : ', data =msg.sender_id.user_id..'/'.. 'Status_text'},
{text = GetSetieng(msg_chat_id).lock_ved, data =msg.sender_id.user_id..'/'.. 'Status_video'},{text = 'الفيديو : ', data =msg.sender_id.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data =msg.sender_id.user_id..'/'.. 'Status_photo'},{text = 'الصور : ', data =msg.sender_id.user_id..'/'.. 'Status_photo'},
{text = GetSetieng(msg_chat_id).lock_user, data =msg.sender_id.user_id..'/'.. 'Status_username'},{text = 'المعرفات : ', data =msg.sender_id.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data =msg.sender_id.user_id..'/'.. 'Status_tags'},{text = 'التاك : ', data =msg.sender_id.user_id..'/'.. 'Status_tags'},
{text = GetSetieng(msg_chat_id).lock_bots, data =msg.sender_id.user_id..'/'.. 'Status_bots'},{text = 'البوتات : ', data =msg.sender_id.user_id..'/'.. 'Status_bots'},
},
{
{text = GetSetieng(msg_chat_id).farsia, data =msg.sender_id.user_id..'/'.. 'Status_farsia'},{text = 'الفارسيه : ', data =msg.sender_id.user_id..'/'.. 'Status_farsia'},
{text = GetSetieng(msg_chat_id).tphlesh, data =msg.sender_id.user_id..'/'.. 'Status_tphlesh'},{text = 'الحمايه : ', data =msg.sender_id.user_id..'/'.. 'Status_tphlesh'},
},
{
{text = GetSetieng(msg_chat_id).alphsar, data =msg.sender_id.user_id..'/'.. 'Status_alphsar'},{text = 'السب : ', data =msg.sender_id.user_id..'/'.. 'Status_alphsar'},
},
{
{text = '- التالي .. ', data =msg.sender_id.user_id..'/'.. 'NextSeting'}
},
{
{text = 'إخفـاء الامـر ', data ='/delAmr'}
},
}
}
return send(msg_chat_id, msg_id, Text, 'md', false, false, false, false, reply_markup)
end
if text == "المجموعه" or text == "القروب" or text == "المجموعة" or text == "الجروب" or text == "الكروب" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Info_Chats = bot.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = bot.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = 'نعم' else web = 'لا'
end
if Get_Chat.permissions.can_change_info then
info = 'نعم' else info = 'لا'
end
if Get_Chat.permissions.can_invite_users then
invite = 'نعم' else invite = 'لا'
end
if Get_Chat.permissions.can_pin_messages then
pin = 'نعم' else pin = 'لا'
end
if Get_Chat.permissions.can_send_media_messages then
media = 'نعم' else media = 'لا'
end
if Get_Chat.permissions.can_send_messages then
messges = 'نعم' else messges = 'لا'
end
if Get_Chat.permissions.can_send_other_messages then
other = 'نعم' else other = 'لا'
end
if Get_Chat.permissions.can_send_polls then
polls = 'نعم' else polls = 'لا'
end
local Namdaysmsg = Redis:get(Zelzal.."Num:MssEgeS:Days"..msg.chat_id..os.date("%d")) or 0
local Namdayspin =Redis:get(Zelzal.."Num:PinMsg:Days"..msg.chat_id..os.date("%d")) or 0
local Namdaysjoine =Redis:get(Zelzal.."Num:joinlink:Days"..msg.chat_id..os.date("%d")) or 0
local NamdaysaddMember =Redis:get(Zelzal.."Num:AddMempber:Days"..msg.chat_id..os.date("%d")) or 0
local tfaol = '⇜ تفاعل القروب اليومي : \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n⇜ عدد الرسائل : '..Namdaysmsg..'\n⇜ الرسائل المثبته : '..Namdayspin..'\n⇜ اضافة الاعضاء : '..NamdaysaddMember..'\n⇜ دخول الاعضاء : '..Namdaysjoine..'\n⇜ نسبه التفاعل : '..TotalNsba(Namdaysmsg)..' %'
local permissions = '\n⇜ صلاحيات القروب :\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..'\n⇜ ارسال الويب : '..web..'\n⇜ تغيير معلومات القروب : '..info..'\n⇜ اضافه مستخدمين : '..invite..'\n⇜ تثبيت الرسائل : '..pin..'\n⇜ ارسال الميديا : '..media..'\n⇜ ارسال الرسائل : '..messges..'\n⇜ اضافه البوتات : '..other..'\n⇜ ارسال استفتاء : '..polls..'\n\n'
local TextChat = '\n⇜ معلومات القروب :\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..' \n⇜ اسم القروب :  ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..') \n⇜ عدد الادمنيه : '..Info_Chats.administrator_count..' \n⇜ عدد المحظورين : '..Info_Chats.banned_count..' \n⇜ عدد الاعضاء : '..Info_Chats.member_count..' \n⇜ عدد المقيديين : '..Info_Chats.restricted_count..' \n⇜ الايدي : `'..msg.chat_id..'` \n'
if Info_Chats.photo then
bot.sendPhoto(msg.chat_id, msg.id, Info_Chats.photo.sizes[1].photo.remote.id,TextChat..permissions..tfaol, "md")
else
return send(msg_chat_id,msg_id, TextChat..permissions..tfaol,"md",true)
end
end
if text and text:match("^معلومات القروب (-100%d+)$") then
local ChatIdd = text:match("^معلومات القروب (-100%d+)$")
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Chats = bot.getSupergroupFullInfo(ChatIdd)
local Get_Chat = bot.getChat(ChatIdd)
if not Get_Chat.id then
return send(msg_chat_id,msg_id,"\n⇜ الايدي غير صحيح او البوت مطرود","md",true)  
end
if Get_Chat.permissions.can_add_web_page_previews then
web = 'نعم' else web = 'لا'
end
if Get_Chat.permissions.can_change_info then
info = 'نعم' else info = 'لا'
end
if Get_Chat.permissions.can_invite_users then
invite = 'نعم' else invite = 'لا'
end
if Get_Chat.permissions.can_pin_messages then
pin = 'نعم' else pin = 'لا'
end
if Get_Chat.permissions.can_send_media_messages then
media = 'نعم' else media = 'لا'
end
if Get_Chat.permissions.can_send_messages then
messges = 'نعم' else messges = 'لا'
end
if Get_Chat.permissions.can_send_other_messages then
other = 'نعم' else other = 'لا'
end
if Get_Chat.permissions.can_send_polls then
polls = 'نعم' else polls = 'لا'
end
local permissions = '\n⇜ صلاحيات القروب :\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..'\n⇜ ارسال الويب : '..web..'\n⇜ تغيير معلومات القروب : '..info..'\n⇜ اضافه مستخدمين : '..invite..'\n⇜ تثبيت الرسائل : '..pin..'\n⇜ ارسال الميديا : '..media..'\n⇜ ارسال الرسائل : '..messges..'\n⇜ اضافه البوتات : '..other..'\n⇜ ارسال استفتاء : '..polls..'\n\n'
local TextChat = '\n⇜ معلومات القروب :\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*'..' \n⇜ اسم القروب : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..') \n⇜ عدد الادمنيه : '..Info_Chats.administrator_count..' \n⇜ عدد المحظورين : '..Info_Chats.banned_count..' \n⇜ عدد الاعضاء : '..Info_Chats.member_count..' \n⇜ عدد المقيديين : '..Info_Chats.restricted_count..' \n⇜ الايدي : `'..ChatIdd..'` \n'
if Info_Chats.photo then
bot.sendPhoto(msg.chat_id, msg.id, Info_Chats.photo.sizes[1].photo.remote.id,TextChat..permissions, "md")
else
return send(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
end
if text == 'كشف الرتب بالعدد' or text == 'كشف المجموعه بالعدد' or text == 'عدد الرتب' then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(8)..' ) ',"md",true)  
end
local MalekAsase = Redis:scard(Zelzal.."Zelzal:MalekAsase:Group"..msg.chat_id) or 0
local MalemAsase = Redis:scard(Zelzal.."Zelzal:MalemAsase:Group"..msg.chat_id) or 0
local TheBasicsQ = Redis:scard(Zelzal.."Zelzal:TheBasicsQ:Group"..msg.chat_id) or 0
local TheBasics = Redis:scard(Zelzal.."Zelzal:TheBasics:Group"..msg.chat_id) or 0
local Originators = Redis:scard(Zelzal.."Zelzal:Originators:Group"..msg.chat_id) or 0
local Managers = Redis:scard(Zelzal.."Zelzal:Managers:Group"..msg.chat_id) or 0
local Addictive = Redis:scard(Zelzal.."Zelzal:Addictive:Group"..msg.chat_id) or 0
local Distinguished = Redis:scard(Zelzal.."Zelzal:Distinguished:Group"..msg.chat_id) or 0
local TheMasicsQ = Redis:scard(Zelzal.."Zelzal:TheMasicsQ:Group"..msg.chat_id) or 0
local TheMasics = Redis:scard(Zelzal.."Zelzal:TheMasics:Group"..msg.chat_id) or 0
local Origimators = Redis:scard(Zelzal.."Zelzal:Origimators:Group"..msg.chat_id) or 0
local Mamagers = Redis:scard(Zelzal.."Zelzal:Mamagers:Group"..msg.chat_id) or 0
local Mddictive = Redis:scard(Zelzal.."Zelzal:Mddictive:Group"..msg.chat_id) or 0
local Mistinguished = Redis:scard(Zelzal.."Zelzal:Mistinguished:Group"..msg.chat_id) or 0
return send(msg_chat_id,msg_id,'\n*🚹 احصائيات رتب الاولاد هنا :*\n*• المالكين الاساسسين ⇜* '..MalekAsase..'\n*• المالكين ⇜* '..TheBasicsQ..'\n*• المنشئين الاساسيين ⇜* '..TheBasics..'\n*• المنشئين ⇜* '..Originators..'\n*• المدراء ⇜* '..Managers..'\n*• الادمنيه ⇜* '..Addictive..'\n*• المميزين ⇜* '..Distinguished..'\n\n\n*🚺 احصائيات رتب البنات هنا :*\n*• المالكات الاساسيات ⇜* '..MalemAsase..'\n*• المالكات ⇜* '..TheMasicsQ..'\n*• المنشئات الاساسيات ⇜* '..TheMasics..'\n*• المنشئات ⇜* '..Origimators..'\n*• المديرات ⇜* '..Mamagers..'\n*• الادمونات ⇜* '..Mddictive..'\n*• المميزات ⇜* '..Mistinguished..' ',"md",true)
end
if text == 'صلاحيات المجموعه' or text == "صلاحيات القروب" or text == "صلاحيات الجروب" or text == "صلاحيات الكروب" then 
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Get_Chat = bot.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = 'نعم' else web = 'لا'
end
if Get_Chat.permissions.can_change_info then
info = 'نعم' else info = 'لا'
end
if Get_Chat.permissions.can_invite_users then
invite = 'نعم' else invite = 'لا'
end
if Get_Chat.permissions.can_pin_messages then
pin = 'نعم' else pin = 'لا'
end
if Get_Chat.permissions.can_send_media_messages then
media = 'نعم' else media = 'لا'
end
if Get_Chat.permissions.can_send_messages then
messges = 'نعم' else messges = 'لا'
end
if Get_Chat.permissions.can_send_other_messages then
other = 'نعم' else other = 'لا'
end
if Get_Chat.permissions.can_send_polls then
polls = 'نعم' else polls = 'لا'
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = msg.sender_id.user_id..'/web'}, 
},
{
{text = '- تغيير معلومات المجموعه : '..info, data =msg.sender_id.user_id..  '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data =msg.sender_id.user_id..  '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data =msg.sender_id.user_id..  '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data =msg.sender_id.user_id..  '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data =msg.sender_id.user_id..  '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data =msg.sender_id.user_id..  '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data =msg.sender_id.user_id.. '/polls'}, 
},
{
{text = 'إخفـاء الامـر ', data ='/delAmr'}
},
}
}
return send(msg_chat_id, msg_id, "⇜ صلاحيات القروب : ", 'md', false, false, false, false, reply_markup)
end
-----------------
if text == "تنزيل جميع الرتب" then
local StatusMember = bot.getChatMember(msg_chat_id,msg.sender_id.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
statusvar = true
elseif msg.TheBasicsQ or msg.TheMasicsQ then
statusvar = true
else
statusvar = false
end
if statusvar == false then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص ( مالك المجموعة ) او ( المالك الاساسي )*',"md",true)
end
Redis:del(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Originators:Group"..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Managers:Group"..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id)
Redis:del(Zelzal.."Zelzal:TheMasics:Group"..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Origimators:Group"..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Mamagers:Group"..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Mddictive:Group"..msg_chat_id)
--Redis:del(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id)
return send(msg_chat_id,msg_id,'\n*⇜ تم تنزيل جميع رتب المجموعة 🎖*\n( المنشئين والمنشئات الاساسسين - المنشئين والمنشئات - المدراء والمديرات - الادمنيه والادمونات ) ',"md",true)
end
if text and text:match('ضع لقب (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('ضع لقب (.*)')
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن او ليست لدي جميع الصلاحيات *","md",true)
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
local SetCustomTitle = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender_id.user_id.."&custom_title="..CustomTitle)
local SetCustomTitle_ = JSON.decode(SetCustomTitle)
if SetCustomTitle_.result == true then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"*⇜ ابشر حطيتله لقب :* "..CustomTitle).Reply,"md",true)  
else
return send(msg_chat_id,msg_id,"\n*⇜ عذراً هناك خطا تاكد من البوت ومن الشخص*","md",true)  
end 
end
if text and text:match('^ضع لقب @(%S+) (.*)$') then
local UserName = {text:match('^ضع لقب @(%S+) (.*)$')}
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عذراً البوت ليس ادمن او ليست لدي جميع الصلاحيات* ","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName[1])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local SetCustomTitle = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
local SetCustomTitle_ = JSON.decode(SetCustomTitle)
if SetCustomTitle_.result == true then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"*⇜ ابشر حطيتله لقب :* "..UserName[2]).Reply,"md",true)
else
return send(msg_chat_id,msg_id,"\n*⇜ عذراً هناك خطا تاكد من البوت ومن الشخص*","md",true)  
end 
end
if text and text:match("^ضع التكرار (%d+)$") or text and text:match("^وضع التكرار (%d+)$") then  
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
local Numbardel = text:match("^ضع التكرار (%d+)$") or text:match("^وضع التكرار (%d+)$")
Redis:hset(Zelzal.."Zelzal:Spam:Group:User"..msg_chat_id ,"Num:Spam",Numbardel)  
send(msg_chat_id,msg_id, '*⇜ تم تعيين عدد التكرار : '..Numbardel..'*',"md",true)
end
if text == 'مسح رسائلي' then
Redis:del(Zelzal..'Zelzal:Num:Message:User'..msg.chat_id..':'..msg.sender_id.user_id)
send(msg_chat_id,msg_id,'*⇜ تم مسح جميع رسائلك* ',"md",true)  
elseif text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' then
Redis:del(Zelzal..'Zelzal:Num:Message:Edit'..msg.chat_id..msg.sender_id.user_id)
send(msg_chat_id,msg_id,'*⇜ تم مسح جميع تعديلاتك*',"md",true) 
elseif text == 'مسح لايكاتي' or text == 'حذف لايكاتي' then
Redis:del(Zelzal..'Zilzal:Message:Like'..msg.sender_id.user_id)
Redis:del(Zelzal..msg.sender_id.user_id.."List_Like")
send(msg_chat_id,msg_id,'*⇜ تم مسـح جميـع لايكـاتـك والمعجبيـن .. بنجـاح ✓*',"md",true) 
elseif text == 'مسح جهاتي' then
Redis:del(Zelzal..'Zelzal:Num:Add:Memp'..msg.chat_id..':'..msg.sender_id.user_id)
send(msg_chat_id,msg_id,'*⇜ تم مسح جميع جهاتك*',"md",true)  
elseif text == 'رسائلي' or text == 'رسايلي' then
send(msg_chat_id,msg_id,'*⇜ عـدد رسـائلك هنـا ← *'..(Redis:get(Zelzal..'Zelzal:Num:Message:User'..msg.chat_id..':'..msg.sender_id.user_id) or 1)..'',"md",true)  
elseif text == 'سحكاتي' or text == 'تعديلاتي' then
send(msg_chat_id,msg_id,'*⇜ عـدد تعديـلاتـك هنـا ← *'..(Redis:get(Zelzal..'Zelzal:Num:Message:Edit'..msg.chat_id..msg.sender_id.user_id) or 0)..'',"md",true) 
elseif text == 'اعجاباتي' or text == 'لايكاتي' then
send(msg_chat_id,msg_id,'*⇜ عـدد لايكـاتـك ⇜ '..(Redis:get(Zelzal..'Zilzal:Message:Like'..msg.sender_id.user_id) or 0)..' ♥️*',"md",true)  
elseif text == 'جهاتي' then
send(msg_chat_id,msg_id,'*⇜ عـدد جهـاتـك هنـا ← *'..(Redis:get(Zelzal.."Zelzal:Num:Add:Memp"..msg.chat_id..":"..msg.sender_id.user_id) or 0)..'',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and (msg.Addictive or msg.Mddictive) then
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*⇜ البوت ليس لديه صلاحية مسح الرسائل*',"md",true)  
end
bot.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
bot.deleteMessages(msg.chat_id,{[1]= msg_id})
end
---------------------- Dev ZilZal ----------------------
if text == 'مسح خمس نجمات' or text == 'حذف خمس نجمات' then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:del(Zelzal..'Zilzal:Takeem:T5')
send(msg_chat_id,msg_id,'*⇜ تم مسـح جميـع تقييم الخمس نجمات .. بنجـاح ✓*',"md",true)
end
end
if text == 'مسح اربع نجمات' or text == 'حذف اربع نجمات' then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:del(Zelzal..'Zilzal:Takeem:T4')
send(msg_chat_id,msg_id,'*⇜ تم مسـح جميـع تقييم الاربع نجمات .. بنجـاح ✓*',"md",true)
end
end
if text == 'مسح ثلاث نجمات' or text == 'حذف ثلاث نجمات' then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:del(Zelzal..'Zilzal:Takeem:T3')
send(msg_chat_id,msg_id,'*⇜ تم مسـح جميـع تقييم الثلاث نجمات .. بنجـاح ✓*',"md",true)
end
end
if text == 'مسح نجمتان' or text == 'حذف نجمتان' then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:del(Zelzal..'Zilzal:Takeem:T2')
send(msg_chat_id,msg_id,'*⇜ تم مسـح جميـع تقييم النجمتان .. بنجـاح ✓*',"md",true)
end
end
if text == 'مسح نجمه' or text == 'حذف نجمه' then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:del(Zelzal..'Zilzal:Takeem:T1')
send(msg_chat_id,msg_id,'*⇜ تم مسـح جميـع تقييم النجمه .. بنجـاح ✓*',"md",true)
end
end
---------------------- Dev ZilZal ----------------------
if text == "تفعيل متجر الرتب" or text == "تفعيل متجر الالعاب" or text == "تفعيل شراء رتبه" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هذا الامر يخص { '..Controller_Num(5)..' }* ',"md",true)  
end
send(msg_chat_id,msg_id,'*⇜ تم تفعيـل متجـر الالعـاب بنجــاح ...\n✓*',"md")
Redis:del(Zelzal..'Matger:Rotp'..msg.chat_id) 
end
if text == "تعطيل متجر الرتب" or text == "تعطيل متجر الالعاب" or text == "تعطيل شراء رتبه" then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هذا الامر يخص { '..Controller_Num(5)..' }* ',"md",true)  
end
send(msg_chat_id,msg_id,'*⇜ تم تعطيـل متجـر الالعـاب بنجــاح ...\n✓*',"md")
Redis:set(Zelzal..'Matger:Rotp'..msg.chat_id,true)  
end
if text == 'شراء رتبه' or text == 'متجر الرتب' or text == 'متجر الالعاب' then 
if Redis:get(Zelzal..'Matger:Rotp'..msg.chat_id) then
return send(msg.chat_id,msg.id,"*⇜ مايمديـك تشتـري رتبـه هنـا 🤷🏻‍♀\n⇜ متجـر الـرتب معطـل من قبـل المنشئيــن🎖*","md",true)
end
local Nokat = Redis:get(Zelzal.."Zelzal:Num:Add:Games"..msg.chat_id..msg.sender_id.user_id) or 0
local zilzal = '*⇜ مرحبًـا بـك عـزيـزي\n⇜ فـي متجـر رتب البـوت 🏦🎗\n⇜ تستطيـع شـراء اي رتبـه مقابـل نقـاط الالعـاب\n⇜ اسعـار الـرتب كالتـالي :\n\n- منشـئ اساسـي/منشئـه اساسيـه ⇜ ⌠ 5000 ⌡ 🎖\n- منشـئ/منشئـه ⇜ ⌠ 3500 ⌡🏅\n- مـديـر/مـديـره ⇜ ⌠ 2000 ⌡🥇\n- ادمــن/ادمـونـه ⇜ ⌠ 1200 ⌡🥈\n- مميــز/مميــزه ⇜ ⌠ 700 ⌡🥉\n\n⇜ عــدد نقـاطـك هــو ⇜ ⌠ '..Nokat..' ⌡⛹🏻‍♀*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'منشئ اساسي ✦ ', data = msg.sender_id.user_id..'/asrtp'},{text = '✦ منشئه اساسيه ', data = msg.sender_id.user_id..'/msrtp'},},
{{text = 'منشـئ ✦ ', data = msg.sender_id.user_id..'/assrtp'},{text = '✦ منشئـه ', data = msg.sender_id.user_id..'/mssrtp'},},
{{text = 'مديـر ✦ ', data = msg.sender_id.user_id..'/asssrtp'},{text = '✦ مديـره ', data = msg.sender_id.user_id..'/msssrtp'},},
{{text = 'ادمـن ✦ ', data = msg.sender_id.user_id..'/assssrtp'},{text = '✦ ادمـونه ', data = msg.sender_id.user_id..'/mssssrtp'},},
{{text = 'مميـز ✦ ', data = msg.sender_id.user_id..'/asssssrtp'},{text = '✦ مميـزه ', data = msg.sender_id.user_id..'/msssssrtp'},},
{{text = 'إخفـاء الامـر ', data ='/delAmr'}},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",false, false, false, false, reply_markup)
end
---------------------- Dev ZilZal ----------------------
if text == "سيارتي" then
local ban = bot.getUser(msg.sender_id.user_id)
local Name = '['..ban.first_name..'](tg://user?id='..ban.id..')' or 'لا يوجد اسم'
local Zilzal = '*⇜ مرحبًـا عـزيـزي ⇜ *'..Name..'\n*⇜ قم بالضغـط ع الـزر لعـرض سيارتـك 🚘*'
local photo = "https://t.me/syzedrattt/13"
local msg_reply = msg.id/2097152/0.5
local keyboard = {}
keyboard.inline_keyboard = {
{
{text = '• اضغـط هنـا •', callback_data=msg.sender_id.user_id.."/mysysr"},
},
}
return https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..msg_reply.."&photo="..photo.."&caption="..URL.escape(Zilzal).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
---------------------- Dev ZilZal ----------------------
if text == 'تفاعل المجموعه' or text == 'تفاعل القروب' and msg.reply_to_message_id == 0 then
local Namdaysmsg = Redis:get(Zelzal.."Num:MssEgeS:Days"..msg.chat_id..os.date("%d")) or 0
local Namdayspin =Redis:get(Zelzal.."Num:PinMsg:Days"..msg.chat_id..os.date("%d")) or 0
local Namdaysjoine =Redis:get(Zelzal.."Num:joinlink:Days"..msg.chat_id..os.date("%d")) or 0
local NamdaysaddMember =Redis:get(Zelzal.."Num:AddMempber:Days"..msg.chat_id..os.date("%d")) or 0
local tfaol = '\n⇜ تفاعل القروب اليومي : \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n\n⇜ عدد الرسائل : '..Namdaysmsg..'\n⇜ الرسائل المثبته : '..Namdayspin..'\n⇜ اضافة الاعضاء : '..NamdaysaddMember..'\n⇜ دخول الاعضاء : '..Namdaysjoine..'\n⇜ نسبه التفاعل : '..TotalNsba(Namdaysmsg)..' %'
return send(msg_chat_id,msg_id,tfaol, "md")
end
if text == 'تعيين الايدي' or text == 'تعيين ايدي' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Redis:Id:Group"..msg.chat_id..""..msg.sender_id.user_id,240,true)  
return send(msg_chat_id,msg_id,[[
*تمام , الحين ارسل شكل الايدي الجديد*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
*- الاختصـارات :*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
`{الاسم}`  *↼ اسم المستخدم*
`{اليوزر}`  *↼ يوزر المستخدم*
`{الرسائل}`  *↼ عدد الرسائل*
`{الصور}`  *↼ عدد الصور*
`{الايدي}`  *↼ ايدي المستخدم*
`{التفاعل}`  *↼ نسبة التفاعل*
`{الرتبه}`  *↼ رتبة المستخدم*
`{التعديل}`  *↼ عدد التعديلات*
`{النقاط}`  *↼ عدد النقاط*
`{البايو}`  *↼ بايو المستخدم*
`{الجهات}`  *↼ عدد الجهات*
`{تعليق}`  *↼ تعليق الصوره*

*- اضغـط على الاختصـارات لـ النسـخ .*
]],"md",true)    
end 
if text == 'مسح الايدي' or text == 'مسح ايدي' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Set:Id:Group"..msg.chat_id)
return send(msg_chat_id,msg_id, '*⇜ تم ازالة كليشة الايدي *',"md",true)  
end
if text == 'تغيير الايدي' or text == 'تغير الايدي' then
if Redis:sismember(Zelzal.."Zelzal:Text:Cmd:Lock"..msg_chat_id,text) then
if Locks_Status(msg.sender_id.user_id,msg,text) ~= "noon" then
return send(msg_chat_id,msg_id,Locks_Status(msg.sender_id.user_id,msg,text),"md",true)
end
end
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
local List = { 
[[
𖡋 𝐔𝐒𝐄 ⌯  {اليوزر} 
𖡋 𝐌𝐒𝐆 ⌯  {الرسائل} 
𖡋 𝐒𝐓𝐀 ⌯  {الرتبه} 
𖡋 𝐈𝐃 ⌯  {الايدي} 
𖡋 𝐄𝐃𝐈𝐓 ⌯  {التعديل}
{البايو}
]],
[[
𖤂 ~ 𝑢𝑠𝑒 {اليوزر} 𖤐
𖤂 ~ 𝑚𝑠𝑔  {الرسائل} 𖤐
𖤂 ~ 𝑠𝑡𝑎  {الرتبه} 𖤐
𖤂 ~ 𝑖𝑑  {الايدي} 𖤐
𖤂 ~ 𝑒𝑑𝑖𝑡 {التعديل} 𖤐
{البايو}
]],
[[
⌁ NaMe ⇨ {الاسم}    
⌁ Use ⇨ {اليوزر} 
⌁ Msg ⇨ {الرسائل} 
⌁ Sta ⇨ {الرتبه} 
⌁ iD ⇨ {الايدي} 
{البايو}
]],
[[
.𖣂 𝙪𝙨𝙚𝙧 , {اليوزر} 
.𖣂 𝙡𝘿 , {الايدي}  
.𖣂 𝙢𝙨𝙂𝙨 , {الرسائل}
.𖣂 𝙨𝙩𝙖𝙨𝙩 , {الرتبه}  
.𖣂 𝙂𝙖𝙢𝙨 , {النقاط} 
]],
[[
☆-𝐮𝐬𝐞𝐫 : {اليوزر} 𖣬  
☆-𝐦𝐬𝐠  : {الرسائل} 𖣬 
☆-𝐬𝐭𝐚 : {الرتبه} 𖣬 
☆-𝐢𝐝  : {الايدي} 𖣬
{البايو}
]],
[[
. USERNAME . {اليوزر}
. STAST . {الرتبه}
. ID . {الايدي}
. MSG . {الرسائل}
. Bio . {البايو}
]],
[[
- USE 𖦹 {اليوزر}
- MSG 𖥳 {الرسائل} 
- STA 𖦹 {الرتبه}
- iD 𖥳 {الايدي}
{البايو}
]],
[[
➞: 𝒔𝒕𝒔𓂅 {الرتبه} 𓍯
➞: 𝒖𝒔𝒆𝒓𓂅 {اليوزر} 𓍯
➞: 𝒎𝒔𝒈𝒆𓂅 {الرسائل} 𓍯
➞: 𝒊𝒅 𓂅 {الايدي} 𓍯
{البايو}
]],
[[
 . User . {اليوزر}
 . Sts . {الرتبه}
 . Id . {الايدي}
 . Msg . {الرسائل}
 . Bio . {البايو}
]],
[[
َ› Msgs : {الرسائل} 
َ› ID : {الايدي}
َ› Stast : {الرتبه}
َ› UserName : {اليوزر} 
َ› Bio : {البايو} 
]],
[[
♡ : 𝐼𝐷 𖠀 {الايدي} .
♡ : 𝑈𝑆𝐸𝑅 𖠀 {اليوزر} .
♡ : 𝑀𝑆𝐺𝑆 𖠀 {الرسائل} .
♡ : 𝑆𝑇𝐴𝑇𝑆 𖠀 {الرتبه} .
♡ : 𝐸𝐷𝐼𝑇  𖠀 {التعديل} .
{البايو}
]]} 
local Text_Rand = List[math.random(#List)] 
Redis:set(Zelzal.."Zelzal:Set:Id:Group"..msg.chat_id,Text_Rand)
return send(msg_chat_id,msg_id, '*⇜ تم تغيير الايدي*',"md",true)  
end
if text == 'مسح الايدي عام' or text == 'مسح ايدي عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Set:Id:Groups")
return send(msg_chat_id,msg_id, '*⇜ تم ازالة كليشة الايدي عام*',"md",true)  
end
if text == 'تعيين الايدي عام' or text == 'تعيين الايدي العام' or text == 'ضع الايدي عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Redis:Id:Groups"..msg.chat_id..""..msg.sender_id.user_id,240,true)  
return send(msg_chat_id,msg_id,[[
*تمام , الحين ارسل شكل الايدي الجديد*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
*- الاختصـارات :*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
`{الاسم}`  *↼ اسم المستخدم*
`{اليوزر}`  *↼ يوزر المستخدم*
`{الرسائل}`  *↼ عدد الرسائل*
`{الصور}`  *↼ عدد الصور*
`{الايدي}`  *↼ ايدي المستخدم*
`{التفاعل}`  *↼ نسبة التفاعل*
`{الرتبه}`  *↼ رتبة المستخدم*
`{التعديل}`  *↼ عدد التعديلات*
`{النقاط}`  *↼ عدد النقاط*
`{البايو}`  *↼ بايو المستخدم*
`{الجهات}`  *↼ عدد الجهات*
`{تعليق}`  *↼ تعليق الصوره*

*- اضغـط على الاختصـارات لـ النسـخ .*
]],"md",true)    
end 
if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'الثانويين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:DevelopersQ:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مطورين ثانويين ","md",true)  
end
Redis:del(Zelzal.."Zelzal:DevelopersQ:Groups") 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من المطورين الثانويين🎖️","md",true)
end
if TextMsg == 'المطورين' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Developers:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مطورين بعد ","md",true)  
end
Redis:del(Zelzal.."Zelzal:Developers:Groups") 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من المطـورين ","md",true)
end
if TextMsg == 'المالكين' then
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
local Info_Memberss = Redis:smembers(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id) 
if #Info_Memberss == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مالكين ","md",true)  
end
Redis:del(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id) 
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id,v.member_id.user_id) 
end
end
end
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Memberss.." ) من المالكين ","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(8)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد منشئين اساسيين ","md",true)  
end
Redis:del(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members..") من المنشئين الاساسيين ","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.TheBasics or not msg.TheMasics then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(4)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد منشئين  ","md",true)  
end
Redis:del(Zelzal.."Zelzal:Originators:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من المنشئين ","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مدراء ","md",true)  
end
Redis:del(Zelzal.."Zelzal:Managers:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من المدراء ","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' )  ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد ادمنيه","md",true)  
end
Redis:del(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من الادمنيه ","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مميزين ","md",true)  
end
Redis:del(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من المميزين ","md",true)
end
if TextMsg == 'المحظورين عام' or TextMsg == 'قائمه العام' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد محظورين عام ","md",true)  
end
Redis:del(Zelzal.."Zelzal:BanAll:Groups") 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من المحظورين عام ","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد محظورين ","md",true)  
end
Redis:del(Zelzal.."Zelzal:BanGroup:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من المحظورين ","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد مكتومين ","md",true)  
end
Redis:del(Zelzal.."Zelzal:SilentGroup:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..#Info_Members.." ) من المكتومين ","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية حظر المستخدمين ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
local y = false
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
bot.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
y = true
end
end
if y == true then
return send(msg_chat_id,msg_id,"⇜ تم مسح ( "..x.." ) من المقيديين ","md",true)
else
send(msg_chat_id,msg_id,'⇜ لا يوجد مقيدين ',"md",true)  
end
end
if TextMsg == 'البوتات' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية حظر المستخدمين ',"md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = bot.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return send(msg_chat_id,msg_id,"\n⇜ عدد البوتات : "..#List_Members.."\n⇜ تم طرد ( "..x.." ) بوت من القروب ","md",true)  
end
if TextMsg == 'المطرودين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية حظر المستخدمين ',"md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Banned", "*", 0, 200)
x = 0
local y = false
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNBan_Bots = bot.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNBan_Bots.luatele == "ok" then
x = x + 1
y = true
end
end
if y == true then
return send(msg_chat_id,msg_id,"\n⇜ عدد المطرودين : "..#List_Members.."\n⇜ تم الغاء الحظر عن ( "..x.." ) ","md",true)  
else
send(msg_chat_id,msg_id,'⇜ لا يوجد مطرودين ',"md",true)  
end
end
if TextMsg == 'المحذوفين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية حظر المستخدمين ',"md",true)  
end
local Info_Members = bot.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
local y = false
for k, v in pairs(List_Members) do
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.type.luatele == "userTypeDeleted" then
local userTypeDeleted = bot.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
y = true
end
end
end
if y == true then
return send(msg_chat_id,msg_id,"\n⇜ تم مسح ( "..x.." ) حساب محذوف ","md",true)  
else
send(msg_chat_id,msg_id,'⇜ لا يوجد محذوفين ',"md",true)  
end
end
end
if text == 'طرد المحذوفين' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية حظر المستخدمين ',"md",true)  
end
local Info_Members = bot.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
local y = false
for k, v in pairs(List_Members) do
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.type.luatele == "userTypeDeleted" then
local userTypeDeleted = bot.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
y = true
end
end
end
if y == true then
return send(msg_chat_id,msg_id,"\n⇜ تم طرد ( "..x.." ) حساب محذوف ","md",true)  
else
send(msg_chat_id,msg_id,'⇜ لا يوجد محذوفين ',"md",true)  
end
end
if text == 'طرد البوتات' then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n⇜ البوت ليس لديه صلاحية حظر المستخدمين ',"md",true)  
end
local Info_Members = bot.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = bot.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return send(msg_chat_id,msg_id,"\n⇜ عدد البوتات : "..#List_Members.."\n⇜ تم طرد ( "..x.." ) بوت ","md",true)  
end
if text == ("مسح الردود") then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:Gif"..v..msg_chat_id)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:Vico"..v..msg_chat_id)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:Stekrs"..v..msg_chat_id)     
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:Text"..v..msg_chat_id)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:Photo"..v..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:Video"..v..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:File"..v..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:video_note"..v..msg_chat_id)
Redis:del(Zelzal.."Zelzal:Add:Rd:Manager:Audio"..v..msg_chat_id)
Redis:del(Zelzal.."Zelzal:List:Manager"..msg_chat_id)
end
return send(msg_chat_id,msg_id,"⇜ تم مسح جميع الردود","md",true)  
end
if text == "الردود" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:List:Manager"..msg_chat_id.."")
local max_chars = 4000 -- الحد الأقصى لعدد الأحرف في الرسالة
local current_chars = 0
local message_parts = {}
local current_part = "⇜ قائمة الردود \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
local db = ""
if Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركة "
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "فويس"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رسالة"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صورة"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنية"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمة فيديو"
end
local item_string = ""..k.." - ( "..v.." ) ࿓ ( "..db.." )\n"
if current_chars + #item_string > max_chars then
table.insert(message_parts, current_part)
current_part = item_string
current_chars = #item_string
else
current_part = current_part .. item_string
current_chars = current_chars + #item_string
end
end
if #list == 0 then
current_part = "⇜ مافيه ردود مضافة ! "
end
table.insert(message_parts, current_part)
for i, part in ipairs(message_parts) do
send(msg_chat_id, msg_id, "["..part.."]", "md", true)
end
end
if text == "اضف رد" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:AradId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:AradId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:AradId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:AradId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:AradId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
Redis:set(Zelzal.."Zelzal:Set:Manager:rd"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر ', data =msg.sender_id.user_id..'/cancelamr'}
},
}
}
return send(msg_chat_id,msg_id,"*⇜ حلو ، الحين ارسل الكلمة اللي تبيها*", 'md', false, false, false, false, reply_markup)
end
if text == "مسح رد" or text == "حذف رد" then
if not msg.Managers or not msg.Mamagers then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(6)..' ) ',"md",true)  
end
if not msg.MalekAsase or not msg.MalemAsase then
if Redis:get(Zelzal.."Zelzal:TheBasicsQ:RadId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك الاسـاسي*","md",true)
end
end
if not msg.TheBasicsQ or not msg.TheMasicsQ then
if Redis:get(Zelzal.."Zelzal:TheBasics:RadId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المالك واعلى*","md",true)
end
end
if not msg.TheBasics or not msg.TheMasics then
if Redis:get(Zelzal.."Zelzal:Originators:RadId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ الاساسي واعلى*","md",true)
end
end
if not msg.Originators or not msg.Origimators then
if Redis:get(Zelzal.."Zelzal:Managers:RadId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المنشئ واعلى*","md",true)
end
end
if not msg.Managers or not msg.Mamagers then
if Redis:get(Zelzal.."Zelzal:Addictive:RadId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*⇜ الامـر مقفـل من قبـل المالك الاساسي\n⇜ مخصص فقـط لـ المدير واعلى*","md",true)
end
end
Redis:set(Zelzal.."Zelzal:Set:Manager:rd"..msg.sender_id.user_id..":"..msg_chat_id,"true2")
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر ', data =msg.sender_id.user_id..'/cancelamr'}
},
}
}
return send(msg_chat_id,msg_id,"*⇜ تمام عيني\n⇜ الحين ارسل الرد عشان امسحه*", 'md', false, false, false, false, reply_markup)
end
if text == ("مسح الردود العامه") or text == ("مسح الردود عام") then 
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..v)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..v)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..v)     
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..v)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..v)
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..v)
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:File"..v)
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..v)
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..v)
Redis:del(Zelzal.."Zelzal:List:Rd:Sudo")
end
return send(msg_chat_id,msg_id,"*⇜ تم مسح الردود عام*","md",true)  
end
if text == ("الردود العامه") or text == ("الردود عام") then 
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:List:Rd:Sudo")
text = "\n*⇜ قائمة الردود العامة *\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
if Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..v) then
db = "متحركة"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..v) then
db = "فويس"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..v) then
db = "ملصق"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..v) then
db = "رسالة"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..v) then
db = "صورة"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..v) then
db = "فيديو"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:File"..v) then
db = "ملف"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..v) then
db = "اغنية"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..v) then
db = "بصمة فيديو"
end
text = text..""..k.." - ( "..v.." ) ࿓ ( "..db.." )\n"
end
if #list == 0 then
text = "*⇜ مافيه ردود مضافة عام !*"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد عام" then 
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Set:Rd"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر ', data =msg.sender_id.user_id..'/cancelamr'}
},
}
}
return send(msg_chat_id,msg_id,"*⇜ حلو ، الحين ارسل الكلمة اللي تبيها*", 'md', false, false, false, false, reply_markup)
end
if text == "مسح رد عام" or text == "حذف رد عام" then 
if not msg.DevelopersQ or not msg.MevelopersQ then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Set:On"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر ', data =msg.sender_id.user_id..'/cancelamr'}
},
}
}
return send(msg_chat_id,msg_id,"*⇜ تمام عيني \n⇜ الحين ارسل الرد عشان امسحه عام*", 'md', false, false, false, false, reply_markup)
end
if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local GetMemberStatus = bot.getChatMember(msg_chat_id,Message_Reply.sender_id.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'نعم'
else
Restricted = 'لا️'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender_id.user_id).BanAll == true then
BanAll = 'نعم'
else
BanAll = 'لا️'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender_id.user_id).BanGroup == true then
BanGroup = 'نعم'
else
BanGroup = 'لا️'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender_id.user_id).SilentGroup == true then
SilentGroup = 'نعم'
else
SilentGroup = 'لا️'
end
send(msg_chat_id,msg_id,'⇜ حظر عام : '..BanAll..'\n⇜ الحظر : '..BanGroup..'\n⇜ الكتم : '..SilentGroup..'\n⇜ التقييد : '..Restricted..'\n ✓',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً البـوت ليـس مشـرفاً .. يرجـى رفعـه وإعطـائه كـافة الصـلاحيات*","md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local GetMemberStatus = bot.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'نعم'
else
Restricted = 'لا️'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true then
BanAll = 'نعم'
else
BanAll = 'لا️'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'نعم'
else
BanGroup = 'لا️'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'نعم'
else
SilentGroup = 'لا️'
end
send(msg_chat_id,msg_id,'⇜ حظر عام : '..BanAll..'\n⇜ الحظر : '..BanGroup..'\n⇜ الكتم : '..SilentGroup..'\n⇜ التقييد : '..Restricted..'\n ✓',"md",true)  
end
-----------------
if text == 'ضع كليشه المطور' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:GetTexting:DevZelzal'..msg_chat_id..':'..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,'⇜ ارسل لي الكليشه ')
end
if text == 'مسح كليشه المطور' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal..'Zelzal:Texting:DevZelzal')
return send(msg_chat_id,msg_id,'⇜ تم مسح كليشه المطور')
end
if text == "استبدال كلمه" or text == "استبدال كلمة" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal..msg_chat_id..msg.sender_id.user_id.."replace",true)
return send(msg_chat_id,msg_id,'\n⇜ ارسل الكلمة القديمة ليتم استبدالها',"md",true)  
end
if text == "مسح الكلمات المستبدله" or text == "مسح الكلمات المستبدلة" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local list = Redis:smembers( Zelzal..msg_chat_id.."Words:r")
for k,v in pairs(list) do
Redis:del(Zelzal..msg_chat_id.."Word:Replace"..v)
end
Redis:del(Zelzal..msg_chat_id.."Words:r")
send(msg_chat_id,msg_id,"⇜ تم مسح الكلمات المستبدلة")
end
if text == "الكلمات المستبدله" or text == "الكلمات المستبدلة" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal..msg_chat_id.."Words:r")
if #list == 0 then
return send(msg_chat_id,msg.id,"⇜ لا توجد كلمات مستبدله")
end
local txx = "⇜ قائمة الكلمات المستبدلة\n"
for k,v in pairs(list) do 
cmdd = Redis:get(Zelzal..msg_chat_id.."Word:Replace"..v)
txx = txx..k.." - ( "..v.." ) ← ( "..cmdd.." )\n"
end
send(msg_chat_id,msg_id,txx)
end
if text == "حذف حسابي" then
local ban = bot.getUser(msg.sender_id.user_id)
local Name = '['..ban.first_name..'](tg://user?id='..ban.id..')'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '⚠️ إضغــط هـنــا للحـذف ⚠️', url = 't.me/'..UserBot..'?start=delete'..msg_chat_id..'u'..msg.sender_id.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id,"*⇜ مرحبًـا عـزيـزي ⇜* "..Name.." 👋\n*⇜ تستطيـع الان حـذف حسـابك بكـل سهـولـه عبـر البـوت*","md",true,false,false,false,reply_markup) 
end
if text == 'سورس' or text == 'السورس' then
if Redis:get(Zelzal.."Sorce:Reply:inline") then
local btext = Redis:get(Zelzal.."Rd:Sorce:inline:text")
local blink = Redis:get(Zelzal.."Rd:Sorce:inline:link")
local anemi = Redis:get(Zelzal.."Add:Rd:Sorce:Gif:inline") 
local veico = Redis:get(Zelzal.."Add:Rd:Sorce:Vico:inline") 
local stekr = Redis:get(Zelzal.."Add:Rd:Sorce:Stekrs:inline") 
local Texingt = Redis:get(Zelzal.."Add:Rd:Sorce:Text:inline") 
local photo = Redis:get(Zelzal.."Add:Rd:Sorce:Photo:inline")
local photoc = Redis:get(Zelzal.."Add:Rd:Sorce:Photoc:inline")
local video = Redis:get(Zelzal.."Add:Rd:Sorce:Video:inline")
local videoc = Redis:get(Zelzal.."Add:Rd:Sorce:Videoc:inline")
local document = Redis:get(Zelzal.."Add:Rd:Sorce:File:inline")
local audio = Redis:get(Zelzal.."Add:Rd:Sorce:Audio:inline")
local audioc = Redis:get(Zelzal.."Add:Rd:Sorce:Audioc:inline")
local video_note = Redis:get(Zelzal.."Add:Rd:Sorce:video_note:inline")
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = btext , url = blink},
},
}
}
if Texingt then 
return send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)
end
if video_note then
return bot.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
return bot.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end
if stekr then 
return bot.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
return bot.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
return bot.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
return bot.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
return bot.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end
if audio then
return bot.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
else
local Text =[[
⦑ 𝗪𝗘𝗟𝗖𝗢𝗠𝗘 𝗧𝗢 𝗧𝗘𝗣𝗧𝗛𝗢𝗡 𝗦𝗢𝗨𝗥𝗖𝗘 🧧 ⦒
★┉ ┉ ┉ ┉ ┉ 𝗧𝗘𝗣𝗧𝗛𝗢𝗡 ┉  ┉ ┉ ┉ ┉★
➥┇𝗪𝗘𝗟𝗖𝗢𝗠𝗘 𝗧𝗢 𝗧𝗘𝗣𝗧𝗛𝗢𝗡 𝗦𝗢𝗨𝗥𝗖𝗘
➥┇𝗕𝗘𝗦𝗧 𝗔𝗥𝗔𝗕𝗜𝗖 𝗦𝗢𝗨𝗥𝗖𝗘
➥┇𝗕𝗘𝗦𝗧 𝗦𝗢𝗨𝗥𝗖𝗘
★┉ ┉ ┉ ┉ ┉ 𝗧𝗘𝗣𝗧𝗛𝗢𝗡 ┉  ┉ ┉ ┉ ┉★
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '˹  𝗨𝗽𝗱𝗮𝘁𝗲 ⁦. 𓌗', url = 't.me/Tepthon'},},
{{text = '˹  𝗗𝗘𝗩 ⁦. 𓌗', url = 't.me/zxaax'},},
}
local msg_id = msg.id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/PPYNY/142?single&caption=' ..URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == 'الاوامر' or text == '/Commands@'..UserBot..'' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ متأكد انك مو عضو ؟!*\n*⇜ لان الامر خاص بالادمنيه واعلى😕*',"md",true)  
end
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(Zelzal..'Zelzal:Channel:Join:Name'), url = 't.me/'..Redis:get(Zelzal..'Zelzal:Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ عليك الاشتـراك في قنـاة البـوت لـ استخـدام الاوامـر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = '❶', data = msg.sender_id.user_id..'/help1'},{text = '❷', data = msg.sender_id.user_id..'/help2'},{text = '❸', data = msg.sender_id.user_id..'/help3'},{text = '❹', data = msg.sender_id.user_id..'/help4'},{text = '❺', data = msg.sender_id.user_id..'/help5'},
},
{
{text = '❻', data = msg.sender_id.user_id..'/helpp6'},{text = '❼', data = msg.sender_id.user_id..'/help7'},{text = '❽', data = msg.sender_id.user_id..'/help8'},{text = '❾', data = msg.sender_id.user_id..'/help9'},{text = '❿', data = msg.sender_id.user_id..'/hellp10'},
},
{
{text = '⓫', data = msg.sender_id.user_id..'/hellp11'},{text = '⓬', data = msg.sender_id.user_id..'/hellp12'},{text = '⓭', data = msg.sender_id.user_id..'/hellp13'},
},
}
}
return send(msg_chat_id,msg_id, [[
*⎙┊يـوجـد ← 𝟙𝟛 قـائمــة فـي البــوت
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
 ⦇ ① ⦈  ←  اوامــر الإدارة & الـرتب
 ⦇ ② ⦈  ←  اوامــر القفـل والتعطيـل
 ⦇ ③ ⦈  ←  قوائــم القفــل / التعطيـل
 ⦇ ④ ⦈  ←  اوامــر الوضــع والاضـافـات
 ⦇ ⑤ ⦈  ←  اوامــر التسليـه والتحشيش
 ⦇ ⑥ ⦈  ←  اوامــر الخدمـات والتـرفيـه
 ⦇ ⑦ ⦈  ←  اوامــر الالعــاب
 ⦇ ⑧ ⦈  ←  اوامــر الـــردود والهـمسـات
 ⦇ ⑨ ⦈  ←  اوامــر التـاك والمنشــن
 ⦇ ⑩ ⦈  ←  اوامــر التــوب تــرنـد
 ⦇ ⑪ ⦈  ←  اوامــر الحـمـاية الـذكـيــه
 ⦇ ⑫ ⦈  ←  اوامــر الذكــاء الاصطنــاعـي
 ⦇ ⑬ ⦈  ←  اوامــر الميـوزك فـي المكالمـات
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⭐┊لـ تقييـم اداء البـوت ارسـل ← تقييم
*
]],"md",true, false, false, false, reply_markup)
---------------------- Dev ZilZal ----------------------
elseif text == 'تقييم' or text == 'تقيم' then 
local Takeem1 = Redis:get(Zelzal..'Zilzal:Takeem:T1') or 0
local Takeem2 = Redis:get(Zelzal..'Zilzal:Takeem:T2') or 0
local Takeem3 = Redis:get(Zelzal..'Zilzal:Takeem:T3') or 0
local Takeem4 = Redis:get(Zelzal..'Zilzal:Takeem:T4') or 0
local Takeem5 = Redis:get(Zelzal..'Zilzal:Takeem:T5') or 0
local NamesBot = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "البوت")
local zilzal = '*- مرحبًـا بك عـزيـزي 🫂*\n*- فـي قائمـة تقييـم البـوت ⇜ ⌠ '..NamesBot..' ⌡* 🎖\n*- قم بـ تقييـم اداء البـوت*\n*- لـ دعمنـا وتحفيزنـا لـ تقديـم المزيـد والافضـل 🏆*'
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = '⭐⤑ '..Takeem1, data = '/takeeem1'},},
{{text = '⭐⭐⤑ '..Takeem2, data = '/takeeem2'},},
{{text = '⭐⭐⭐⤑ '..Takeem3, data = '/takeeem3'},},
{{text = '⭐⭐⭐⭐⤑ '..Takeem4, data = '/takeeem4'},},
{{text = '⭐⭐⭐⭐⭐⤑ '..Takeem5..' 🎖', data = '/takeeem5'},},
}
}
return send(msg_chat_id,msg_id,zilzal,"md",true, false, false, false, reply_markup)
---------------------- Dev ZilZal ----------------------
elseif text == 'الالعاب' or text == 'العاب' then
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'شروحـات الالعـاب', data = msg.sender_id.user_id..'/gamesdes'},
},
{
{text = 'القائمه الرئيسية', data = msg.sender_id.user_id..'/helpall'},
},
}
}
local TextHelp = [[
*✦ قائمــة العــاب البــوت ⁦.🎳 𓌗*
ٴ★┉ ┉ ┉ ┉ ┉ 𝙏𝙀𝙋𝙏𝙃𝙊𝙉 ┉  ┉ ┉ ┉ ┉★
✦ اكـثـر من 100 لعبـة مسليـة وجديـدة
ٴ★┉ ┉ ┉ ┉ ┉ 𝙏𝙀𝙋𝙏𝙃𝙊𝙉 ┉  ┉ ┉ ┉ ┉★
✦ العـاب الانـلايـن 🕹  » بلاي
✦ البنـك الشهيـرة 🏦  » بنك
✦ أحكـام الشهيـره ⚖  » احكام
✦ النـوادي ⚽️  » نوادي
✦ المـزرعـة 🪵  » مزرعه
✦ لعبـة الصراحـه والغموض 🕳  » صراحه
✦ كرسـي الاعتـراف 🪑  » كرسي
✦ لعبـة عقــاب 🔪  » عقاب
✦ لعبـة الرعـب 🪬  » مريم
✦ لونك المفضل 💈  » الوان
✦ أعـلام الـدول 🚩  » اعلام
✦ عواصـم الـدول  » عواصم
✦ شخصيات ومشاهيـر 👨‍🎤  » مشاهير
✦ لعبة التحدي  » تحدي
✦ حجره - ورقه - مقص » حجره
✦ الـروليت بالمعرفـات » روليت
✦ الـروليت بالإنضمـام » الروليت
✦ لـو خيـروك  » خيرني
✦ لـو خيـروك بالصـور  » خيرني بالصور
✦ كـت تـويت  » كت
✦ كـت تـويت بالصـور  » كت صوره
✦ لعبـة الغـاز الذكـاء » لغز
✦ اسمـاء الحيوانـات » حيوانات
✦ تقـريب الصـور » زوم
✦ لعبـة الصـور » صور
✦ المختـلـف » المختلف
✦ الامثــله » امثله
✦ العكــس » العكس
✦ الحــزوره » حزوره - حزر
✦ المعــانـي » معاني
✦ المـحيبـس » بات
✦ التخـميـن » خمن
✦ الاســرع » الاسرع - ترتيب
✦ السمـايـلات » سمايلات
✦ لعبـة اكمـل الجُمـله » جمل
✦ لعبـة الكلمـات » كلمات
✦ مسائـل رياضيـات » رياضيات
✦ معانـي كلمـات انكليزيـه » انكليزي
✦ لعبـة الحـظ » الحظ - حظي
✦ لعبـة اللغـة العربيـة » عربي
✦ اسئــله متنـوعـة » اسئله
✦ لعبـة اسئلـه دينيـة » دين
✦ لعبـة التفكيـك » تفكيك
ٴ★┉ ┉ ┉ ┉ ┉ 𝙏𝙀𝙋𝙏𝙃𝙊𝙉 ┉  ┉ ┉ ┉ ┉★
*✦ متجـر الـرتب 💳🎖*
- لشـراء رتبه بالبوت مقابل نقاط الالعاب
← ❨ متجر الرتب ❩ لعـرض المتجـر
← ❨ شراء رتبه ❩ لشـراء رتبـه مقابـل نقـاط
← تفعيل / تعطيل ❨ متجر الرتب ❩
ٴ★┉ ┉ ┉ ┉ ┉ 𝙏𝙀𝙋𝙏𝙃𝙊𝙉 ┉  ┉ ┉ ┉ ┉★
✦ نقاطي ← لعـرض عـدد نقـاطك
✦ بيع نقاطي + { العدد }
كل نقطه مقابل (50) رساله
]]
return send(msg_chat_id,msg_id,TextHelp,"md",false, false, false, false, reply_markup)
end
if text == 'تحديث' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
send(msg_chat_id,msg_id, "*⇜  تم تحديث الملفات *","md",true)
dofile('Zelzal.lua')  
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n• هذا الامر يخص ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Change:Name:Bot"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي الاسم*","md",true)  
end
if text == "مسح اسم البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Name:Bot") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسم البوت*","md",true)   
end
if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = bot.getChat(v)
local ChatAction = bot.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(Zelzal..'Zelzal:Num:User:Pv',v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'⇜ العدد الكامل ( '..#list..' )\n⇜ تم العثور على ( '..x..' ) من المشتركين حاظرين البوت',"md")
else
return send(msg_chat_id,msg_id,'⇜ العدد الكامل ( '..#list..' )\n⇜ لم يتم العثور على وهميين',"md")
end
end
if text == 'تنظيف المجموعات' or text == 'تنظيف القروبات' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = bot.getChat(v)
if Get_Chat.id then
local statusMem = bot.getChatMember(Get_Chat.id,Zelzal)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
send(Get_Chat.id,0,'*⇜ البوت عضو في القروب سوف اغادر*',"md")
Redis:srem(Zelzal..'Zelzal:ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(Zelzal..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
bot.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(Zelzal..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(Zelzal..'Zelzal:ChekBotAdd',v)
bot.leaveChat(v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'⇜ العدد الكامل ( '..#list..' ) \n⇜ تم العثور على ( '..x..' ) قروب البوت ليس ادمن \n⇜ تم تعطيل القروب ومغادرة البوت من الوهمي ',"md")
else
return send(msg_chat_id,msg_id,'⇜ العدد الكامل ( '..#list..' ) \n⇜ لا توجد قروبات وهمية',"md")
end
end
if text and text:match('^رفع القيود عام @(%S+)$') then
local UserName = text:match('^رفع القيود عام @(%S+)$') 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخدام معرف قناة او مجموعة ؟!*","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً  .. لا تستطيع استخـدام معـرف البـوت ؟!*","md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:ChekBotAdd")   
for k,v in pairs(list) do  
Redis:srem(Zelzal.."Zelzal:KtmAll:Groups",UserId_Info.id) 
Redis:srem(Zelzal.."Zelzal:BanAll:Groups",UserId_Info.id) 
Redis:srem(Zelzal.."Zelzal:BanGroup:Group"..v,UserId_Info.id) 
Redis:srem(Zelzal.."Zelzal:SilentGroup:Group"..v,UserId_Info.id) 
bot.setChatMemberStatus(v,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
end
return send(msg_chat_id,msg_id,"\n*⇜ تم رفع القيود عنه عام*","md",true)  
end
-----------------
if text == 'مسح رسائله' and msg.reply_to_message_id ~= 0 then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
Redis:del(Zelzal..'Zelzal:Num:Message:User'..msg_chat_id..':'..Message_Reply.sender_id.user_id) 
return send(msg_chat_id,msg_id,"*⇜ ابشـر مسحت رسائله *", "md")
end
if text == 'مسح نقاطه' and msg.reply_to_message_id ~= 0 then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
Redis:del(Zelzal.."Zelzal:Num:Add:Games"..msg.chat_id..Message_Reply.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ ابشـر مسحت نقاطه *", "md")
end
if text == 'مسح تعديلاته' and msg.reply_to_message_id ~= 0 then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
Redis:del(Zelzal..'Zelzal:Num:Message:Edit'..msg.chat_id..Message_Reply.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ ابشـر مسحت تعديلاته *", "md")
end
if text and text:match("^بيع نقاطي (%d+)$") then
local NumGame = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NumGame) == tonumber(0) then
return send(msg_chat_id,msg_id,"\n⇜ لا استطيع بيع اقل من ( 1 ) نقطة","md",true)  
end
local NumberGame = Redis:get(Zelzal.."Zelzal:Num:Add:Games"..msg.chat_id..msg.sender_id.user_id)
if tonumber(NumberGame) == tonumber(0) then
return send(msg_chat_id,msg_id,"⇜ ماعندك نقاط \n⇜ ارسل الالعاب وابدأ اللعب ","md",true)  
end
if tonumber(NumGame) > tonumber(NumberGame) then
return send(msg_chat_id,msg_id,"⇜ نقاطك ماتكفي \n⇜ لزيادة نقاطك ارسل الالعاب وابدأ اللعب ","md",true)   
end
local NumberGet = tonumber(NumGame) * 50
Redis:decrby(Zelzal.."Zelzal:Num:Add:Games"..msg.chat_id..msg.sender_id.user_id,NumGame)  
Redis:incrby(Zelzal.."Zelzal:Num:Message:User"..msg.chat_id..":"..msg.sender_id.user_id,NumberGet)  
return send(msg_chat_id,msg_id,"⇜ تم خصم ( "..NumGame.." ) من نقاطك \n⇜ ضفتلك ( "..NumberGet.." ) رسالة","md",true)  
end 
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id ~= 0 and Redis:get(Zelzal.."Zelzal:Status:Games"..msg.chat_id) then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:incrby(Zelzal.."Zelzal:Num:Add:Games"..msg.chat_id..Message_Reply.sender_id.user_id, text:match("^اضف نقاط (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم اضافه له ( "..text:match("^اضف نقاط (%d+)$").." ) نقطة").Reply,"md",true)  
end
if text and text:match("^اضف تعديلات (%d+)$") and msg.reply_to_message_id ~= 0 and Redis:get(Zelzal.."Zelzal:Status:Games"..msg.chat_id) then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:incrby(Zelzal..'Zelzal:Num:Message:Edit'..msg.chat_id..Message_Reply.sender_id.user_id, text:match("^اضف تعديلات (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم اضافه له ( "..text:match("^اضف تعديلات (%d+)$").." ) من التعديلات").Reply,"md",true)  
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id ~= 0 and Redis:get(Zelzal.."Zelzal:Status:Games"..msg.chat_id) then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. تستطيع فقـط استخـدام الامـر على المستخدمين*","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:incrby(Zelzal.."Zelzal:Num:Message:User"..msg.chat_id..":"..Message_Reply.sender_id.user_id, text:match("^اضف رسائل (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم اضافه له ( "..text:match("^اضف رسائل (%d+)$").." ) رسالة").Reply,"md",true)  
end
if text and text:match("^اضف لايكات (%d+)$") and msg.reply_to_message_id ~= 0 then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n*⇜ عذرآ تستطيع فقط استخدام الامر على المستخدمين* ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n*⇜ هييه مايمديك تستخدم الامر علي ياورع ؟!*","md",true)  
end
Redis:sadd(Zelzal.."List_Like"..Message_Reply.sender_id.user_id,msg.sender_id.user_id)
local GetLike = Redis:incrby(Zelzal.."Zilzal:Message:Like"..Message_Reply.sender_id.user_id, text:match("^اضف لايكات (%d+)$"))  
Redis:hset(Zelzal..':GroupUserCountLike:'..msg.chat_id,Message_Reply.sender_id.user_id,GetLike)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id) 
if UserInfo.first_name then
NameLUser = UserInfo.first_name
else
NameLUser = UserInfo.first_name
end
NameLUser = NameLUser
NameLUser = NameLUser:gsub("]","")
NameLUser = NameLUser:gsub("[[]","")
Redis:hset(Zelzal..':GroupLikeNameUser:'..msg.chat_id,Message_Reply.sender_id.user_id,NameLUser)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender_id.user_id,"⇜ تم اضافه له { "..text:match("^اضف لايكات (%d+)$").." } من اللايكـات").Reply,"md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ مـايمـديك .. هـذا الامـر يخص مطـور البـوت الاسـاسـي 🧑🏻‍💻*',"md",true) 
end
end
if text and text:match("^اضف خمس نجمات (%d+)$") then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:incrby(Zelzal..'Zilzal:Takeem:T5', text:match("^اضف خمس نجمات (%d+)$"))  
return send(msg_chat_id,msg_id,"*⇜ تم اضافه عـدد* { "..text:match("^اضف خمس نجمات (%d+)$").." } *تقييـم خمس نجمـات ⭐*","md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ مـايمـديك .. هـذا الامـر يخص مطـور البـوت الاسـاسـي 🧑🏻‍💻*',"md",true) 
end
end
if text and text:match("^اضف اربع نجمات (%d+)$") then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:incrby(Zelzal..'Zilzal:Takeem:T4', text:match("^اضف اربع نجمات (%d+)$"))  
return send(msg_chat_id,msg_id,"*⇜ تم اضافه عـدد* { "..text:match("^اضف اربع نجمات (%d+)$").." } *تقييـم اربع نجمـات ⭐*","md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ مـايمـديك .. هـذا الامـر يخص مطـور البـوت الاسـاسـي 🧑🏻‍💻*',"md",true) 
end
end
if text and text:match("^اضف ثلاث نجمات (%d+)$") then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:incrby(Zelzal..'Zilzal:Takeem:T3', text:match("^اضف ثلاث نجمات (%d+)$"))  
return send(msg_chat_id,msg_id,"*⇜ تم اضافه عـدد* { "..text:match("^اضف ثلاث نجمات (%d+)$").." } *تقييـم ثلاث نجمـات ⭐*","md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ مـايمـديك .. هـذا الامـر يخص مطـور البـوت الاسـاسـي 🧑🏻‍💻*',"md",true) 
end
end
if text and text:match("^اضف نجمتين (%d+)$") then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:incrby(Zelzal..'Zilzal:Takeem:T2', text:match("^اضف نجمتين (%d+)$"))  
return send(msg_chat_id,msg_id,"*⇜ تم اضافه عـدد* { "..text:match("^اضف نجمتين (%d+)$").." } *تقييـم نجمتيـن ⭐*","md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ مـايمـديك .. هـذا الامـر يخص مطـور البـوت الاسـاسـي 🧑🏻‍💻*',"md",true) 
end
end
if text and text:match("^اضف نجمه (%d+)$") then
if tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) or tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
Redis:incrby(Zelzal..'Zilzal:Takeem:T1', text:match("^اضف نجمه (%d+)$"))  
return send(msg_chat_id,msg_id,"*⇜ تم اضافه عـدد* { "..text:match("^اضف نجمه (%d+)$").." } *تقييـم نجمـه ⭐*","md",true)  
else
return send(msg_chat_id,msg_id,'\n*⇜ مـايمـديك .. هـذا الامـر يخص مطـور البـوت الاسـاسـي 🧑🏻‍💻*',"md",true) 
end
end
if text == "نقاطي" then 
local Num = Redis:get(Zelzal.."Zelzal:Num:Add:Games"..msg.chat_id..msg.sender_id.user_id) or 0
if Num == 0 then 
return send(msg_chat_id,msg_id, "*⇜ ليس لديك نقاط ارسل الالعاب وابدأ اللعب*","md",true)  
else
return send(msg_chat_id,msg_id, "*⇜ عدد نقاطك ← *"..Num.."","md",true)  
end
end
if text == "مسح القوائم" or text == "مسح الرتب" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local reply_markup = bot.replyMarkup{
type = "inline",
data = {
{
{text="المطورين الاساسيين",data=msg.sender_id.user_id..'/Redis:Devall'},
},
{
{text="المكتومين عام",data=msg.sender_id.user_id..'/KtmAll'},{text="المحظورين عام",data=msg.sender_id.user_id..'/BanAll'},
},
{
{text="الثانويين",data=msg.sender_id.user_id..'/DevelopersQ'},{text="المطورين",data=msg.sender_id.user_id..'/Developers'},
},
{
{text="المالكين",data=msg.sender_id.user_id..'/TheBasicsQ'},{text="المنشئين الاساسيين",data=msg.sender_id.user_id..'/TheBasics'},
},
{
{text="المنشئين",data=msg.sender_id.user_id..'/Originators'},{text="المدراء",data=msg.sender_id.user_id..'/Managers'},
},
{
{text="الادمنيه",data=msg.sender_id.user_id..'/Addictive'},{text="المميزين",data=msg.sender_id.user_id..'/DelDistinguished'},
},
{
{text="المكتومين",data=msg.sender_id.user_id..'/SilentGroupGroup'},{text="المحظورين",data=msg.sender_id.user_id..'/BanGroup'},
},
{
{text = "إخفـاء الامـر ", data =msg.sender_id.user_id.."/delAmr"}
},
}
}
return send(msg_chat_id,msg_id,"*⇜ اختر احدى القوائم لمسحها :*", "md", false, false, false, false, reply_markup)
end 
if text == "مسح نقاطي" then 
Redis:del(Zelzal.."Zelzal:Num:Add:Games"..msg.chat_id..msg.sender_id.user_id)
return send(msg_chat_id,msg_id, "*⇜ ابشـر مسحت نقاطك*","md",true)  
end
if text == ("مسح الردود الانلاين العامه") or text == ("مسح ردود الانلاين عام") then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( '..Controller_Num(2)..' )* ',"md",true)  
end
local list = Redis:smembers(Zelzal.."List:Manager:inline3am")
for k,v in pairs(list) do
Redis:del(Zelzal.."Add:Rd:Manager:Gif:inline3am"..v) 
Redis:del(Zelzal.."Add:Rd:Manager:Vico:inline3am"..v) 
Redis:del(Zelzal.."Add:Rd:Manager:Stekrs:inline3am"..v) 
Redis:del(Zelzal.."Add:Rd:Manager:Text:inline3am"..v) 
Redis:del(Zelzal.."Add:Rd:Manager:Photo:inline3am"..v)
Redis:del(Zelzal.."Add:Rd:Manager:Photoc:inline3am"..v)
Redis:del(Zelzal.."Add:Rd:Manager:Video:inline3am"..v)
Redis:del(Zelzal.."Add:Rd:Manager:Videoc:inline3am"..v)
Redis:del(Zelzal.."Add:Rd:Manager:File:inline3am"..v)
Redis:del(Zelzal.."Add:Rd:Manager:video_note:inline3am"..v)
Redis:del(Zelzal.."Add:Rd:Manager:Audio:inline3am"..v)
Redis:del(Zelzal.."Add:Rd:Manager:Audioc:inline3am"..v)
Redis:del(Zelzal.."Rd:Manager:inline3am:v"..v)
Redis:del(Zelzal.."Rd:Manager:inline3am:link"..v)
Redis:del(Zelzal.."List:Manager:inline3am")
end
return send(msg_chat_id,msg_id,"*⇜ تم مسح قائمة الردود الانلاين عام*","md",true)
end
if text and Redis:get(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id) == "set_link" then
Redis:del(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id)
local zillzall = Redis:get(Zelzal.."Text:Manager:inline3am"..msg.sender_id.user_id..":")
Redis:set(Zelzal.."Rd:Manager:inline3am:link"..zillzall, text)
send(msg_chat_id,msg_id,"*「  *"..zillzall.."*  」\nواضفنا الرد ياحلو 🌚\n✓*","md",true)
return false
end
if text and Redis:get(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id) == "set_inline" then
Redis:set(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id, "set_link")
local zillzall = Redis:get(Zelzal.."Text:Manager:inline3am"..msg.sender_id.user_id..":")
Redis:set(Zelzal.."Rd:Manager:inline3am:text"..zillzall, text)
send(msg_chat_id,msg_id,"*⇜ الان ارسل الرابط \n⇜ مثال :* [https://t.me/z_zzz8]","md",true)
return false
end
if Redis:get(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id) == "true1" and tonumber(msg.sender_id.user_id) ~= tonumber(Zelzal) then
Redis:del(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id)
Redis:set(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local zillzall = Redis:get(Zelzal.."Text:Manager:inline3am"..msg.sender_id.user_id..":")
if msg.content.text then 
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Zelzal.."Add:Rd:Manager:Text:inline3am"..zillzall, text)
elseif msg.content.sticker then 
Redis:set(Zelzal.."Add:Rd:Manager:Stekrs:inline3am"..zillzall, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then
Redis:set(Zelzal.."Add:Rd:Manager:Vico:inline3am"..zillzall, msg.content.voice_note.voice.remote.id)
elseif msg.content.audio then
Redis:set(Zelzal.."Add:Rd:Manager:Audio:inline3am"..zillzall, msg.content.audio.audio.remote.id)
Redis:set(Zelzal.."Add:Rd:Manager:Audioc:inline3am"..zillzall, msg.content.caption.text)
elseif msg.content.document then
Redis:set(Zelzal.."Add:Rd:Manager:File:inline3am"..zillzall, msg.content.document.document.remote.id)
elseif msg.content.animation then
Redis:set(Zelzal.."Add:Rd:Manager:Gif:inline3am"..zillzall, msg.content.animation.animation.remote.id)
elseif msg.content.video_note then
Redis:set(Zelzal.."Add:Rd:Manager:video_note:inline3am"..zillzall, msg.content.video_note.video.remote.id)
elseif msg.content.video then
Redis:set(Zelzal.."Add:Rd:Manager:Video:inline3am"..zillzall, msg.content.video.video.remote.id)
Redis:set(Zelzal.."Add:Rd:Manager:Videoc:inline3am"..zillzall, msg.content.caption.text)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Zelzal.."Add:Rd:Manager:Photo:inline3am"..zillzall, idPhoto)
Redis:set(Zelzal.."Add:Rd:Manager:Photoc:inline3am"..zillzall, msg.content.caption.text)
end
send(msg_chat_id,msg_id,"*⇜ الان ارسل الكلام داخل الزر*","md",true)
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id.."") == "true2" then
if not Redis:sismember(Zelzal.."List:Manager:inline3am", text) then
 Redis:del(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id.."")
 return send(msg_chat_id,msg_id,"*⇜ لا يوجد رد لهذه الكلمة*","md",true)
end
Redis:del(Zelzal.."Add:Rd:Manager:Gif:inline3am"..text) 
Redis:del(Zelzal.."Add:Rd:Manager:Vico:inline3am"..text) 
Redis:del(Zelzal.."Add:Rd:Manager:Stekrs:inline3am"..text) 
Redis:del(Zelzal.."Add:Rd:Manager:Text:inline3am"..text) 
Redis:del(Zelzal.."Add:Rd:Manager:Photo:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Photoc:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Video:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Videoc:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:File:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:video_note:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Audio:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Audioc:inline3am"..text)
Redis:del(Zelzal.."Rd:Manager:inline3am:text"..text)
Redis:del(Zelzal.."Rd:Manager:inline3am:link"..text)
Redis:del(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id.."")
Redis:srem(Zelzal.."List:Manager:inline3am", text)
send(msg_chat_id,msg_id,"*⇜ ابشر مسحت الرد من قائمة الانلاين العامة *","md",true)
return false
end
end
if text and text:match("^(.*)$") and tonumber(msg.sender_id.user_id) ~= tonumber(Zelzal) then
if Redis:get(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id) == "true" then
Redis:set(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id,"true1")
Redis:set(Zelzal.."Text:Manager:inline3am"..msg.sender_id.user_id..":", text)
Redis:del(Zelzal.."Add:Rd:Manager:Gif:inline3am"..text) 
Redis:del(Zelzal.."Add:Rd:Manager:Vico:inline3am"..text) 
Redis:del(Zelzal.."Add:Rd:Manager:Stekrs:inline3am"..text) 
Redis:del(Zelzal.."Add:Rd:Manager:Text:inline3am"..text) 
Redis:del(Zelzal.."Add:Rd:Manager:Photo:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Photoc:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Video:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Videoc:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:File:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:video_note:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Audio:inline3am"..text)
Redis:del(Zelzal.."Add:Rd:Manager:Audioc:inline3am"..text)
Redis:del(Zelzal.."Rd:Manager:inline3am:text"..text)
Redis:del(Zelzal.."Rd:Manager:inline3am:link"..text)
Redis:sadd(Zelzal.."List:Manager:inline3am", text)
send(msg_chat_id,msg_id,[[
*⇜ حلو , الحين ارسل جواب الرد
⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*
ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*
 `{اليوزر}` *↬ يوزر المستخدم*
 `{الرسائل}` *↬ عدد الرسائل*
 `{الاسم}` *↬ اسم المستخدم*
 `{الايدي}` *↬ ايدي المستخدم*
 `{الرتبه}` *↬ رتبة المستخدم*
 `{التعديل}` *↬ عدد التعديلات*

]],"md",true)
return false
end
end
if text == "اضف رد انلاين عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( '..Controller_Num(2)..' )* ',"md",true)  
end
Redis:set(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ حلو ، الحين ارسل الكلمة اللي تبيها*","md",false, false, false, false, reply_markup)
end
if text and not Redis:get(Zelzal.."Status:Reply:inline3am"..msg_chat_id) then
local btext = Redis:get(Zelzal.."Rd:Manager:inline3am:text"..text)
local blink = Redis:get(Zelzal.."Rd:Manager:inline3am:link"..text)
local anemi = Redis:get(Zelzal.."Add:Rd:Manager:Gif:inline3am"..text) 
local veico = Redis:get(Zelzal.."Add:Rd:Manager:Vico:inline3am"..text) 
local stekr = Redis:get(Zelzal.."Add:Rd:Manager:Stekrs:inline3am"..text) 
local Texingt = Redis:get(Zelzal.."Add:Rd:Manager:Text:inline3am"..text) 
local photo = Redis:get(Zelzal.."Add:Rd:Manager:Photo:inline3am"..text)
local photoc = Redis:get(Zelzal.."Add:Rd:Manager:Photoc:inline3am"..text)
local video = Redis:get(Zelzal.."Add:Rd:Manager:Video:inline3am"..text)
local videoc = Redis:get(Zelzal.."Add:Rd:Manager:Videoc:inline3am"..text)
local document = Redis:get(Zelzal.."Add:Rd:Manager:File:inline3am"..text)
local audio = Redis:get(Zelzal.."Add:Rd:Manager:Audio:inline3am"..text)
local audioc = Redis:get(Zelzal.."Add:Rd:Manager:Audioc:inline3am"..text)
local video_note = Redis:get(Zelzal.."Add:Rd:Manager:video_note:inline3am"..text)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = btext , url = blink},
},
}
}
if Texingt then 
local UserInfo = bot.getUser(msg.sender_id.user_id)
local NumMsg = Redis:get(Zelzal..'Num:Message:User'..msg_chat_id..':'..msg.sender_id.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Zelzal..'Num:Message:Edit'..msg_chat_id..msg.sender_id.user_id) or 0
local Texingt = Texingt:gsub('{المعرف}',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('{الاسم}',UserInfo.first_name)
local Texingt = Texingt:gsub('{الايدي}',msg.sender_id.user_id)
local Texingt = Texingt:gsub('{التعديل}',NumMessageEdit)
local Texingt = Texingt:gsub('{الرسائل}',NumMsg)
local Texingt = Texingt:gsub('{الرتبه}',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)
end
if video_note then
bot.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
bot.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end
if stekr then 
bot.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
bot.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
bot.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
bot.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
bot.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end
if audio then
bot.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
end
if text == "حذف رد انلاين عام" or text == "مسح رد انلاين عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( '..Controller_Num(2)..' )* ',"md",true)  
end
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
Redis:set(Zelzal.."Set:Manager:rd:inline3am"..msg.sender_id.user_id..":"..msg_chat_id,"true2")
return send(msg_chat_id,msg_id,"*⇜ تمام عيني  \n⇜ الحين ارسل الرد عشان امسحه*","md",false, false, false, false, reply_markup)
end 
if text == ("الردود الانلاين العامه") or text == ("الردود الانلاين عام") then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص ( '..Controller_Num(2)..' )* ',"md",true)  
end
local list = Redis:smembers(Zelzal.."List:Manager:inline3am")
text = "*⇜ قائمة الردود الانلاين العامة*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
if Redis:get(Zelzal.."Add:Rd:Manager:Gif:inline3am"..v) then
db = "متحركة"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Vico:inline3am"..v) then
db = "فويس"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Stekrs:inline3am"..v) then
db = "ملصق"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Text:inline3am"..v) then
db = "رسالة"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Photo:inline3am"..v) then
db = "صورة"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Video:inline3am"..v) then
db = "فيديو"
elseif Redis:get(Zelzal.."Add:Rd:Manager:File:inline3am"..v) then
db = "ملف"
elseif Redis:get(Zelzal.."Add:Rd:Manager:Audio:inline3am"..v) then
db = "اغنية"
elseif Redis:get(Zelzal.."Add:Rd:Manager:video_note:inline3am"..v) then
db = "بصمة فيديو"
end
text = text..""..k.." - ( "..v.." ) ࿓ ( "..db.." )\n"
end
if #list == 0 then
text = "*⇜ عذرا لا يوجد ردود انلاين عامة*"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)
end
---------------------------------------------------------------------------------
if text == 'كشف المجموعة' or text == "كشف المجموعه" or text == "كشف الرتب" or text == 'كشف القروب' or text == 'كشف مجموعه' or text == 'كشف مجموعة' then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = bot.getUser(v.member_id.user_id)
if UserInfo.first_name ~= "" then
if UserInfo.username then
Creator = "⇜ صاحب القروب : [@"..UserInfo.username.."]\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
else
Creator = "⇜ صاحب القروب : ["..FlterBio(UserInfo.first_name).."](tg://user?id="..UserInfo.id..")\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
end
end
end
end
Info_Members1 = Redis:smembers(Zelzal.."Zelzal:MalekAsase:Group"..msg_chat_id) 
local MalekAsase = Redis:scard(Zelzal.."Zelzal:MalekAsase:Group"..msg.chat_id) or 0
if #Info_Members1 ~= 0 then
ListMembers1 = '\n⇜ قائمة المالكين الاساسين : ( '..MalekAsase..' ) \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members1) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers1 = ListMembers1..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers1 = ListMembers1..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
else
ListMembers1 = ' '
end
Info_Members2 = Redis:smembers(Zelzal.."Zelzal:TheBasicsQ:Group"..msg_chat_id) 
local TheBasicsQ = Redis:scard(Zelzal.."Zelzal:TheBasicsQ:Group"..msg.chat_id) or 0
if #Info_Members2 ~= 0 then
ListMembers2 = '\n⇜ قائمة المالكين : ( '..TheBasicsQ..' )\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members2) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers2 = ListMembers2..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers2 = ListMembers2..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
else
ListMembers2 = ' '
end
Info_Members3 = Redis:smembers(Zelzal.."Zelzal:TheBasics:Group"..msg_chat_id) 
local TheBasics = Redis:scard(Zelzal.."Zelzal:TheBasics:Group"..msg.chat_id) or 0
if #Info_Members3 ~= 0 then
ListMembers3 = '\n⇜ قائمة المنشئين الاساسيين : ( '..TheBasics..' ) \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members3) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers3 = ListMembers3..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers3 = ListMembers3..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
else
ListMembers3 = ' '
end
Info_Members4 = Redis:smembers(Zelzal.."Zelzal:Originators:Group"..msg_chat_id) 
local Originators = Redis:scard(Zelzal.."Zelzal:Originators:Group"..msg.chat_id) or 0
if #Info_Members4 ~= 0 then
ListMembers4 = '\n⇜ قائمة المنشئين : ( '..Originators..' ) \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members4) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers4 = ListMembers4..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers4 = ListMembers4..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
else
ListMembers4 = ' '
end
Info_Members5 = Redis:smembers(Zelzal.."Zelzal:Managers:Group"..msg_chat_id) 
local Managers = Redis:scard(Zelzal.."Zelzal:Managers:Group"..msg.chat_id) or 0
if #Info_Members5 ~= 0 then
ListMembers5 = '\n⇜ قائمة المدراء : ( '..Managers..' ) \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members5) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers5 = ListMembers5..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers5 = ListMembers5..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
else
ListMembers5 = ' '
end
Info_Members6 = Redis:smembers(Zelzal.."Zelzal:Addictive:Group"..msg_chat_id) 
local Addictive = Redis:scard(Zelzal.."Zelzal:Addictive:Group"..msg.chat_id) or 0
if #Info_Members6 ~= 0 then
ListMembers6 = '\n⇜ قائمة الادمن : ( '..Addictive..' ) \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members6) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers6 = ListMembers6..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers6 = ListMembers6..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
else
ListMembers6 = ' '
end
Info_Members7 = Redis:smembers(Zelzal.."Zelzal:Distinguished:Group"..msg_chat_id) 
local Distinguished = Redis:scard(Zelzal.."Zelzal:Distinguished:Group"..msg.chat_id) or 0
if #Info_Members7 ~= 0 then
ListMembers7 = '\n⇜ قائمة المميزين : ( '..Distinguished..' ) \n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members7) do
local UserInfo = bot.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers7 = ListMembers7..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers7 = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
else
ListMembers7 = ' '
end
send(msg_chat_id, msg_id, Creator..ListMembers1..ListMembers2..ListMembers3..ListMembers4..ListMembers5..ListMembers6..ListMembers7, 'md')
end
---------------------------------------------------------------------------------
clock = os.clock
function sleeep(n)
local t0 = clock()
while clock() - t0 <= n do end
end
-----------------
if text and text:match("^بوت (.*)$") then
local TextName = text:match("^بوت (.*)$")
if TextName == "حذف" or TextName == "الحذف" then
return false
end
local TextLoading = "*⇜ جـارِ الاتصال بالذكاء الاصطناعي ➿*\n*⇜ انتظـر لحظـات ⏳*"
local rep = msg.id/2097152/0.5
local m = json:decode(https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..msg_chat_id.."&text="..URL.escape(TextLoading).."&parse_mode=markdown&reply_to_message_id="..rep)).result.message_id
local url = https.request("https://olga.telehost.cloud/api/ai.php?promt="..URL.escape(TextName))
local json = JSON.decode(url)
if json and json.message then
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
return send(msg_chat_id,msg_id,'*'..json.message..'*',"md",true)
end
if json and json.answer then
return send(msg_chat_id,msg_id,'*'..json.answer..'*',"md",true)
end
end
-----------------
if text and text:match("^صلاة (.*)$") or text and text:match("^صلاه (.*)$") then
local textcity = text:match("^صلاة (.*)$") or text:match("^صلاه (.*)$")
if textcity == "اليمن" or textcity == "صنعاء" then
Madina = "صنعاء"
Daolaa = "اليمن"
City = "Sanaa"
Country = "Yemen"
elseif textcity == "العراق" or textcity == "بغداد" then
Madina = "بغداد"
Daolaa = "العراق"
City = "Baghdad"
Country = "Iraq"
elseif textcity == "مصر" or textcity == "القاهرة" then
Madina = "القاهرة"
Daolaa = "مصر"
City = "Cairo"
Country = "Egypt"
elseif textcity == "ليبيا" or textcity == "طرابلس" then
Madina = "طرابلس"
Daolaa = "ليبيا"
City = "Tripoli"
Country = "Libya"
elseif textcity == "السودان" or textcity == "الخرطوم" then
Madina = "الخرطوم"
Daolaa = "السودان"
City = "Khartoum"
Country = "Sudan"
elseif textcity == "السعودية" or textcity == "الرياض" or textcity == "مكة" then
Madina = "مكة المكرمة"
Daolaa = "السعودية"
City = "Mecca"
Country = "Saudi-Arabia"
elseif textcity == "تركيا" or textcity == "أنقرة" then
Madina = "أنقرة"
Daolaa = "تركيا"
City = "Ankara"
Country = "Turkey"
elseif textcity == "سوريا" or textcity == "دمشق" then
Madina = "دمشق"
Daolaa = "سوريا"
City = "Damascus"
Country = "Syria"
elseif textcity == "الاردن" or textcity == "عمان" then
Madina = "عمان"
Daolaa = "الاردن"
City = "Amman"
Country = "Jordan"
elseif textcity == "لبنان" or textcity == "بيروت" then
Madina = "بيروت"
Daolaa = "لبنان"
City = "Beirut"
Country = "Lebanon"
elseif textcity == "تونس" or textcity == "تونس" then
Madina = "تونس"
Daolaa = "تونس"
City = "Tunis"
Country = "Tunisia"
elseif textcity == "المغرب" or textcity == "الرباط" then
Madina = "الرباط"
Daolaa = "المغرب"
City = "Rabat"
Country = "Morocco"
elseif textcity == "الجزائر" or textcity == "الجزائر" then
Madina = "الجزائر"
Daolaa = "الجزائر"
City = "Algiers"
Country = "Algeria"
elseif textcity == "الكويت" or textcity == "الكويت" then
Madina = "الكويت"
Daolaa = "الكويت"
City = "Kuwait"
Country = "Kuwait"
elseif textcity == "الامارات" or textcity == "أبو ظبي" then
Madina = "أبو ظبي"
Daolaa = "الامارات"
City = "Abu Dhabi"
Country = "UAE"
elseif textcity == "البحرين" or textcity == "المنامة" then
Madina = "المنامة"
Daolaa = "البحرين"
City = "Manama"
Country = "Bahrain"
elseif textcity == "قطر" or textcity == "الدوحة" then
Madina = "الدوحة"
Daolaa = "قطر"
City = "Doha"
Country = "Qatar"
elseif textcity == "فلسطين" or textcity == "القدس" then
Madina = "القدس"
Daolaa = "فلسطين"
City = "Jerusalem"
Country = "Palestine"
elseif textcity == "عُمان" or textcity == "مسقط" then
Madina = "مسقط"
Daolaa = "سلطنة عُمان"
City = "Muscat"
Country = "Oman"
elseif textcity == "ايران" or textcity == "طهران" then
Madina = "طهران"
Daolaa = "إيران"
City = "Tehran"
Country = "Iran"
else
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً المدينة او الدولة غير موجودة ..\n⇜ او تأكد من كتابتها بشكل صحيح ؟!*","md",true)  
end
local url = "https://api.aladhan.com/v1/timingsByCity?city="..City.."&country="..Country.."&method=1&school=0"
local request = https.request(url)
local result = JSON.decode(request)
local ar_weekday = result.data.date.hijri.weekday.ar
local ar_day = result.data.date.hijri.day
local ar_month = result.data.date.hijri.month.ar
local ar_year = result.data.date.hijri.year
local Melady = result.data.date.gregorian.date
local Hijree = ar_day.. " " ..ar_month.. " " ..ar_year
local Dhuhr = result.data.timings.Dhuhr
if string.sub(Dhuhr, 1, 2) == "13:" then
Dhuhr = "01:" ..string.sub(Dhuhr, 4)
end
local Asr = result.data.timings.Asr
Asr = Asr:gsub("15:", "03:"):gsub("16:", "03:"):gsub("17:", "04:")
local Sunset = result.data.timings.Sunset
Sunset = Sunset:gsub("17:", "05:"):gsub("18:", "06:")
local Maghrib = result.data.timings.Maghrib
Maghrib = Maghrib:gsub("17:", "05:"):gsub("18:", "06:")
local Isha = result.data.timings.Isha
Isha = Isha:gsub("18:", "06:"):gsub("19:", "07:")
local Zilzal = "\n*🕋╎اوقـات الصـلاة بالتـوقيت المحلـي لعواصـم الـدول*"..
"\n*🕌╎المـدينة ⤎*  "..Madina..
"\n*🗺╎الـدولة  ⤎*  "..Daolaa..
"\n*🏷╎اليـوم   ⤎*  " ..ar_weekday..
"\n*🗓╎التـاريخ   ⤎*  " ..Melady.. " م"..
"\n*🗒╎الهـجري   ⤎*  " ..Hijree.. " هـ"..
"\n*🎑╎الامـساك  ⤎*  " ..result.data.timings.Imsak.. " ص"..
"\n*🏙╎الـفجر      ⤎*  " ..result.data.timings.Fajr.. " ص"..
"\n*🌇╎الظهـر     ⤎*  " ..Dhuhr.. " م"..
"\n*🗾╎العـصر     ⤎*  " ..Asr.. " م"..
"\n*🌃╎المـغرب   ⤎*  " ..Maghrib.. " م"..
"\n*🌉╎العشـاء    ⤎*  " ..Isha.. " م"..
"\n*🌌╎منتـصف الليل ⤎*  " ..result.data.timings.Midnight..
"\n*🌄╎شـروق الشمس  ⤎*  " ..result.data.timings.Sunrise.. " ص"..
"\n*🌅╎غـروب الشمس  ⤎*  " ..Sunset.. " م\n*༄*"
local photo = "https://t.me/R_RR5/983"
local ban = bot.getUser(Zelzal)
local msg_reply = msg.id/2097152/0.5
local keyboard = {}
keyboard.inline_keyboard = {
{{text = ban.first_name,url="t.me/"..UserBot..""}},
}
return https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..msg_reply.."&photo="..photo.."&caption="..URL.escape(Zilzal).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text and text:match("^الطقس (.*)$") or text and text:match("^طقس (.*)$") then
local textcity = text:match("^طقس (.*)$") or text:match("^الطقس (.*)$") 
local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
local url = BASE_URL
url = url..'?q='..textcity..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
url = url..'&units=metric'
local b, c, h = request(url)
local weather = JSON.decode(b)
local pressure = weather.main.pressure
local humidity = weather.main.humidity
local conditions = '- حالة الجو : '
if weather.weather[1].main == 'Clear' then
conditions = conditions .. 'صافي ☀'
elseif weather.weather[1].main == 'Clouds' then
conditions = conditions .. 'غائم ☁☁'
elseif weather.weather[1].main == 'Rain' then
conditions = conditions .. 'ماطر ☔'
elseif weather.weather[1].main == 'Thunderstorm' then
conditions = conditions .. 'عاصف ☔☔☔☔'
elseif weather.weather[1].main == 'Mist' then
conditions = conditions .. 'مغبر 💨'
end
local temp = '*⌯ الطقس في :* '..textcity..'\n*- درجة الحرارة :* '..weather.main.feels_like..' 🌡\n*- الضغط :* '..pressure..'\n*- الرطوبة :* '..humidity..'\n'..conditions..'\n ✓'
send(msg_chat_id,msg_id,temp,"md",true)
end
-----------------
if text == "تفعيل القفل التلقائي" then
if not msg.Managers or not msg.Mamagers then
return send(msg.chat_id,msg.id,"⇜ هذا الامر يخص المدير")
end
Redis:del(Zelzal..msg.chat_id..'chat_lock:lock')
send(msg.chat_id,msg.id,"⇜ تم تفعيل قفل الدردشه التلقائي \n⇜ استخدم الامر : تعيين وقت قفل الدردشه ")
end
if text == "تعطيل القفل التلقائي" then
if not msg.Managers or not msg.Mamagers then
return send(msg.chat_id,msg.id,"⇜ هذا الامر يخص المدير")
end
Redis:set(Zelzal..msg.chat_id..'chat_lock:lock',true)
send(msg.chat_id,msg.id,"⇜ تم تعطيل قفل الدردشه التلقائي")
end
if text == "القفل التلقائي" then
if not msg.Managers or not msg.Mamagers then
return send(msg.chat_id,msg.id,"⇜ هذا الامر يخص المدير")
end
if Redis:get(Zelzal..msg.chat_id..'chat_lock:lock') then
state = "معطل"
else
state = "مفعل"
end
if Redis:get(Zelzal..msg.chat_id..'time:chat:lock')  then
lock_time = Redis:get(Zelzal..msg.chat_id..'time:chat:lock') 
else
lock_time = 00
end
if Redis:get(Zelzal..msg.chat_id..'time:chat:on') then
on_time = Redis:get(Zelzal..msg.chat_id..'time:chat:on')
else
on_time = 00
end
local current_time = request("https://dev-revor.tk/Apis/Auto/Auto.php?a=hi")
local txx = "⇜ القفل التلقائي : "..state.." \n⇜ الوقت الان : "..current_time.."\n\n⇜ وقت بداية القفل » "..lock_time.."\n⇜ وقت نهاية القفل » "..on_time
return send(msg.chat_id,msg.id,txx)
end
-----------------
if text then
if Redis:get(Zelzal..msg.sender_id.user_id..'set:time:chat') then
if text == "الغاء" then
Redis:del(Zelzal..msg.sender_id.user_id..'set:time:chat')
return send(msg.chat_id,msg.id,"⇜ تم الغاء الامر")
end
if text:match("(%d+)") then
if tonumber(text) <= 24 then
if tonumber(text) == 24 then
lock_time = 00
else
lock_time = tonumber(text)
end
Redis:del(Zelzal..msg.sender_id.user_id..'set:time:chat')
Redis:set(Zelzal..msg.sender_id.user_id..'set:time:chat:on',true)
Redis:del(Zelzal..msg.chat_id..'time:chat:lock')
Redis:set(Zelzal..msg.chat_id..'time:chat:lock',math.floor(tonumber(lock_time)))
return send(msg.chat_id,msg.id,"⇜ تم حفظ وقت القفل الساعه "..text.."\n ارسل الان وقت التفعيل ")
else
return send(msg.chat_id,msg.id,"⇜ لقد ارسلت وقت خاطئ")
end
else
return send(msg.chat_id,msg.id,"⇜ لقد ارسلت وقت خاطئ")
end
elseif Redis:get(Zelzal..msg.sender_id.user_id..'set:time:chat:on') then
if text == "الغاء" then
Redis:del(Zelzal..msg.sender_id.user_id..'set:time:chat:on')
return send(msg.chat_id,msg.id,"⇜ تم الغاء الامر")
end
if text:match("(%d+)") then
if tonumber(text) <= 24 then
if tonumber(text) == 24 then
lock_time = 00
else
lock_time = tonumber(text)
end
Redis:del(Zelzal..msg.sender_id.user_id..'set:time:chat:on')
Redis:del(Zelzal..msg.chat_id..'time:chat:on')
Redis:set(Zelzal..msg.chat_id..'time:chat:on',math.floor(tonumber(lock_time)))
return send(msg.chat_id,msg.id,"⇜ تم حفظ وقت الفتح الساعه "..lock_time.."\n")
else
return send(msg.chat_id,msg.id,"⇜ لقد ارسلت وقت خاطئ")
end
else
return send(msg.chat_id,msg.id,"⇜ لقد ارسلت وقت خاطئ")
end
end
end
-------------
if text == "الميزات" or text == "ميزات" then
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local list = Redis:smembers(Zelzal.."meza:names:")
if #list == 0 then
return send(msg.chat_id, msg.id,"⇜ لا يوجد ميزات", 'md')
end
local Text_Msg = "الميـزات :\n\n"
for k,v in pairs(list) do
local link = Redis:get(Zelzal.."meza:link"..v)
local type = Redis:get(Zelzal.."meza:type"..v)
Text_Msg = Text_Msg..k.." - "..v.." :\n○ : "..link.." ( "..type.." )\n\n" 
end
return send(msg.chat_id, msg.id,Text_Msg, 'md', true)
end
if text == "حذف ميزات" or text == "حذف الميزات" or text == "مسح ميزات" or text == "مسح الميزات" then 
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
local list = Redis:smembers(Zelzal.."meza:names:")
if #list == 0 then
return send(msg.chat_id, msg.id,"*⇜ لا يوجد ميزات*", 'md')
end
for k,v in pairs(list) do
Redis:del(Zelzal.."meza:type"..v)
Redis:del(Zelzal.."meza:link"..v)
end
Redis:del(Zelzal.."meza:names:")
return send(msg.chat_id, msg.id,"*⇜ تم مسح الميزات جميعها*", 'md')
end
if text == "اضف ميزه" or text == "اضف ميزة" then 
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
Redis:set(Zelzal.."add_meza:send:"..msg.chat_id..":"..msg.sender_id.user_id, true)
return send(msg.chat_id, msg.id,"*⇜ ارسل اسم الميزة*", 'md')
end
if text == "حذف ميزه" or text == "مسح ميزه" or text == "حذف ميزة" or text == "مسح ميزة" then 
if not msg.TheBasicsQ or not msg.TheMasicsQ then
return send(msg_chat_id,msg_id,'*⇜ عـذراً .. عـزيـزي 🤷🏻‍♀*\n*⇜ هذا الامـر يخـص المـالك🎖*',"md",true)
end
Redis:set(Zelzal.."add_meza:rem:"..msg.chat_id..":"..msg.sender_id.user_id, true)
return send(msg.chat_id, msg.id,"*⇜ ارسل اسم الميزة*", 'md')
end
if text and Redis:get(Zelzal.."add_meza:rem:"..msg.chat_id..":"..msg.sender_id.user_id) == "true" then
if Redis:get(Zelzal.."meza:type"..text) then
Redis:del(Zelzal.."meza:type"..text)
Redis:del(Zelzal.."meza:link"..text)
Redis:del(Zelzal.."add_meza:rem:"..msg.chat_id..":"..msg.sender_id.user_id)
Redis:srem(Zelzal.."meza:names:", text)
send(msg.chat_id, msg.id,"*⇜ تم مسح الميزة*", 'md')
else
Redis:del(Zelzal.."add_meza:rem:"..msg.chat_id..":"..msg.sender_id.user_id)
send(msg.chat_id, msg.id,"*⇜ لا يوجد ميزة بهذا الاسم*", 'md')
end
end
if text and Redis:get(Zelzal.."add_meza:send:"..msg.chat_id..":"..msg.sender_id.user_id) == "true" then
Redis:set(Zelzal.."add_meza:send:"..msg.chat_id..":"..msg.sender_id.user_id, "link")
Redis:set(Zelzal.."add_meza:name:"..msg.chat_id..":"..msg.sender_id.user_id, text)
return send(msg.chat_id, msg.id,"*⇜ تم حفظ الاسم \n⇜ ارسل رابط القناة*", 'md')
end
-----------------
if text and Redis:get(Zelzal.."add_meza:send:"..msg.chat_id..":"..msg.sender_id.user_id) == "link" then
if not text:match('https://t.me/(.*)') then
return send(msg.chat_id, msg.id,"*⇜ الرابط خطأ \n⇜ ارسل الرابط مثل : https://t.me/z_zzz8 *", 'md', true)
end
Redis:del(Zelzal.."add_meza:send:"..msg.chat_id..":"..msg.sender_id.user_id)
local meza_name = Redis:get(Zelzal.."add_meza:name:"..msg.chat_id..":"..msg.sender_id.user_id)
Redis:set(Zelzal.."meza:link"..meza_name, text)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'صور 📸', data = msg.sender_id.user_id..'/meza_photo'}
},
{
{text = 'فيديو 📹', data = msg.sender_id.user_id..'/meza_video'}
},
{
{text = 'صوت 🎧', data = msg.sender_id.user_id..'/meza_audio'}
},
{
{text = 'متحركه 🎴', data = msg.sender_id.user_id..'/meza_animation'}
},
{
{text = 'ملصق 🌁', data = msg.sender_id.user_id..'/meza_sticker'}
},
}
}
return send(msg.chat_id, msg.id,"*⇜ تم حفظ الرابط \n⇜ اختر نوع الميديا :\n✓*", 'md',true, false, false, false, reply_markup)
end
if text and Redis:get(Zelzal.."meza:type"..text) then
local meza_link = Redis:get(Zelzal.."meza:link"..text)
local channel = meza_link:match('https://t.me/(.*)')
print(channel)
local post_num = last_id(channel)
print(post_num)
local rand = math.random(2,post_num)
local link = meza_link.."/"..rand
print(link)
local meza_type = Redis:get(Zelzal.."meza:type"..text)
print(meza_type)
if meza_type == "photo" then
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&photo="..link.."&caption="..URL.escape(" ").."&reply_to_message_id="..(msg.id/2097152/0.5))
elseif meza_type == "video" then
https.request("https://api.telegram.org/bot"..Token.."/sendvideo?chat_id="..msg_chat_id.."&caption="..URL.escape(" ").."&video="..link.."&reply_to_message_id="..(msg.id/2097152/0.5).."&parse_mode=Markdown")
elseif meza_type == "animation" then
https.request("https://api.telegram.org/bot"..Token.."/sendanimation?chat_id="..msg_chat_id.."&caption="..URL.escape(" ").."&animation="..link.."&reply_to_message_id="..(msg.id/2097152/0.5).."&parse_mode=Markdown")
elseif meza_type == "audio" then
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg.chat_id.."&audio="..link.."&caption="..URL.escape(" ").."&reply_to_message_id="..(msg.id/2097152/0.5))
elseif meza_type == "sticker" then
https.request("https://api.telegram.org/bot"..Token.."/sendsticker?chat_id="..msg.chat_id.."&sticker="..link.."&caption="..URL.escape(" ").."&reply_to_message_id="..(msg.id/2097152/0.5))
end
end
if text == "تستي" then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..msg_id..' ) ',"md",true)  
end
----------------------------------------------------------------------------------------
if text and text:match("^تعيين عدد الاحرف (%d+)$") or text and text:match("^تعين عدد الاحرف (%d+)$") then  
if not msg.Originators or not msg.Origimators then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(5)..' ) ',"md",true)  
end
local Numbardel = text:match("^تعيين عدد الاحرف (%d+)$") or text:match("^تعين عدد الاحروف (%d+)$")
Redis:set(Zelzal.."NUM_CH_MAX"..msg_chat_id, Numbardel)
send(msg_chat_id,msg_id, 'تم تعيين عدد الاحرف : '..Numbardel)
end
---------------------------------------------------------------------------------
if Redis:get(Zelzal.."addchannel"..msg.sender_id.user_id) == "on" then
if text and text:match("^@[%a%d_]+$") then
local m , res = http.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = JSON.decode(m)
if res == 200 then
ch = data.result.id
Redis:set(Zelzal.."chadmin"..msg_chat_id,ch)
send(msg_chat_id,msg_id,"*⇜ تم حفظ ايدي القناه*","md",true)  
else
send(msg_chat_id,msg_id,"*⇜ المعرف خطأ*","md",true)  
end
elseif text and text:match('^-100(%d+)$') then
ch = text
Redis:set(Zelzal.."chadmin"..msg_chat_id,ch) 
send(msg_chat_id,msg_id,"⇜ تم حفظ ايدي القناه","md",true)  
elseif text and not text:match('^-100(%d+)$') then
send(msg_chat_id,msg_id,"*⇜ الايدي خطأ .. يجب ان يبدأ بـ -100*","md",true)  
end
Redis:del(Zelzal.."addchannel"..msg.sender_id.user_id)
end
if text == "القناه المضافه" or text == "القناة المضافة" then
if Redis:get(Zelzal.."chadmin"..msg_chat_id) then
send(msg_chat_id,msg_id,Redis:get(Zelzal.."chadmin"..msg_chat_id),"md",true)  
else 
send(msg_chat_id,msg_id,"*⇜ لا توجد قناه*","md",true)  
end 
end
if text == "حذف القناه" or text == "حذف القناة" or text == "مسح القناة" or text == "مسح القناه" or text == "حذف قناه" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص* ( الادمن,المدير,المالك,المطور ) بس ',"md",true)  
end
if Redis:get(Zelzal.."chadmin"..msg_chat_id) then
Redis:del(Zelzal.."chadmin"..msg_chat_id) 
send(msg_chat_id,msg_id,"*⇜ تم حذف القناه بنجاح*","md",true)  
else 
send(msg_chat_id,msg_id,"*⇜ لا توجد قناه*","md",true)  
end 
end
if text == "اضف قناه" or text == "اضف قناة"then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'*⇜ هـذا الامـر يخـص* ( الادمن,المدير,المالك,المطور ) بس ',"md",true)  
end
Redis:set(Zelzal.."addchannel"..msg.sender_id.user_id,"on") 
send(msg_chat_id,msg_id,"*⇜ ارسل يوزر او ايدي القناه*","md",true)  
end
if text == "الساعه" or text == "الوقت" then
local current_time = os.time() + 3600 -- إضافة ساعة واحدة
local zelzallll = "\n*⇜ الساعة الان :* \n"..os.date("%p %I:%M:%S", current_time)
send(msg_chat_id,msg_id,zelzallll,"md")
end
if text == "نمله" or text == "نملة" or text == "النمله" then
local photo = "https://te.legra.ph/file/437c4b16cfbcee983cf14.jpg"
local caption = ""
local keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '>> 🐜 <<', callback_data="/kill_the_ant"},
},
}
local msg_rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..msg_rep.."&photo="..photo.."&caption="..URL.escape(caption).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == "ترند القروبات" or text == "ترند المجموعات" then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
GroupAllRtba = Redis:hgetall(Zelzal..':GroupUserCountMsg:groups')
GetAllNames  = Redis:hgetall(Zelzal..':GroupNameUser:groups')
GroupAllRtbaL = {}
for k,v in pairs(GroupAllRtba) do table.insert(GroupAllRtbaL,{v,k}) end
Count,Kount,i = 8 , 0 , 1
for _ in pairs(GroupAllRtbaL) do Kount = Kount + 1 end
table.sort(GroupAllRtbaL, function(a, b) return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then Count = Kount end
Text = "*⇜ قائمة ترند القروبات*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(GroupAllRtbaL) do
if v[2] and v[2]:match("(-100%d+)") then
local InfoChat = bot.getChat(v[2])
local InfoChats = bot.getSupergroupFullInfo(v[2])
if InfoChats.code ~= 400 then
var(InfoChats.invite_link)
if not InfoChats.invite_link then
linkedid = "["..InfoChat.title.."]" or "اسم القروب خطأ"
else
linkedid = "["..InfoChat.title.."]" or "اسم القروب خطأ"
end
if i <= Count then  
Text = Text..i..") :"..v[1].." | "..(linkedid).." \n" 
end ; 
i=i+1
end
end
end
return send(msg.chat_id,msg.id,Text,"md",true)
end
if text and msg.chat_id then
local GetMsg = Redis:incr(Zelzal..'Zelzal:MsgNumbergroups'..msg.chat_id) or 1
Redis:hset(Zelzal..':GroupUserCountMsg:groups',msg.chat_id,GetMsg)
end
-----------------
if text == 'ابلاغ' or text == 'بلاغ' or text == 'تبليغ' and tonumber(msg.reply_to_message_id) ~= 0 then
if Redis:get(Zelzal.."rebomsg"..msg.chat_id) then
local Remsg = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Remsg.sender_id.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return false
end
if Remsg.sender_id.user_id == msg.sender_id.user_id then
return false
end
Info_Members = bot.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
UserInfo = bot.getUser(v.member_id.user_id)
end
end
local Get_Chat = bot.getChat(msg.chat_id)
local Info_Chats = bot.getSupergroupFullInfo(msg.chat_id)
local nameuser = bot.getUser(msg.sender_id.user_id)
if nameuser.first_name then
nameuser = "["..nameuser.first_name.."](tg://user?id="..nameuser.id..")"
else
nameuser = 'لا يوجد اسم'
end
local nameuserr = bot.getUser(Remsg.sender_id.user_id)
if nameuserr.first_name then
nameuserr = "["..nameuserr.first_name.."](tg://user?id="..nameuserr.id..")"
else
nameuserr = 'لا يوجد اسم'
end
local id = tostring(msg.chat_id)
gt = string.upper(id:gsub('-100',''))
gtr = math.floor(msg.reply_to_message_id/2097152/0.5)
telink = "https://t.me/c/"..gt.."/"..gtr..""
bot.deleteMessages(msg.chat_id,{[1]= msg.id})
textd = '*⇜ بـلاغ جـديـد 🚨⚠️*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n\n*- القروب :* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n\n*- الساعة :* '..os.date("%p %I:%M:%S")..'\n*- التاريخ :* '..os.date("%Y/%m/%d")..'\n*- صاحب البلاغ :* '..nameuser..'\n*- صاحب الرسالة :* '..nameuserr..'\n*- رابط الرسالة :* '..telink..''
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text="• مسح الرسالة •",data = msg.reply_to_message_id..":kk:"..gt.."/delreb:"..UserInfo.id}},
}
}
bot.sendText(UserInfo.id,0,textd,"md",false, false, false, false, reply_markup)
end
end
----------------
if text and text:match("^قوقل (.*)$") then
local F = text:match("^قوقل (.*)$") 
local Text_mira = "⇜ اضغط على بحثك وهو "..F..""
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'اضغط هنا', url = 'https://www.google.com/search?q='..F..'&ie=UTF-8&oe=UTF-8&hl=ar-sa&client=safari'},
},
}
}
return bot.sendText(msg.chat_id,msg.id,Text_mira,"md",false, false, false, false, reply_markup)
end
if text and (text:match("^ضع قناتي (.*)$") or text:match("^وضع قناتي (.*)$")) then
local UserId = Text:match("^ضع قناتي (.*)$") or text:match("^وضع قناتي (.*)$") 
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
Redis:set(Zelzal..'SOFI:Channel:Vip'..msg.sender_id.user_id,UserId)
local Text = "⇜ تم حفظ قناتك"
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text="• الغاء •",data="/DelChannelVip:"..msg.sender_id.user_id}},
{{text="• اخفاء •",data="/HideChannelVip:"..msg.sender_id.user_id}},
}
}
bot.sendText(msg_chat_id,msg_id,Text,"md",false, false, false, false, reply_markup)
return false   
end
if text == "حذف قناتي" or text == "مسح قناتي" then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if not Redis:get(Zelzal..'SOFI:Channel:Vip'..msg.sender_id.user_id) then
Text = "⇜ انت لم تقم بـ وضع قناتك"
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text="• وضع قناتي •",data="/ChangeChannelVip:"..msg.sender_id.user_id}},
{{text="• اخفاء •",data="/HideChannelVip:"..msg.sender_id.user_id}},
}
}
bot.sendText(msg_chat_id,msg_id,Text,"md",false, false, false, false, reply_markup)
return false
else
Redis:del(Zelzal..'SOFI:Channel:Vip'..msg.sender_id.user_id)
Text = "⇜ تم مسح قناتك "
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text="• وضع قناتي •",data="/ChangeChannelVip:"..msg.sender_id.user_id}},
{{text="• اخفاء •",data="/HideChannelVip:"..msg.sender_id.user_id}},
}
}
bot.sendText(msg_chat_id,msg_id,Text,"md",false, false, false, false, reply_markup)
return false
end
end
if Redis:get(Zelzal..'SetChannelVip'..msg.sender_id.user_id) then 
if text =='الغاء' then 
bot.sendText(msg_chat_id,msg_id, '⇜ تم الغاء حفظ قناتك ',"md",true)  
Redis:del(Zelzal..'SetChannelVip'..msg.sender_id.user_id)
return false  
end 
Redis:del(Zelzal..'SetChannelVip'..msg.sender_id.user_id)
Redis:set(Zelzal..'SOFI:Channel:Vip'..msg.sender_id.user_id,text)
local text = "⇜ تم حفظ قناتك"
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text="• تغيير قناتي •",data="/ChangeChannelVip:"..msg.sender_id.user_id},{text="• مسح قناتي •",callback_data="/DelChannelVip:"..msg.sender_id.user_id}},
{{text="• اخفاء •",data="/HideChannelVip:"..msg.sender_id.user_id}},
}
}
bot.sendText(msg_chat_id,msg_id,text,"md",false, false, false, false, reply_markup)
return false   
end
if text and text:match("^ضع قناتي$") or text and text:match("^وضع قناتي$") then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
local text = "⇜ ارسل لي قناتك الان"
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text="• الغاء •",data="/CancelChannelVip:"..msg.sender_id.user_id}},
}
}
bot.sendText(msg_chat_id,msg_id,text,"md",false, false, false, false, reply_markup)
Redis:set(Zelzal..'SetChannelVip'..msg.sender_id.user_id,true)
return false
end
if text and text:match("^قناتي$") then
if not msg.Addictive or not msg.Mddictive then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(7)..' ) ',"md",true)  
end
if not Redis:get(Zelzal..'SOFI:Channel:Vip'..msg.sender_id.user_id) then
bot.sendText(msg_chat_id,msg_id, "⇜ لم تقم باضافة قناتك\n⇜ قم بارسال وضع قناتي","md",true)
else
local rules = Redis:get(Zelzal..'SOFI:Channel:Vip'..msg.sender_id.user_id)
bot.sendText(msg_chat_id,msg_id, rules,"md",true)
end
end
end -- GroupBot
if chat_type(msg.chat_id) == "UserBot" then 
if text == 'تحديث الملفات' or text == 'تحديث' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
send(msg_chat_id,msg_id, "*⇜  تم تحديث الملفات*","md",true)
dofile('Zelzal.lua')  
end
------------------------------------ كود لوحة الاعضاء ------------------------------------
if text == "حذف حسابي" or text == "⚠️ حـذف حسـابـي ⚠️" or text == "/deleteacc" then
local ban = bot.getUser(msg.sender_id.user_id)
local Name = '['..ban.first_name..'](tg://user?id='..ban.id..')'
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '✦ حـذف الحسـاب ✦', type = 'requestphone'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ مرحبًـا عـزيـزي* "..Name.."\n\n*⇜ تستطيـع حـذف حسـابك بسـهوله عبـر البـوت ⎋ \n⇜ فكـر جيـداً .. قبـل ان تحـذف حسـابك 🚸*", "md", true, false, false, false, reply_markup)
end
if text and Redis:get(Zelzal..msg.sender_id.user_id.."hash") and Redis:get(Zelzal..msg.sender_id.user_id.."num") and Redis:get(Zelzal..msg.sender_id.user_id..'pass') then
if text == "الغاء" or text == "✦ الغـاء ✦" then
Redis:del(Zelzal..msg.sender_id.user_id.."hash")
Redis:del(Zelzal..msg.sender_id.user_id.."num")
Redis:del(Zelzal..msg.sender_id.user_id.."pass")
local k = {
remove_keyboard = true
}
return https.request("https://api.telegram.org/bot"..Token.."/sendmessage?text="..URL.escape("⇜ تم الغـاء امـر حـذف حسـابك . . بنجـاح ✅").."&chat_id="..msg.chat_id.."&reply_markup="..JSON.encode(k))
end
local hash = Redis:get(Zelzal..msg.sender_id.user_id.."hash")
local num = Redis:get(Zelzal..msg.sender_id.user_id.."num")
local pass = Redis:get(Zelzal..msg.sender_id.user_id.."pass")
send(msg_chat_id,msg_id,"*⇜ جاري حذف حسابك يرجي الانتظار . . .🚸*","md",true)  
sleep(2)
local url = https.request("https://www.zmm.aba.vg/delapi/oppu.php?phone="..num.."&access_hash="..hash.."&password="..pass.."&do_delete=true")
local json = JSON.decode(url)
if json and json.error == "PASSWORD OR ACCESS_HASH INVALID | OR DO_DELETE => FALSE OR DO_DELETE EMPTY" then
return send(msg.chat_id,msg.id,"*⇜ خطـأ بالكـود .. قم بارسـال الكـود الصحيـح...* ","md",true)  
else
Redis:del(Zelzal..msg.sender_id.user_id.."hash")
Redis:del(Zelzal..msg.sender_id.user_id.."num")
Redis:del(Zelzal..msg.sender_id.user_id.."pass")
return send(msg_chat_id,msg_id,"*⇜ وداعـاً .. نـراك قريبًـا ...*","md",true)  
end
end
if text and Redis:get(Zelzal..msg.sender_id.user_id.."hash") and Redis:get(Zelzal..msg.sender_id.user_id.."num") and not Redis:get(Zelzal..msg.sender_id.user_id..'pass') then
if text == "الغاء" or text == "✦ الغـاء ✦" then
Redis:del(Zelzal..msg.sender_id.user_id.."hash")
Redis:del(Zelzal..msg.sender_id.user_id.."num")
local k = {
remove_keyboard = true
}
return https.request("https://api.telegram.org/bot"..Token.."/sendmessage?text="..URL.escape("⇜ تم الغـاء امـر حـذف حسـابك . . بنجـاح ✅").."&chat_id="..msg.chat_id.."&reply_markup="..JSON.encode(k))
end
Redis:set(Zelzal..msg.sender_id.user_id..'pass',text)
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '✦ تـأكيـد الحـذف ✦',type = 'text'},{text = '✦ الغـاء ✦',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ هل انت متأكد من انك تريد حذف حسابك ؟!*",'md', false, false, false, false, reply_markup)
end
if data and data.content and data.content.luatele == "messageContact" then
--bot.sendForwarded(Sudo_Id, 0, data.sender_id.user_id, data.id)--
local num = "+"..data.content.contact.phone_number
local url = https.request("https://www.zmm.aba.vg/delapi/oppu.php?phone="..num)
local json = JSON.decode(url)
if json and json.result and json.result.description == "password has been sent" then
Redis:set(Zelzal..msg.sender_id.user_id.."hash",json.result.access_hash)
Redis:set(Zelzal..msg.sender_id.user_id.."num",num)
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '✦ الغـاء ✦',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ تم ارسـال رمـز التأكيـد اليـك\n⇜ ارسـله الينـا الان ...*\n\n*⇜ او اضغـط الغـاء لـ الغـاء عمليـة الحـذف ...🛂*",'md', false, false, false, false, reply_markup)
else
send(msg_chat_id,msg_id,"*⇜ اووبـس .. حدث خطـأ ربمـا بسبب كثـرة المحـاولات*","md",true)  
end
return false 
end
------------------------------------ كود لوحة الاعضاء ------------------------------------
if text and text:match("/start liink(.*)u(%d+)") then
local zilzal = {text:match("/start liink(.*)u(%d+)") }
if msg_user_send_id ~= tonumber(zilzal[2]) then
send(msg_chat_id,msg_id,'*⇜ مطـي 🦓.. هـذا الامـر لا يخصك*',"md",true)
else
local Get_Chat = bot.getChat(zilzal[1])
local GetLink = Redis:get(Zelzal.."Group:Link"..zilzal[1]) 
if GetLink then
local reply_markup = bot.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return send(msg_chat_id, msg_id, "*⇜ رابــط المجمـوعـه 🖇♥️ :* \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local m = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..tonumber(zilzal[1]))
local LinkGroup = JSON.decode(m)
local reply_markup = bot.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.result.invite_link},},}}
return send(msg_chat_id, msg_id, "*⇜ رابــط المجمـوعـه 🖇♥️ :* \n["..Get_Chat.title.. ']('..LinkGroup.result.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end
end
if text and text:match("/start delete(.*)u(%d+)") then
local testhdf = {text:match("/start delete(.*)u(%d+)") }
if msg_user_send_id ~= tonumber(testhdf[2]) then
send(msg_user_send_id,msg_id,'*⇜ مطـي 🦓.. هـذا الامـر لا يخصك*',"md",true)  
else
local sender_name = bot.getUser(testhdf[2]).first_name
local sender_id = bot.getUser(testhdf[2]).id
return send(msg_user_send_id,msg_id,"*⇜ مرحبًـا بـك عـزيـزي*  ["..sender_name.."](tg://user?id="..sender_id..") \n*⇜ تستطيـع حـذف حسـابك بسـهوله عبـر البـوت ⎋ *\n*⇜ اضغط ع الامـر /deleteacc .. لحـذف حسـابك 🚸*","md",true)  
end
end
if text and text:match("/start hhms(.*)from_id(%d+)") then
local zillzall = {text:match("/start hhms(.*)from_id(%d+)") }
if msg_user_send_id ~= tonumber(zillzall[2]) then
send(msg_user_send_id,msg_id,'*⇜ هـذا الامـر ليس لك ياحمـار 😒*',"md",true)  
else
Redis:set(Zelzal.."hms:"..msg_user_send_id, zillzall[1])
return send(msg_user_send_id,msg_id,'*⇜ ارسل الهمسه الان*',"md",true)  
end
elseif text and not text:match("(.*)start(.*)") and Redis:get(Zelzal.."hms:"..msg_user_send_id) then
local zillzall = Redis:get(Zelzal.."hms:"..msg_user_send_id)
local msgg = msg_id/2097152/0.5
Redis:set(Zelzal.."hms:"..zillzall.."text:", text)
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..msgg)
--- كود الغاء بدون زر موافقه ---
local chat_id = Redis:get(Zelzal.."hms:"..zillzall.."chat_id")
local to_id = Redis:get(Zelzal.."hms:"..zillzall.."to")
local msg_id = Redis:get(Zelzal.."hms:"..zillzall.."msg_id")
local sender_name = bot.getUser(msg_user_send_id).first_name
local to_name = bot.getUser(to_id).first_name
--- رد الهمسة ---
local zelrand = math.random(1,9999999999999)
Redis:set(Zelzal.."hms:"..zelrand.."chat_id", chat_id)
Redis:set(Zelzal.."hms:"..zelrand.."to", msg_user_send_id)
Redis:set(Zelzal.."hms:"..zelrand.."msg_id",msg_id)
--- رد الهمسة ---
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'فتـح الهمسـة 🗳', data = "sender:"..msg_user_send_id.."to:"..to_id.."hmsa:"..zillzall}
},
{
{text = 'اهمس لـ '..sender_name..'', url = 't.me/'..UserBot..'?start=hhms'..zelrand..'from_id'..to_id..''},
},
}
}
send(chat_id,0,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..to_id..") 」\n*⇜ لديك همسة سرية من*「 ["..sender_name.."](tg://user?id="..msg_user_send_id..") 」","md",true,false,false,false,reply_markup)
send(msg_chat_id,0,"*⇜ تم ارسـال الهمسـة .. بنجـاح ✅*", 'md',false)
Redis:del(Zelzal.."hms:"..msg_user_send_id)
end
-- ارسال الهمسه الميديا --
if text and text:match("/start hmms(.*)from_id(%d+)") then
local zillzall = {text:match("/start hmms(.*)from_id(%d+)") }
if msg_user_send_id ~= tonumber(zillzall[2]) then
return send(msg_user_send_id,msg_id,'*⇜ هـذا الامـر ليس لك ياحمـار 😒*',"md",true)  
else
Redis:set(Zelzal.."hmms:"..msg_user_send_id, zillzall[1])
return send(msg_user_send_id,msg_id,'*⇜ مرحبًـا بك عـزيـزي 🙋‍♀️*\n\n*⇜ ارسـل همسـة الميـديـا الان 🔖*\n*⇜ تستطيـع الهمـس بجميـع انـواع الميديـا ✅*\n*⇜ صورة🎇 - ملصق🎫 - متحركة✨ - فيديو🎬- صوت🎙️ - ملف📁*\n*⇜ تستطيـع ايضاً ارسـال الميديـا بكابشـن ✅* ( ميديا تحتها نص )',"md",true)
end
end
if Redis:get(Zelzal.."hmms:"..msg_user_send_id) and (msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo) then
local zillzall = Redis:get(Zelzal.."hmms:"..msg_user_send_id)
if msg.content.sticker then
Redis:set(Zelzal.."Zelzal:Add:Hmsm:Media:Stekrs"..msg_user_send_id..zillzall, msg.content.sticker.sticker.remote.id)  
end
if msg.content.voice_note then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Hmsm:caption:vico"..msg.content.voice_note.voice.remote.id..msg_user_send_id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Hmsm:Media:Vico"..msg_user_send_id..zillzall, msg.content.voice_note.voice.remote.id)
end
if msg.content.audio then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Hmsm:caption:audio"..msg.content.audio.audio.remote.id..msg_user_send_id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Hmsm:Media:Audio"..msg_user_send_id..zillzall, msg.content.audio.audio.remote.id)  
end
if msg.content.document then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Hmsm:caption:document"..msg.content.document.document.remote.id..msg_user_send_id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Hmsm:Media:File"..msg_user_send_id..zillzall, msg.content.document.document.remote.id)  
end
if msg.content.animation then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Hmsm:caption:gif"..msg.content.animation.animation.remote.id..msg_user_send_id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Hmsm:Media:Gif"..msg_user_send_id..zillzall, msg.content.animation.animation.remote.id)  
end
if msg.content.video_note then
Redis:set(Zelzal.."Zelzal:Add:Hmsm:Media:video_note"..msg_user_send_id..zillzall, msg.content.video_note.video.remote.id)  
end
if msg.content.video then
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Hmsm:caption:video"..msg.content.video.video.remote.id..msg_user_send_id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Hmsm:Media:Video"..msg_user_send_id..zillzall, msg.content.video.video.remote.id)  
end
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if msg.content.caption.text then
Redis:set(Zelzal.."Zelzal:Add:Hmsm:caption:Photo"..idPhoto..msg_user_send_id, msg.content.caption.text)  
end
Redis:set(Zelzal.."Zelzal:Add:Hmsm:Media:Photo"..msg_user_send_id..zillzall, idPhoto)
end
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..msgg)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'نعم', data = msg_user_send_id.."hmms"..zillzall},{text = 'لا', data = msg_user_send_id.."nn_hmms"..zillzall}
},
}
}
return send(msg_chat_id,0,"*⇜ هـل انت متأكـد من ارسـال همسـة الميديـا ؟!*","md",true,false,false,false,reply_markup)
end
-- استلام الهمسة الميديا --
if text and text:match("/start hmmms(.*)sender(.*)to(.*)") then
local zillzall = {text:match("/start hmmms(.*)sender(.*)to(.*)") }
if msg_user_send_id == tonumber(zillzall[2]) then
return send(msg_user_send_id,msg_id,'*⇜ انت مرسل الهمسة ميحتاج تفتحها يامطي 😒*',"md",true)
end
if msg_user_send_id ~= tonumber(zillzall[3]) then
return send(msg_user_send_id,msg_id,'*⇜ الهمسـة ليست لك ياحمـار 😒*',"md",true)
end
local too_id = Redis:get(Zelzal.."hmms:"..zillzall[3].."to")
local to_id = bot.getUser(zillzall[3]).id
local sender_name = bot.getUser(zillzall[2]).first_name
local to_name = bot.getUser(zillzall[3]).first_name
local anemi = Redis:get(Zelzal.."Zelzal:Add:Hmsm:Media:Gif"..zillzall[2]..zillzall[1])   
local veico = Redis:get(Zelzal.."Zelzal:Add:Hmsm:Media:Vico"..zillzall[2]..zillzall[1])   
local stekr = Redis:get(Zelzal.."Zelzal:Add:Hmsm:Media:Stekrs"..zillzall[2]..zillzall[1])     
local photo = Redis:get(Zelzal.."Zelzal:Add:Hmsm:Media:Photo"..zillzall[2]..zillzall[1])
local video = Redis:get(Zelzal.."Zelzal:Add:Hmsm:Media:Video"..zillzall[2]..zillzall[1])
local document = Redis:get(Zelzal.."Zelzal:Add:Hmsm:Media:File"..zillzall[2]..zillzall[1])
local audio = Redis:get(Zelzal.."Zelzal:Add:Hmsm:Media:Audio"..zillzall[2]..zillzall[1])
local video_note = Redis:get(Zelzal.."Zelzal:Add:Hmsm:Media:video_note"..zillzall[2]..zillzall[1])
if video_note then
bot.sendVideoNote(msg_user_send_id,msg_id, video_note)
send(msg_user_send_id,msg_id,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ هـذه همسة ميديا من*「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」","md",true)
send(zillzall[2],0,"*⇜ عمࢪي* 「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」\n*⇜ تم فتـح همستك .. بنجـاح ✅*\n*⇜ بواسطـة*「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ نـوع الهمسـة (فيديو 🎬)*","md",true)
Redis:del(Zelzal.."Zelzal:Add:Hmsm:Media:video_note"..zillzall[2]..zillzall[1])
Redis:del(Zelzal.."hmms:"..zillzall[2])
end
if photo then
local captionsend = Redis:get(Zelzal.."Zelzal:Add:Hmsm:caption:Photo"..photo..zillzall[2]) or ''
bot.sendPhoto(msg.chat_id, msg.reply_to_message_id, photo,'['..captionsend..']',"md")
send(msg_user_send_id,msg_id,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ هـذه همسة ميديا من*「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」","md",true)
send(zillzall[2],0,"*⇜ عمࢪي* 「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」\n*⇜ تم فتـح همستك .. بنجـاح ✅*\n*⇜ بواسطـة*「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ نـوع الهمسـة (صورة 🌠)*","md",true)
Redis:del(Zelzal.."Zelzal:Add:Hmsm:Media:Photo"..zillzall[2]..zillzall[1])
end
if stekr then 
bot.sendSticker(msg_user_send_id,msg_id, stekr)
send(msg_user_send_id,msg_id,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ هـذه همسة ميديا من*「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」","md",true)
send(zillzall[2],0,"*⇜ عمࢪي* 「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」\n*⇜ تم فتـح همستك .. بنجـاح ✅*\n*⇜ بواسطـة*「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ نـوع الهمسـة (ملصق 🎟)*","md",true)
Redis:del(Zelzal.."Zelzal:Add:Hmsm:Media:Stekrs"..zillzall[2]..zillzall[1])
end
if veico then
local captionsend = Redis:get(Zelzal.."Zelzal:Add:Hmsm:caption:vico"..veico..zillzall[2]) or ''
bot.sendVoiceNote(msg_user_send_id,msg_id, veico, '['..captionsend..']',"md")
send(msg_user_send_id,msg_id,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ هـذه همسة ميديا من*「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」","md",true)
send(zillzall[2],0,"*⇜ عمࢪي* 「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」\n*⇜ تم فتـح همستك .. بنجـاح ✅*\n*⇜ بواسطـة*「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ نـوع الهمسـة (تسجيل صوتي 🎙)*","md",true)
Redis:del(Zelzal.."Zelzal:Add:Hmsm:Media:Vico"..zillzall[2]..zillzall[1])
end
if video then 
local captionsend = Redis:get(Zelzal.."Zelzal:Add:Hmsm:caption:video"..video..zillzall[2]) or ''
bot.sendVideo(msg_user_send_id,msg_id, video, '['..captionsend..']', "md")
send(msg_user_send_id,msg_id,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ هـذه همسة ميديا من*「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」","md",true)
send(zillzall[2],0,"*⇜ عمࢪي* 「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」\n*⇜ تم فتـح همستك .. بنجـاح ✅*\n*⇜ بواسطـة*「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ نـوع الهمسـة (فيديو 🎬)*","md",true)
Redis:del(Zelzal.."Zelzal:Add:Hmsm:Media:Video"..zillzall[2]..zillzall[1])
end
if anemi then
local captionsend = Redis:get(Zelzal.."Zelzal:Add:Hmsm:caption:gif"..anemi..zillzall[2]) or ''
bot.sendAnimation(msg_user_send_id,msg_id, anemi, '['..captionsend..']', "md")
send(msg_user_send_id,msg_id,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ هـذه همسة ميديا من*「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」","md",true)
send(zillzall[2],0,"*⇜ عمࢪي* 「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」\n*⇜ تم فتـح همستك .. بنجـاح ✅*\n*⇜ بواسطـة*「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ نـوع الهمسـة (متحركة 🎆)*","md",true)
Redis:del(Zelzal.."Zelzal:Add:Hmsm:Media:Gif"..zillzall[2]..zillzall[1])
end
if document then
local captionsend = Redis:get(Zelzal.."Zelzal:Add:Hmsm:caption:document"..document..zillzall[2]) or ''
bot.sendDocument(msg_user_send_id,msg_id, document, '['..captionsend..']', 'md')
send(msg_user_send_id,msg_id,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ هـذه همسة ميديا من*「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」","md",true)
send(zillzall[2],0,"*⇜ عمࢪي* 「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」\n*⇜ تم فتـح همستك .. بنجـاح ✅*\n*⇜ بواسطـة*「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ نـوع الهمسـة (ملف 📂)*","md",true)
Redis:del(Zelzal.."Zelzal:Add:Hmsm:Media:File"..zillzall[2]..zillzall[1])
end
if audio then
local captionsend = Redis:get(Zelzal.."Zelzal:Add:Hmsm:caption:audio"..audio..zillzall[2]) or ''
bot.sendAudio(msg_user_send_id,msg_id, audio, '['..captionsend..']',"md")
send(msg_user_send_id,msg_id,"*⇜ عمࢪي* 「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ هـذه همسة ميديا من*「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」","md",true)
send(zillzall[2],0,"*⇜ عمࢪي* 「 ["..sender_name.."](tg://user?id="..zillzall[2]..") 」\n*⇜ تم فتـح همستك .. بنجـاح ✅*\n*⇜ بواسطـة*「 ["..to_name.."](tg://user?id="..zillzall[3]..") 」\n*⇜ نـوع الهمسـة (مقطع صوتي 🎙)*","md",true)
Redis:del(Zelzal.."Zelzal:Add:Hmsm:Media:Audio"..zillzall[2]..zillzall[1])
end
end
if text and text:match("/start hazr(.*)from_id(%d+)") then
bob = {text:match("/start hazr(.*)from_id(%d+)") }
if msg_user_send_id ~= tonumber(bob[2]) then
return send(msg_user_send_id,msg_id,'*⇜ هـذا الامـر ليس لك ياحمـار 😒*',"md",true)  
end
local list = Redis:smembers(Zelzal..'listhzerid'..msg.chat_id) 
if #list == 1 then 
return send(msg_user_send_id,msg_id,'*⇜ يجب انضمام لاعبان على الاقل\n اعد الضغط على زر*',"md",true)  
end 
hazrgroupid = Redis:get(Zelzal.."hazrgroupid"..msg_user_send_id)
if not Redis:get(Zelzal.."hzergametime"..hazrgroupid) then
return false
end
Redis:set(Zelzal.."hazrstart"..msg_user_send_id, true)
return send(msg_user_send_id,msg_id,'⇜ ارسل السؤال مع الجواب وبينهم اشارة هاشتاك #\n- مثال :\n حيوان شرس من اربع احرف#الاسد\n ✓',"md",true)  
elseif text and text:match('(.*)#(.*)') and Redis:get(Zelzal.."hazrstart"..msg_user_send_id) then
if msg_user_send_id ~= tonumber(bob[2]) then
return send(msg_user_send_id,msg_id,'⇜ هـذا الامـر ليس لك ياحمـار 😒',"md",true)  
end
if not Redis:get(Zelzal.."hzergametime"..hazrgroupid) then
return false
end
bobe = {text:match("(.*)#(.*)") }
Redis:del(Zelzal.."hazrstart"..msg_user_send_id)
send(msg_user_send_id,msg_id,'*⇜ تم ارسال السؤال الى القروب*\n ✓',"md",true)
Redis:set(Zelzal.."hazrqustion"..hazrgroupid, bobe[1])
Redis:set(Zelzal.."hazranswer"..hazrgroupid, bobe[2])
Redis:del(Zelzal.."hzergametime"..hazrgroupid)
local nameuser = bot.getUser(msg_user_send_id)
if nameuser.first_name then
nameuser = "["..nameuser.first_name.."](tg://user?id="..nameuser.id..")"
else
nameuser = 'لا يوجد اسم'
end
local time = os.time()
Redis:set(Zelzal.."Zilzal:Game:Time"..hazrgroupid,time)
send(hazrgroupid,0,'السؤال من '..nameuser..'\n\n- '..bobe[1]..' ؟\n ✓',"md",true)
Redis:del(Zelzal.."hazrgroupid"..msg_user_send_id)
end
-----------------
if text and text:match("/start korsi(.*)from_id(%d+)") then
local testkorsi = {text:match("/start korsi(.*)from_id(%d+)") }
local chat_id = Redis:get(Zelzal.."korsi:"..testkorsi[1].."chat_id")
local Quizz = Redis:get(Zelzal.."Quiz:Add:Koorsy"..chat_id) or 0
if tonumber(Quizz) == tonumber(10) then
return send(msg_user_send_id,msg_id, "*⇜ عذراً لقد وصلتم للحد الاعلى من الاسئلة\n⇜ ارسل كرسي وابدأ اللعب من جديد*","md",true)  
end
if not Redis:sismember(Zelzal..'List_Korsi'..chat_id,testkorsi[2]) then
send(msg_user_send_id,msg_id,'*⇜ الامر للمشاركين في اللعبة فقط*',"md",true)  
else
Redis:set(Zelzal.."korsi:"..msg_user_send_id, testkorsi[1])
return send(msg_user_send_id,msg_id,'*⇜ ارسل السؤال الان*',"md",true)  
end
elseif text and not text:match("(.*)start(.*)") and Redis:get(Zelzal.."korsi:"..msg_user_send_id) then
local testkorsi = Redis:get(Zelzal.."korsi:"..msg_user_send_id)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'نعم', data = msg_user_send_id.."korsi"..testkorsi},{text = 'لا', data = msg_user_send_id.."nn_korsi"..testkorsi}
},
}
}
Redis:set(Zelzal.."korsi:"..testkorsi.."text:", text)
return bot.sendText(msg_chat_id,msg_id,"*⇜ هل انتا متأكد من السؤال ؟*","md",true,false,false,false,reply_markup)
end
-----------------
if text and text:match("/start saraha(.*)from_id(%d+)") then
local testsaraha = {text:match("/start saraha(.*)from_id(%d+)") }
local chat_id = Redis:get(Zelzal.."saraha:"..testsaraha[1].."chat_id")
local Qiuizz = Redis:get(Zelzal.."Quiz:Add:Saraha"..chat_id) or 0
if tonumber(Qiuizz) == tonumber(5) then
return send(msg_user_send_id,msg_id, "*⇜ عذراً لقد وصلتم للحد الاعلى من الاسئلة\n⇜ ارسل صراحه وابدأ اللعب من جديد*","md",true)   
end
if msg_user_send_id ~= tonumber(testsaraha[2]) then
send(msg_user_send_id,msg_id,'*⇜ انتا لست الفائز*',"md",true)    
else
Redis:set(Zelzal.."saraha:"..msg_user_send_id, testsaraha[1])
return send(msg_user_send_id,msg_id,'*⇜ ارسل السؤال الان*',"md",true)  
end
elseif text and not text:match("(.*)start(.*)") and Redis:get(Zelzal.."saraha:"..msg_user_send_id) then
local testsaraha = Redis:get(Zelzal.."saraha:"..msg_user_send_id)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'نعم', data = msg_user_send_id.."saraha"..testsaraha},{text = 'لا', data = msg_user_send_id.."nn_saraha"..testsaraha}
},
}
}
Redis:set(Zelzal.."saraha:"..testsaraha.."text:", text)
return bot.sendText(msg_chat_id,msg_id,"*⇜ سيتم ارسال السؤال بسرية تامة اضغط نعم*","md",true,false,false,false,reply_markup)
end
-----------------
if text and text:match("/start koorsi(.*)") then
local testkoorsi = {text:match("/start koorsi(.*)") }
local chat_id = Redis:get(Zelzal.."koorsi:"..testkoorsi[1].."chat_id")
local Quizz = Redis:get(Zelzal.."Quiz:Add:Koorsy"..chat_id) or 0
if tonumber(Quizz) == tonumber(10) then
return send(msg_user_send_id,msg_id, "*⇜ عذراً لقد وصلتم للحد الاعلى من الاسئلة\n⇜ ارسل كرسي وابدأ اللعب من جديد*","md",true)  
end
if not Redis:sismember(Zelzal..'List_Koorsi'..chat_id,IdUser) then
send(msg_user_send_id,msg_id,'*⇜ الامر للمشاركين في اللعبة فقط*',"md",true)  
else
Redis:set(Zelzal.."koorsi:"..msg_user_send_id, testkoorsi[1])
return send(msg_user_send_id,msg_id,'*⇜ ارسل السؤال الان*',"md",true)  
end
elseif text and not text:match("(.*)start(.*)") and Redis:get(Zelzal.."koorsi:"..msg_user_send_id) then
local testkoorsi = Redis:get(Zelzal.."koorsi:"..msg_user_send_id)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'نعم', data = msg_user_send_id.."koorsi"..testkoorsi},{text = 'لا', data = msg_user_send_id.."nn_koorsi"..testkoorsi}
},
}
}
Redis:set(Zelzal.."koorsi:"..testkoorsi.."text:", text)
return bot.sendText(msg_chat_id,msg_id,"*⇜ هل انتا متأكد من السؤال ؟*","md",true,false,false,false,reply_markup)
end
------------------------------------ كود لوحة الاعضاء ------------------------------------
if text and text:match("^بوت (.*)$") then
local TextName = text:match("^بوت (.*)$")
if TextName == "حذف" or TextName == "الحذف" then
return false
end
local TextLoading = "*⇜ جـارِ الاتصال بالذكاء الاصطناعي ➿*\n*⇜ انتظـر لحظـات ⏳*"
local rep = msg.id/2097152/0.5
local m = json:decode(https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..msg_chat_id.."&text="..URL.escape(TextLoading).."&parse_mode=markdown&reply_to_message_id="..rep)).result.message_id
local url = https.request("https://api-1stclass-hashierholmes.vercel.app/gpt/ada?question="..URL.escape(TextName))
local json = JSON.decode(url)
if json and json.message then
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
return send(msg_chat_id,msg_id,'*'..json.message..'*',"md",true)
end
if json and json.answer then
return send(msg_chat_id,msg_id,'*'..json.answer..'*',"md",true)
end
end
-------------------------------------------------------------------------
if text == '/start' or text == '✦ رجـوع ✦' then
local photo = bot.getUserProfilePhotos(Zelzal)
local ban = bot.getUser(Zelzal)
local Zilzal = bot.getUser(Sudo_Id) 
local Ahmedd = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "فولت")
local bain = bot.getUser(msg.sender_id.user_id)
Participants = (Redis:scard(Zelzal..'Zelzal:Num:User:Pv') or 0)
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)  
if not msg.ControllerBot then
if not Redis:get(Zelzal.."Zelzal:Start:Bot") then
if bain.username then
banusername = ' @'..bain.username..' '
else
banusername = 'لا يوجد'
end
if bain.first_name then
baniusername = '*['..bain.first_name..'](tg://user?id='..bain.id..')*'
else
baniusername = 'لا يوجد'
end
local Usperos = ' '..Participants..' '
local CmdStart = '*\n⇜ اططلـق بـوت اسمـي '..(Redis:get(Zelzal.."Zelzal:Name:Bot") or "لا يوجد بعد")..
'\n⇜ الأفضـل ؏ـلى تيليجـرام 𓌗'..
'\n⇜ بـوت خـدمي + حمايـة + ذكاء اصطناعي + زخرفـة + همسـه .. والمزيـد'..
'\n⇜ لحمايـة المجموعـات من التفليش والتصفير والاباحي .. الخ'..
'\n⇜ اكثـر من 100 لعبة مسلية وجديدة'..
'\n⇜ فقـط ارفعـني إشـراف كامـل الصلاحيـات'..
'\n⇜ وسيتم تفعيـل البـوت تلقـائيـاً'..
'\n\n⇜ لعـرض كيبـورد الاوامـر الخـدميـة إضغـط ← /cmds *'
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '✦ إضغط لاضافه '..Ahmedd..' لمجموعتك ✦', url = 't.me/'..UserBot..'?startgroup=new'},},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(CmdStart).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
if Redis:get(Zelzal.."Zelzal:LogerBot") then
local Loger_Id = Redis:get(Zelzal.."Zelzal:Loger:Groub")
send(Loger_Id,0,'*\n⇜ سيـدي المطـور دخـل شخـص إلى البـوت 🥷 \n⇜ إسمـه ⇜ '..baniusername..' \n⇜ ايديـه ⇜ '..msg.sender_id.user_id..'\n⇜ معرفـه ⇜ '..banusername..' \n⇜ أصبحت إحصـائيات بـوتك سيـدي ⇜ '..Usperos..' \n *',"md")
else
send(Sudo_Id,0,'*\n⇜ سيـدي المطـور دخـل شخـص إلى البـوت 🥷 \n⇜ إسمـه ⇜ '..baniusername..' \n⇜ ايديـه ⇜ '..msg.sender_id.user_id..'\n⇜ معرفـه ⇜ '..banusername..' \n⇜ أصبحت إحصـائيات بـوتك سيـدي ⇜ '..Usperos..' \n *',"md")
end
else
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{{text = 'إضغط لاضافه '..Ahmedd..'لمجموعتك 𖠪', url = 't.me/'..UserBot..'?startgroup=new'},},
{{text = Zilzal.first_name, url = "https://t.me/"..Zilzal.username..""},},}}
return send(msg_chat_id,msg_id,Redis:get(Zelzal.."Zelzal:Start:Bot"),"md",false, false, false, false, reply_markup)
end
end
else
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = '★ السـورس ★',type = 'text'},{text = '★ البـوت ★',type = 'text'},},
{{text = '★ التواصــل ★',type = 'text'},},
{{text = '★ الاشتـراك الاجبـاري ★',type = 'text'},},
{{text = '★ الاذاعـه ★',type = 'text'},{text = '★ الاحصائيـات ★',type = 'text'},},
{{text = '★ المطوريـن ★',type = 'text'},{text = '★ الـردود العـامـه ★',type = 'text'},},
{{text = '★ الحظـر والكتـم العـام ★',type = 'text'},},
{{text = '★ كاشـف الانتحـال ★',type = 'text'},},
{{text = '★ تخصيص رتب البـوت ★',type = 'text'},},
{{text = '★ قـروب اشعـارات البـوت ★',type = 'text'},},
{{text = '★ كيبـورد الخـدمـات ★',type = 'text'},},
}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك مطـوري الغـالي🧑🏻‍💻\n⇜ في لوحتـك الخـاصـه لـ التحكـم بـ البـوت ⎋*', 'md', false, false, false, false, reply_markup)
end
end
if text == "اوامر المطور" or text == "★ المطوريـن ★" then 
if msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = '✦ المطـور ✦',type = 'text'},},
{{text = '✦ اوامـر المطـور الاسـاسـي ✦',type = 'text'},},
{{text = '✦ المطورين الثانويين ✦',type = 'text'},{text = '✦ المطورات الثانويات ✦',type = 'text'},},
{{text = '✦ المطـوريـن ✦',type = 'text'},{text = '✦ المطـورات ✦',type = 'text'},},
{{text = '✦ تنزيل مطور اساسي ✦',type = 'text'},{text = '✦ رفع مطور اساسي ✦',type = 'text'},},
{{text = '✦ تغيير كليشة المطور ✦',type = 'text'},{text = '✦ حذف كليشة المطور ✦', type = 'text'},},
{{text = '✦ الغـاء الامــر ✦',type = 'text'},},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك مجـددًا .. عـزيـزي المطـور* \n*⇜ اليك الازرار الخاصـه بالمطـوريـن لسـورس تيبثــون 𝙏𝙀𝙋𝙏𝙃𝙊𝙉*', 'md', false, false, false, false, reply_markup)
end
end
if text == "★ البـوت ★" and msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = '✦ تغيير اسم البوت ✦',type = 'text'},{text = '✦ حذف اسم البوت ✦', type = 'text'},},
{{text = '✦ تعيين نـوع البوت ✦', type = 'text'},},
{{text = '✦ تفعيل البوت الخدمي ✦',type = 'text'},},
{{text = '✦ تعطيل البوت الخدمي ✦', type = 'text'},},
{{text = '✦ تعطيل نداء المطور ✦',type = 'text'},{text = '✦ تفعيل نداء المطور ✦', type = 'text'},},
{{text = '✦ الغـاء الامــر ✦',type = 'text'},},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك مجـددًا .. عـزيـزي المطـور* \n*⇜ اليك الازرار الخاصـه بـ اوامـر البـوت لسـورس تيبثــون 𝙏𝙀𝙋𝙏𝙃𝙊𝙉*', 'md', false, false, false, false, reply_markup)
end
if text == "★ الاحصائيـات ★" and msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = '✦ الاحصـائيـات ✦',type = 'text'},},
{{text = '✦ ترند المجموعات ✦', type = 'text'},{text = '✦ روابط المجموعات ✦', type = 'text'},},
{{text = '✦ تنظيف المجموعات ✦',type = 'text'},{text = '✦ تنظيف المشتركين ✦', type = 'text'},},
{{text = '✦ جلب نسخه احتياطيه ✦',type = 'text'},},
{{text = '✦ جلب نسخة الردود ✦',type = 'text'},},
{{text = '✦ جلب نسخه الردود عام ✦',type = 'text'},},
{{text = '✦ تفعيل نسخه تلقائيه ✦',type = 'text'},{text = '✦ تعطيل نسخه تلقائيه ✦', type = 'text'},},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك .. عـزيـزي المطـور*\n*⇜ اليك الازرار الخاصه بقسـم إحصـائيات البـوت*', 'md', false, false, false, false, reply_markup)
end
if text == "اوامر الردود" or text == "★ الـردود العـامـه ★" then
if msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{
{text = 'اضف رد عام',type = 'text'},{text = 'اضف رد متعدد عام', type = 'text'},
},
{
{text = 'مسح رد عام',type = 'text'},{text = 'مسح رد متعدد عام', type = 'text'},
},
{
{text = 'الردود العامه',type = 'text'},{text = 'الردود المتعدده عام', type = 'text'},
},
{
{text = 'الغاء الامر',type = 'text'},
},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك .. عـزيـزي المطـور*\n*⇜ اليك الازرار الخاصه بقسـم ردود البـوت عـام*', 'md', false, false, false, false, reply_markup)
end
end
if text == "★ الاذاعـه ★" and msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = '✦ اذاعـه بالتثبيت ✦',type = 'text'},},
{{text = '✦ اذاعـه للمجموعـات ✦',type = 'text'},{text = '✦ اذاعـه خـاص ✦', type = 'text'},},
{{text = '✦ اذاعـه بالتوجيـه ✦',type = 'text'},{text = '✦ اذاعه بالتوجيه خاص ✦', type = 'text'},},
{{text = '✦ الغـاء الامــر ✦',type = 'text'},},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك مجـددًا .. عـزيـزي المطـور* \n*⇜ اليك الازرار الخاصـه بالاذاعـه لسـورس تيبثــون 𝙏𝙀𝙋𝙏𝙃𝙊𝙉*', 'md', false, false, false, false, reply_markup)
end
if text == "اوامر الاشتراك الاجباري" or text == "★ الاشتـراك الاجبـاري ★" then
if msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{
{text = "ضع تاريخ الاشتراك",type = 'text'},{text = "اشتراك البوت", type = 'text'},
},
{
{text = 'الاشتراك الاجباري',type = 'text'},{text = 'تغيير الاشتراك الاجباري',type = 'text'},
},
{
{text = 'تفعيل الاشتراك الاجباري',type = 'text'},{text = 'تعطيل الاشتراك الاجباري',type = 'text'},
},
{
{text = 'الغاء الامر',type = 'text'},
},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك .. عـزيـزي المطـور*\n*⇜ اليك الازرار الخاصه بقسـم الاشتـراك الاجبـاري*', 'md', false, false, false, false, reply_markup)
end
end
if text == "اوامر التواصل" or text == "★ التواصــل ★" then
if msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{
{text = 'تعطيل التواصل',type = 'text'},{text = 'تفعيل التواصل',type = 'text'},
},
{
{text = 'تعطيل ردود التواصل',type = 'text'},{text = 'تفعيل ردود تواصل',type = 'text'},
},
{
{text = 'مسح رد تواصل',type = 'text'},{text = 'اضف رد تواصل',type = 'text'},
},
{
{text = 'ردود التواصل',type = 'text'},
},
{
{text = 'الغاء الامر',type = 'text'},
},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك .. عـزيـزي المطـور*\n*⇜ اليك الازرار الخاصه بقسـم التواصـل*', 'md', false, false, false, false, reply_markup)
end
end
if text == "★ الحظـر والكتـم العـام ★" and msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{
{text = 'المحظورين عام',type = 'text'}, {text = 'المكتومين عام',type = 'text'},
},
{
{text = 'مسح المحظورين عام',type = 'text'},{text = 'مسح المكتومين عام', type = 'text'},
},
{
{text = 'قائمه العام',type = 'text'},
},
{
{text = 'الغاء الامر',type = 'text'},
},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك .. عـزيـزي المطـور*\n*⇜ اليك الازرار الخاصه بالكتـم والحظـر العـام*', 'md', false, false, false, false, reply_markup)
end
if text == "★ كاشـف الانتحـال ★" and msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = '✦ تفعيل كاشف الانتحال ✦',type = 'text'},},
{{text = '✦ تعطيل كاشف الانتحال ✦',type = 'text'},},
{{text = '✦ الغـاء الامــر ✦',type = 'text'},},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك .. عـزيـزي المطـور 🧑🏻‍💻 *\n*⇜ اليك اوامـر كاشف الانتحال 🥷*\n\n*⇜ ماهـو كاشف الانتحال ⁉️*\n*كاشف الانتحال اضافة جديده ممطروقـه لـ البوت*\nعندما يتم تفعيل الكاشف سوف يطلب البوت منك اسم كمثال اسم حسابك عندما يكتشف البوت باحدى المجموعات ان في شخص منتحل حسابك سوف يقوم البوت بكتمه تلقائياً لحتى يغير الاسم وسوف يقوم البوت بارسال رسالة اليك هنا بـ يوزر الشخص ورابط المجموعة التي وجده فيها', 'md', false, false, false, false, reply_markup)
end
if text == "★ تخصيص رتب البـوت ★" and msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = '✦ رتبة المطور الاساسي ✦',type = 'text'},},
{{text = '✦ رتبة المطور الاساسي2 ✦',type = 'text'},},
{{text = '✦ رتبة المطور الثانوي ✦',type = 'text'},},
{{text = '✦ رتبة المطوره الثانويه ✦',type = 'text'},},
{{text = '✦ رتبة المطوره ✦',type = 'text'},{text = '✦ رتبة المطور ✦',type = 'text'},},
{{text = '✦ رتبة المالك الاساسي ✦',type = 'text'},},
{{text = '✦ رتبة المالكه الاساسيه ✦',type = 'text'},},
{{text = '✦ رتبة المالكه ✦',type = 'text'},{text = '✦ رتبة المالك ✦',type = 'text'},},
{{text = '✦ رتبة المنشئ الاساسي ✦',type = 'text'},},
{{text = '✦ رتبة المنشئه الاساسيه ✦',type = 'text'},},
{{text = '✦ رتبة المنشئه ✦',type = 'text'},{text = '✦ رتبة المنشئ ✦',type = 'text'},},
{{text = '✦ رتبة المديره ✦',type = 'text'},{text = '✦ رتبة المدير ✦',type = 'text'},},
{{text = '✦ رتبة الادمونه ✦',type = 'text'},{text = '✦ رتبة الادمن ✦',type = 'text'},},
{{text = '✦ رتبة المميزه ✦',type = 'text'},{text = '✦ رتبة المميز ✦',type = 'text'},},
{{text = '✦ رتبة العضو ✦',type = 'text'},},
{{text = '✦ الغـاء الامــر ✦',type = 'text'},},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك .. عـزيـزي المطـور*\n*⇜ اليك الازرار الخاصه بتخصيص وتغييـر رتب البـوت عـام*', 'md', false, false, false, false, reply_markup)
end
if text == "★ قـروب اشعـارات البـوت ★" and msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = '✦ تفعيل قروب الاشعارات ✦',type = 'text'},},
{{text = '✦ تعطيل قروب الاشعارات ✦',type = 'text'},},
{{text = '✦ الغـاء الامــر ✦',type = 'text'},},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بك .. عـزيـزي المطـور 🧑🏻‍💻 *\n*⇜ اليك اوامـر قـروب اشعـارات سجـل البـوت 🛎*\n\n*⇜ ماهـو قـروب الاشعـارات ⁉️*\n*قـروب الاشعـارات اضافة جديده ممطروقـه لـ البـوت*\nعندما يتم تفعيل واضافة المجموعة\nسوف يطلب البوت منك ايدي المجموعة وعندما يتم تفعيل المجموعة واضافة البوت اليها\nسوف تكون المجموعة مكان لـ تخزين اشعارات البوت بدلاً من خاص البوت\nحتى يصبح خاص البوت مكاناً مرتبًـا بعيـداً عن الاشعـارات المزعجـه احيانا لبعـض مطورين البوت', 'md', false, false, false, false, reply_markup)
end
if text == "★ السـورس ★" and msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{
{text = "ضع صوره للترحيب",type = 'text'},{text = 'معلومات التنصيب',type = 'text'},
},
{
{text = 'تعيين رمز السورس',type = 'text'},{text = 'مسح رمز السورس',type = 'text'},
},
{
{text = 'تعيين قناة الحقوق',type = 'text'},{text = 'مسح قناة الحقوق',type = 'text'},
},
{
{text = 'تغيير كليشه المطور',type = 'text'},{text = 'مسح كليشه المطور', type = 'text'},
},
{
{text = 'تغيير كليشة السورس',type = 'text'},{text = 'مسح كليشة السورس', type = 'text'},
},
{
{text = 'تنظيف المجموعات',type = 'text'},{text = 'تنظيف المشتركين', type = 'text'},
},
{
{text = 'الغاء الامر',type = 'text'},
},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ الازرار الخاصه*', 'md', false, false, false, false, reply_markup)
end
if text == "العوده" or text == '✦ رجـوع ✦' then
if msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = '★ السـورس ★',type = 'text'},{text = '★ البـوت ★',type = 'text'},},
{{text = '★ التواصــل ★',type = 'text'},},
{{text = '★ الاشتـراك الاجبـاري ★',type = 'text'},},
{{text = '★ الاذاعـه ★',type = 'text'},{text = '★ الاحصائيـات ★',type = 'text'},},
{{text = '★ المطوريـن ★',type = 'text'},{text = '★ الـردود العـامـه ★',type = 'text'},},
{{text = '★ الحظـر والكتـم العـام ★',type = 'text'},},
{{text = '★ كاشـف الانتحـال ★',type = 'text'},},
{{text = '★ تخصيص رتب البـوت ★',type = 'text'},},
{{text = '★ قـروب اشعـارات البـوت ★',type = 'text'},},
{{text = '★ كيبـورد الخـدمـات ★',type = 'text'},},
}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك مطـوري الغـالي🧑🏻‍💻\n⇜ في لوحتـك الخـاصـه لـ التحكـم بـ البـوت ⎋*', 'md', false, false, false, false, reply_markup)
end
end
if text == '★ اشعار واقتباسات ★' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'شعر',type = 'text'},{text = 'قصائد', type = 'text'},
},
{
{text = 'لوكيت',type = 'text'},{text = 'عبارات', type = 'text'},
},
{
{text = 'جداريات',type = 'text'},{text = 'هيدرات', type = 'text'},
},
{
{text = 'اقتباسات',type = 'text'},{text = 'اقتباس', type = 'text'},
},
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك عـزيـزي \n⇜ في قسـم الاشعـار والاقتباسـات ⎋*', 'md', false, false, false, false, reply_markup)
end
if text == '★ ترفيه ومرح ★' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'مسلسل',type = 'text'},{text = 'فلم', type = 'text'},
},
{
{text = 'ايدت انمي',type = 'text'},{text = 'ايدت', type = 'text'},
},
{
{text = 'اطربني',type = 'text'},{text = 'اغاني', type = 'text'},
},
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك عـزيـزي \n⇜ في قسـم الترفيـه والمـرح ⎋*', 'md', false, false, false, false, reply_markup)
end
if text == '★ سينما ومسرح ★' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'مسلسل',type = 'text'},{text = 'فلم', type = 'text'},
},
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك عـزيـزي \n⇜ في قسـم السينمـا والمسـرح ⎋*', 'md', false, false, false, false, reply_markup)
end
if text == '★ افتـارات ★' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'افتارات تطقيم',type = 'text'},
},
{
{text = 'افتارات بنات',type = 'text'},{text = 'افتارات عيال',type = 'text'},
},
{
{text = 'افتارات كيبوب',type = 'text'}, {text = 'افتارات انمي',type = 'text'},
},
{
{text = 'افتارات فنانين',type = 'text'},{text = 'افتارات لاعبين', type = 'text'},
},
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك عـزيـزي \n⇜ في قسـم الافتـآرات والصـور ⎋*', 'md', false, false, false, false, reply_markup)
end
if text == '★ متحركـات ★' then 
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'متحركات بنات',type = 'text'}, {text = 'متحركات عيال',type = 'text'},
},
{ 
{text = 'متحركات اطفال',type = 'text'},{text = 'متحركات كيبوب', type = 'text'},
},
{
{text = 'متحركات كوكسال',type = 'text'},{text = 'متحركات رومانسيه', type = 'text'},
},
{
{text = 'متحركات قطط',type = 'text'},
},
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك عـزيـزي \n⇜ في قسـم المتحـركـات المتنـوعـه ⎋*', 'md', false, false, false, false, reply_markup)
end
if text == '★ االذكـاء الاصطنـاعـي ★' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local TextHelp = [[*
『  الذكــاء الاصطنــاعــي 💡🦾  』
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
اول بوت حماية يدعم الذكاء الاصطناعي ChatGpt 🔅

يتميز البوت عن بقية البوتات بدعمه لـ آخر اصدار من اصدارات الذكاء الاصطناعي
ChatGpt3.5-turbo 
الذي يتميز بـ :
- آخر اصدار ذكي ومحدث
- الإجابة على الأسئلة بشكل دقيق وسريع
- دعم جميع اللغات والمواضيع بما فيها اللغة العربية
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
كل ماعليك هو فقط ارسـال
بوت + سؤالك
*]]
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id, TextHelp, 'md', false, false, false, false, reply_markup)
end
if text == '★ ميـوزك المكالمـات ★' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local TextHelp = [[*
『  الميـوزك & المكالمـات 🎶🎧 』
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
يتميـز البـوت بـ تشغيـل الاغـاني والفيديـو في المحـادثات الصوتيـه والمرئيـه

لـ تصفـح اوامـر قسـم الميـوزك ارسـل
(ميوزك)
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
هناك سورس ميوزك كامل مربوط ببوت الحماية لـ جعل البوت خدمـي و شامـل لكـل شـيئ
*]]
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id, TextHelp, 'md', false, false, false, false, reply_markup)
end
if text == '★ 𝗬𝗼𝘂𝗧𝘂𝗯𝗲🎞اليوتيوب ★' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local TextHelp = [[*
『  اليوتيوب 🎞 𝗬𝗼𝘂𝗧𝘂𝗯𝗲  』
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
يتميـز البـوت بـ تحميـل عالـي السـرعـة وبلا حـدود من اليـوتيـوب 🛸

- لـ تحميـل المقـاطع الصوتيـه 🎧 ارسـل
(بحث) + اسـم الاغنيـه

- لـ البحث عن روابـط 🖇 ارسـل
(ابحث) + كلمـه او نـص

ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
*]]
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id, TextHelp, 'md', false, false, false, false, reply_markup)
end
if text == '★ العـاب ممطروقـه ★' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local TextHelp = [[*
『  قائمـة الالعـاب الجديـدة 🎮🎳  』
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
- لعبـة الرعـب الشهيـرة مريــم 🧟‍♀
- لعبـة تحليـل شخصيتـك من لونـك المفضـل 🧞‍♀
- لعبـة سيـارات عشوائيـه 🚗
- العـاب الانـلايـن المتطـوره 🪁

- هنـاك المزيـد من الالعـاب 40 لعبـة اخـرى تستطيـع ان تجربهـا في المجمـوعـات فقـط ارسـل كلمـة العاب في المجمـوعـة 🏆
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
*]]
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '★ لعبـة مريـم ★',type = 'text'}
},
{
{text = '★ شخصيتك من لونك المفضـل ★',type = 'text'}
},
{
{text = '★ لعبـة سيارتـي ★',type = 'text'}
},
{
{text = '★ العـاب الانـلايـن ★',type = 'text'}
},
{{text = 'رجــوع',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id, TextHelp, 'md', false, false, false, false, reply_markup)
end
if text == '★ كيبـورد الخـدمـات ★' or text == 'رجــوع' then
if msg.ControllerBot then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = '★ متحركـات ★',type = 'text'},{text = '★ افتـارات ★',type = 'text'},},
{{text = '★ االذكـاء الاصطنـاعـي ★',type = 'text'},},
{{text = '★ ميـوزك المكالمـات ★',type = 'text'},},
{{text = '★ 𝗬𝗼𝘂𝗧𝘂𝗯𝗲🎞اليوتيوب ★',type = 'text'},},
{{text = '★ العـاب ممطروقـه ★',type = 'text'},},
{{text = '★ حالات واتس ★',type = 'text'},{text = '★ ترفيه ومرح ★',type = 'text'},},
{{text = '★ سينما ومسرح ★',type = 'text'},},
{{text = '★ اشعار واقتباسات ★',type = 'text'},{text = '★ قرآن كريم ★',type = 'text'},},
{{text = '★ الطقـس ودرجة الحرارة ★',type = 'text'},},
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return send(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك مطـوري الغـالي🏻‍💻\n⇜ في لوحـة الاوامـر الخدميـه ⎋*', 'md', false, false, false, false, reply_markup)
end
end
if text == '/keb' or text == '/cmds' or text == 'رجــوع' then
Redis:sadd(Zelzal..'Zelzal:Num:User:Pv',msg.sender_id.user_id)
Redis:set(Zelzal.."keyboardmemb"..msg.sender_id.user_id,true)
if not msg.ControllerBot then
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = '★ متحركـات ★',type = 'text'},{text = '★ افتـارات ★',type = 'text'},},
{{text = '★ االذكـاء الاصطنـاعـي ★',type = 'text'},},
{{text = '★ ميـوزك المكالمـات ★',type = 'text'},},
{{text = '★ 𝗬𝗼𝘂𝗧𝘂𝗯𝗲🎞اليوتيوب ★',type = 'text'},},
{{text = '★ العـاب ممطروقـه ★',type = 'text'},},
{{text = '★ حالات واتس ★',type = 'text'},{text = '★ ترفيه ومرح ★',type = 'text'},},
{{text = '★ سينما ومسرح ★',type = 'text'},},
{{text = '★ اشعار واقتباسات ★',type = 'text'},{text = '★ قرآن كريم ★',type = 'text'},},
{{text = '★ الطقـس ودرجة الحرارة ★',type = 'text'},},
}}
return bot.sendText(msg_chat_id,msg_id,'*⇜ مرحبًـا بـك عـزيـزي🧑🏻‍💻\n⇜ في لوحـة الاوامـر الخدميـه ⎋*', 'md', false, false, false, false, reply_markup)
end
end
-----------------
if Redis:get(Zelzal.."set:chs"..msg.sender_id.user_id) then
if text then
if text == "الغاء" then
Redis:del(Zelzal.."set:chs"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'*⇜ تم الغـاء الامـر .. بنجـاح ✓*',"md",true)  
end
if text:match("^@(.*)$") then
local ch = text:match("^@(.*)$")
Redis:set(Zelzal.."chsource",ch)
Redis:del(Zelzal.."set:chs"..msg.sender_id.user_id)
send(msg_chat_id,msg_id,'*⇜ تم حفـظ معـرف قنـاة الحقـوق .. بنجـاح ✓*',"md",true)
dofile('Zelzal.lua')  
else
send(msg_chat_id,msg_id,'*⇜ اووبـس .. المعـرف خطـأ*',"md",true)  
end
end
end
if text == "تعيين قناة الحقوق" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."set:chs"..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,'*ارسل معرف القناه الان*',"md",true)  
end
if text == "حذف قناة الحقوق" or text == "مسح قناة الحقوق" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."chsource")
return send(msg_chat_id,msg_id,'*⇜ تم استعـادة قنـاة السـورس الرسميـة .. بـنجـاح ☑️*',"md",true)  
end
-----------------
if Redis:get(Zelzal.."set:rmz"..msg.sender_id.user_id) then
if text then
if text == "الغاء" then
Redis:del(Zelzal.."set:rmz"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء الامر ',"md",true)  
end
Redis:set(Zelzal..'rmzsource',text)
Redis:del(Zelzal.."set:rmz"..msg.sender_id.user_id)
send(msg_chat_id,msg_id,'*⇜ تم حفـظ رمـز السـورس الجديـد .. بـنجـاح ☑️*',"md",true)  
dofile('Zelzal.lua')  
end
end
if text == "تعيين رمز السورس" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."set:rmz"..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,'*ارسـل الرمـز الجديـد بـدلاً مـن ( ⇜ )*',"md",true)  
end
if text == "حذف رمز السورس" or text == "مسح رمز السورس" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."rmzsource","⇜")
return send(msg_chat_id,msg_id,'*⇜ تم استعـادة رمـز السـورس الاصلـي .. بـنجـاح ☑️*',"md",true)  
end
-----------------
if text == "القروبات" or text == "الجروبات" or text == "الكروبات" or text == "المجموعات" or text == "✦ روابط المجموعات ✦" then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1895219306) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
local G = "قروبات البوت :\n"
local list = Redis:smembers(Zelzal.."Zelzal:ChekBotAdd")
for k,v in pairs(list) do  
local Get_Chat = bot.getChat(v)
local Info_Chats = bot.getSupergroupFullInfo(v)
if Info_Chats and Info_Chats.invite_link then
link = Info_Chats.invite_link.invite_link
else
link = "لا يوجد" 
end
if Get_Chat and Get_Chat.title then
title = Get_Chat.title
else 
title = "لا يوجد" 
end
G = G.."اسم القروب : "..title.."\nايدي القروب : "..v.."\nرابط القروب : "..link.."\nٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆\n"
end
local File = io.open('./Groups.txt', "w")
File:write(G)
File:close()
bot.sendDocument(msg_chat_id,msg_id,'./Groups.txt', '*⇜ تم جبتلك القروبات*\n', 'md')
end
if text == "ترند القروبات" or text == "ترند المجموعات" or text == "ترند الجروبات" or text == "ترند الكروبات" or text == "✦ ترند المجموعات ✦" then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1895219306) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
GroupAllRtba = Redis:hgetall(Zelzal..':GroupUserCountMsg:groups')
GetAllNames  = Redis:hgetall(Zelzal..':GroupNameUser:groups')
GroupAllRtbaL = {}
for k,v in pairs(GroupAllRtba) do table.insert(GroupAllRtbaL,{v,k}) end
Count,Kount,i = 8 , 0 , 1
for _ in pairs(GroupAllRtbaL) do Kount = Kount + 1 end
table.sort(GroupAllRtbaL, function(a, b) return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then Count = Kount end
Text = "⇜ قائمة ترند القروبات \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(GroupAllRtbaL) do
if v[2] and v[2]:match("(-100%d+)") then
local InfoChat = bot.getChat(v[2])
local InfoChats = bot.getSupergroupFullInfo(v[2])
if InfoChats.code ~= 400 then
var(InfoChats.invite_link)
if not InfoChats.invite_link then
linkedid = "["..InfoChat.title.."]" or "اسم القروب خطأ"
else
linkedid = "["..InfoChat.title.."]" or "اسم القروب خطأ"
end
if i <= Count then  
Text = Text..i..") :"..v[1].." | "..(linkedid).." \n" 
end ; 
i=i+1
end
end
end
return send(msg.chat_id,msg.id,Text,"md",true)
end
if text == 'تنظيف المشتركين' or text == '✦ تنظيف المشتركين ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = bot.getChat(v)
local ChatAction = bot.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(Zelzal..'Zelzal:Num:User:Pv',v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'⇜ العدد الكامل ( '..#list..' )\n⇜ تم العثور على ( '..x..' ) من المشتركين حاظرين البوت',"md")
else
return send(msg_chat_id,msg_id,'⇜ العدد الكامل ( '..#list..' )\n⇜ لم يتم العثور على وهميين',"md")
end
end
if text == "اضف رد متعدد عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
send(msg.chat_id,msg.id,"*⇜ ارسل الان الكلمه لاضافتها في الردود*","md",true)
Redis:set(Zelzal.."Set:arrayy"..msg.sender_id.user_id..":"..msg.chat_id,true)
return false 
end
if text == "مسح رد من متعدد عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Set:array:Ssdd"..msg.sender_id.user_id..":"..msg.chat_id,"delrd")
send(msg.chat_id,msg.id,"*⇜ ارسل كلمة الرد*","md",true)  
return false
end
if text == "مسح رد متعدد عام" then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Set:array:rdd"..msg.sender_id.user_id..":"..msg.chat_id,"delrd")
send(msg.chat_id,msg.id,"*⇜ ارسل الان الكلمه لمسحها من الردود*","md",true)  
return false
end
if text == ("الردود المتعدده عام") or text == ("✦ الـردود المتعـدده عـام ✦") then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal..'List:arrayy')
t = "*⇜ قائمه الردود المتعدده عام*\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆* \n\n"
for k,v in pairs(list) do
t = t..""..k.." - ( "..v.." ) ࿓ ( رسالة )\n"
end
if #list == 0 then
t = "*⇜ لا يوجد ردود متعدده عام*"
end
send(msg.chat_id,msg.id,t,"md",true)  
end
if text == 'تنظيف المجموعات' or text == '✦ تنظيف المجموعات ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = bot.getChat(v)
if Get_Chat.id then
local statusMem = bot.getChatMember(Get_Chat.id,Zelzal)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
send(Get_Chat.id,0,'*⇜ البوت عضو في القروب سوف اغادر*',"md")
Redis:srem(Zelzal..'Zelzal:ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(Zelzal..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
bot.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(Zelzal..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(Zelzal..'Zelzal:ChekBotAdd',v)
bot.leaveChat(v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'⇜ العدد الكامل ( '..#list..' ) للقروبات \n⇜ تم العثور على ( '..x..' ) قروب البوت ليس ادمن \n⇜ تم تعطيل القروب ومغادرة البوت من الوهمي ',"md")
else
return send(msg_chat_id,msg_id,'⇜ العدد الكامل ( '..#list..' ) للقروبات \n⇜ لا توجد قروبات وهمية',"md")
end
end
if text == 'تغيير كليشه ستارت' or text == '✦ تغيير كليشه ستارت ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Change:Start:Bot"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي كليشه Start *","md",true)  
end
if text == 'مسح كليشه ستارت' or text == '✦ حذف كليشه ستارت ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Start:Bot") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح كليشه Start *","md",true)   
end
if text == 'اضف رد تواصل' or text == '✦ اضف رد التواصل ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Change:Twassl:Bot"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي رد التواصل *","md",true)  
end
if text == 'مسح رد تواصل' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Twassl:Bot") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح رد التواصل *","md",true)   
end
if text == 'تغيير كليشة السورس' or text == '✦ تغيير كليشة السورس ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id,true)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء', data = msg.sender_id.user_id..'/cancelamr'},
},
}
}
return send(msg_chat_id,msg_id,"*⇜ حلو , الحين ارسل كليشة السورس*\n*⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*","md",false, false, false, false, reply_markup)
end
if text == 'مسح كليشة السورس' or text == '✦ مسح كليشة السورس ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
if not Redis:get(Zelzal.."Sorce:Reply:inline") then
return send(msg_chat_id,msg_id,'\n*⇜ ليس هناك كليشه مضافه بعد*',"md",true)  
end
Redis:del(Zelzal.."Add:Rd:Sorce:Gif:inline") 
Redis:del(Zelzal.."Add:Rd:Sorce:Vico:inline") 
Redis:del(Zelzal.."Add:Rd:Sorce:Stekrs:inline") 
Redis:del(Zelzal.."Add:Rd:Sorce:Text:inline") 
Redis:del(Zelzal.."Add:Rd:Sorce:Photo:inline")
Redis:del(Zelzal.."Add:Rd:Sorce:Photoc:inline")
Redis:del(Zelzal.."Add:Rd:Sorce:Video:inline")
Redis:del(Zelzal.."Add:Rd:Sorce:Videoc:inline")
Redis:del(Zelzal.."Add:Rd:Sorce:File:inline")
Redis:del(Zelzal.."Add:Rd:Sorce:video_note:inline")
Redis:del(Zelzal.."Add:Rd:Sorce:Audio:inline")
Redis:del(Zelzal.."Add:Rd:Sorce:Audioc:inline")
Redis:del(Zelzal.."Rd:Sorce:inline:text")
Redis:del(Zelzal.."Rd:Sorce:inline:link")
Redis:del(Zelzal.."Sorce:Reply:inline")
Redis:del(Zelzal.."Set:Sorce:rd:inline"..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"*⇜ ابشر مسحت الرد من قائمة الانلاين*","md",true)
end
------------------------------------ زلزال الهيبه ------------------------------------
if (Redis:get(Zelzal..'Zelzal:Add:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id) == 'true') then
if text == 'الغاء' or text == 'الغاء الامر' or text == '✦ الغـاء الامــر ✦' then 
Redis:del(Zelzal..'Zelzal:Add:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,'⇜ تم الغاء تفعيل البوت في القناة')
end
Redis:del(Zelzal..'Zelzal:Add:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = bot.searchPublicChat(text)
if not UserId_Info.id then
Redis:del(Zelzal..'Zelzal:Add:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id)
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً .. لا يوجد حسـاب بهـذا المعـرف ؟!*","md",true)  
end
local ChannelUser = text:gsub('@','')
if UserId_Info.type.is_channel == true then
local StatusMember = bot.getChatMember(UserId_Info.id,Zelzal).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,"\n⇜ البوت عضو في القناة يرجى رفع البوت ادمن واعادة تفعيله ","md",true)  
end
Redis:sadd(Zelzal.."Zelzal:Add:Channel:Join"..msg.sender_id.user_id,ChannelUser) 
return send(msg_chat_id,msg_id,"\n⇜ تم تفعيل البوت على قناة : [@"..ChannelUser..']',"md",true)  
else
return send(msg_chat_id,msg_id,"\n⇜ هذا ليس معرف قناة يرجى ارسال معرف القناة الصحيح: [@"..ChannelUser..']',"md",true)  
end
end
end
if text == 'تفعيل البوت' then
Redis:set(Zelzal..'Zelzal:Add:Channel:Redis'..msg_chat_id..':'..msg.sender_id.user_id,true)
return send(msg_chat_id,msg_id,"\n⇜ ارسل يوزر قناتك الان ","md",true)  
end
if text == 'تعطيل البوت' then
Redis:srem(Zelzal.."Zelzal:Add:Channel:Join"..msg.sender_id.user_id,ChannelUser) 
return send(msg_chat_id,msg_id,"\n⇜ تم تعطيل البوت","md",true)  
end
if text == 'القناة المضافه' or text == 'القناه المضافه' then
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Add:Channel:Join"..msg.sender_id.user_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"⇜ لا يوجد قنوات , ","md",true)  
end
ListMembers = '\n*⇜ قائمة القنوات *\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
ListMembers = ListMembers..""..k.." - @"..v.."\n"
end
return send(msg_chat_id, msg_id, ListMembers, 'md')
end
-----------------
if text and text:match('^اوامر @(%S+)$') then
local UserName = text:match('^اوامر @(%S+)$')
local UserId_Info = bot.searchPublicChat(UserName)
if Redis:sismember(Zelzal.."Zelzal:Add:Channel:Join"..msg.sender_id.user_id,UserName) then
Redis:set(Zelzal.."chcmdpv"..msg.sender_id.user_id,UserName)
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = UserId_Info.title, url = 't.me/'..UserName}, },}}
return send(msg.chat_id,msg.id,'\n*⇜ الاوامـر هي*',"md",false, false, false, false, reply_markup)
end
end
if text == "قفل الصور" and Redis:get(Zelzal.."chcmdpv"..msg.sender_id.user_id) then
local UserName = Redis:get(Zelzal.."chcmdpv"..msg.sender_id.user_id)
local UserId_Info = bot.searchPublicChat(UserName)
Redis:set(Zelzal.."Zelzal:Lockch:Photo"..UserId_Info.id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender_id.user_id,"⇜ تم قفل الصور").Lock,"md",true)  
return false
end 
-----------------
if text == 'اضف مانع الانتحال' or text == '✦ تفعيل كاشف الانتحال ✦' or text == 'تفعيل مانع الانتحال' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Add:Thift:Bot"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسم حسابك الان 🪪*\n\n*⇜ مثـال :*\n*⇜ اذا كان اسم حسابك هو Hmd </>*\n*⇜ ارسل لي الاسم هكذا فقط Hmd*\n*⇜ بدون رموز الاسم الاساسي فقط 🥷*","md",true)  
end
if text == '✦ تعطيل كاشف الانتحال ✦' or text == 'تعطيل مانع الانتحال' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Thift:Bot")
Redis:del(Zelzal.."thiftname")
return send(msg_chat_id,msg_id,"*⇜ تم تعطيل مانع الانتحال*\n*⇜ ومسح الاسم .. بنجاح ✅*","md",true)   
end
if (text == 'تغيير رتبة المطور الاساسي' or text == '✦ رتبة المطور الاساسي ✦' or text == 'تغيير رتبه المطور الاساسي') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Sudo1"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المطـور الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المطور الاساسي' or text == 'مسح رتبه المطور الاساسي') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Sudo:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المطـور الاسـاسـي وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المطور الاساسي2' or text == '✦ رتبة المطور الاساسي2 ✦' or text == 'تغيير رتبه المطور الاساسي2') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Sudo2"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المطـور الاسـاسـي 2 الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المطور الاساسي2' or text == 'مسح رتبه المطور الاساسي2') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Sudo2:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المطـور الاسـاسـي 2 وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المطور الثانوي' or text == '✦ رتبة المطور الثانوي ✦' or text == 'تغيير رتبه المطور الثانوي') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:DevQ"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المطـور الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المطور الثانوي' or text == 'مسح رتبه المطور الثانوي') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:DeveloperQ:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المطـور الثانـوي وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المطوره الثانويه' or text == '✦ رتبة المطوره الثانويه ✦' or text == 'تغيير رتبه المطوره الثانويه') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:MevQ"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المطـوره الثانـويـه الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المطوره الثانويه' or text == 'مسح رتبه المطوره الثانويه') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:MeveloperQ:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المطـوره الثانـويـه وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المطور' or text == '✦ رتبة المطور ✦' or text == 'تغيير رتبه المطور') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Dev"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المطـور الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المطور' or text == 'مسح رتبه المطور') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Developer:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المطـور وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المطوره' or text == '✦ رتبة المطوره ✦' or text == 'تغيير رتبه المطوره') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mev"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المطـوره الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المطوره' or text == 'مسح رتبه المطوره') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Meveloper:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المطـوره وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المالك الاساسي' or text == '✦ رتبة المالك الاساسي ✦' or text == 'تغيير رتبه المالك الاساسي') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Pqq"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المالك الاساسي الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المالك الاساسي' or text == 'مسح رتبه المالك الاساسي') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:PresidentQQ:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المالك الاساسي وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المالكه الاساسيه' or text == '✦ رتبة المالكه الاساسيه ✦' or text == 'تغيير رتبه المالكه الاساسيه') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mqq"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المالكه الاساسيه الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المالكه الاساسيه' or text == 'مسح رتبه المالكه الاساسيه') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:MresidentQQ:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المالكه الاساسيه وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المالك' or text == '✦ رتبة المالك ✦' or text == 'تغيير رتبه المالك') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Ppp"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المالك الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المالك' or text == 'مسح رتبه المالك') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:PresidentQ:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المالك وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المالكه' or text == '✦ رتبة المالكه ✦' or text == 'تغيير رتبه المالكه') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mpp"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المالكه الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المالكه' or text == 'مسح رتبه المالكه') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:MresidentQ:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المالكه وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المنشئ الاساسي' or text == '✦ رتبة المنشئ الاساسي ✦' or text == 'تغيير رتبه المنشئ الاساسي') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Prr"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المنشئ الاساسي الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المنشئ الاساسي' or text == 'مسح رتبه المنشئ الاساسي') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:President:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المنشئ الاساسي وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المنشئه الاساسيه' or text == '✦ رتبة المنشئه الاساسيه ✦' or text == 'تغيير رتبه المنشئه الاساسيه') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mrr"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المنشئه الاساسيه الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المنشئه الاساسيه' or text == 'مسح رتبه المنشئه الاساسيه') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Mresident:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المنشئه الاساسيه وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المنشئ' or text == '✦ رتبة المنشئ ✦' or text == 'تغيير رتبه المنشئ') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Crr"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المنشئ الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المنشئ' or text == 'مسح رتبه المنشئ') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Constructor:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المنشئ وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المنشئه' or text == '✦ رتبة المنشئه ✦' or text == 'تغيير رتبه المنشئه') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mir"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المنشئه الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المنشئه' or text == 'مسح رتبه المنشئه') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Monstructor:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المنشئه وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المدير' or text == '✦ رتبة المدير ✦' or text == 'تغيير رتبه المدير') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mod"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المدير الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المدير' or text == 'مسح رتبه المدير') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Manager:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المدير وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المديره' or text == '✦ رتبة المديره ✦' or text == 'تغيير رتبه المديره') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mom"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المديره الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المديره' or text == 'مسح رتبه المديره') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Mamager:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المديره وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة الادمن' or text == '✦ رتبة الادمن ✦' or text == 'تغيير رتبه الادمن') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Adm"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة الادمن الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة الادمن' or text == 'مسح رتبه الادمن') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Admin:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة الادمن وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة الادمونه' or text == '✦ رتبة الادمونه ✦' or text == 'تغيير رتبه الادمونه') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mdm"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة الادمونه الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة الادمونه' or text == 'مسح رتبه الادمونه') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Mdmin:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة الادمونه وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المميز' or text == '✦ رتبة المميز ✦' or text == 'تغيير رتبه المميز') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Vip"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المميز الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المميز' or text == 'مسح رتبه المميز') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Vip:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المميز وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة المميزه' or text == '✦ رتبة المميزه ✦' or text == 'تغيير رتبه المميزه') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mip"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة المميزه الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة المميزه' or text == 'مسح رتبه المميزه') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Mip:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة المميزه وارجـاع الاصليـه*","md",true)   
end
if (text == 'تغيير رتبة العضو' or text == '✦ رتبة العضو ✦' or text == 'تغيير رتبه العضو') and msg.ControllerBot then 
Redis:setex(Zelzal.."Zelzal:Change:Rotba:Mem"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي اسـم رتبـة العضو الجديـده الان*","md",true)  
end
if (text == 'مسح رتبة العضو' or text == 'مسح رتبه العضو') and msg.ControllerBot then 
Redis:del(Zelzal.."Zelzal:Mempar:General:Reply") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسـم رتبـة العضو وارجـاع الاصليـه*","md",true)   
end
------------------------------------ زلزال الهيبه ------------------------------------
if text == 'تغيير اسم البوت' or text == '✦ تغيير اسم البوت ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Change:Name:Bot"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسل لي الاسم*","md",true)  
end
if text == 'مسح اسم البوت' or text == '✦ حذف اسم البوت ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Name:Bot") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح اسم البوت*","md",true)   
end
if text and text:match("^تعيين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal..'Zelzal:Num:Add:Bot',text:match("تعيين عدد الاعضاء (%d+)$") ) 
send(msg_chat_id,msg_id,'⇜ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعيين عدد الاعضاء (%d+)$")..' عضو ',"md",true)  
elseif text =='احصائيات' or text =='✦ الاحصـائيـات ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
send(msg_chat_id,msg_id,'*⇜ عدد احصائيات البوت *\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ عدد القروبات :* '..(Redis:scard(Zelzal..'Zelzal:ChekBotAdd') or 0)..'\n*⇜ عدد المشتركين :* '..(Redis:scard(Zelzal..'Zelzal:Num:User:Pv') or 0)..'',"md",true)  
end
------------------------------------ زلزال الهيبه ------------------------------------
if text == 'تغيير كليشه المطور' or text == '✦ تغيير كليشة المطور ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Add:User:Dev"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ ارسـل الان يـوزر الشخـص*","md",true)  
end
if text == 'مسح كليشه المطور' or text == '✦ حذف كليشة المطور ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Loger:Groub")
Redis:del(Zelzal.."Zelzal:LogerBot")
return send(msg_chat_id,msg_id,"*⇜ تم حذف كليشة المطور وارجاع يوزر المطور الاصلي*","md",true)
end
------------------------------------ زلزال الهيبه ------------------------------------
if text == 'اضف رد عام' or text == '✦ اضف رد عام ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Set:Rd"..msg.sender_id.user_id..":"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"*⇜ ارسل الان الكلمه لاضافتها في الردود العامه*","md",true)  
end
if text == 'مسح رد عام' or text == '✦ حذف رد عام ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:Set:On"..msg.sender_id.user_id..":"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"*⇜ ارسل الان الكلمه لمسحها من الردود العامه*","md",true)  
end
if text == '✦ اوامـر المطـور الاسـاسـي ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local TextHelp = [[*
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
• اوامــر المطــور الاسـاسـي
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ رفع - تنزيل ↢ مطور اساسي
⌯ المطورين الاساسيين
⌯ مسح المطورين الاساسيين
⇜ رفع - تنزيل ↢ مطور ثانوي
⇜ رفع - تنزيل ↢ مطور
⌯ المطورين الثانويين
⌯ مسح المطورين الثانويين
⌯ رفع - تنزيل ↢ مطور
⌯ المطورين ↢ مسح المطورين
⌯ تغيير المطور الاساسي
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ تحديث ↢ تحديث السورس
⌯ تفعيل الوضع المدفوع
⌯ الغاء الوضع المدفوع
⌯ تفعيل الوضع المدفوع + الايدي
⌯ الغاء الوضع المدفوع + الايدي
⌯ معلومات القروب + الايدي
⌯ حظر قروب + الايدي
⌯ غادر + الايدي
⌯ اسم بوتك + غادر بالقروب
⌯ تفعيل - تعطيل ↢ الاشتراك الاجباري
⌯ الاشتراك الاجباري
⌯ تغيير الاشتراك الاجباري
⌯ تعيين عدد الاعضاء + العدد
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ حظر عام ↢ الغاء حظر عام
⌯ قائمه العام ↢ مسح قائمه العام
⌯ كتم عام ↢ الغاء كتم عام
⌯ المكتومين عام
⌯ مسح المكتومين عام
⌯ رفع القيود عام + المعرف
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ تغيير - مسح ↢ اسم البوت
⌯ ضع صوره للترحيب
⌯ الاحصائيات
⌯ ذيع + ايدي القروب بالرد
⌯ اذاعه ↢ اذاعه خاص
⌯ اذاعه بالتوجيه ↢ اذاعه بالتثبيت
⌯ اذاعه خاص بالتوجيه
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ تفعيل - تعطيل ↢ جلب النسخ تلقائي
⌯ جلب النسخه الاحتياطيه
⌯ رفع النسخه الاحتياطيه بالرد
⌯ جلب نسخه الردود
⌯ رفع نسخه الردود بالرد
⌯ جلب نسخه الردود العامه
⌯ رفع نسخه الردود العامه بالرد
⌯ اشتراك البوت
⌯ معلومات التنصيب
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ تعيين - مسح ↢ الايدي عام
⌯ اضف - مسح ↢ رد عام
⌯ اضف - مسح ↢ رد عام متعدد
⌯ اضف - مسح ↢ رد مميز عام
⌯ اضف - مسح ↢ رد انلاين عام
⌯ مسح الردود المميزه عام
⌯ مسح ردود الانلاين عام
⌯ ضع - مسح ↢ الترحيب عام
⌯ ضع - مسح ↢ كليشه المطور
⌯ الردود العامه ↢ مسح الردود العامه
⌯ اضف - مسح ↢ صوت عام
⌯ الصوتيات عام
⌯ مسح الصوتيات عام
⌯ تغيير رمز السورس
⌯ منع عام ↢ الغاء منع عام
⌯ قائمه المنع عام
⌯ مسح قائمه المنع عام
⌯ تفعيل - تعطيل ↢ ردود البوت عام
⌯ تفعيل - تعطيل ↢ البنك عام
⌯ غادر + الايـدي ↢ لـ مغـادرة جـروب
⌯ حظر جروب + الايـدي ↢ لـ حظـره عـام
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ اضف - مسح ↢ سؤال
⌯ الاسئله المضافه
⌯ مسح الاسئله المضافه
⌯ اضف - مسح ↢ لغز
⌯ الالغاز ↢ مسح الالغاز
⌯ اضف - مسح ↢ سؤال كت
⌯ اسئله كت
⌯ اضف - مسح ↢ سؤال - جمل
⌯ مسح الجمل
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ تفعيل - تعطيل ↓
⌯ البوت الخدمي - المغادرة - الاذاعه
⌯ التواصل - الاحصائيات
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
♥️ امـر اضافة لايكات وهميـه ♥️
⌯ اضف لايكات + عدد ⇜ بالـرد
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
🌟 اوامـر رفـع تقييـم البـوت 🌟
⌯ اضف خمس نجمات + عدد
⌯ اضف اربع نجمات + عدد
⌯ اضف ثلاث نجمات + عدد
⌯ اضف نجمتين + عدد
⌯ اضف نجمه + عدد
ٴ⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆
⌯ رفع - تنزيل ↢ مالك اساسي
⌯ رفع - تنزيل ↢ مالكه اساسيه
⌯ المالكين الاساسيين
⌯ المالكات الاساسيات
⌯ مسح المالكين الاساسيين
⌯ مسح المالكات الاساسيات
⌯ رفع - تنزيل ↢ مالك
⌯ المالكين ↢ مسح المالكين
⌯ تنزيل جميع الرتب
⌯ تغيير كليشه المالك ( اذا كان حساب المالك محذوف يمكنك وضع يوزر جديد )
⌯ مسح كليشه المالك 
*]]
local reply_markup = bot.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{{text = '✦ رجـوع ✦',type = 'text'},},}}
return bot.sendText(msg_chat_id,msg_id, TextHelp, 'md', false, false, false, false, reply_markup)
end
if text == '✦ المطـور ✦' then
local NamesBot = (Redis:get(Zelzal.."Zelzal:Name:Bot") or "لايوجد")
local UserInfo = bot.getUser(Sudo_Id)
if UserInfo.username and UserInfo.username ~= "" then
t = '['..UserInfo.first_name..'](t.me/'..UserInfo.username..')'
ban = ' '..UserInfo.first_name..' '
u = '[@'..UserInfo.username..']'
else
t = '['..UserInfo.first_name..'](tg://user?id='..UserInfo.id..')'
u = 'لا يوجد'
end
Bio = getbio(UserInfo.id)
local photo = bot.getUserProfilePhotos(UserInfo.id)
if photo.total_count > 0 then
local TestText = "*• Name Bot ↦ *"..NamesBot.."\n*━━━━━━━━━━━━*\n*• Dev ↦ *"..(t).."\n*• Bio ↦ "..Bio.."*"
keyboardd = {}
keyboardd.inline_keyboard = {
{
{text = ban, url = "https://t.me/"..UserInfo.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg_chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
send(msg_chat_id,msg_id,"المطور 𖦹 "..(t).." ","md",true)  
end
end
if text == '✦ المطورين الثانويين ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:DevelopersQ:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مطورين ثانويين*","md",true)  
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
if text == '✦ المطورات الثانويات ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:MevelopersQ:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مطورات ثانويات*","md",true)  
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
if text == '✦ المطـوريـن ✦' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Developers:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مطورين بعد*","md",true)  
end
ListMembers = '\n*⇜ قائمـة المطـورين*\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
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
if text == '✦ المطـورات ✦' then
if not msg.DevelopersQ or not msg.MevelopersQ then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(2)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Mevelopers:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مطورات بعد*","md",true)  
end
ListMembers = '\n*⇜ قائمـة المطورات*\n ٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
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
if text and text:match("^صلاة (.*)$") or text and text:match("^صلاه (.*)$") then
local textcity = text:match("^صلاة (.*)$") or text:match("^صلاه (.*)$")
if textcity == "اليمن" or textcity == "صنعاء" then
Madina = "صنعاء"
Daolaa = "اليمن"
City = "Sanaa"
Country = "Yemen"
elseif textcity == "العراق" or textcity == "بغداد" then
Madina = "بغداد"
Daolaa = "العراق"
City = "Baghdad"
Country = "Iraq"
elseif textcity == "مصر" or textcity == "القاهرة" then
Madina = "القاهرة"
Daolaa = "مصر"
City = "Cairo"
Country = "Egypt"
elseif textcity == "ليبيا" or textcity == "طرابلس" then
Madina = "طرابلس"
Daolaa = "ليبيا"
City = "Tripoli"
Country = "Libya"
elseif textcity == "السودان" or textcity == "الخرطوم" then
Madina = "الخرطوم"
Daolaa = "السودان"
City = "Khartoum"
Country = "Sudan"
elseif textcity == "السعودية" or textcity == "الرياض" or textcity == "مكة" then
Madina = "مكة المكرمة"
Daolaa = "السعودية"
City = "Mecca"
Country = "Saudi-Arabia"
elseif textcity == "تركيا" or textcity == "أنقرة" then
Madina = "أنقرة"
Daolaa = "تركيا"
City = "Ankara"
Country = "Turkey"
elseif textcity == "سوريا" or textcity == "دمشق" then
Madina = "دمشق"
Daolaa = "سوريا"
City = "Damascus"
Country = "Syria"
elseif textcity == "الاردن" or textcity == "عمان" then
Madina = "عمان"
Daolaa = "الاردن"
City = "Amman"
Country = "Jordan"
elseif textcity == "لبنان" or textcity == "بيروت" then
Madina = "بيروت"
Daolaa = "لبنان"
City = "Beirut"
Country = "Lebanon"
elseif textcity == "تونس" or textcity == "تونس" then
Madina = "تونس"
Daolaa = "تونس"
City = "Tunis"
Country = "Tunisia"
elseif textcity == "المغرب" or textcity == "الرباط" then
Madina = "الرباط"
Daolaa = "المغرب"
City = "Rabat"
Country = "Morocco"
elseif textcity == "الجزائر" or textcity == "الجزائر" then
Madina = "الجزائر"
Daolaa = "الجزائر"
City = "Algiers"
Country = "Algeria"
elseif textcity == "الكويت" or textcity == "الكويت" then
Madina = "الكويت"
Daolaa = "الكويت"
City = "Kuwait"
Country = "Kuwait"
elseif textcity == "الامارات" or textcity == "أبو ظبي" then
Madina = "أبو ظبي"
Daolaa = "الامارات"
City = "Abu Dhabi"
Country = "UAE"
elseif textcity == "البحرين" or textcity == "المنامة" then
Madina = "المنامة"
Daolaa = "البحرين"
City = "Manama"
Country = "Bahrain"
elseif textcity == "قطر" or textcity == "الدوحة" then
Madina = "الدوحة"
Daolaa = "قطر"
City = "Doha"
Country = "Qatar"
elseif textcity == "فلسطين" or textcity == "القدس" then
Madina = "القدس"
Daolaa = "فلسطين"
City = "Jerusalem"
Country = "Palestine"
elseif textcity == "عُمان" or textcity == "مسقط" then
Madina = "مسقط"
Daolaa = "سلطنة عُمان"
City = "Muscat"
Country = "Oman"
elseif textcity == "ايران" or textcity == "طهران" then
Madina = "طهران"
Daolaa = "إيران"
City = "Tehran"
Country = "Iran"
else
return send(msg_chat_id,msg_id,"\n*⇜ عـذراً المدينة او الدولة غير موجودة ..\n⇜ او تأكد من كتابتها بشكل صحيح ؟!*","md",true)  
end
local url = "https://api.aladhan.com/v1/timingsByCity?city="..City.."&country="..Country.."&method=1&school=0"
local request = https.request(url)
local result = JSON.decode(request)
local ar_weekday = result.data.date.hijri.weekday.ar
local ar_day = result.data.date.hijri.day
local ar_month = result.data.date.hijri.month.ar
local ar_year = result.data.date.hijri.year
local Melady = result.data.date.gregorian.date
local Hijree = ar_day.. " " ..ar_month.. " " ..ar_year
local Dhuhr = result.data.timings.Dhuhr
if string.sub(Dhuhr, 1, 2) == "13:" then
Dhuhr = "01:" ..string.sub(Dhuhr, 4)
end
local Asr = result.data.timings.Asr
Asr = Asr:gsub("15:", "03:"):gsub("16:", "03:"):gsub("17:", "04:")
local Sunset = result.data.timings.Sunset
Sunset = Sunset:gsub("17:", "05:"):gsub("18:", "06:")
local Maghrib = result.data.timings.Maghrib
Maghrib = Maghrib:gsub("17:", "05:"):gsub("18:", "06:")
local Isha = result.data.timings.Isha
Isha = Isha:gsub("18:", "06:"):gsub("19:", "07:")
local Zilzal = "\n*🕋╎اوقـات الصـلاة بالتـوقيت المحلـي لعواصـم الـدول*"..
"\n*🕌╎المـدينة ⤎*  "..Madina..
"\n*🗺╎الـدولة  ⤎*  "..Daolaa..
"\n*🏷╎اليـوم   ⤎*  " ..ar_weekday..
"\n*🗓╎التـاريخ   ⤎*  " ..Melady.. " م"..
"\n*🗒╎الهـجري   ⤎*  " ..Hijree.. " هـ"..
"\n*🎑╎الامـساك  ⤎*  " ..result.data.timings.Imsak.. " ص"..
"\n*🏙╎الـفجر      ⤎*  " ..result.data.timings.Fajr.. " ص"..
"\n*🌇╎الظهـر     ⤎*  " ..Dhuhr.. " م"..
"\n*🗾╎العـصر     ⤎*  " ..Asr.. " م"..
"\n*🌃╎المـغرب   ⤎*  " ..Maghrib.. " م"..
"\n*🌉╎العشـاء    ⤎*  " ..Isha.. " م"..
"\n*🌌╎منتـصف الليل ⤎*  " ..result.data.timings.Midnight..
"\n*🌄╎شـروق الشمس  ⤎*  " ..result.data.timings.Sunrise.. " ص"..
"\n*🌅╎غـروب الشمس  ⤎*  " ..Sunset.. " م\n*༄*"
local photo = "https://t.me/R_RR5/983"
local ban = bot.getUser(Zelzal)
local msg_reply = msg.id/2097152/0.5
local keyboard = {}
keyboard.inline_keyboard = {
{{text = ban.first_name,url="t.me/"..UserBot..""}},
}
return https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..msg_reply.."&photo="..photo.."&caption="..URL.escape(Zilzal).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text and text:match("^الطقس (.*)$") or text and text:match("^طقس (.*)$") then
local textcity = text:match("^طقس (.*)$") or text:match("^الطقس (.*)$") 
local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
local url = BASE_URL
url = url..'?q='..textcity..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
url = url..'&units=metric'
local b, c, h = request(url)
local weather = JSON.decode(b)
local pressure = weather.main.pressure
local humidity = weather.main.humidity
local conditions = '- حالة الجو : '
if weather.weather[1].main == 'Clear' then
conditions = conditions .. 'صافي ☀'
elseif weather.weather[1].main == 'Clouds' then
conditions = conditions .. 'غائم ☁☁'
elseif weather.weather[1].main == 'Rain' then
conditions = conditions .. 'ماطر ☔'
elseif weather.weather[1].main == 'Thunderstorm' then
conditions = conditions .. 'عاصف ☔☔☔☔'
elseif weather.weather[1].main == 'Mist' then
conditions = conditions .. 'مغبر 💨'
end
local temp = '*⌯ الطقس في :* '..textcity..'\n*- درجة الحرارة :* '..weather.main.feels_like..' 🌡\n*- الضغط :* '..pressure..'\n*- الرطوبة :* '..humidity..'\n'..conditions..'\n ✓'
send(msg_chat_id,msg_id,temp,"md",true)
end
if text == ('★ الطقـس ودرجة الحرارة ★') then
return send(msg_chat_id,msg_id,"\n*⇜ قم بارسـال الامـر كالتالي\n⇜ طقس + المدينه\n⇜ مثـال : طقس صنعاء*","md",true)  
end
if text == ('✦ رفع مطور اساسي ✦') and msg.reply_to_message_id == 0 then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
return send(msg_chat_id,msg_id,"\n*⇜ قم بارسـال الامـر كالتالي\n⇜ رفع مطور اساسي + (يوزر او ايدي الشخص)\n⇜ لرفعـه مطـور اساسي² معـك*","md",true)  
end
if text == ('✦ تنزيل مطور اساسي ✦') and msg.reply_to_message_id == 0 then
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) then
YouCan = true
elseif tonumber(msg.sender_id.user_id) == tonumber(1260465030) then
YouCan = true
else
YouCan = false
end
if YouCan == false then
return send(msg_chat_id,msg_id,'\n*⇜ نو .. مايخصك ؟!*\n*⇜ يخص ( المطور الاساسي ) فقط*',"md",true)  
end
return send(msg_chat_id,msg_id,"\n*⇜ قم بارسـال الامـر كالتالي\n⇜ تنزيل مطور اساسي + (يوزر او ايدي الشخص)\n⇜ لـ تنزيـله من رتبـة مطـور اساسي²*","md",true)  
end
if text == ("الردود العامه") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:List:Rd:Sudo")
text = "\n*⇜ قائمة الردود العامة *\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n"
for k,v in pairs(list) do
if Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..v) then
db = "متحركة"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..v) then
db = "فويس"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..v) then
db = "ملصق"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..v) then
db = "رسالة"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..v) then
db = "صورة"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..v) then
db = "فيديو"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:File"..v) then
db = "ملف"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..v) then
db = "اغنية"
elseif Redis:get(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..v) then
db = "بصمة فيديو"
end
text = text..""..k.." - ( "..v.." ) ࿓ ( "..db.." )\n"
end
if #list == 0 then
text = "*⇜ مافي ردود مضافة عام !*"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == ("مسح الردود العامه") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local list = Redis:smembers(Zelzal.."Zelzal:List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Gif"..v)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:vico"..v)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:stekr"..v)     
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Text"..v)   
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Photo"..v)
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Video"..v)
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:File"..v)
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:Audio"..v)
Redis:del(Zelzal.."Zelzal:Add:Rd:Sudo:video_note"..v)
Redis:del(Zelzal.."Zelzal:List:Rd:Sudo")
end
return send(msg_chat_id,msg_id,"*⇜ تم مسح الردود العامه*","md",true)  
end
-----------------
if text == 'مسح المطورين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Developers:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مطورين بعد *","md",true)  
end
Redis:del(Zelzal.."Zelzal:Developers:Groups") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح ( "..#Info_Members.." ) من المطـورين *","md",true)
end
if text == 'مسح الثانويين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:DevelopersQ:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مطورين ثانويين بعد🎖️* ","md",true)  
end
Redis:del(Zelzal.."Zelzal:DevelopersQ:Groups") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح ("..#Info_Members..") من المطورين الثانويين🎖️*","md",true)
end
if text == 'مسح قائمه العام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد محظورين عام *","md",true)  
end
Redis:del(Zelzal.."Zelzal:BanAll:Groups") 
return send(msg_chat_id,msg_id,"*⇜ تم مسح ( "..#Info_Members.." ) من المحظورين عام *","md",true)
end
if text == 'تعطيل البوت الخدمي' or text == '✦ تعطيل البوت الخدمي ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:BotFree") 
return send(msg_chat_id,msg_id,"*⇜ تم تعطيل البوت الخدمي *","md",true)
end
if text == 'تعطيل التواصل' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:TwaslBot") 
return send(msg_chat_id,msg_id,"*⇜ تم تعطيل التواصل داخل البوت *","md",true)
end
if text == 'تفعيل البوت الخدمي' or text == '✦ تفعيل البوت الخدمي ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:BotFree",true) 
return send(msg_chat_id,msg_id,"*⇜ تم تفعيل البوت الخدمي *","md",true)
end
if text == 'تفعيل التواصل' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:set(Zelzal.."Zelzal:TwaslBot",true) 
return send(msg_chat_id,msg_id,"*⇜ تم تفعيل التواصل داخل البوت *","md",true)
end
------------------------------------ زلزال الهيبه ------------------------------------
if text == 'تفعيل جروب السجل' or text == 'تفعيل مجموعه السجل' or text == 'تفعيل قروب السجل' or text == 'تفعيل كروب السجل' or text == 'تفعيل السجل' or text == '✦ تفعيل قروب الاشعارات ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Add:Loger:Bot"..msg.sender_id.user_id,300,true) 
return send(msg_chat_id,msg_id,"*⇜ اتبـع الخطـوات التاليـه ليعمـل البـوت بشكـل صحيـح في المجموعـة :*\n\n*1⇜ قم باضافة البوت لمجموعة السجل وارفعه كامل الصلاحيات*\n*2⇜ قم بجعل سجل المجموعة ظاهراً*\n*3⇜ ارسـل الان ايـدي مجمـوعـة السجـل مبدوء بـ -100*","md",true)  
end
if text == 'تعطيل جروب السجل' or text == 'تعطيل مجموعه السجل' or text == 'تعطيل قروب السجل' or text == 'تعطيل كروب السجل' or text == 'تعطيل السجل' or text == '✦ تعطيل قروب الاشعارات ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:del(Zelzal.."Zelzal:Loger:Groub")
Redis:del(Zelzal.."Zelzal:LogerBot")
return send(msg_chat_id,msg_id,"*⇜ تم تعطيل جروب السجل .. بنجـاح ✅ *\n\n*⇜ سيتم حفظ كل اشعارات البوت في الخاص*\n*⇜ من الان فصاعداً بدلاً من قروب السجل*","md",true)
end
-------------------------------------------------------------------------------------
if text == "نداء" or text == "نادي" then
local Info_Members = bot.searchChatMembers(msg.chat_id, "*", 200)
local List = Info_Members.members
local Zelzal = List[math.random(#List)] 
local data = bot.getUser(Zelzal.member_id.user_id)
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
local Textinggt = {" ‌‌‏حـب عظيم لڪل لحظه جمـيله بيني وبينڪ🌼", 
"حيلي على حيلك لو شفت التعب صابك 🤍", "‌‏ گد ما بوجهك ضوى شكيت بيك وگلت بالشمس متلثم", }
local Descriptioont = Textinggt[math.random(#Textinggt)]
Text = "\n*"..Descriptioont.."* ↤ ["..tagname.."](tg://user?id="..Zelzal.member_id.user_id..")"
send(msg_chat_id,msg_id,""..Text.."","md",true)
end


------------------------------------ زلزال الهيبه ------------------------------------
if text=="اذاعه خاص" or text=="✦ اذاعـه خـاص ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender_id.user_id, 600, true) 
return send(msg_chat_id,msg_id, "*⇜ الحيـن ارسـل لي الرسـاله*\n*⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ للخروج ارسل ( الغاء )*","md",true)  
end
-----------------
if text=="اذاعه" or text=="✦ اذاعـه للمجموعـات ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender_id.user_id, 600, true)
return send(msg_chat_id,msg_id, "*⇜ الحيـن ارسـل لي الرسـاله*\n*⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ للخروج ارسل ( الغاء )*","md",true)  
end
-----------------
if text=="اذاعه بالتثبيت" or text=="✦ اذاعـه بالتثبيت ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender_id.user_id, 600, true) 
return send(msg_chat_id,msg_id, "*⇜ الحيـن ارسـل لي الرسـاله*\n*⇜ ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ للخروج ارسل ( الغاء )*","md",true)  
end
-----------------
if text=="اذاعه بالتوجيه" or text=="✦ اذاعـه بالتوجيـه ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender_id.user_id, 600, true) 
return send(msg_chat_id,msg_id, "*⇜ الحيـن ارسـل لي الرسـاله توجيـه*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ للخروج ارسل ( الغاء )*","md",true)  
end
-----------------
if text=="اذاعه خاص بالتوجيه" or text=="✦ اذاعه بالتوجيه خاص ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
Redis:setex(Zelzal.."Zelzal:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender_id.user_id, 600, true) 
return send(msg_chat_id,msg_id, "*⇜ الحيـن ارسـل لي الرسـاله توجيـه*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n*⇜ للخروج ارسل ( الغاء )*","md",true)  
end
------------------------------------ زلزال الهيبه ------------------------------------
if text == 'قائمه العام' or text == 'المحظورين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد محظورين عام *","md",true)  
end
ListMembers = '\n*⇜ قائمة المحظورين عام *\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
for k, v in pairs(Info_Members) do
local UserInfo = bot.getUser(v)
var(v)
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
if text == 'المكتومين عام' or text == 'قائمه المكتومين عام' then
if not msg.ControllerBot then
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:KtmAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مكتومين عام*","md",true)  
end
ListMembers = '\n*⇜ قائمة المكتومين عام*\nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
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
data = {{{text = 'مسح المكتومين عام', data = msg.sender_id.user_id..'/KtmAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:Developers:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مطورين بعد* ","md",true)  
end
ListMembers = '\n*⇜ قائمـة المطـورين* \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
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
if text == 'الثانويين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*⇜ هـذا الامـر يخـص* ( '..Controller_Num(1)..' ) ',"md",true)  
end
local Info_Members = Redis:smembers(Zelzal.."Zelzal:DevelopersQ:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"*⇜ لا يوجد مطورين ثانويين🎖️*","md",true)  
end
ListMembers = '\n*⇜ قائمة المطور الثانوي🎖️* \nٴ*⋆┄─┄─┄─┄┄─┄─┄─┄─┄┄⋆*\n'
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
if not msg.ControllerBot then
if Redis:get(Zelzal.."Zelzal:TwaslBot") and not Redis:sismember(Zelzal.."Zelzal:BaN:In:Tuasl",msg.sender_id.user_id) and not Redis:get(Zelzal.."hms:"..msg.sender_id.user_id) and not Redis:get(Zelzal.."keyboardmemb"..msg.sender_id.user_id) then
local ListGet = {Sudo_Id,msg.sender_id.user_id}
local IdSudo = bot.getChat(ListGet[1]).id
local IdUser = bot.getChat(ListGet[2]).id
local FedMsg = bot.sendForwarded(IdSudo, 0, IdUser, msg_id)
Redis:setex(Zelzal.."Zelzal:Twasl:UserId"..msg.date,172800,IdUser)
if FedMsg.content.luatele == "messageSticker" then
send(IdSudo,0,Reply_Status(IdUser,'⇜ قام بارسال ملصق').Reply,"md",true)  
end
if Redis:get(Zelzal.."Zelzal:Twassl:Bot") then
return send(IdUser,msg_id,Redis:get(Zelzal.."Zelzal:Twassl:Bot"),"md",true) 
else
return send(IdUser,msg_id,'⇜ تم ارسال رسالتك الى المطور',"md",true) 
end
end
else 
if msg.reply_to_message_id ~= 0 then
local Message_Get = bot.getMessage(msg_chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = Redis:get(Zelzal.."Zelzal:Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
Redis:sadd(Zelzal..'Zelzal:BaN:In:Tuasl',Info_User)  
return send(msg_chat_id,msg_id,Reply_Status(Info_User,'⇜ تم حظره من تواصل في البوت ').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
Redis:srem(Zelzal..'Zelzal:BaN:In:Tuasl',Info_User)  
return send(msg_chat_id,msg_id,Reply_Status(Info_User,'⇜ تم الغاء حظره من تواصل في البوت ').Reply,"md",true)  
end 
local ChatAction = bot.sendChatAction(Info_User,'Typing')
if not Info_User or ChatAction.message == "USER_IS_BLOCKED" then
send(msg_chat_id,msg_id,Reply_Status(Info_User,'⇜ قام بحظر البوت لا استطيع ارسال رسالتك اليه ').Reply,"md",true)  
end
if msg.content.video_note then
bot.sendVideoNote(Info_User, 0, msg.content.video_note.video.remote.id)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
bot.sendPhoto(Info_User, 0, idPhoto,'')
elseif msg.content.sticker then 
bot.sendSticker(Info_User, 0, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then 
bot.sendVoiceNote(Info_User, 0, msg.content.voice_note.voice.remote.id, '', 'md')
elseif msg.content.video then 
bot.sendVideo(Info_User, 0, msg.content.video.video.remote.id, '', "md")
elseif msg.content.animation then 
bot.sendAnimation(Info_User,0, msg.content.animation.animation.remote.id, '', 'md')
elseif msg.content.document then
bot.sendDocument(Info_User, 0, msg.content.document.document.remote.id, '', 'md')
elseif msg.content.audio then
bot.sendAudio(Info_User, 0, msg.content.audio.audio.remote.id, '', "md") 
elseif text then
send(Info_User,0,text,"md",true)
end 
send(msg_chat_id,msg_id,Reply_Status(Info_User,'⇜ تم ارسال رسالتك اليه ').Reply,"md",true)
end
end
end
end --UserBot
end -- File_Bot_Run
function CallBackLua(data)
RunCallBack(data)
end
luatele.run(CallBackLua)
