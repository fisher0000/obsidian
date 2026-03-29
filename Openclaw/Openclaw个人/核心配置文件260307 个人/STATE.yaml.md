STATE.yaml

_# 龙虾项目管理中心_

_# 龙虾的自主项目管理_

project: lobster-intelligence _# 项目名称：龙虾情报系统_

created: 2026-03-05T15:00:00Z _# 创建时间_

updated: 2026-03-05T15:00:00Z _# 更新时间_

owner: 龙虾（王涛） _# 项目所有者_

_# 项目注册表 - 所有活跃项目_

projects:
- id: ai-intelligence _# 项目ID：AI情报_

name: AI科技情报监测 _# 项目名称_

pm: pm-ai-intel _# 项目经理_

status: active _# 状态：活跃_

priority: p0 _# 优先级：P0（最高）_

- id: pharma-intelligence _# 项目ID：医药情报_

name: 呼吸药情报监测 _# 项目名称_

pm: pm-pharma _# 项目经理_

status: active _# 状态：活跃_

priority: p0 _# 优先级：P0（最高）_

- id: investment-tracking _# 项目ID：投资跟踪_

name: 投资动态跟踪 _# 项目名称_

pm: pm-invest _# 项目经理_

status: pending _# 状态：待定_

priority: p1 _# 优先级：P1_

_# 活跃任务_

tasks:

_# AI科技情报任务_

- id: ai-daily-2026-03-05 _# 任务ID_

project: ai-intelligence _# 所属项目_

title: 今日AI科技日报 _# 任务标题_

status: pending _# 状态：待定_

owner: pm-ai-intel _# 负责人_

priority: p0 _# 优先级_

scheduled: "09:00" _# 定时：09:00_



_# 下一步行动_

next_actions:

- "pm-ai-intel: 启动今日AI情报搜集" _# AI项目经理行动_

- "pm-pharma: 检查今日临床数据发布" _# 医药项目经理行动_

- "xiaoxia: 等待虾总确认PM启动" _# 小虾行动_

_# 资源链接_

resources:

memory: ~/.openclaw/workspace/memory/ _# 记忆文件目录_

reports: ~/.openclaw/workspace/reports/ _# 报告输出目录_

skills: ~/.openclaw/skills/ _# 技能目录_