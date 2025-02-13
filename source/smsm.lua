function smsm(msg)
    if not msg or not msg.content or not msg.content.text then return end
    
    local text = msg.content.text.text
    local xname = Redis:get(Fast.."Name:Bot") or "ماتركس"
    
    if text:match("^"..xname.." (.*)$") then
        text = text:match("^"..xname.." (.*)$")
    end
    
    if tonumber(msg.sender_id.user_id) == tonumber(Fast) then return false end

    -- التعامل مع الأوامر
    if text == "تفعيل سمسمي" then
        if not msg.Manger then
            return send(msg.chat_id, msg.id, '\n*• هذا الامر يخص '..Controller_Num(6)..' *', "md", true)  
        end
        Redis:del(Fast.."smsme"..msg.chat_id)
        send(msg.chat_id, msg.id, "• تم تفعيل سمسمي")
    elseif text == "تعطيل سمسمي" then
        -- باقي الأوامر...
    end

    -- معالجة الردود
    if text and msg.reply_to_message_id ~= 0 and chat_type(msg.chat_id) == "GroupBot" then
        local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
        if Message_Reply and Message_Reply.sender_id and tonumber(rep_idd) == tonumber(Fast) then
            local get = Redis:get(Fast.."smsme") or Redis:get(Fast.."smsme"..msg.chat_id)
            if get then return false end
            
            local ai_api = https.request("https://dev-almortageltech.pantheonsite.io/api/smsm.php?almortagel=ه"..URL.escape(text).."&lc=ar&cf=false")
            local ai_decode = JSON.decode(ai_api)
            local ai_text = ai_decode['success']
            
            if ai_text:match("(.*)سناب(.*)") or ai_text:match("(.*) تيك (.*)") then
                txx = "لا افهمك"
            else
                txx = ai_text
            end
            
            send(msg.chat_id, msg.id, txx)
        end
    end
end

return {Fast = smsm}


