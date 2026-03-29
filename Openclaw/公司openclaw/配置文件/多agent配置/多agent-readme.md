README.md 完整内容：

# 多Agent系统架构说明

## 🏗️ 架构概览

┌─────────────────┐

│ 用户（龙虾） │

└────────┬────────┘

│

┌────────▼────────┐

│ 小虾（主控） │

│ Coordinator │

└────────┬────────┘

│

┌────────────────────┼────────────────────┐

│ │ │

┌───────▼───────┐ ┌───────▼───────┐ ┌───────▼───────┐  
│ 情报搜集专家 │ │ 报告撰写专家 │ │ 化学合成专家 │  
│ Intelligence │ │ Report Writer │ │ Chemistry │  
│ Gatherer │ │ & Reviewer │ │ Expert │  
└───────┬───────┘ └───────┬───────┘ └───────┬───────┘  
│ │ │  
└────────────────────┼────────────────────┘  
│  
┌────────▼────────┐  
│ 最终报告输出 │  
└─────────────────┘  
  
【技能共享池 - 所有Agent共享22个技能】  
├─ 信息检索类: tavily-search, tavily-research, tavily-extract, tavily-crawl  
├─ 飞书生态类: feishu-lark, feishu-doc, feishu-drive, feishu-chat-analyzer, ...  
├─ 文档处理类: pdf-to-markdown, paddleocr-text-recognition, mistral-ocr  
├─ 开发工具类: github-cli, docker-best-practices, trello  
└─ 核心能力类: find-skills, self-improving-agent, proactive-agent, ...

---

## 📋 Agent职责

| Agent | 职责 | 输入 | 输出 |

|-------|------|------|------|

| **小虾（主控）** | 任务分发、结果汇总、用户交互 | 用户指令 | 最终报告 |

| **情报搜集专家** | 全网搜索、信源验证、初步筛选 | 主题/关键词 | 结构化情报数据 |

| **报告撰写专家** | 报告生成、质量审核、格式标准化 | 情报数据 | Executive Briefing报告 |

| **化学合成专家** | 合成路线分析、工艺评估、专利规避 | 化学/药物情报 | 技术评估报告 |

---

## 🔧 技能共享机制

### 全技能访问策略

本多Agent系统采用**全技能共享**策略，所有Agent均可访问全部22个已安装技能。

**设计理念：**

- **灵活性**：Agent可根据任务需求调用任意技能，不受限于预设技能集

- **效率性**：避免重复安装相同技能，节省资源

- **扩展性**：新增技能自动对所有Agent可用

### 技能分类

| 类别 | 技能列表 | 主要使用者 |

|------|----------|-----------|

| **信息检索** | tavily-search, tavily-research, tavily-extract, tavily-crawl | 情报搜集专家 |

| **飞书生态** | feishu-lark, feishu-doc, feishu-drive, feishu-chat-analyzer, feishu-reply-enhanced, feishu-permission-kb, feishu-message-inspector, 王涛-群消息-汇总 | 报告撰写专家 |

| **文档处理** | pdf-to-markdown, paddleocr-text-recognition, mistral-ocr, lobster-daily-briefing | 报告撰写专家 |

| **开发工具** | github-cli, docker-best-practices, trello | 所有Agent |

| **核心能力** | find-skills, self-improving-agent, proactive-agent | 所有Agent |

### 技能使用建议

虽然所有Agent共享全部技能，但建议：

- **情报搜集专家** 主要使用信息检索类技能

- **报告撰写专家** 主要使用飞书生态和文档处理类技能

- **化学合成专家** 主要使用研究搜索和文档处理类技能

**跨领域调用示例：**

情报搜集专家 → 发现化学专利 → 调用 paddleocr-text-recognition 提取专利PDF文字  
化学合成专家 → 需要群聊讨论 → 调用 feishu-lark 发送消息  
报告撰写专家 → 需要搜索验证 → 调用 tavily-research 深度研究

---

## 🔄 工作流程

### 标准情报工作流

┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐  
│ 开始 │────▶│ 情报搜集 │────▶│ 化学评估 │────▶│ 报告撰写 │  
│ │ │ (30min) │ │ (20min) │ │ (15min) │  
└──────────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘  
│ │ │  
▼ ▼ ▼  
┌──────────┐ ┌──────────┐ ┌──────────┐  
│ 原始数据 │ │ 技术分析 │ │ 最终报告 │  
│ JSON格式 │ │ JSON格式 │ │ MD格式 │  
└──────────┘ └──────────┘ └──────────┘

### 工作流触发条件

1. **手动触发**：用户发送指令

- "生成今日AI情报日报"

- "分析这个药物合成路线"

2. **定时触发**：通过HEARTBEAT或Cron

- 09:00 - AI情报日报

- 18:00 - 呼吸药情报日报

3. **事件触发**：检测到高优先级情报

- P0级别突发新闻

- 交叉领域重大进展

---

## 📁 文件结构

~/.openclaw/agents/  
├── config.yaml # 主配置文件  
├── multi-agent.sh # 启动脚本  
│  
├── intelligence-gatherer/ # 情报搜集Agent  
│ └── SOUL.md  
│  
├── report-writer/ # 报告撰写Agent  
│ └── SOUL.md  
│  
└── chemistry-expert/ # 化学合成Agent  
└── SOUL.md

---

## 🚀 使用方式

### 命令行操作

```bash

# 检查所有Agent状态

~/.openclaw/agents/multi-agent.sh check

# 执行AI情报日报

~/.openclaw/agents/multi-agent.sh ai-daily

# 执行呼吸药情报工作流（含化学分析）

~/.openclaw/agents/multi-agent.sh pharma-daily

# 自定义主题

~/.openclaw/agents/multi-agent.sh custom

# 查看配置

~/.openclaw/agents/multi-agent.sh config

# 交互式菜单

~/.openclaw/agents/multi-agent.sh

通过小虾（主控Agent）调用

直接发送指令：  

- "启动AI情报工作流"
    

- "执行呼吸药日报"
    

- "分析XX药物的合成路线"
    

⚙️ 配置说明

配置文件：config.yaml

_# Agent基本配置_

agents:

- id: intelligence-gatherer

name: "情报搜集专家"

role: "信息搜集"

skills: ["search", "research", "extract", "crawl"]

- id: report-writer

name: "报告撰写专家"

role: "报告生成"

skills: ["feishu-doc", "pdf-to-markdown"]

- id: chemistry-expert

name: "化学合成专家"

role: "技术评估"

skills: ["research", "web_search"]

_# 定时任务_

cron:

- name: "AI情报日报"

schedule: "0 9 * * *"

- name: "呼吸药情报日报"

schedule: "0 18 * * *"

🔧 扩展计划

阶段1（已完成）

- ✅ 3个专业Agent配置
    

- ✅ 标准情报工作流
    

- ✅ 定时任务配置
    

阶段2（待实施）

- ⏳ 通过sessions_spawn真正实现Agent隔离
    

- ⏳ Agent间状态同步机制
    

- ⏳ 工作流可视化监控
    

阶段3（规划中）

- ⏳ 更多专业Agent（法律、财务、市场）
    

- ⏳ 动态Agent调度
    

- ⏳ 学习优化（根据历史反馈调整工作流）
    

📞 技术支持

有问题请联系：小虾（龙虾的专属AI情报官）  
  
多Agent系统，协同创造更高价值。