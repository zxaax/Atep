@Client.on_message(filters.command(["قفل القنوات"], "") & filters.group, group=39)
async def lock_vasassd(client, message):
   bot_username = client.me.username
   OWNER_ID = await get_dev(bot_username) 
   if message.chat.id in hemaya.get(message.chat.id, []):
       return
   get = await client.get_chat_member(message.chat.id, message.from_user.id)
   if get.status in [ChatMemberStatus.OWNER, ChatMemberStatus.ADMINISTRATOR] or message.from_user.id == OWNER_ID or message.from_user.username in caes:
       oo = [message.chat.id]
       add_knoat(oo, bot_username)
       await message.reply_text(f"• تم قفل المتحركات بواسطه ↤︎「 {message.from_user.mention}")
   else:
       await message.reply_text(f"مرحبا عزيزي {message.from_user.mention} هذا الأمر لا يخصك")
  
@Client.on_message(filters.command(["فتح القنوات"], "") & filters.group, group=40)
async def unlsock_aaaa(client, message):
   bot_username = client.me.username
   OWNER_ID = await get_dev(bot_username) 
   if message.chat.id in hemaya.get(message.chat.id, []):
     return
   get = await client.get_chat_member(message.chat.id, message.from_user.id)
   if get.status in [ChatMemberStatus.OWNER, ChatMemberStatus.ADMINISTRATOR] or message.from_user.id == OWNER_ID or message.from_user.username in caes:
    group_id = message.chat.id
    for x in get_knoat(bot_username):
        if x[0] == group_id:
            del_knoat(x, bot_username)
    await message.reply_text(f"• تم فتح المتحركات بواسطه ↤︎「 {message.from_user.mention}")
   else:
    await message.reply_text(f"مرحبا عزيزي {message.from_user.mention} هذا الأمر لا يخصك")

def add_knoat(bots, bot_username):
    if is_knoat(bots, bot_username):
        return
    r.sadd(f"knoat{bot_username}", str(bots))

def is_knoat(bots, bot_username):
    try:
        a = get_knoat(bot_username)
        if bots in a:
            return True
        return False
    except:
        return False

def del_knoat(bots, bot_username):
    if not is_knoat(bots, bot_username):
        return False
    r.srem(f"knoat{bot_username}", str(bots))

def get_knoat(bot_username):
    try:
        lst = []
        for a in r.smembers(f"knoat{bot_username}"):
            lst.append(eval(a.decode('utf-8')))
        return lst
    except:
        return []

@Client.on_message(filters.text,group=41)
async def delet_kanoat(client, message):
   bot_username = client.me.username
   OWNER_ID = await get_dev(bot_username)
   for x in get_knoat(bot_username):
       ch = x[0]
       if message.chat.id == ch:
           try:
               h = message.from_user.id
           except Exception as e:
               await message.delete()
               
@Client.on_callback_query(filters.regex("^kanoatlock (\\d+)$"))
async def close_kanoat(c: Client, m: CallbackQuery):
    a = m.data.split(" ")
    if m.from_user.id != int(a[1]):
        await c.answer_callback_query(m.id, text="صاحب الامر هو فقط من يستطيع الضغط على الزر 🥷", show_alert=True)
        return
    bot_username = c.me.username
    oo = [m.message.chat.id]
    add_knoat(oo, bot_username)
    await m.message.edit_text("تم قفل القنوات بنجاح 📣", reply_markup=InlineKeyboardMarkup(
        [
            [InlineKeyboardButton("رجوع", callback_data="hemm " + str(m.from_user.id))],
        ]
    ))

@Client.on_callback_query(filters.regex("^kanoatopen (\\d+)$"))
async def open_kanoat(c: Client, m: CallbackQuery):
    a = m.data.split(" ")
    if m.from_user.id != int(a[1]):
        await c.answer_callback_query(m.id, text="صاحب الامر هو فقط من يستطيع الضغط على الزر 🥷", show_alert=True)
        return
    bot_username = c.me.username
    group_id = m.message.chat.id
    for x in get_knoat(bot_username):
        if x[0] == group_id:
            del_knoat(x, bot_username)
    await m.message.edit_text("تم فتح القنوات بنجاح  📣", reply_markup=InlineKeyboardMarkup(
        [
            [InlineKeyboardButton("رجوع", callback_data="hemm " + str(m.from_user.id))],
        ]
    ))
#..........................................  حمايه القنوات  ................................................................