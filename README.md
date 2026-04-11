# Neovim 配置说明

这是一个基于 `lazy.nvim` 的个人 Neovim 配置，入口清晰，插件开关集中在本地 `lua/config.lua`，适合按需裁剪和逐步扩展。

默认特性：

- `mapleader` 为 `,`
- 使用 `lazy.nvim` 管理插件，并在首次启动时自动引导安装
- 使用 `which-key` 展示 leader 菜单
- 提供 `config.lua` 本地插件开关和保存后自动重载
- 默认主题为 `gruvbox`
- 默认集成文件树、模糊搜索、终端、Git、补全、会话、注释、状态栏等常用能力

## 环境要求

- Neovim `0.11+`
- `git`
- 建议使用 Nerd Font，否则部分图标会显示不完整

按功能建议额外安装：

- `ripgrep`：`Telescope live_grep`
- `lazygit`：`<leader>gg`
- `python3`：`:JsonFormat`
- 启用 `LSP` / `none-ls` / `treesitter` 后，对应语言服务器或外部工具

## 安装

```bash
git clone https://github.com/sunliang711/nvim ~/.config/nvim
cd ~/.config/nvim
cp lua/config-example.lua lua/config.lua
nvim
```

说明：

- `lua/config.lua` 是本地配置文件，已被 Git 忽略，不会污染仓库
- 第一次启动时会自动拉取 `lazy.nvim` 和启用的插件
- 如果没有先复制 `lua/config.lua`，启动时会因为 `require("config")` 失败而报错

## 目录结构

```text
.
├── init.lua                   # 启动入口，加载 config/basic，并启动 lazy.nvim
├── lua/config-example.lua     # 本地配置模板
├── lua/config.lua             # 本地配置，Git 忽略
├── lua/basic/                 # 基础配置：options、keymaps、commands、autocmds
├── lua/plugins/               # lazy.nvim 插件声明
├── lua/plugin-configs/        # 各插件的具体配置
└── lua/functions.lua          # 常用功能函数，如切换 option、重载 config.lua
```

## 配置入口

本配置最重要的入口是 `lua/config.lua`。

它负责：

- 统一管理插件开关
- 控制 LSP、Treesitter、Copilot 等可选能力
- 让本地个性化调整和仓库默认模板分离

首次使用时可以直接复制模板：

```bash
cp lua/config-example.lua lua/config.lua
```

## 插件开关

示例配置见 `lua/config-example.lua`，默认开关如下：

| 配置项 | 默认值 | 说明 |
| --- | --- | --- |
| `cmp.enabled` | `true` | 补全系统 `nvim-cmp` |
| `trouble.enabled` | `true` | 诊断/符号列表 |
| `lsp.enabled` | `false` | 原生 LSP 主开关 |
| `lsp.mason` | `true` | LSP Server 安装管理 |
| `lsp.saga` | `true` | LSP UI 增强 |
| `lsp.none_ls` | `true` | formatter / diagnostics / code actions |
| `lsp.fidget` | `true` | LSP 进度提示 |
| `lsp.signature` | `true` | 签名提示 |
| `lsp.navic` | `true` | 面包屑导航 |
| `treesitter.enabled` | `false` | Treesitter 主开关 |
| `treesitter.autotag` | `true` | 自动闭合标签 |
| `treesitter.endwise` | `true` | 自动补全 end |
| `copilot.enabled` | `false` | GitHub Copilot |
| `copilot.cmp` | `true` | Copilot 接入 cmp |
| `alpha.enabled` | `true` | Dashboard |
| `auto_session.enabled` | `true` | 会话管理 |
| `autopairs.enabled` | `true` | 自动补全括号 |
| `bufferline.enabled` | `true` | Buffer 标签栏 |
| `colorscheme.enabled` | `true` | 主题 |
| `comment.enabled` | `true` | 注释 |
| `gitsigns.enabled` | `true` | Git 边栏标记 |
| `hop.enabled` | `true` | 快速跳转 |
| `indent_blankline.enabled` | `true` | 缩进辅助线 |
| `lazydev.enabled` | `true` | Lua 开发增强 |
| `lualine.enabled` | `true` | 状态栏 |
| `mini_icons.enabled` | `true` | 图标支持 |
| `neoscroll.enabled` | `true` | 平滑滚动 |
| `notify.enabled` | `true` | 通知增强 |
| `nvimtree.enabled` | `true` | 文件树 |
| `rust.enabled` | `true` | Rust 语法/工具支持 |
| `surround.enabled` | `true` | 包围符编辑 |
| `telescope.enabled` | `true` | 模糊搜索 |
| `toggleterm.enabled` | `true` | 终端集成 |
| `whichkey.enabled` | `true` | 快捷键提示 |

建议：

- 想启用语言开发能力时，先把 `lsp.enabled = true`
- 想启用语法高亮和结构解析增强时，再把 `treesitter.enabled = true`
- `copilot` 默认关闭，按需开启

## config.lua 热重载

常用操作：

- `,cp`：快速打开 `lua/config.lua`
- 保存 `lua/config.lua`：自动重新加载配置

当前热重载策略是保守模式：

- 会重新执行 `lua/config.lua`
- 会重新解析 lazy 的 plugin spec
- 会重新挂载新的 `keys` / `cmd` / `event` handler
- 新启用且 `lazy = false` 的插件会尽量立即加载
- 新关闭的插件，通常需要重启 Neovim 才能完全卸载

如果保存后看到类似下面的提示，属于预期行为：

```text
config.lua reloaded, restart Neovim if plugin switches did not fully apply
```

## 基础默认行为

基础配置位于 `lua/basic/`，主要行为如下：

- 使用系统剪贴板 `clipboard=unnamedplus`
- 行号、相对行号默认开启
- `wrap` 默认开启
- `splitbelow` / `splitright` 默认开启
- `list` 默认开启，并显示行尾、Tab、尾随空格
- `cursorline` 默认开启
- `undofile` 默认开启
- 搜索默认 `ignorecase + smartcase`

## 常用快捷键

所有 leader 快捷键都以 `,` 开头。启用 `which-key` 后，按下 `,` 会看到分组提示。

### 文件与搜索

| 快捷键 | 说明 |
| --- | --- |
| `,fe` | 打开/关闭 `nvim-tree` |
| `,fE` | 在 `nvim-tree` 中定位当前文件 |
| `,ff` | 查找文件 |
| `,fF` | 查找文件，带预览 |
| `,ft` | 全局文本搜索 |
| `,fb` | Buffer 列表 |
| `,fr` | 最近文件 |
| `,fc` | 命令列表 |

更多 Telescope 入口：

- `,tr`：寄存器
- `,tk`：快捷键列表
- `,th`：命令历史
- `,tc`：命令列表
- `,tm`：man pages
- `,tC`：主题切换
- `,tl`：恢复上次搜索
- `,t?`：帮助文档

### 配置与选项

| 快捷键 | 说明 |
| --- | --- |
| `,ow` | 切换自动换行 |
| `,or` | 切换相对行号 |
| `,ol` | 切换当前行高亮 |
| `,oc` | 切换当前列高亮 |
| `,os` | 切换拼写检查 |
| `,oi` | 切换 `nvim-tree` 的 gitignore 过滤 |
| `,oD` | 背景设为 dark |
| `,oL` | 背景设为 light |
| `,oh` | 切换搜索高亮 |

### 配置入口

| 快捷键 | 说明 |
| --- | --- |
| `,cp` | 打开 `lua/config.lua` |
| `,ce` | 打开 `init.lua` |
| `,ch` | 运行 `:checkhealth` |
| `,cd` | 打开 Dashboard |

### 保存与退出

| 快捷键 | 说明 |
| --- | --- |
| `,fw` | 保存全部 |
| `,fq` | 保存全部并退出 |
| `,fQ` | 强制退出，不保存 |

### Buffer 与窗口

| 快捷键 | 说明 |
| --- | --- |
| `,bn` | 下一个 Buffer |
| `,bp` / `,bb` | 上一个 Buffer |
| `,bd` | 关闭当前 Buffer |
| `,bo` | 关闭其他 Buffer |
| `,bc` | 选择要关闭的 Buffer |
| `,bj` | 选择要跳转的 Buffer |
| `,wh` `,wj` `,wk` `,wl` | 窗口跳转 |
| `,w-` | 水平分屏 |
| `,w|` | 垂直分屏 |
| `,wq` | 关闭当前窗口 |
| `<C-h/j/k/l>` | 普通模式下窗口跳转 |
| `<Up/Down/Left/Right>` | 调整窗口大小 |

### Git

| 快捷键 | 说明 |
| --- | --- |
| `,gj` / `,gk` | 上一个 / 下一个 hunk |
| `,gp` | 预览 hunk |
| `,gr` | 重置 hunk |
| `,gR` | 重置整个 Buffer |
| `,gs` | 暂存 hunk |
| `,gu` | 取消暂存 hunk |
| `,go` | Telescope 查看变更文件 |
| `,gb` | 切换分支 |
| `,gc` | 查看提交 |
| `,gg` | 打开 `lazygit` |

### 终端

| 快捷键 | 说明 |
| --- | --- |
| `<C-t>` | 打开/关闭终端 |
| `,Tt` | 浮动终端 |
| `,Th` | 水平终端 |
| `,Tv` | 垂直终端 |

终端模式下：

- `jk`：退出到普通模式
- `<C-h/j/k/l>`：在终端窗口之间跳转

### 搜索增强与辅助

| 快捷键 | 说明 |
| --- | --- |
| `gw` | Hop 按单词跳转 |
| `gl` | Hop 按行跳转 |
| `gp` | Hop 按模式跳转 |
| `,/` | 注释当前行或选中区域 |
| `,xx` | Trouble 诊断列表 |
| `,xX` | 当前 Buffer 诊断列表 |
| `,xl` | Location List |
| `,xq` | Quickfix List |
| `,xs` | Symbols |

### 会话

| 快捷键 | 说明 |
| --- | --- |
| `,a` | 搜索并切换会话 |

说明：

- `auto-session` 本身不依赖 `telescope`
- 如果启用了 `telescope`，会自动加载 `session-lens`，体验更好

### LSP

LSP 默认关闭；启用后可使用下面两类快捷键。

leader 菜单：

| 快捷键 | 说明 |
| --- | --- |
| `,la` | Code Action |
| `,lf` | 跳转定义 / Finder |
| `,li` | LSP 信息 |
| `,lj` / `,lk` | 下一个 / 上一个诊断 |
| `,ll` | CodeLens |
| `,lo` | 文档大纲 |
| `,lq` | 诊断写入 loclist |
| `,lr` | 重命名 |
| `,lR` | References |
| `,ls` | 文档符号 |
| `,lS` | 工作区符号，需要 `telescope` |
| `,lI` | 打开 `Mason` |

Buffer 内常用键：

| 快捷键 | 说明 |
| --- | --- |
| `gd` | definition |
| `gD` | declaration |
| `gI` | implementation |
| `gy` | type definition |
| `gr` | references |
| `K` | hover |
| `gf` | format |
| `gl` | 当前行诊断 |

说明：

- 启用 LSP 后会默认开启保存前格式化
- 配置中默认会启用 `rust_analyzer`、`pyright`、`ts_ls`、`gopls`、`lua_ls`、`html`、`cssls`、`jsonls`、`bashls`、`solc`、`emmet_ls`
- 如果同时开启 `lsp.mason = true`，会由 `mason.nvim` 自动安装这些 server

## nvim-tree 使用说明

默认行为：

- 默认显示 `.gitignore` 文件
- 默认跟随当前文件更新根目录

全局快捷键：

- `,fe`：打开/关闭文件树
- `,fE`：在文件树中定位当前文件
- `,oi`：切换是否隐藏 `.gitignore` 文件

进入文件树后，常用按键：

- `H`：切换 dotfiles 显示
- `I`：切换 gitignore 过滤
- `a`：新建文件
- `d`：删除
- `r`：重命名
- `v`：垂直分屏打开
- `?`：帮助

## 内置命令

基础命令位于 `lua/basic/commands.lua`。

| 命令 | 说明 |
| --- | --- |
| `:JsonFormat` | 使用 `python3 -m json.tool` 格式化当前 JSON |
| `:W` | 以 sudo 写入当前文件 |
| `:Wq` | 以 sudo 写入并退出 |
| `:Pure` | 关闭行号、列表字符和缩进线，方便复制 |
| `:Unpure` | 恢复普通显示 |
| `:Push` | 调用外部 `share push` |
| `:Pull` | 调用外部 `share pull` |

说明：

- `:Push` / `:Pull` 依赖你本地安装了 `share` 命令

## 可选能力与外部依赖

### none-ls

当 `PLUGINS.lsp.none_ls = true` 且 `PLUGINS.lsp.enabled = true` 时，会尝试启用以下能力：

- `prettierd`
- `shfmt`
- `black`
- `isort`
- `stylua`
- `write_good`
- `selene`

这些工具需要你自行安装，否则对应 source 会不可用。

### Treesitter

当 `PLUGINS.treesitter.enabled = true` 时，会启用：

- `nvim-treesitter`
- `nvim-treesitter-endwise`
- `nvim-ts-autotag`

首次安装和更新会触发 `:TSUpdate`。

### Copilot

当 `PLUGINS.copilot.enabled = true` 时，会启用：

- `copilot.lua`
- 如果 `PLUGINS.copilot.cmp = true` 且 `cmp` 开启，还会启用 `copilot-cmp`

如需代理，可在 `lua/config.lua` 中设置：

```lua
copilot = {
    enabled = true,
    cmp = true,
    http_proxy = "http://127.0.0.1:7890",
},
```

## 常见工作流

### 1. 日常编辑

- 打开 Neovim
- 按 `,` 查看 `which-key` 菜单
- 用 `,ff` / `,ft` 搜索文件和文本
- 用 `,fe` 或 `,fE` 配合文件树浏览项目

### 2. 调整插件开关

- 按 `,cp` 打开 `lua/config.lua`
- 修改对应 `enabled` 开关
- 保存文件，等待自动重载
- 如果关闭的是已加载插件，按提示重启 Neovim

### 3. 启用开发环境

- 在 `lua/config.lua` 中把 `lsp.enabled = true`
- 如需 Treesitter，再把 `treesitter.enabled = true`
- 重启 Neovim 或保存后观察提示
- 使用 `,lI` 打开 `Mason` 检查语言服务器安装情况

### 4. 管理插件

- `,ps`：`Lazy sync`
- `,pl`：查看 `Lazy log`
- `,pp`：查看插件详情
- `,pb`：执行插件 build

## 新增插件

如果要往这套配置里新增插件，推荐保持现有结构：

1. 在 `lua/plugins/` 下新增插件声明文件，例如 `lua/plugins/foo.lua`
2. 在 `lua/plugin-configs/` 下新增对应配置，例如 `lua/plugin-configs/foo/init.lua`
3. 如果希望通过本地配置控制开关，在 `lua/config-example.lua` 和本地 `lua/config.lua` 中加入 `PLUGINS.foo.enabled`
4. 在插件声明中使用 `enabled` / `cond` 读取 `PLUGINS.foo.enabled`

## 说明

- 这套配置以本地可裁剪为优先，不追求“全家桶强绑定”
- `config.lua` 是本地层，适合做插件开关、代理、个人偏好等不应提交到仓库的内容
- 如果你修改了 `lua/plugins/` 或 `lua/plugin-configs/` 本身，建议手动重启一次 Neovim，避免对热重载能力产生过高预期
