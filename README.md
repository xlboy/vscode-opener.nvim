# vscode-opener.nvim

English | [简体中文](./README.zh.md)

Open current working area, buffers, etc. in VSCode

--- 

https://github.com/xlboy/vscode-opener.nvim/assets/63690944/06bc02be-1dd6-4e5a-acda-84747ddc02e5

## Features

- Open the current buffer in VSCode

- Open all buffers in VSCode

- Open the current working directory (cwd) in VSCode

## Installation

1. Use lazy
```lua
{ "xlboy/vscode-opener.nvim" }
```

## Configuration

> The purpose of setup is only to set the configuration
```lua
require('vscode-opener').setup({ ... }) -- See below↓for specific configuration parameters
```

Default configuration:
```lua
{
  notify = true, -- Whether or not to give related prompts after opening related content in VSCode
  -- The command to use when opening VSCode
  -- Possible values: "code" | "cursor"
  via = "code"
}
```

## How to use

###  Through shortcut keys

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

### Through the picker

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

## License
MIT
