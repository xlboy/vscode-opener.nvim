# vscode-opener.nvim

[English](./README.md) | 简体中文

在 VSCode 打开当前工作区、缓冲区等

--- 

https://github.com/xlboy/vscode-opener.nvim/assets/63690944/06bc02be-1dd6-4e5a-acda-84747ddc02e5

## 功能

- 在 VSCode 中打开当前 buffer

- 在 VSCode 中打开所有 buffer

- 在 VSCode 中打开当前工作的目录（cwd）


## 安装

1. 使用 lazy
```lua
{ "xlboy/vscode-opener.nvim" }
```

## 配置

> setup 的作用仅单单是设置配置
```lua
require('vscode-opener').setup({ ... }) -- 具体配置参数请看下面↓
```

默认配置：
```lua
{
  notify = true, -- 在 VSCode 中打开相关内容后是否要做出相关提示
  -- 打开 VSCode 时使用的命令
  -- 可能的值: "code" | "cursor"
  via = "code"
}
```

## 如何使用

### 通过快捷键

Lazy:

```lua
{
  "xlboy/vscode-opener.nvim",
  keys = {
    {
      "<leader>vsw",
      "<cmd>lua require('vscode-opener').open_cwd()<CR>",
      desc = "Open Current Workspace in VSCode",
    },
    {
      "<leader>vsc",
      "<cmd>lua require('vscode-opener').open_current_buf()<CR>",
      desc = "Open Current Buffer in VSCode",
    },
    {
      "<leader>vse",
      "<cmd>lua require('vscode-opener').open_current_buf({ cwd = false })<CR>",
      desc = "Open Current Buffer in VSCode (No CWD)",
    },
    {
      "<leader>vsa",
      "<cmd>lua require('vscode-opener').open_all_bufs()<CR>",
      desc = "Open All Buffers in VSCode",
    },
  },
}
```

### 通过选择器

```lua
{
  "xlboy/vscode-opener.nvim",
  keys = {
    {
      "<leader>vsc",
      "<cmd>lua require('vscode-opener').open()<CR>",
      desc = "Open VSCode Opener Menu",
    },
  },
}
```

## 许可证
MIT
