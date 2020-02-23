#!/usr/bin/env lua5.3
-- version 1.0
-- github.com/luagram
local luagram_function, function_core, update_functions, luagram_timer = {}, {}, {}, {}
local luagram = {
  logo = [[
 _     _   _    _       ____  ____      _     __  __
| |   | | | |  / \     / ___||  _ \    / \   |  \/  |
| |   | | | | / _ \   | |  _ | |_) |  / _ \  | |\/| |
| |___| |_| |/ ___ \  | |_| ||  _ <  / ___ \ | |  | |
|_____|\___//_/   \_\  \____||_| \_\/_/   \_\|_|  |_|

VERSION : 1.0 / BETA
]],
luagram_helper = {
      ['match'] = 'function > match(table)[string]',
      ['base64_encode'] = ' function > base64_encode(str)',
      ['base64_decode'] = ' function > base64_decode(str)',
      ['number_format'] = ' function > number_format(number)',
      ['secToClock'] = ' function > secToClock(seconds)',
      ['in_array'] = ' function > in_array(table, value)',
      ['add_events'] = ' function > add_events(def,filters)',
      ['vardump'] = ' function > vardump(input)',
      ['set_timer'] = ' function > set_timer(seconds, def, argv)',
      ['get_timer'] = ' function > get_timer(timer_id)',
      ['cancel_timer'] = ' function > cancel_timer(timer_id)',
      ['exists'] = ' function > exists(file)',
      ['logOut'] = ' function > logOut()',
      ['getPasswordState'] = ' function > getPasswordState()',
      ['setPassword'] = ' function > setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)',
      ['getRecoveryEmailAddress'] = ' function > getRecoveryEmailAddress(password)',
      ['setRecoveryEmailAddress'] = ' function > setRecoveryEmailAddress(password, new_recovery_email_address)',
      ['requestPasswordRecovery'] = ' function > requestPasswordRecovery()',
      ['recoverPassword'] = ' function > recoverPassword(recovery_code)',
      ['createTemporaryPassword'] = ' function > createTemporaryPassword(password, valid_for)',
      ['getTemporaryPasswordState'] = ' function > getTemporaryPasswordState()',
      ['getMe'] = ' function > getMe()',
      ['getUser'] = ' function > getUser(user_id)',
      ['getUserFullInfo'] = ' function > getUserFullInfo(user_id)',
      ['getBasicGroup'] = ' function > getBasicGroup(basic_group_id)',
      ['getBasicGroupFullInfo'] = ' function > getBasicGroupFullInfo(basic_group_id)',
      ['getSupergroup'] = ' function > getSupergroup(supergroup_id)',
      ['getSupergroupFullInfo'] = ' function > getSupergroupFullInfo(supergroup_id)',
      ['getSecretChat'] = ' function > getSecretChat(secret_chat_id)',
      ['getChat'] = ' function > getChat(chat_id)',
      ['getMessage'] = ' function > getMessage(chat_id, message_id)',
      ['getRepliedMessage'] = ' function > getRepliedMessage(chat_id, message_id)',
      ['getChatPinnedMessage'] = ' function > getChatPinnedMessage(chat_id)',
      ['getMessages'] = ' function > getMessages(chat_id, message_ids)',
      ['getFile'] = ' function > getFile(file_id)',
      ['getRemoteFile'] = ' function > getRemoteFile(remote_file_id, file_type)',
      ['getChats'] = ' function > getChats(offset_chat_id, limit, offset_order)',
      ['searchPublicChat'] = ' function > searchPublicChat(username)',
      ['searchPublicChats'] = ' function > searchPublicChats(query)',
      ['searchChats'] = ' function > searchChats(query, limit)',
      ['checkChatUsername'] = ' function > checkChatUsername(chat_id, username)',
      ['searchChatsOnServer'] = ' function > searchChatsOnServer(query, limit)',
      ['clearRecentlyFoundChats'] = ' function > clearRecentlyFoundChats()',
      ['getTopChats'] = ' function > getTopChats(category, limit)',
      ['removeTopChat'] = ' function > removeTopChat(category, chat_id)',
      ['addRecentlyFoundChat'] = ' function > addRecentlyFoundChat(chat_id)',
      ['getCreatedPublicChats'] = ' function > getCreatedPublicChats()',
      ['removeRecentlyFoundChat'] = ' function > removeRecentlyFoundChat(chat_id)',
      ['getChatHistory'] = ' function > getChatHistory(chat_id, from_message_id, offset, limit, only_local)',
      ['getGroupsInCommon'] = ' function > getGroupsInCommon(user_id, offset_chat_id, limit)',
      ['searchMessages'] = ' function > searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)',
      ['searchChatMessages'] = ' function > searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)',
      ['searchSecretMessages'] = ' function > searchSecretMessages(chat_id, query, from_search_id, limit, filter)',
      ['deleteChatHistory'] = ' function > deleteChatHistory(chat_id, remove_from_chat_list)',
      ['searchCallMessages'] = ' function > searchCallMessages(from_message_id, limit, only_missed)',
      ['getChatMessageByDate'] = ' function > getChatMessageByDate(chat_id, date)',
      ['getPublicMessageLink'] = ' function > getPublicMessageLink(chat_id, message_id, for_album)',
      ['sendMessageAlbum'] = ' function > sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)',
      ['sendBotStartMessage'] = ' function > sendBotStartMessage(bot_user_id, chat_id, parameter)',
      ['sendInlineQueryResultMessage'] = ' function > sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)',
      ['forwardMessages'] = ' function > forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album)',
      ['sendChatSetTtlMessage'] = ' function > sendChatSetTtlMessage(chat_id, ttl)',
      ['sendChatScreenshotTakenNotification'] = ' function > sendChatScreenshotTakenNotification(chat_id)',
      ['deleteMessages'] = ' function > deleteMessages(chat_id, message_ids, revoke)',
      ['deleteChatMessagesFromUser'] = ' function > deleteChatMessagesFromUser(chat_id, user_id)',
      ['editMessageText'] = ' function > editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)',
      ['editMessageCaption'] = ' function > editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)',
      ['getTextEntities'] = ' function > getTextEntities(text)',
      ['getFileMimeType'] = ' function > getFileMimeType(file_name)',
      ['getFileExtension'] = ' function > getFileExtension(mime_type)',
      ['getInlineQueryResults'] = ' function > getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)',
      ['getCallbackQueryAnswer'] = ' function > getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)',
      ['deleteChatReplyMarkup'] = ' function > deleteChatReplyMarkup(chat_id, message_id)',
      ['sendChatAction'] = ' function > sendChatAction(chat_id, action, progress)',
      ['openChat'] = ' function > openChat(chat_id)',
      ['closeChat'] = ' function > closeChat(chat_id)',
      ['viewMessages'] = ' function > viewMessages(chat_id, message_ids, force_read)',
      ['openMessageContent'] = ' function > openMessageContent(chat_id, message_id)',
      ['readAllChatMentions'] = ' function > readAllChatMentions(chat_id)',
      ['createPrivateChat'] = ' function > createPrivateChat(user_id, force)',
      ['createBasicGroupChat'] = ' function > createBasicGroupChat(basic_group_id, force)',
      ['createSupergroupChat'] = ' function > createSupergroupChat(supergroup_id, force)',
      ['createSecretChat'] = ' function > createSecretChat(secret_chat_id)',
      ['createNewBasicGroupChat'] = ' function > createNewBasicGroupChat(user_ids, title)',
      ['createNewSupergroupChat'] = ' function > createNewSupergroupChat(title, is_channel, description)',
      ['createNewSecretChat'] = ' function > createNewSecretChat(user_id)',
      ['upgradeBasicGroupChatToSupergroupChat'] = ' function > upgradeBasicGroupChatToSupergroupChat(chat_id)',
      ['setChatTitle'] = ' function > setChatTitle(chat_id, title)',
      ['setChatPhoto'] = ' function > setChatPhoto(chat_id, photo)',
      ['setChatDraftMessage'] = ' function > setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)',
      ['toggleChatIsPinned'] = ' function > toggleChatIsPinned(chat_id, is_pinned)',
      ['setChatClientData'] = ' function > setChatClientData(chat_id, client_data)',
      ['addChatMember'] = ' function > addChatMember(chat_id, user_id, forward_limit)',
      ['addChatMembers'] = ' function > addChatMembers(chat_id, user_ids)',
      ['setChatMemberStatus'] = ' function > setChatMemberStatus(chat_id, user_id, status, right)',
      ['getChatMember'] = ' function > getChatMember(chat_id, user_id)',
      ['searchChatMembers'] = ' function > searchChatMembers(chat_id, query, limit)',
      ['getChatAdministrators'] = ' function > getChatAdministrators(chat_id)',
      ['setPinnedChats'] = ' function > setPinnedChats(chat_ids)',
      ['downloadFile'] = ' function > downloadFile(file_id, priority)',
      ['cancelDownloadFile'] = ' function > cancelDownloadFile(file_id, only_if_pending)',
      ['uploadFile'] = ' function > uploadFile(file, file_type, priority)',
      ['cancelUploadFile'] = ' function > cancelUploadFile(file_id)',
      ['deleteFile'] = ' function > deleteFile(file_id)',
      ['generateChatInviteLink'] = ' function > generateChatInviteLink(chat_id)',
      ['checkChatInviteLink'] = ' function > checkChatInviteLink(invite_link)',
      ['joinChatByInviteLink'] = ' function > joinChatByInviteLink(invite_link)',
      ['createCall'] = ' function > createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)',
      ['acceptCall'] = ' function > acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)',
      ['blockUser'] = ' function > blockUser(user_id)',
      ['unblockUser'] = ' function > unblockUser(user_id)',
      ['getBlockedUsers'] = ' function > getBlockedUsers(offset, limit)',
      ['importContacts'] = ' function > importContacts(phone_number, first_name, last_name, user_id)',
      ['searchContacts'] = ' function > searchContacts(query, limit)',
      ['removeContacts'] = ' function > removeContacts(user_ids)',
      ['getImportedContactCount'] = ' function > getImportedContactCount()',
      ['changeImportedContacts'] = ' function > changeImportedContacts(phone_number, first_name, last_name, user_id)',
      ['clearImportedContacts'] = ' function > clearImportedContacts()',
      ['getUserProfilePhotos'] = ' function > getUserProfilePhotos(user_id, offset, limit)',
      ['getStickers'] = ' function > getStickers(emoji, limit)',
      ['searchStickers'] = ' function > searchStickers(emoji, limit)',
      ['getArchivedStickerSets'] = ' function > getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)',
      ['getTrendingStickerSets'] = ' function > getTrendingStickerSets()',
      ['getAttachedStickerSets'] = ' function > getAttachedStickerSets(file_id)',
      ['getStickerSet'] = ' function > getStickerSet(set_id)',
      ['searchStickerSet'] = ' function > searchStickerSet(name)',
      ['searchInstalledStickerSets'] = ' function > searchInstalledStickerSets(is_masks, query, limit)',
      ['searchStickerSets'] = ' function > searchStickerSets(query)',
      ['changeStickerSet'] = ' function > changeStickerSet(set_id, is_installed, is_archived)',
      ['viewTrendingStickerSets'] = ' function > viewTrendingStickerSets(sticker_set_ids)',
      ['reorderInstalledStickerSets'] = ' function > reorderInstalledStickerSets(is_masks, sticker_set_ids)',
      ['getRecentStickers'] = ' function > getRecentStickers(is_attached)',
      ['addRecentSticker'] = ' function > addRecentSticker(is_attached, sticker)',
      ['clearRecentStickers'] = ' function > clearRecentStickers(is_attached)',
      ['getFavoriteStickers'] = ' function > getFavoriteStickers()',
      ['addFavoriteSticker'] = ' function > addFavoriteSticker(sticker)',
      ['removeFavoriteSticker'] = ' function > removeFavoriteSticker(sticker)',
      ['getStickerEmojis'] = ' function > getStickerEmojis(sticker)',
      ['getSavedAnimations'] = ' function > getSavedAnimations()',
      ['addSavedAnimation'] = ' function > addSavedAnimation(animation)',
      ['removeSavedAnimation'] = ' function > removeSavedAnimation(animation)',
      ['getRecentInlineBots'] = ' function > getRecentInlineBots()',
      ['searchHashtags'] = ' function > searchHashtags(prefix, limit)',
      ['removeRecentHashtag'] = ' function > removeRecentHashtag(hashtag)',
      ['getWebPagePreview'] = ' function > getWebPagePreview(text)',
      ['getWebPageInstantView'] = ' function > getWebPageInstantView(url, force_full)',
      ['getNotificationSettings'] = ' function > getNotificationSettings(scope, chat_id)',
      ['setNotificationSettings'] = ' function > setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)',
      ['resetAllNotificationSettings'] = ' function > resetAllNotificationSettings()',
      ['setProfilePhoto'] = ' function > setProfilePhoto(photo)',
      ['deleteProfilePhoto'] = ' function > deleteProfilePhoto(profile_photo_id)',
      ['setName'] = ' function > setName(first_name, last_name)',
      ['setBio'] = ' function > setBio(bio)',
      ['setUsername'] = ' function > setUsername(username)',
      ['getActiveSessions'] = ' function > getActiveSessions()',
      ['terminateAllOtherSessions'] = ' function > terminateAllOtherSessions()',
      ['terminateSession'] = ' function > terminateSession(session_id)',
      ['toggleBasicGroupAdministrators'] = ' function > toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)',
      ['setSupergroupUsername'] = ' function > setSupergroupUsername(supergroup_id, username)',
      ['setSupergroupStickerSet'] = ' function > setSupergroupStickerSet(supergroup_id, sticker_set_id)',
      ['toggleSupergroupInvites'] = ' function > toggleSupergroupInvites(supergroup_id, anyone_can_invite)',
      ['toggleSupergroupSignMessages'] = ' function > toggleSupergroupSignMessages(supergroup_id, sign_messages)',
      ['toggleSupergroupIsAllHistoryAvailable'] = ' function > toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)',
      ['setSupergroupDescription'] = ' function > setSupergroupDescription(supergroup_id, description)',
      ['pinSupergroupMessage'] = ' function > pinSupergroupMessage(supergroup_id, message_id, disable_notification)',
      ['unpinSupergroupMessage'] = ' function > unpinSupergroupMessage(supergroup_id)',
      ['reportSupergroupSpam'] = ' function > reportSupergroupSpam(supergroup_id, user_id, message_ids)',
      ['getSupergroupMembers'] = ' function > getSupergroupMembers(supergroup_id, filter, query, offset, limit)',
      ['deleteSupergroup'] = ' function > deleteSupergroup(supergroup_id)',
      ['closeSecretChat'] = ' function > closeSecretChat(secret_chat_id)',
      ['getChatEventLog'] = ' function > getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)',
      ['getSavedOrderInfo'] = ' function > getSavedOrderInfo()',
      ['deleteSavedOrderInfo'] = ' function > deleteSavedOrderInfo()',
      ['deleteSavedCredentials'] = ' function > deleteSavedCredentials()',
      ['getSupportUser'] = ' function > getSupportUser()',
      ['getWallpapers'] = ' function > getWallpapers()',
      ['setUserPrivacySettingRules'] = ' function > setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)',
      ['getUserPrivacySettingRules'] = ' function > getUserPrivacySettingRules(setting)',
      ['getOption'] = ' function > getOption(name)',
      ['setOption'] = ' function > setOption(name, option_value, value)',
      ['setAccountTtl'] = ' function > setAccountTtl(ttl)',
      ['getAccountTtl'] = ' function > getAccountTtl()',
      ['deleteAccount'] = ' function > deleteAccount(reason)',
      ['getChatReportSpamState'] = ' function > getChatReportSpamState(chat_id)',
      ['reportChat'] = ' function > reportChat(chat_id, reason, text, message_ids)',
      ['getStorageStatistics'] = ' function > getStorageStatistics(chat_limit)',
      ['getStorageStatisticsFast'] = ' function > getStorageStatisticsFast()',
      ['optimizeStorage'] = ' function > optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)',
      ['setNetworkType'] = ' function > setNetworkType(type)',
      ['getNetworkStatistics'] = ' function > getNetworkStatistics(only_current)',
      ['addNetworkStatistics'] = ' function > addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)',
      ['resetNetworkStatistics'] = ' function > resetNetworkStatistics()',
      ['getCountryCode'] = ' function > getCountryCode()',
      ['getInviteText'] = ' function > getInviteText()',
      ['getTermsOfService'] = ' function > getTermsOfService()',
      ['sendText'] = ' function > sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)',
      ['sendAnimation'] = ' function > sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendAudio'] = ' function > sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendDocument'] = ' function > sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendPhoto'] = ' function > sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendSticker'] = ' function > sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)',
      ['sendVideo'] = ' function > sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendVideoNote'] = ' function > sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendVoiceNote'] = ' function > sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)',
      ['sendLocation'] = ' function > sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)',
      ['sendVenue'] = ' function > sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)',
      ['sendContact'] = ' function > sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)',
      ['sendInvoice'] = ' function > sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)',
      ['sendForwarded'] = ' function > sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)',
      ['sendPoll'] = 'function > sendPoll(chat_id, reply_to_message_id, question, options, pollType, is_anonymous, allow_multiple_answers)'
},
colors_key = {
  reset =      0,
  bright     = 1,
  dim        = 2,
  underline  = 4,
  blink      = 5,
  reverse    = 7,
  hidden     = 8,
  black     = 30,
  red       = 31,
  green     = 32,
  yellow    = 33,
  blue      = 34,
  magenta   = 35,
  cyan      = 36,
  white     = 37,
  blackbg   = 40,
  redbg     = 41,
  greenbg   = 42,
  yellowbg  = 43,
  bluebg    = 44,
  magentabg = 45,
  cyanbg    = 46,
  whitebg   = 47
},
  config = {
  }
}
local LuaGram = require 'luagram'
local client = LuaGram()
----------------------------------------------- luagram core function
function function_core._CALL_(update)
  if update and type(update) == 'table' then
    for i = 0 , #update_functions do
      if not update_functions[i].filters then
        send_update = true
        update_message = update
      elseif update.luagram and update_functions[i].filters and luagram_function.in_array(update_functions[i].filters,  update.luagram) then
        send_update = true
        update_message = update
      else
        send_update = false
      end
      if update_message and send_update and type(update_message) == 'table' then
        xpcall(update_functions[i].def, function_core.print_error, update_message)
      end
      update_message = nil
      send_update = nil
    end
  end
end
function function_core.change_table(input, send)
  if send then
    changes ={
      luagram = string.reverse('epyt@')
    }
    rems = {
    }
  else
    changes = {
      _ = string.reverse('margaul'),
    }
    rems = {
      string.reverse('epyt@')
    }
  end
  if type(input) == 'table' then
    local res = {}
    for key,value in pairs(input) do
      for k, rem in pairs(rems) do
        if key == rem then
          value = nil
        end
      end
      local key = changes[key] or key
      if type(value) ~= 'table' then
        res[key] = value
      else
        res[key] = function_core.change_table(value, send)
      end
    end
    return res
  else
    return input
  end
end
function function_core.run_table(input)
  local to_original = function_core.change_table(input, true)
  local result = client:execute(to_original)
  if type(result) ~= 'table' then
    return nil
  else
    return function_core.change_table(result)
  end
end
function function_core.print_error(err)
  print(luagram_function.colors('%{red}\27[5m bug in your script ! %{reset}\n\n%{red}'.. err))
end
function function_core.send_tdlib(input)
  local to_original = function_core.change_table(input, true)
  client:send(to_original)
end

function_core.send_tdlib{
  luagram = 'getAuthorizationState'
}
LuaGram.setLogLevel(3)
LuaGram.setLogPath('/usr/lib/x86_64-linux-gnu/lua/5.3/.luagram.log')
-----------------------------------------------luagram_function
function luagram_function.match(...)
  local val = {}
  for no,v in ipairs({...}) do
    val[v] = true
  end
  return val
end
function luagram_function.poll(chat_id)
  return function_core.run_table{
      luagram = 'sendMessage',
      chat_id = chat_id,
      reply_to_message_id = reply_to_message_id or 0,
      input_message_content = {
        luagram = 'inputMessagePoll',
        is_anonymous = true,
        question = 'test',
        type = {
          luagram = 'pollTypeRegular',
          allow_multiple_answers = false
        },
        options = {'t','test2'}
    }
  }
end
function luagram_function.secToClock(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return {hours=00,mins=00,secs=00}
  else
    local hours = string.format("%02.f", math.floor(seconds / 3600));
    local mins = string.format("%02.f", math.floor(seconds / 60 - ( hours*60 ) ));
    local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
    return {hours=hours,mins=mins,secs=secs}
  end
end
function luagram_function.number_format(num)
  local out = tonumber(num)
  while true do
    out,i= string.gsub(out,'^(-?%d+)(%d%d%d)', '%1,%2')
    if (i==0) then
      break
    end
  end
  return out
end
function luagram_function.base64_encode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((str:gsub('.', function(x)
			local r,Base='',x:byte()
			for i=8,1,-1 do r=r..(Base%2^i-Base%2^(i-1)>0 and '1' or '0') end
			return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return Base:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#str%3+1])
end
function luagram_function.base64_decode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  str = string.gsub(str, '[^'..Base..'=]', '')
  return (str:gsub('.', function(x)
    if (x == '=') then
      return ''
    end
    local r,f='',(Base:find(x)-1)
    for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then
      return ''
    end
    local c=0
    for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
    return string.char(c)
  end))
end
function luagram_function.exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         return true
      end
   end
   return ok, err
end
function luagram_function.in_array(table, value)
  for k,v in pairs(table) do
    if value == v then
      return true
    end
  end
  return false
end
function luagram_function.colors(buffer)
  for keys in buffer:gmatch('%%{(.-)}') do
    buffer = string.gsub(buffer,'%%{'..keys..'}', '\27['..luagram.colors_key[keys]..'m')
  end
  return buffer .. '\27[0m'
end
function luagram_function.add_events(def,filters)
  if type(def) ~= 'function' then
    function_core.print_error('the add_events def must be a function !')
    return {
      luagram = false,
    }
    elseif type(filters) ~= 'table' then
      function_core.print_error('the add_events filters must be a table !')
      return {
        luagram = false,
      }
    else
      update_functions[#update_functions + 1] = {}
      update_functions[#update_functions + 1].def = def
      update_functions[#update_functions + 1].filters = filters
      return {
        luagram = true,
      }
  end
end
function luagram_function.help(def_name)
  if not def_name or def_name == '*' then
    local Counter = 0
    print(luagram_function.colors('%{green} luagram function name :%{reset} \n\n'))
    for function_name,example in pairs(luagram.luagram_helper) do
      if Counter % 2 == 0 then
        print(luagram_function.colors(Counter..' - %{yellow}'..function_name..'%{reset}'))
      else
        print(Counter..' - '..function_name)
      end
      Counter = Counter + 1
    end
    print(luagram_function.colors('\n\n%{green} > app.help(function_name)'))
  elseif def_name then
    for key,value in pairs(luagram.luagram_helper) do
      if string.lower(def_name) == string.lower(key) then
        print(luagram_function.colors(' - %{yellow} '..value))
        return value
      end
    end
  else
    print(luagram_function.colors(' - %{red} Function not found ! %{reset}'))
  end
end
function luagram_function.vardump(input)
  local function vardump(value)
     if type(value) == 'table' then
        local dump = '{\n'
        for key,v in pairs(value) do
           if type(key) == 'number' then
             key = '['..key..']'
           elseif type(key) == 'string' and key:match('@') then
             key = '["'..key..'"]'
           end
           if type(v) == 'string' then
             v = "'" .. v .. "'"
           end
           dump = dump .. key .. ' = ' .. vardump(v) .. ',\n'
        end
        return dump .. '}'
     else
        return tostring(value)
     end
   end
  print(luagram_function.colors('%{yellow} vardump : %{reset}\n\n%{green}'..vardump(input)))
  return vardump(input)
end
function luagram_function.set_timer(seconds, def, argv)
  if type(seconds) ~= 'number' then
    return {
      luagram = false,
      message = 'set_timer(int seconds, funtion def, table)'
    }
  elseif type(def) ~= 'function' then
    return {
      luagram = false,
      message = 'set_timer(int seconds, funtion def, table)'
    }
  end
  luagram_timer[#luagram_timer + 1] = {
    def = def,
    argv = argv,
    run_in = os.time() + seconds
  }
  return {
    luagram = true,
    run_in = os.time() + seconds,
    timer_id = #luagram_timer
  }
end
function luagram_function.get_timer(timer_id)
  local timer_data = luagram_timer[timer_id]
  if timer_data then
    return {
      luagram = true,
      run_in = timer_data.run_in,
      argv = timer_data.argv
    }
  else
    return {
      luagram = false,
    }
  end
end
function luagram_function.cancel_timer(timer_id)
  if luagram_timer[timer_id] then
    table.remove(luagram_timer,timer_id)
    return {
      luagram = true
    }
  else
    return {
      luagram = false
    }
  end
end
function luagram_function.getChatId(chat_id)
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    return {
      id = string.sub(chat_id, 5),
      type = 'supergroup'
    }
  else
    local basicgroup_id = string.sub(chat_id, 2)
    return {
      id = string.sub(chat_id, 2),
      type = 'basicgroup'
    }
  end
end
function luagram_function.getInputFile(file, conversion_str, expected_size)
  local str = tostring(file)
  if (conversion_str and expectedsize) then
    return {
      luagram = 'inputFileGenerated',
      original_path = tostring(file),
      conversion = tostring(conversion_str),
      expected_size = expected_size
    }
  else
    if str:match('/') then
      return {
        luagram = 'inputFileLocal',
        path = file
      }
    elseif str:match('^%d+$') then
      return {
        luagram = 'inputFileId',
        id = file
      }
    else
      return {
        luagram = 'inputFileRemote',
        id = file
      }
    end
  end
end
function luagram_function.getParseMode(parse_mode)
  if parse_mode then
    local mode = parse_mode:lower()
    if mode == 'markdown' or mode == 'md' then
      return {
        luagram = 'textParseModeMarkdown'
      }
    elseif mode == 'html' or mode == 'lg' then
      return {
        luagram = 'textParseModeHTML'
      }
    end
  end
end
function luagram_function.parseTextEntities(text, parse_mode)
  if type(parse_mode) == 'string' and string.lower(parse_mode) == 'lg' then
    for txt in text:gmatch('%%{(.-)}') do
      local _text, text_type = txt:match('(.*),(.*)')
      if type(_text) == 'string' and type(text_type) == 'string' then
        local text_type = string.gsub(text_type,' ','')
        if (string.lower(text_type) == 'b' or string.lower(text_type) == 'i' or string.lower(text_type) == 'c') then
          local text_type = string.lower(text_type)
          local text_type = text_type == 'c' and 'code' or text_type
          text = string.gsub(text,'%%{'..txt..'}','<'..text_type..'>'.._text..'</'..text_type..'>')
        else
          if type(tonumber(text_type)) == 'number' then
            link = 'tg://user?id='..text_type
          else
            link = text_type
          end
          text = string.gsub(text,'%%{'..txt..'}','<a href="'..link..'">'.._text..'</a>')
        end
      end
    end
  end
  return function_core.run_table{
    luagram = 'parseTextEntities',
    text = tostring(text),
    parse_mode = luagram_function.getParseMode(parse_mode)
  }
end
function luagram_function.vectorize(table)
  if type(table) == 'table' then
    return table
  else
    return {
      table
    }
  end
end
function luagram_function.setLimit(limit, num)
  local limit = tonumber(limit)
  local number = tonumber(num or limit)
  return (number >= limit) and limit or number
end
function luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
  local luagram_body, message = {
    luagram = 'sendMessage',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id or 0,
    disable_notification = disable_notification or 0,
    from_background = from_background or 1,
    reply_markup = reply_markup,
    input_message_content = input_message_content
  }, {}
  if input_message_content.text then
    text = input_message_content.text.text
  elseif input_message_content.caption then
    text = input_message_content.caption.text
  end
  if text then
    if parse_mode then
      local result = luagram_function.parseTextEntities(text, parse_mode)
      if luagram_body.input_message_content.text then
        luagram_body.input_message_content.text = result
      else
        luagram_body.input_message_content.caption = result
      end
      return function_core.run_table(luagram_body)
    else
      while #text > 4096 do
        text = string.sub(text, 4096, #text)
        message[#message + 1] = text
      end
      message[#message + 1] = text
      for i = 1, #message do
        if input_message_content.text and input_message_content.text.text then
          luagram_body.input_message_content.text.text = message[i]
        else
          luagram_body.input_message_content.caption.text = message[i]
        end
        return function_core.run_table(luagram_body)
      end
    end
  else
    return function_core.run_table(luagram_body)
  end
end
function luagram_function.logOut()
  return function_core.run_table{
    luagram = 'logOut'
  }
end
function luagram_function.getPasswordState()
  return function_core.run_table{
    luagram = 'getPasswordState'
  }
end
function luagram_function.setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)
  return function_core.run_table{
    old_password = tostring(old_password),
    new_password = tostring(new_password),
    new_hint = tostring(new_hint),
    set_recovery_email_address = set_recovery_email_address,
    new_recovery_email_address = tostring(new_recovery_email_address)
  }
end
function luagram_function.getRecoveryEmailAddress(password)
  return function_core.run_table{
    luagram = 'getRecoveryEmailAddress',
    password = tostring(password)
  }
end
function luagram_function.setRecoveryEmailAddress(password, new_recovery_email_address)
  return function_core.run_table{
    luagram = 'setRecoveryEmailAddress',
    password = tostring(password),
    new_recovery_email_address = tostring(new_recovery_email_address)
  }
end
function luagram_function.requestPasswordRecovery()
  return function_core.run_table{
    luagram = 'requestPasswordRecovery'
  }
end
function luagram_function.recoverPassword(recovery_code)
  return function_core.run_table{
    luagram = 'recoverPassword',
    recovery_code = tostring(recovery_code)
  }
end
function luagram_function.createTemporaryPassword(password, valid_for)
  local valid_for = valid_for > 86400 and 86400 or valid_for
  return function_core.run_table{
    luagram = 'createTemporaryPassword',
    password = tostring(password),
    valid_for = valid_for
  }
end
function luagram_function.getTemporaryPasswordState()
  return function_core.run_table{
    luagram = 'getTemporaryPasswordState'
  }
end
function luagram_function.getMe()
  return function_core.run_table{
    luagram = 'getMe'
  }
end
function luagram_function.getUser(user_id)
  return function_core.run_table{
    luagram = 'getUser',
    user_id = user_id
  }
end
function luagram_function.getUserFullInfo(user_id)
  return function_core.run_table{
    luagram = 'getUserFullInfo',
    user_id = user_id
  }
end
function luagram_function.getBasicGroup(basic_group_id)
  return function_core.run_table{
    luagram = 'getBasicGroup',
    basic_group_id = luagram_function.getChatId(basic_group_id).id
  }
end
function luagram_function.getBasicGroupFullInfo(basic_group_id)
  return function_core.run_table{
    luagram = 'getBasicGroupFullInfo',
    basic_group_id = luagram_function.getChatId(basic_group_id).id
  }
end
function luagram_function.getSupergroup(supergroup_id)
  return function_core.run_table{
    luagram = 'getSupergroup',
    supergroup_id = luagram_function.getChatId(supergroup_id).id
  }
end
function luagram_function.getSupergroupFullInfo(supergroup_id)
  return function_core.run_table{
    luagram = 'getSupergroupFullInfo',
    supergroup_id = luagram_function.getChatId(supergroup_id).id
  }
end
function luagram_function.getSecretChat(secret_chat_id)
  return function_core.run_table{
    luagram = 'getSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function luagram_function.getChat(chat_id)
  return function_core.run_table{
    luagram = 'getChat',
    chat_id = chat_id
  }
end
function luagram_function.getMessage(chat_id, message_id)
  return function_core.run_table{
    luagram = 'getMessage',
    chat_id = chat_id,
    message_id = message_id
  }
end
function luagram_function.getRepliedMessage(chat_id, message_id)
  return function_core.run_table{
    luagram = 'getRepliedMessage',
    chat_id = chat_id,
    message_id = message_id
  }
end
function luagram_function.getChatPinnedMessage(chat_id)
  return function_core.run_table{
    luagram = 'getChatPinnedMessage',
    chat_id = chat_id
  }
end
function luagram_function.getMessages(chat_id, message_ids)
  return function_core.run_table{
    luagram = 'getMessages',
    chat_id = chat_id,
    message_ids = vectorize(message_ids)
  }
end
function luagram_function.getFile(file_id)
  return function_core.run_table{
    luagram = 'getFile',
    file_id = file_id
  }
end
function luagram_function.getRemoteFile(remote_file_id, file_type)
  return function_core.run_table{
    luagram = 'getRemoteFile',
    remote_file_id = tostring(remote_file_id),
    file_type = {
      luagram = 'fileType' .. file_type or 'Unknown'
    }
  }
end
function luagram_function.getChats(offset_chat_id, limit, offset_order)
  return function_core.run_table{
    luagram = 'getChats',
    offset_order = offset_order or '9223372036854775807',
    offset_chat_id = offset_chat_id or 0,
    limit = limit or 20
  }
end
function luagram_function.searchPublicChat(username)
  return function_core.run_table{
    luagram = 'searchPublicChat',
    username = tostring(username)
  }
end
function luagram_function.searchPublicChats(query)
  return function_core.run_table{
    luagram = 'searchPublicChats',
    query = tostring(query)
  }
end
function luagram_function.searchChats(query, limit)
  return function_core.run_table{
    luagram = 'searchChats',
    query = tostring(query),
    limit = limit
  }
end
function luagram_function.checkChatUsername(chat_id, username)
  return function_core.run_table{
    luagram = 'checkChatUsername',
    chat_id = chat_id,
    username = tostring(username)
  }
end
function luagram_function.searchChatsOnServer(query, limit)
  return function_core.run_table{
    luagram = 'searchChatsOnServer',
    query = tostring(query),
    limit = limit
  }
end
function luagram_function.clearRecentlyFoundChats()
  return function_core.run_table{
    luagram = 'clearRecentlyFoundChats'
  }
end
function luagram_function.getTopChats(category, limit)
  return function_core.run_table{
    luagram = 'getTopChats',
    category = {
      luagram = 'topChatCategory' .. category
    },
    limit = luagram_function.setLimit(30, limit)
  }
end
function luagram_function.removeTopChat(category, chat_id)
  return function_core.run_table{
    luagram = 'removeTopChat',
    category = {
      luagram = 'topChatCategory' .. category
    },
    chat_id = chat_id
  }
end
function luagram_function.addRecentlyFoundChat(chat_id)
  return function_core.run_table{
    luagram = 'addRecentlyFoundChat',
    chat_id = chat_id
  }
end
function luagram_function.getCreatedPublicChats()
  return function_core.run_table{
    luagram = 'getCreatedPublicChats'
  }
end
function luagram_function.removeRecentlyFoundChat(chat_id)
  return function_core.run_table{
    luagram = 'removeRecentlyFoundChat',
    chat_id = chat_id
  }
end
function luagram_function.getChatHistory(chat_id, from_message_id, offset, limit, only_local)
  return function_core.run_table{
    luagram = 'getChatHistory',
    chat_id = chat_id,
    from_message_id = from_message_id,
    offset = offset,
    limit = luagram_function.setLimit(100, limit),
    only_local = only_local
  }
end
function luagram_function.getGroupsInCommon(user_id, offset_chat_id, limit)
  return function_core.run_table{
    luagram = 'getGroupsInCommon',
    user_id = user_id,
    offset_chat_id = offset_chat_id or 0,
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)
  return function_core.run_table{
    luagram = 'searchMessages',
    query = tostring(query),
    offset_date = offset_date or 0,
    offset_chat_id = offset_chat_id or 0,
    offset_message_id = offset_message_id or 0,
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)
  return function_core.run_table{
    luagram = 'searchChatMessages',
    chat_id = chat_id,
    query = tostring(query),
    sender_user_id = sender_user_id or 0,
    from_message_id = from_message_id or 0,
    offset = offset or 0,
    limit = luagram_function.setLimit(100, limit),
    filter = {
      luagram = 'searchMessagesFilter' .. filter
    }
  }
end
function luagram_function.searchSecretMessages(chat_id, query, from_search_id, limit, filter)
  local filter = filter or 'Empty'
  return function_core.run_table{
    luagram = 'searchSecretMessages',
    chat_id = chat_id or 0,
    query = tostring(query),
    from_search_id = from_search_id or 0,
    limit = luagram_function.setLimit(100, limit),
    filter = {
      luagram = 'searchMessagesFilter' .. filter
    }
  }
end
function luagram_function.deleteChatHistory(chat_id, remove_from_chat_list)
  return function_core.run_table{
    luagram = 'deleteChatHistory',
    chat_id = chat_id,
    remove_from_chat_list = remove_from_chat_list
  }
end
function luagram_function.searchCallMessages(from_message_id, limit, only_missed)
  return function_core.run_table{
    luagram = 'searchCallMessages',
    from_message_id = from_message_id or 0,
    limit = luagram_function.setLimit(100, limit),
    only_missed = only_missed
  }
end
function luagram_function.getChatMessageByDate(chat_id, date)
  return function_core.run_table{
    luagram = 'getChatMessageByDate',
    chat_id = chat_id,
    date = date
  }
end
function luagram_function.getPublicMessageLink(chat_id, message_id, for_album)
  return function_core.run_table{
    luagram = 'getPublicMessageLink',
    chat_id = chat_id,
    message_id = message_id,
    for_album = for_album
  }
end
function luagram_function.sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)
  return function_core.run_table{
    luagram = 'sendMessageAlbum',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id or 0,
    disable_notification = disable_notification,
    from_background = from_background,
    input_message_contents = luagram_function.vectorize(input_message_contents)
  }
end
function luagram_function.sendBotStartMessage(bot_user_id, chat_id, parameter)
  return function_core.run_table{
    luagram = 'sendBotStartMessage',
    bot_user_id = bot_user_id,
    chat_id = chat_id,
    parameter = tostring(parameter)
  }
end
function luagram_function.sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)
  return function_core.run_table{
    luagram = 'sendInlineQueryResultMessage',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id,
    disable_notification = disable_notification,
    from_background = from_background,
    query_id = query_id,
    result_id = tostring(result_id)
  }
end
function luagram_function.forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album)
  return function_core.run_table{
    luagram = 'forwardMessages',
    chat_id = chat_id,
    from_chat_id = from_chat_id,
    message_ids = luagram_function.vectorize(message_ids),
    disable_notification = disable_notification,
    from_background = from_background,
    as_album = as_album
  }
end
function luagram_function.sendChatSetTtlMessage(chat_id, ttl)
  return function_core.run_table{
    luagram = 'sendChatSetTtlMessage',
    chat_id = chat_id,
    ttl = ttl
  }
end
function luagram_function.sendChatScreenshotTakenNotification(chat_id)
  return function_core.run_table{
    luagram = 'sendChatScreenshotTakenNotification',
    chat_id = chat_id
  }
end
function luagram_function.deleteMessages(chat_id, message_ids, revoke)
  return function_core.run_table{
    luagram = 'deleteMessages',
    chat_id = chat_id,
    message_ids = luagram_function.vectorize(message_ids),
    revoke = revoke
  }
end
function luagram_function.deleteChatMessagesFromUser(chat_id, user_id)
  return function_core.run_table{
    luagram = 'deleteChatMessagesFromUser',
    chat_id = chat_id,
    user_id = user_id
  }
end
function luagram_function.editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)
  local luagram_body = {
    luagram = 'editMessageText',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup,
    input_message_content = {
      luagram = 'inputMessageText',
      disable_web_page_preview = disable_web_page_preview,
      text = {
        text = text
      },
      clear_draft = clear_draft
    }
  }
  if parse_mode then
    luagram_body.input_message_content.text = luagram_function.parseTextEntities(text, parse_mode)
  end
  return function_core.run_table(luagram_body)
end
function luagram_function.editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)
  local luagram_body = {
    luagram = 'editMessageCaption',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup,
    caption = caption
  }
  if parse_mode then
      luagram_body.caption = luagram_function.parseTextEntities(text,parse_mode)
  end
  return function_core.run_table(luagram_body)
end
function luagram_function.getTextEntities(text)
  return function_core.run_table{
    luagram = 'getTextEntities',
    text = tostring(text)
  }
end
function luagram_function.getFileMimeType(file_name)
  return function_core.run_table{
    luagram = 'getFileMimeType',
    file_name = tostring(file_name)
  }
end
function luagram_function.getFileExtension(mime_type)
  return function_core.run_table{
    luagram = 'getFileExtension',
    mime_type = tostring(mime_type)
  }
end
function luagram_function.getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)
  return function_core.run_table{
    luagram = 'getInlineQueryResults',
    bot_user_id = bot_user_id,
    chat_id = chat_id,
    user_location = {
      luagram = 'location',
      latitude = latitude,
      longitude = longitude
    },
    query = tostring(query),
    offset = tostring(offset)
  }
end
function luagram_function.getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)
  return function_core.run_table{
    luagram = 'getCallbackQueryAnswer',
    chat_id = chat_id,
    message_id = message_id,
    payload = {
      luagram = 'callbackQueryPayload' .. payload,
      data = data,
      game_short_name = game_short_name
    }
  }
end
function luagram_function.deleteChatReplyMarkup(chat_id, message_id)
  return function_core.run_table{
    luagram = 'deleteChatReplyMarkup',
    chat_id = chat_id,
    message_id = message_id
  }
end
function luagram_function.sendChatAction(chat_id, action, progress)
  return function_core.run_table{
    luagram = 'sendChatAction',
    chat_id = chat_id,
    action = {
      luagram = 'chatAction' .. action,
      progress = progress or 100
    }
  }
end
function luagram_function.openChat(chat_id)
  return function_core.run_table{
    luagram = 'openChat',
    chat_id = chat_id
  }
end
function luagram_function.closeChat(chat_id)
  return function_core.run_table{
    luagram = 'closeChat',
    chat_id = chat_id
  }
end
function luagram_function.viewMessages(chat_id, message_ids, force_read)
  return function_core.run_table{
    luagram = 'viewMessages',
    chat_id = chat_id,
    message_ids = luagram_function.vectorize(message_ids),
    force_read = force_read
  }
end
function luagram_function.openMessageContent(chat_id, message_id)
  return function_core.run_table{
    luagram = 'openMessageContent',
    chat_id = chat_id,
    message_id = message_id
  }
end
function luagram_function.readAllChatMentions(chat_id)
  return function_core.run_table{
    luagram = 'readAllChatMentions',
    chat_id = chat_id
  }
end
function luagram_function.createPrivateChat(user_id, force)
  return function_core.run_table{
    luagram = 'createPrivateChat',
    user_id = user_id,
    force = force
  }
end
function luagram_function.createBasicGroupChat(basic_group_id, force)
  return function_core.run_table{
    luagram = 'createBasicGroupChat',
    basic_group_id = luagram_function.getChatId(basic_group_id).id,
    force = force
  }
end
function luagram_function.createSupergroupChat(supergroup_id, force)
  return function_core.run_table{
    luagram = 'createSupergroupChat',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    force = force
  }
end
function luagram_function.createSecretChat(secret_chat_id)
  return function_core.run_table{
    luagram = 'createSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function luagram_function.createNewBasicGroupChat(user_ids, title)
  return function_core.run_table{
    luagram = 'createNewBasicGroupChat',
    user_ids = luagram_function.vectorize(user_ids),
    title = tostring(title)
  }
end
function luagram_function.createNewSupergroupChat(title, is_channel, description)
  return function_core.run_table{
    luagram = 'createNewSupergroupChat',
    title = tostring(title),
    is_channel = is_channel,
    description = tostring(description)
  }
end
function luagram_function.createNewSecretChat(user_id)
  return function_core.run_table{
    luagram = 'createNewSecretChat',
    user_id = tonumber(user_id)
  }
end
function luagram_function.upgradeBasicGroupChatToSupergroupChat(chat_id)
  return function_core.run_table{
    luagram = 'upgradeBasicGroupChatToSupergroupChat',
    chat_id = chat_id
  }
end
function luagram_function.setChatTitle(chat_id, title)
  return function_core.run_table{
    luagram = 'setChatTitle',
    chat_id = chat_id,
    title = tostring(title)
  }
end
function luagram_function.setChatPhoto(chat_id, photo)
  return function_core.run_table{
    luagram = 'setChatPhoto',
    chat_id = chat_id,
    photo = getInputFile(photo)
  }
end
function luagram_function.setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)
  local luagram_body = {
    luagram = 'setChatDraftMessage',
    chat_id = chat_id,
    draft_message = {
      luagram = 'draftMessage',
      reply_to_message_id = reply_to_message_id,
      input_message_text = {
        luagram = 'inputMessageText',
        disable_web_page_preview = disable_web_page_preview,
        text = {text = text},
        clear_draft = clear_draft
      }
    }
  }
  if parse_mode then
      luagram_body.draft_message.input_message_text.text = luagram_function.parseTextEntities(text, parse_mode)
  end
  return function_core.run_table(luagram_body)
end
function luagram_function.toggleChatIsPinned(chat_id, is_pinned)
  return function_core.run_table{
    luagram = 'toggleChatIsPinned',
    chat_id = chat_id,
    is_pinned = is_pinned
  }
end
function luagram_function.setChatClientData(chat_id, client_data)
  return function_core.run_table{
    luagram = 'setChatClientData',
    chat_id = chat_id,
    client_data = tostring(client_data)
  }
end
function luagram_function.addChatMember(chat_id, user_id, forward_limit)
  return function_core.run_table{
    luagram = 'addChatMember',
    chat_id = chat_id,
    user_id = user_id,
    forward_limit = luagram_function.setLimit(300, forward_limit)
  }
end
function luagram_function.addChatMembers(chat_id, user_ids)
  return function_core.run_table{
    luagram = 'addChatMembers',
    chat_id = chat_id,
    user_ids = luagram_function.vectorize(user_ids)
  }
end
function luagram_function.setChatMemberStatus(chat_id, user_id, status, right)
  local right = right and luagram_function.vectorize(right) or {}
  local status = string.lower(status)
  if status == 'creator' then
    chat_member_status = {
      luagram = 'chatMemberStatusCreator',
      is_member = right[1] or 1
    }
  elseif status == 'administrator' then
    chat_member_status = {
      luagram = 'chatMemberStatusAdministrator',
      can_be_edited = right[1] or 1,
      can_change_info = right[2] or 1,
      can_post_messages = right[3] or 1,
      can_edit_messages = right[4] or 1,
      can_delete_messages = right[5] or 1,
      can_invite_users = right[6] or 1,
      can_restrict_members = right[7] or 1,
      can_pin_messages = right[8] or 1,
      can_promote_members = right[9] or 0
    }
  elseif status == 'restricted' then
    chat_member_status = {
      permissions = {
        luagram = 'chatPermissions',
        can_send_polls = right[2] or 0,
        can_add_web_page_previews = right[3] or 1,
        can_change_info = right[4] or 0,
        can_invite_users = right[5] or 0,
        can_pin_messages = right[6] or 0,
        can_send_media_messages = right[7] or 0,
        can_send_messages = right[8] or 0,
        can_send_other_messages = right[9] or 0
      },
      is_member = right[1] or 1,
      restricted_until_date = right[10] or 0,
      luagram = 'chatMemberStatusRestricted'
    }
  elseif status == 'banned' then
    chat_member_status = {
      luagram = 'chatMemberStatusBanned',
      banned_until_date = right[1] or 0
    }
  end
  return function_core.run_table{
    luagram = 'setChatMemberStatus',
    chat_id = chat_id,
    user_id = user_id,
    status = chat_member_status or {}
  }
end


function luagram_function.getChatMember(chat_id, user_id)
  return function_core.run_table{
    luagram = 'getChatMember',
    chat_id = chat_id,
    user_id = user_id
  }
end
function luagram_function.searchChatMembers(chat_id, query, limit)
  return function_core.run_table{
    luagram = 'searchChatMembers',
    chat_id = chat_id,
    query = tostring(query),
    limit = luagram_function.setLimit(200, limit)
  }
end
function luagram_function.getChatAdministrators(chat_id)
  return function_core.run_table{
    luagram = 'getChatAdministrators',
    chat_id = chat_id
  }
end
function luagram_function.setPinnedChats(chat_ids)
  return function_core.run_table{
    luagram = 'setPinnedChats',
    chat_ids = luagram_function.vectorize(chat_ids)
  }
end
function luagram_function.downloadFile(file_id, priority)
  return function_core.run_table{
    luagram = 'downloadFile',
    file_id = file_id,
    priority = priority or 32
  }
end
function luagram_function.cancelDownloadFile(file_id, only_if_pending)
  return function_core.run_table{
    luagram = 'cancelDownloadFile',
    file_id = file_id,
    only_if_pending = only_if_pending
  }
end
function luagram_function.uploadFile(file, file_type, priority)
  local ftype = file_type or 'Unknown'
  return function_core.run_table{
    luagram = 'uploadFile',
    file = luagram_function.getInputFile(file),
    file_type = {
      luagram = 'fileType' .. ftype
    },
    priority = priority or 32
  }
end
function luagram_function.cancelUploadFile(file_id)
  return function_core.run_table{
    luagram = 'cancelUploadFile',
    file_id = file_id
  }
end
function luagram_function.deleteFile(file_id)
  return function_core.run_table{
    luagram = 'deleteFile',
    file_id = file_id
  }
end
function luagram_function.generateChatInviteLink(chat_id)
  return function_core.run_table{
    luagram = 'generateChatInviteLink',
    chat_id = chat_id
  }
end
function luagram_function.checkChatInviteLink(invite_link)
  return function_core.run_table{
    luagram = 'checkChatInviteLink',
    invite_link = tostring(invite_link)
  }
end
function luagram_function.joinChatByInviteLink(invite_link)
  return function_core.run_table{
    luagram = 'joinChatByInviteLink',
    invite_link = tostring(invite_link)
  }
end
function luagram_function.createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)
  return function_core.run_table{
    luagram = 'createCall',
    user_id = user_id,
    protocol = {
      luagram = 'callProtocol',
      udp_p2p = udp_p2p,
      udp_reflector = udp_reflector,
      min_layer = min_layer or 65,
      max_layer = max_layer or 65
    }
  }
end
function luagram_function.acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)
  return function_core.run_table{
    luagram = 'acceptCall',
    call_id = call_id,
    protocol = {
      luagram = 'callProtocol',
      udp_p2p = udp_p2p,
      udp_reflector = udp_reflector,
      min_layer = min_layer or 65,
      max_layer = max_layer or 65
    }
  }
end
function luagram_function.blockUser(user_id)
  return function_core.run_table{
    luagram = 'blockUser',
    user_id = user_id
  }
end
function luagram_function.unblockUser(user_id)
  return function_core.run_table{
    luagram = 'unblockUser',
    user_id = user_id
  }
end
function luagram_function.getBlockedUsers(offset, limit)
  return function_core.run_table{
    luagram = 'getBlockedUsers',
    offset = offset or 0,
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.importContacts(phone_number, first_name, last_name, user_id)
  return function_core.run_table{
    luagram = 'importContacts',
    contacts = {
      luagram = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id or 0
    }
  }
end
function luagram_function.searchContacts(query, limit)
  return function_core.run_table{
    luagram = 'searchContacts',
    query = tostring(query),
    limit = limit
  }
end
function luagram_function.removeContacts(user_ids)
  return function_core.run_table{
    luagram = 'removeContacts',
    user_ids = luagram_function.vectorize(user_ids)
  }
end
function luagram_function.getImportedContactCount()
  return function_core.run_table{
    luagram = 'getImportedContactCount'
  }
end
function luagram_function.changeImportedContacts(phone_number, first_name, last_name, user_id)
  return function_core.run_table{
    luagram = 'changeImportedContacts',
    contacts = {
      luagram = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id or 0
    }
  }
end
function luagram_function.clearImportedContacts()
  return function_core.run_table{
    luagram = 'clearImportedContacts'
  }
end
function luagram_function.getUserProfilePhotos(user_id, offset, limit)
  return function_core.run_table{
    luagram = 'getUserProfilePhotos',
    user_id = user_id,
    offset = offset or 0,
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.getStickers(emoji, limit)
  return function_core.run_table{
    luagram = 'getStickers',
    emoji = tostring(emoji),
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.searchStickers(emoji, limit)
  return function_core.run_table{
    luagram = 'searchStickers',
    emoji = tostring(emoji),
    limit = limit
  }
end
function luagram_function.getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)
  return function_core.run_table{
    luagram = 'getArchivedStickerSets',
    is_masks = is_masks,
    offset_sticker_set_id = offset_sticker_set_id,
    limit = limit
  }
end
function luagram_function.getTrendingStickerSets()
  return function_core.run_table{
    luagram = 'getTrendingStickerSets'
  }
end
function luagram_function.getAttachedStickerSets(file_id)
  return function_core.run_table{
    luagram = 'getAttachedStickerSets',
    file_id = file_id
  }
end
function luagram_function.getStickerSet(set_id)
  return function_core.run_table{
    luagram = 'getStickerSet',
    set_id = set_id
  }
end
function luagram_function.searchStickerSet(name)
  return function_core.run_table{
    luagram = 'searchStickerSet',
    name = tostring(name)
  }
end
function luagram_function.searchInstalledStickerSets(is_masks, query, limit)
  return function_core.run_table{
    luagram = 'searchInstalledStickerSets',
    is_masks = is_masks,
    query = tostring(query),
    limit = limit
  }
end
function luagram_function.searchStickerSets(query)
  return function_core.run_table{
    luagram = 'searchStickerSets',
    query = tostring(query)
  }
end
function luagram_function.changeStickerSet(set_id, is_installed, is_archived)
  return function_core.run_table{
    luagram = 'changeStickerSet',
    set_id = set_id,
    is_installed = is_installed,
    is_archived = is_archived
  }
end
function luagram_function.viewTrendingStickerSets(sticker_set_ids)
  return function_core.run_table{
    luagram = 'viewTrendingStickerSets',
    sticker_set_ids = luagram_function.vectorize(sticker_set_ids)
  }
end
function luagram_function.reorderInstalledStickerSets(is_masks, sticker_set_ids)
  return function_core.run_table{
    luagram = 'reorderInstalledStickerSets',
    is_masks = is_masks,
    sticker_set_ids = luagram_function.vectorize(sticker_set_ids)
  }
end
function luagram_function.getRecentStickers(is_attached)
  return function_core.run_table{
    luagram = 'getRecentStickers',
    is_attached = is_attached
  }
end
function luagram_function.addRecentSticker(is_attached, sticker)
  return function_core.run_table{
    luagram = 'addRecentSticker',
    is_attached = is_attached,
    sticker = luagram_function.getInputFile(sticker)
  }
end
function luagram_function.clearRecentStickers(is_attached)
  return function_core.run_table{
    luagram = 'clearRecentStickers',
    is_attached = is_attached
  }
end
function luagram_function.getFavoriteStickers()
  return function_core.run_table{
    luagram = 'getFavoriteStickers'
  }
end
function luagram_function.addFavoriteSticker(sticker)
  return function_core.run_table{
    luagram = 'addFavoriteSticker',
    sticker = luagram_function.getInputFile(sticker)
  }
end
function luagram_function.removeFavoriteSticker(sticker)
  return function_core.run_table{
    luagram = 'removeFavoriteSticker',
    sticker = luagram_function.getInputFile(sticker)
  }
end
function luagram_function.getStickerEmojis(sticker)
  return function_core.run_table{
    luagram = 'getStickerEmojis',
    sticker = luagram_function.getInputFile(sticker)
  }
end
function luagram_function.getSavedAnimations()
  return function_core.run_table{
    luagram = 'getSavedAnimations'
  }
end
function luagram_function.addSavedAnimation(animation)
  return function_core.run_table{
    luagram = 'addSavedAnimation',
    animation = luagram_function.getInputFile(animation)
  }
end
function luagram_function.removeSavedAnimation(animation)
  return function_core.run_table{
    luagram = 'removeSavedAnimation',
    animation = luagram_function.getInputFile(animation)
  }
end
function luagram_function.getRecentInlineBots()
  return function_core.run_table{
    luagram = 'getRecentInlineBots'
  }
end
function luagram_function.searchHashtags(prefix, limit)
  return function_core.run_table{
    luagram = 'searchHashtags',
    prefix = tostring(prefix),
    limit = limit
  }
end
function luagram_function.removeRecentHashtag(hashtag)
  return function_core.run_table{
    luagram = 'removeRecentHashtag',
    hashtag = tostring(hashtag)
  }
end
function luagram_function.getWebPagePreview(text)
  return function_core.run_table{
    luagram = 'getWebPagePreview',
    text = {
      text = text
    }
  }
end
function luagram_function.getWebPageInstantView(url, force_full)
  return function_core.run_table{
    luagram = 'getWebPageInstantView',
    url = tostring(url),
    force_full = force_full
  }
end
function luagram_function.getNotificationSettings(scope, chat_id)
  return function_core.run_table{
    luagram = 'getNotificationSettings',
    scope = {
      luagram = 'notificationSettingsScope' .. scope,
      chat_id = chat_id
    }
  }
end
function luagram_function.setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)
  return function_core.run_table{
    luagram = 'setNotificationSettings',
    scope = {
      luagram = 'notificationSettingsScope' .. scope,
      chat_id = chat_id
    },
    notification_settings = {
      luagram = 'notificationSettings',
      mute_for = mute_for,
      sound = tostring(sound),
      show_preview = show_preview
    }
  }
end
function luagram_function.resetAllNotificationSettings()
  return function_core.run_table{
    luagram = 'resetAllNotificationSettings'
  }
end
function luagram_function.setProfilePhoto(photo)
  return function_core.run_table{
    luagram = 'setProfilePhoto',
    photo = luagram_function.getInputFile(photo)
  }
end
function luagram_function.deleteProfilePhoto(profile_photo_id)
  return function_core.run_table{
    luagram = 'deleteProfilePhoto',
    profile_photo_id = profile_photo_id
  }
end
function luagram_function.setName(first_name, last_name)
  return function_core.run_table{
    luagram = 'setName',
    first_name = tostring(first_name),
    last_name = tostring(last_name)
  }
end
function luagram_function.setBio(bio)
  return function_core.run_table{
    luagram = 'setBio',
    bio = tostring(bio)
  }
end
function luagram_function.setUsername(username)
  return function_core.run_table{
    luagram = 'setUsername',
    username = tostring(username)
  }
end
function luagram_function.getActiveSessions()
  return function_core.run_table{
    luagram = 'getActiveSessions'
  }
end
function luagram_function.terminateAllOtherSessions()
  return function_core.run_table{
    luagram = 'terminateAllOtherSessions'
  }
end
function luagram_function.terminateSession(session_id)
  return function_core.run_table{
    luagram = 'terminateSession',
    session_id = session_id
  }
end
function luagram_function.toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)
  return function_core.run_table{
    luagram = 'toggleBasicGroupAdministrators',
    basic_group_id = luagram_function.getChatId(basic_group_id).id,
    everyone_is_administrator = everyone_is_administrator
  }
end
function luagram_function.setSupergroupUsername(supergroup_id, username)
  return function_core.run_table{
    luagram = 'setSupergroupUsername',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    username = tostring(username)
  }
end
function luagram_function.setSupergroupStickerSet(supergroup_id, sticker_set_id)
  return function_core.run_table{
    luagram = 'setSupergroupStickerSet',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    sticker_set_id = sticker_set_id
  }
end
function luagram_function.toggleSupergroupInvites(supergroup_id, anyone_can_invite)
  return function_core.run_table{
    luagram = 'toggleSupergroupInvites',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    anyone_can_invite = anyone_can_invite
  }
end
function luagram_function.toggleSupergroupSignMessages(supergroup_id, sign_messages)
  return function_core.run_table{
    luagram = 'toggleSupergroupSignMessages',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    sign_messages = sign_messages
  }
end
function luagram_function.toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)
  return function_core.run_table{
    luagram = 'toggleSupergroupIsAllHistoryAvailable',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    is_all_history_available = is_all_history_available
  }
end
function luagram_function.setSupergroupDescription(supergroup_id, description)
  return function_core.run_table{
    luagram = 'setSupergroupDescription',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    description = tostring(description)
  }
end
function luagram_function.pinSupergroupMessage(supergroup_id, message_id, disable_notification)
  return function_core.run_table{
    luagram = 'pinSupergroupMessage',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    message_id = message_id,
    disable_notification = disable_notification
  }
end
function luagram_function.unpinSupergroupMessage(supergroup_id)
  return function_core.run_table{
    luagram = 'unpinSupergroupMessage',
    supergroup_id = luagram_function.getChatId(supergroup_id).id
  }
end
function luagram_function.reportSupergroupSpam(supergroup_id, user_id, message_ids)
  return function_core.run_table{
    luagram = 'reportSupergroupSpam',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    user_id = user_id,
    message_ids = luagram_function.vectorize(message_ids)
  }
end
function luagram_function.getSupergroupMembers(supergroup_id, filter, query, offset, limit)
  local filter = filter or 'Recent'
  return function_core.run_table{
    luagram = 'getSupergroupMembers',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    filter = {
      luagram = 'supergroupMembersFilter' .. filter,
      query = query
    },
    offset = offset or 0,
    limit = luagram_function.setLimit(200, limit)
  }
end
function luagram_function.deleteSupergroup(supergroup_id)
  return function_core.run_table{
    luagram = 'deleteSupergroup',
    supergroup_id = luagram_function.getChatId(supergroup_id).id
  }
end
function luagram_function.closeSecretChat(secret_chat_id)
  return function_core.run_table{
    luagram = 'closeSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function luagram_function.getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)
  local filters = filters or {1,1,1,1,1,1,1,1,1,1}
  return function_core.run_table{
    luagram = 'getChatEventLog',
    chat_id = chat_id,
    query = tostring(query) or '',
    from_event_id = from_event_id or 0,
    limit = luagram_function.setLimit(100, limit),
    filters = {
      luagram = 'chatEventLogFilters',
      message_edits = filters[0],
      message_deletions = filters[1],
      message_pins = filters[2],
      member_joins = filters[3],
      member_leaves = filters[4],
      member_invites = filters[5],
      member_promotions = filters[6],
      member_restrictions = filters[7],
      info_changes = filters[8],
      setting_changes = filters[9]
    },
    user_ids = luagram_function.vectorize(user_ids)
  }
end
function luagram_function.getSavedOrderInfo()
  return function_core.run_table{
    luagram = 'getSavedOrderInfo'
  }
end
function luagram_function.deleteSavedOrderInfo()
  return function_core.run_table{
    luagram = 'deleteSavedOrderInfo'
  }
end
function luagram_function.deleteSavedCredentials()
  return function_core.run_table{
    luagram = 'deleteSavedCredentials'
  }
end
function luagram_function.getSupportUser()
  return function_core.run_table{
    luagram = 'getSupportUser'
  }
end
function luagram_function.getWallpapers()
  return function_core.run_table{
    luagram = 'getWallpapers'
  }
end
function luagram_function.setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)
  local setting_rules = {
    [0] = {
      luagram = 'userPrivacySettingRule' .. rules
    }
  }
  if allowed_user_ids then
    setting_rules[#setting_rules + 1] = {
      {
        luagram = 'userPrivacySettingRuleAllowUsers',
        user_ids = luagram_function.vectorize(allowed_user_ids)
      }
    }
  elseif restricted_user_ids then
    setting_rules[#setting_rules + 1] = {
      {
        luagram = 'userPrivacySettingRuleRestrictUsers',
        user_ids = luagram_function.vectorize(restricted_user_ids)
      }
    }
  end
  return function_core.run_table{
    luagram = 'setUserPrivacySettingRules',
    setting = {
      luagram = 'userPrivacySetting' .. setting
    },
    rules = {
      luagram = 'userPrivacySettingRules',
      rules = setting_rules
    }
  }
end
function luagram_function.getUserPrivacySettingRules(setting)
  return function_core.run_table{
    luagram = 'getUserPrivacySettingRules',
    setting = {
      luagram = 'userPrivacySetting' .. setting
    }
  }
end
function luagram_function.getOption(name)
  return function_core.run_table{
    luagram = 'getOption',
    name = tostring(name)
  }
end
function luagram_function.setOption(name, option_value, value)
  return function_core.run_table{
    luagram = 'setOption',
    name = tostring(name),
    value = {
      luagram = 'optionValue' .. option_value,
      value = value
    }
  }
end
function luagram_function.setAccountTtl(ttl)
  return function_core.run_table{
    luagram = 'setAccountTtl',
    ttl = {
      luagram = 'accountTtl',
      days = ttl
    }
  }
end
function luagram_function.getAccountTtl()
  return function_core.run_table{
    luagram = 'getAccountTtl'
  }
end
function luagram_function.deleteAccount(reason)
  return function_core.run_table{
    luagram = 'deleteAccount',
    reason = tostring(reason)
  }
end
function luagram_function.getChatReportSpamState(chat_id)
  return function_core.run_table{
    luagram = 'getChatReportSpamState',
    chat_id = chat_id
  }
end
function luagram_function.reportChat(chat_id, reason, text, message_ids)
  return function_core.run_table{
    luagram = 'reportChat',
    chat_id = chat_id,
    reason = {
      luagram = 'chatReportReason' .. reason,
      text = text
    },
    message_ids = luagram_function.vectorize(message_ids)
  }
end
function luagram_function.getStorageStatistics(chat_limit)
  return function_core.run_table{
    luagram = 'getStorageStatistics',
    chat_limit = chat_limit
  }
end
function luagram_function.getStorageStatisticsFast()
  return function_core.run_table{
    luagram = 'getStorageStatisticsFast'
  }
end
function luagram_function.optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)
  local file_type = file_type or ''
  return function_core.run_table{
    luagram = 'optimizeStorage',
    size = size or -1,
    ttl = ttl or -1,
    count = count or -1,
    immunity_delay = immunity_delay or -1,
    file_type = {
      luagram = 'fileType' .. file_type
    },
    chat_ids = luagram_function.vectorize(chat_ids),
    exclude_chat_ids = luagram_function.vectorize(exclude_chat_ids),
    chat_limit = chat_limit
  }
end
function luagram_function.setNetworkType(type)
  return function_core.run_table{
    luagram = 'setNetworkType',
    type = {
      luagram = 'networkType' .. type
    },
  }
end
function luagram_function.getNetworkStatistics(only_current)
  return function_core.run_table{
    luagram = 'getNetworkStatistics',
    only_current = only_current
  }
end
function luagram_function.addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)
  local file_type = file_type or 'None'
  return function_core.run_table{
    luagram = 'addNetworkStatistics',
    entry = {
      luagram = 'networkStatisticsEntry' .. entry,
      file_type = {
        luagram = 'fileType' .. file_type
      },
      network_type = {
        luagram = 'networkType' .. network_type
      },
      sent_bytes = sent_bytes,
      received_bytes = received_bytes,
      duration = duration
    }
  }
end
function luagram_function.resetNetworkStatistics()
  return function_core.run_table{
    luagram = 'resetNetworkStatistics'
  }
end
function luagram_function.getCountryCode()
  return function_core.run_table{
    luagram = 'getCountryCode'
  }
end
function luagram_function.getInviteText()
  return function_core.run_table{
    luagram = 'getInviteText'
  }
end
function luagram_function.getTermsOfService()
  return function_core.run_table{
    luagram = 'getTermsOfService'
  }
end
function luagram_function.sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageText',
    disable_web_page_preview = disable_web_page_preview,
    text = {text = text},
    clear_draft = clear_draft
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageAnimation',
    animation = luagram_function.getInputFile(animation),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    duration = duration,
    width = width,
    height = height
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageAudio',
    audio = luagram_function.getInputFile(audio),
    album_cover_thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    duration = duration,
    title = tostring(title),
    performer = tostring(performer)
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageDocument',
    document = luagram_function.getInputFile(document),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption}
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessagePhoto',
    photo = luagram_function.getInputFile(photo),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    added_sticker_file_ids = luagram_function.vectorize(added_sticker_file_ids),
    width = width,
    height = height,
    ttl = ttl or 0
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageSticker',
    sticker = luagram_function.getInputFile(sticker),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    width = width,
    height = height
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageVideo',
    video = luagram_function.getInputFile(video),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    added_sticker_file_ids = luagram_function.vectorize(added_sticker_file_ids),
    duration = duration,
    width = width,
    height = height,
    ttl = ttl
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageVideoNote',
    video_note = luagram_function.getInputFile(video_note),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    duration = duration,
    length = length
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageVoiceNote',
    voice_note = luagram_function.getInputFile(voice_note),
    caption = {text = caption},
    duration = duration,
    waveform = waveform
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageLocation',
    location = {
      luagram = 'location',
      latitude = latitude,
      longitude = longitude
    },
    live_period = liveperiod
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageVenue',
    venue = {
      luagram = 'venue',
      location = {
        luagram = 'location',
        latitude = latitude,
        longitude = longitude
      },
      title = tostring(title),
      address = tostring(address),
      provider = tostring(provider),
      id = tostring(id)
    }
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageContact',
    contact = {
      luagram = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id
    }
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageInvoice',
    invoice = invoice,
    title = tostring(title),
    description = tostring(description),
    photo_url = tostring(photo_url),
    photo_size = photo_size,
    photo_width = photo_width,
    photo_height = photo_height,
    payload = payload,
    provider_token = tostring(provider_token),
    provider_data = tostring(provider_data),
    start_parameter = tostring(start_parameter)
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageForwarded',
    from_chat_id = from_chat_id,
    message_id = message_id,
    in_game_share = in_game_share
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendPoll(chat_id, reply_to_message_id, question, options, pollType, is_anonymous, allow_multiple_answers)
  local input_message_content = {
      luagram = 'inputMessagePoll',
      is_anonymous = is_anonymous,
      question = question,
      type = {
        luagram = 'pollType'..pollType,
        allow_multiple_answers = allow_multiple_answers
      },
      options = options
    }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram.VERSION()
  print(luagram_function.colors('%{yellow}\27[5m'..luagram.logo),'\n\n')
  return true
end
function luagram.run(main_def, filters)
  if type(main_def) ~= 'function' then
    function_core.print_error('the run main_def must be a main function !')
    os.exit(1)
  else
    update_functions[0] = {}
    update_functions[0].def = main_def
    update_functions[0].filters = filters
  end
  while true do
    for timer_id, timer_data in pairs(luagram_timer) do
      if os.time() >= timer_data.run_in then
        xpcall(timer_data.def, function_core.print_error,timer_data.argv)
        table.remove(luagram_timer,timer_id)
      end
    end
    local update = function_core.change_table(client:get(1))
    if update then
      if type(update) ~= 'table' then
          goto finish
      end
      if update.authorization_state then
        luagram.login(update.authorization_state)
      else
        function_core._CALL_(update)
      end
    end
    ::finish::
  end
end
function luagram.set_config(data)
  luagram.VERSION()
  if not data.api_hash then
    print(luagram_function.colors('%{red} please use api_hash in your script !'))
    os.exit()
  end
  if not data.api_id then
    print(luagram_function.colors('%{red} please use api_id in your script !'))
    os.exit()
  end
  if not data.session_name then
    print(luagram_function.colors('%{red} please use session_name in your script !'))
    os.exit()
  end
  if not data.token and not luagram_function.exists('.luagram-'..data.session_name) then
    io.write(luagram_function.colors('\n%{green} please use your token or phone number > '))
    local phone_token = io.read()
    if phone_token:match('%d+:') then
      luagram.config.is_bot = true
      luagram.config.token = phone_token
    else
      luagram.config.is_bot = false
      luagram.config.phone = phone_token
    end
  end
  luagram.config.encryption_key = data.encryption_key or ''
  luagram.config.parameters = {
    luagram = 'setTdlibParameters',
    use_message_database = data.use_message_database or true,
    api_id = data.api_id,
    api_hash = data.api_hash,
    use_secret_chats = use_secret_chats or true,
    system_language_code = data.language_code or 'en',
    device_model = data.device_model or 'luagram',
    system_version = data.system_version or 'linux',
    application_version = data.app_version or '1.0',
    enable_storage_optimizer = data.enable_storage_optimizer or true,
    use_pfs = data.use_pfs or true,
    database_directory = '.luagram-'..data.session_name
  }
  return luagram_function
end
function luagram.login(state)
  if state.luagram == 'error' and (state.message == 'PHONE_NUMBER_INVALID' or state.message == 'ACCESS_TOKEN_INVALID') then
    if state.message == 'PHONE_NUMBER_INVALID' then
      print(luagram_function.colors('%{red} phone number invalid !'))
    else
      print(luagram_function.colors('%{red} access token invalid !'))
    end
    io.write(luagram_function.colors('\n%{green} please use your token or phone number > '))
    local phone_token = io.read()
    if phone_token:match('%d+:') then
      function_core.send_tdlib{
        luagram = 'checkAuthenticationBotToken',
        token = phone_token
      }
    else
      function_core.send_tdlib{
        luagram = 'setAuthenticationPhoneNumber',
        phone_number = phone_token
      }
    end
  elseif state.luagram == 'error' and state.message == 'PHONE_CODE_INVALID' then
    io.write(luagram_function.colors('\n%{green} Please enter the authentication code you received > '))
    local code = io.read()
    function_core.send_tdlib{
      luagram = 'checkAuthenticationCode',
      code = code
    }
  elseif state.luagram == 'error' and state.message == 'PASSWORD_HASH_INVALID' then
    print(luagram_function.colors('%{red}two-step is wrong !'))
    io.write(luagram_function.colors('\n%{green} Please enter your password > '))
    local password = io.read()
    function_core.send_tdlib{
      luagram = 'checkAuthenticationPassword',
      password = password
    }
  elseif state.luagram == 'authorizationStateWaitTdlibParameters' then
    function_core.send_tdlib{
      luagram = 'setTdlibParameters',
      parameters = luagram.config.parameters
    }
  elseif state.luagram == 'authorizationStateWaitEncryptionKey' then
    function_core.send_tdlib{
      luagram = 'checkDatabaseEncryptionKey',
      encryption_key = luagram.config.encryption_key
    }
  elseif state.luagram == 'authorizationStateWaitPhoneNumber' then
    if luagram.config.is_bot then
      function_core.send_tdlib{
        luagram = 'checkAuthenticationBotToken',
        token = luagram.config.token
      }
    else
      function_core.send_tdlib{
        luagram = 'setAuthenticationPhoneNumber',
        phone_number = luagram.config.phone
      }
    end
  elseif state.luagram == 'authorizationStateWaitCode' then
      io.write(luagram_function.colors('\n%{green} Please enter the authentication code you received > '))
      local code = io.read()
      function_core.send_tdlib{
        luagram = 'checkAuthenticationCode',
        code = code
      }
  elseif state.luagram == 'authorizationStateWaitPassword' then
      io.write(luagram_function.colors('\n%{green} Please enter your password [ '..state.password_hint..' ] > '))
      local password = io.read()
      function_core.send_tdlib{
        luagram = 'checkAuthenticationPassword',
        password = password
      }
  elseif state.luagram == 'authorizationStateWaitRegistration' then
    io.write(luagram_function.colors('\n%{green} Please enter your first name > '))
    local first_name = io.read()
    io.write(luagram_function.colors('\n%{green} Please enter your last name > '))
    local last_name = io.read()
    function_core.send_tdlib{
      luagram = 'registerUser',
      first_name = first_name,
      last_name = last_name
    }
  elseif state.luagram == 'authorizationStateReady' then
    print(luagram_function.colors("%{green}>> login successfully let's rock <<"))
  elseif state.luagram == 'authorizationStateClosed' then
    return true
  end
end
return luagram