-- select_character_processor: 以词定字
-- 详见 `lua/select_character.lua`
select_character_processor = require("select_character")

-- easy_en_enhance_filter: 连续输入增强
-- 详见 `lua/easy_en.lua`
local easy_en = require("easy_en")
easy_en_enhance_filter = easy_en.enhance_filter

-- jimmy54/rime-lua.git
date_translator = require("date")

module2={
  {module='command', module_name="cammand_proc",name_space="command" },
  {module='english', module_name="english_proc",name_space="english" },
  {module="conjunctive", odule_name = "conjunctive_proc",name_space="conjunctive"},
  { module= 'multi_reverse', module_name= "multi_reverse__proc", name_space= "multi_reverse" },
}

init_processor = require('init_processor')
