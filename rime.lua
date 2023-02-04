-- 增加 KeySequence(string)
-- 1
--    local ks= KeySequence()
--    ks:parse("abc")
-- 2
--    local ks= KeySequence("abc")
--
local _KeySequence=KeySequence
KeySequence = function(str)
  local ks = _KeySequence()
  if type(str)== "string" then
    ks:parse(str)
  end
  return ks
end


--[[
librime-lua 样例

调用方法：
在配方文件中作如下修改：
```
  engine:
    ...
    translators:
      ...
      - lua_translator@lua_function3
      - lua_translator@lua_function4
      ...
    filters:
      ...
      - lua_filter@lua_function1
      - lua_filter@lua_function2
      ...
```

其中各 `lua_function` 为在本文件所定义变量名。
--]]

--[[
本文件的后面是若干个例子，按照由简单到复杂的顺序示例了 librime-lua 的用法。
每个例子都被组织在 `lua` 目录下的单独文件中，打开对应文件可看到实现和注解。

各例可使用 `require` 引入。
如：
```
  foo = require("bar")
```
可认为是载入 `lua/bar.lua` 中的例子，并起名为 `foo`。
配方文件中的引用方法为：`...@foo`。

--]]


-- I. translators:

-- date_translator: 将 `date` 翻译为当前日期
-- 详见 `lua/date.lua`:
date_translator = require("others/date")

-- time_translator: 将 `time` 翻译为当前时间
-- 详见 `lua/time.lua`
time_translator = require("others/time")

week_translator = require("others/week")
-- number_translator: 将 `/` + 阿拉伯数字 翻译为大小写汉字
-- 详见 `lua/number.lua`
number_translator = require("others/number")


-- II. filters:

-- charset_filter: 滤除含 CJK 扩展汉字的候选项
-- charset_comment_filter: 为候选项加上其所属字符集的注释
-- 详见 `lua/charset.lua`
local charset = require("others/charset")
charset_filter = charset.filter
charset_comment_filter = charset.comment_filter

-- single_char_filter: 候选项重排序，使单字优先
-- 详见 `lua/single_char.lua`
single_char_filter = require("others/single_char")

-- reverse_lookup_filter: 依地球拼音为候选项加上带调拼音的注释
-- 详见 `lua/reverse.lua`
reverse_lookup_filter = require("others/reverse")

--use wildcard to search code
expand_translator = require("others/expand_translator")


-- III. processors:

-- switch_processor: 通过选择自定义的候选项来切换开关（以简繁切换和下一方案为例）
-- 详见 `lua/switch.lua`
switch_processor = require("others/switch")

-- select_character_processor: 以词定字
-- 详见 `lua/select_character.lua`
select_character_processor = require("select_character")

-- easy_en_enhance_filter: 连续输入增强
-- 详见 `lua/easy_en.lua`
local easy_en = require("easy_en")
easy_en_enhance_filter = easy_en.enhance_filter

---- librime-lua-script
-- 方式 2 通过 init_processor 工具加载，可以查看init_processor.lua中的用法说明
init_processor = require('init_processor')

--module1={
--  -- 以词定字
--  -- { module= 'component/select_character', module_name= 'select_character', name_space= "translator" },
--  { module= 'english'    , module_name= "english_proc",     name_space= "english"},
--  { module= 'conjunctive', module_name= "conjunctive_proc", name_space= "conjunctive"},
--}
--module2={
--  {module = 'command', module_name = "cammand_proc", name_space = "command" },
--  {module='english', module_name="english_proc",name_space="english" },
--  {module="conjunctive", odule_name = "conjunctive_proc",name_space="conjunctive"},
--  {module= 'multi_reverse', module_name= "multi_reverse__proc", name_space= "multi_reverse" },
--}

-- 方式 3 独立加载模块
-- 載入 multi_reverse_processor multi_reverse_filter
multi_reverse_proc = require('multi_reverse')
assert( multi_reverse_processor)

-- selcet_character = require 'component/select_character'
