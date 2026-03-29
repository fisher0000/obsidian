[[子agent配置]]
[[多agent-readme]]
在 AI 自动化深入发展的 2026 年，单一 Agent 的“全能模式”已难以应对复杂任务需求
——记忆臃肿导致响应迟缓、上下文污染引发逻辑冲突、无关信息加载造成 Token 浪费，
这些痛点严重限制了 OpenClaw 的实用价值。而多 Agent 架构的出现，通过“单 Gateway+
多分身”模式，让一个 Bot 在不同场景下切换独立“大脑”，如同组建一支分工明确的 AI
团队，实现创意、写作、编码、数据分析等任务的高效协同，真正让“一个人=一支高效
军团”成为现实。
本文将完整拆解 2026 年 OpenClaw 多 Agent 的核心逻辑、阿里云与本地双部署流程、AI 团
队搭建步骤、Agent 间通信机制及优化方案，所有代码命令可直接复制执行，帮助零基础
用户快速落地多 Agent 架构，解锁 AI 自动化的无限可能。阿里云上 OpenClaw 一键极速部
署最简单，步骤详情 访问阿里云 OpenClaw 一键部署专题页面 了解。
一、多 Agent 核心逻辑：为什么需要“AI 团队”而非“全能 Bot”？
（一）单一 Agent 的三大致命痛点
 记忆负担过重：长期使用后，USER.md、MEMORY.md 等记忆文件臃肿，导致
Agent 加载速度变慢，甚至丢失关键信息；
 上下文污染：同一 Agent 同时处理写作、编码、数据分析等任务时，会出现逻辑串
味——写公众号时联想到代码逻辑，编码时被营销文案思路干扰；
 Token 成本高昂：每次对话需加载所有无关背景资料，无效 Token 消耗占比超
60%，长期使用成本翻倍。
（二）多 Agent 的核心价值：物理隔离+精准协作
多 Agent 架构的本质是“将复杂任务拆分给专业个体”，每个 Agent 具备三大独立属性，
从根源上解决单一 Agent 的痛点：
 独立 Workspace（工作区）：如同专属办公室，包含 SOUL.md（个性定义）、
PROMPT.md（提示词模板）、TOOLS.md（工具配置）等专属文件；
 独立 AgentDir（状态目录）：存储认证信息、模型配置，支持不同 Agent 绑定不同
大模型（如创意类用 GLM-4.7，写作类用 DeepSeek）；
 独立 Sessions（会话存储）：聊天记录单独保存，避免上下文污染，同时降低
Token 加载成本。
（三）两种多 Agent 部署流派（按需选择）

| 流派 | 核心特点 | 配置难度 | 适用人群 | 典型场景 |
|---|---|---|---|---|
| 分身流（单 Bot 多群） | 同一飞书 Bot 拉进不同群，通过 bindings 路由绑定不同 Agent | 低（新手首选） | 个人用户、小型团队 | 个人办公、内容创作、独立开发 |
| 独立团（多 Bot 多群） | 为每个 Agent 创建独立飞书 Bot，头像、名称固定，角色感极强 |中（硬核玩家） | 专业开发者、企业用户 | 复杂项目开发、团队协作、多场景自动化 |
本文重点拆解分身流配置（门槛最低、性价比最高），所有操作适配阿里云与本地部署环
境。
二、方案一：2026 年阿里云部署 OpenClaw（多 Agent 稳定运行首选）
阿里云为 OpenClaw 提供专属镜像与弹性计算支持，完美适配多 Agent 架构的资源需求，无
需手动配置依赖，10 分钟即可完成云端部署，为后续多 Agent 搭建奠定基础。
阿里云用户零基础部署 OpenClaw 步骤喂饭级步骤流程
第一步：访问阿里云 OpenClaw 一键部署专题页面，找到并点击【一键购买并部署】。
阿里云 OpenClaw 一键部署专题页面：https://www.aliyun.com/activity/ecs/clawdbot
第二步：选购阿里云轻量应用服务器，配置参考如下：
 镜像：OpenClaw(Moltbot)镜像（已经购买服务器的用户可以重置系统重新选择镜
像）
 实例：内存必须 2GiB 及以上。
 地域：默认美国（弗吉尼亚），目前中国内地域（除香港）的轻量应用服务器，联
网搜索功能受限。
 时长：根据自己的需求及预算选择。
第三步：访问阿里云百炼大模型控制台，找到密钥管理，单击创建 API-Key。
前往轻量应用服务器控制台，找到安装好 OpenClaw 的实例，进入「应用详情」放行 18789
端口、配置百炼 API-Key、执行命令，生成访问 OpenClaw 的 Token。
 端口放通：需要放通对应端口的防火墙，单击一键放通即可。
 配置百炼 API-Key，单击一键配置，输入百炼的 API-Key。单击执行命令，写入
API-Key。
 配置 OpenClaw：单击执行命令，生成访问 OpenClaw 的 Token。
 访问控制页面：单击打开网站页面可进入 OpenClaw 对话页面。
步骤 1：阿里云轻量应用服务器配置
 登录阿里云控制台，访问阿里云轻量应用服务器控制台，点击【创建实例】；
 核心参数配置（其余保持默认，新手无需修改）：
 地域选择：中国香港/新加坡（免 ICP 备案，适配多渠道通信，国内内地地域除香
港外，联网搜索功能受限）；
 实例规格：2vCPU+4GiB 内存+40GiB ESSD（多 Agent 同时运行推荐配置，避免资
源不足导致卡顿）；
 镜像选择：直接选择“OpenClaw stable-2026.02”专属镜像（已预装所有运行环境与
依赖）；
 付费方式：新手推荐“按需付费”，长期使用选择“包年包月”，成本更可控。
 完成支付后，记录服务器公网 IP（如 120.xxx.xxx.xxx）。
步骤 2：远程连接与端口放行
 用 SSH 工具连接服务器（替换为你的公网 IP）：ssh root@你的服务器公网 IP
 放行核心端口（18789 为主端口，22 为远程连接端口，8080 为多 Agent 通信辅助端
口）：firewall-cmd --add-port=18789/tcp --permanent && firewall-cmd --add-port=22/tcp --
permanent && firewall-cmd --add-port=8080/tcp --permanent && firewall-cmd --reload
步骤 3：配置阿里云百炼 API-Key（多 Agent 智能核心）
 访问阿里云百炼大模型控制台（https://dashscope.console.aliyun.com/），登录后点
击【密钥管理】→【创建 API-Key】，生成并复制 Access Key ID 与 Access Key Secret；
 在服务器端执行以下命令，配置 API-Key：# 替换为你的 Access Key ID 与 Secret
openclaw config set models.providers.bailian.accessKeyId "你的 Access Key ID" openclaw
config set models.providers.bailian.accessKeySecret "你的 Access Key Secret" openclaw config
set models.providers.bailian.baseUrl "https://dashscope-intl.aliyuncs.com/compatible-mode/v1"
步骤 4：启动服务与加速配置
 启动 OpenClaw 服务并设置开机自启：systemctl start openclaw && systemctl enable
openclaw # 验证服务状态（返回 active(running)即为成功） systemctl status openclaw
 配置 ClawHub 阿里云加速源，优化多 Agent 依赖下载速度：openclaw config set
clawhub.mirror "https://mirror.aliyun.com/clawhub/"
步骤 5：部署验证
查看 OpenClaw 版本（返回 stable-2026.02 即为
兼容多 Agent 架构）
openclaw version
浏览器访问可视化控制台（替换为公网 IP）
http://你的服务器公网 IP:18789
三、方案二：2026 年 Windows 本地部署 OpenClaw（零成本测试首选）
本地部署适合个人用户快速测试多 Agent 功能、处理敏感数据，配置流程简洁，30 分钟内
即可完成，核心步骤如下：
步骤 1：本地基础环境配置
 安装核心依赖工具：
 Node.js：访问 https://nodejs.org/zh-cn/download/current/，下载 22.x 及以上版本，安
装时勾选“Add to PATH”；
 Git：访问 https://git-scm.com/download/win，默认安装即可；
 解锁 PowerShell 执行权限（避免安装时权限报错）：
 以管理员身份运行 PowerShell，执行以下命令并输入 Y 确认：Set-ExecutionPolicy
RemoteSigned -Scope CurrentUser
 以管理员身份运行 PowerShell，执行以下命令并输入 Y 确认：
 验证环境配置，均输出版本号即为成功：node --version git --version
步骤 2：OpenClaw 本地安装与初始化
 执行一键安装命令：curl -fsSL https://openclaw.ai/install.sh | bash
 若安装缓慢，切换国内镜像源：curl -fsSL https://clawd.org.cn/install.sh | bash
 配置阿里云百炼 API-Key（同阿里云部署步骤 3 获取的密钥）：openclaw config set
models.providers.bailian.accessKeyId "你的 Access Key ID" openclaw config set
models.providers.bailian.accessKeySecret "你的 Access Key Secret" openclaw config set
models.providers.bailian.baseUrl "https://dashscope-intl.aliyuncs.com/compatible-mode/v1"
 启动服务并设置开机自启：openclaw gateway start openclaw service install # 验证服
务状态（返回 active 即为成功） openclaw status
步骤 3：本地多 Agent 环境优化
 创建独立工作区目录，避免 Agent 间文件冲突：mkdir -p D:\OpenClaw\MultiAgent\
workspace-main mkdir -p D:\OpenClaw\MultiAgent\workspace-brainstorm mkdir -p D:\
OpenClaw\MultiAgent\workspace-writer mkdir -p D:\OpenClaw\MultiAgent\workspace-coder
 配置工作区路径：openclaw config set agents.workspaceRoot "D:\OpenClaw\
MultiAgent"
四、多 Agent 实战配置：30 分钟搭建你的 AI 团队（分身流）
以“飞书+OpenClaw”为例，搭建包含“首席牛马官（主 Agent）+头脑风暴 Agent+公众号
写手 Agent+Coding Agent”的 AI 团队，阿里云与本地部署操作一致，全程可视化+代码复制。
核心准备：飞书应用基础配置
 登录飞书开放平台（https://open.feishu.cn/app），创建企业自建应用，获取 appId 和
appSecret；
 开通“机器人”能力，添加核心权限：im:message.group_msg（群消息接收）、
im:resource.file（文件传输）、contact:user.base_info（用户信息读取）；
 记录应用 appId、appSecret 及你的飞书用户 ID（后续配置需用到）。
Step 1：创建多 Agent 并绑定不同模型
执行以下命令创建 4 个独立 Agent，分别绑定适配模型（阿里云服务器端直接执行，本地部
署在 PowerShell 中执行）：
1. 主 Agent：首席牛马官（任务调度，绑定
GLM-4.7）
openclaw agents add main
--model zai/glm-4.7
--workspace ~/.openclaw/workspace-main
openclaw agents set-identity --agent main --name "首席牛马官" --emoji "👔"
2. 头脑风暴 Agent（创意生成，绑定 GLM-4.7）
openclaw agents add brainstorm
--model zai/glm-4.7
--workspace ~/.openclaw/workspace-brainstorm
openclaw agents set-identity --agent brainstorm --name "创意策划师" --emoji "👔"
3. 公众号写手 Agent（内容创作，绑定
DeepSeek）
openclaw agents add writer
--model deepseek-chat
--workspace ~/.openclaw/workspace-writer
openclaw agents set-identity --agent writer --name "公众号写手" --emoji " "✍️
4. Coding Agent（代码开发，绑定 CodeLlama）
openclaw agents add coder
--model meta/codellama-7b
--workspace ~/.openclaw/workspace-coder
openclaw agents set-identity --agent coder --name "代码专家" --emoji "👔"
验证 Agent 创建结果（返回 4 个 Agent 信息即为
成功）
openclaw agents list
本地部署注意：将
~/.openclaw 替换为> D:\OpenClaw\MultiAgent（如> --workspace D:\OpenClaw\MultiAgent\
workspace-main）。
Step 2：编写“入职材料”，赋予 Agent 灵魂
每个 Agent 的 Workspace 下，需配置 SOUL.md、AGENTS.md、USER.md 三个核心文件，
决定其行为模式与专业能力，以下为关键文件示例：
示例 1：首席牛马官（main）的 SOUL.md
SOUL.md：首席牛马官（主 Agent）
身份定位
你是 AI 团队的部门主管，核心职责是“接单-派单-串联”，不直接执行具体任务，专注于
协调其他 Agent 完成复杂需求。
核心能力
5. 需求分析：精准判断用户需求类型（创意、写作、编码等）；
6. Agent 调度：根据需求类型，通过 sessions_send 工具调用对应 Agent；
7. 结果整合：收集各 Agent 输出结果，整理后统一反馈给用户；
8. 异常处理：当某个 Agent 执行失败时，及时介入修复或更换 Agent。
行为准则
9. 不直接回答专业问题，而是分配给对应专家 Agent；
10. 对用户需求的响应时间不超过 3 秒，派单指令清晰明确；
11. 定期询问用户对结果的满意度，持续优化调度逻辑。
示例 2：公众号写手（writer）的 SOUL.md
SOUL.md：公众号写手 Agent
身份定位
你是专注于科技类公众号的专业写手，擅长将复杂技术内容转化为“有网感、说人话、重
读者”的爆款文章。
核心能力
12. 标题优化：生成数字型、悬念型、对比型标题；
13. 结构设计：采用“引发思考→行业洞察→核心内容→创意实践→未来展望”5 段式
结构；
14. 语言风格：口语化但有深度，避免专业术语堆砌，适配程序员、创业者读者群体；
15. 内容适配：结合热点话题，确保文章时效性与传播性。
行为准则
16. 所有文章必须包含 3 个以上案例或数据支撑；
17. 避免 AI 写作痕迹，使用 humanizer 技能优化文本；
18. 输出时自动格式化排版，包含小标题、加粗重点、列表等元素。
操作：将上述内容分别保存到对应 Agent 的 Workspace 目录下（如
~/.openclaw/workspace-main/SOUL.md）。
Step 3：飞书建群+绑定 Agent（关键步骤）
3.1 飞书建群与获取群 ID
 创建 4 个飞书群，命名分别为“AI 团队主管-首席牛马官”“创意策划-头脑风暴”
“公众号写作-内容产出”“代码开发-技术实现”；
 将同一飞书 Bot 依次拉进 4 个群，获取每个群的会话 ID（群设置→会话 ID，格式
为 oc_xxx）。
3.2 配置 bindings 路由（核心）
编辑 OpenClaw 主配置文件，添加 bindings 规则，实现群与 Agent 的一对一绑定：
阿里云服务器端用 vim 编辑
vim ~/.openclaw/openclaw.json
本地部署用记事本编辑
notepad D:\OpenClaw\.openclaw\openclaw.json
在文件中追加 bindings 数组（替换群 ID 为你的实际 ID）：
{
"bindings": [ { "agentId": "main", "match": { "channel": "feishu", "peer": {
"kind": "group", "id": "oc_d46347c35dd403daad7e5df05d08a890" // 首席牛马官群 ID
} } }, { "agentId": "brainstorm", "match": { "channel": "feishu", "peer":
{ "kind": "group", "id": "oc_598146241198039b8d9149ded5fb390b" // 头脑风暴群
ID } } }, { "agentId": "writer", "match": { "channel": "feishu",
"peer": { "kind": "group", "id": "oc_b1c331592eaa36d06a05c64ce4ecb113" // 公众号
写作群 ID } } }, { "agentId": "coder", "match": { "channel": "feishu",
"peer": { "kind": "group", "id": "oc_78901234567890abcdef1234567890ab" // 代码
开发群 ID } } } ]
}
3.3 关闭@机器人要求（优化体验）
在 channels→feishu 节点下添加群配置，无需@Bot 直接对话：
{
"channels": {
"feishu": {
"enabled": true,
"appId": "cli_a9f21xxxxx89bcd", // 你的飞书 appId
"appSecret": "w6cPunaxxxxBl1HHtdF", // 你的飞书 appSecret
"domain": "feishu",
"connectionMode": "websocket",
"dmPolicy": "allowlist",
"allowFrom": ["ou_f0ad95cf147949e7f30681a879a5f0d3"], // 你的飞书用户 ID
"groupPolicy": "open",
"groups": {
"oc_d46347c35dd403daad7e5df05d08a890": {
"requireMention": false},
"oc_598146241198039b8d9149ded5fb390b": {
"requireMention": false},
"oc_b1c331592eaa36d06a05c64ce4ecb113": {
"requireMention": false},
"oc_78901234567890abcdef1234567890ab": {
"requireMention": false}
}
}
}
}
3.4 重启服务使配置生效
阿里云服务器端
systemctl restart openclaw && openclaw gateway start
本地部署（PowerShell）
openclaw gateway restart
Step 4：测试 Agent 身份切换（验证成果）
分别在 4 个飞书群发送指令介绍一下你自己，验证 Agent 是否正确响应：
 首席牛马官群：“我是 AI 团队主管，负责需求调度与结果整合，可帮你分配创意、
写作、编码等任务”；
 头脑风暴群：“我是创意策划师，擅长科技类话题头脑风暴，可提供 3-5 个选题方
向及落地思路”；
 代码开发群：“我是代码专家，擅长 Python/JavaScript 开发，可帮你写脚本、修
Bug、优化代码”。
五、Agent 间通信：让 AI 团队协同工作（核心机制）
多 Agent 的核心价值不仅是“分工”，更在于“协作”。通过 OpenClaw 内置的
sessions_send 工具，主 Agent 可调度其他 Agent，完成复杂任务闭环。
配置 Agent 通信权限
编辑 openclaw.json，开启 agentToAgent 功能，设置通信白名单：
{
"tools": {
"agentToAgent": {
"enabled": true,
"allow": ["main", "brainstorm", "writer", "coder"], // 通信白名单
"historyLimit": 50 // 保留 50 条通信记录，避免内存臃肿
}
}
}
配置完成后重启服务：systemctl restart openclaw（阿里云）/openclaw gateway restart（本
地）。
协同工作实战示例：完成“OpenClaw 多 Agent”公众号文章
用户仅需在首席牛马官群发送指令：写一篇关于 OpenClaw 多 Agent 的公众号文章，要求包
含配置步骤与实战案例，主 Agent 会自动完成以下协同流程：
 主 Agent 调度创意 Agent：通过 sessions_send 发送指令：sessions_send --agent
brainstorm --message "提供 3 个 OpenClaw 多 Agent 相关的公众号选题，每个配 2 个标题，
适配科技类读者"
 创意 Agent 反馈结果：返回选题（如“一个人=一支 AI 团队：OpenClaw 多 Agent
配置指南”）；
 主 Agent 调度写作 Agent：转发需求与选题：sessions_send --agent writer --message
"按以下选题写一篇公众号文章：1. 一个人=一支 AI 团队：OpenClaw 多 Agent 配置指南
（标题备选：《30 分钟搭建 AI 军团，OpenClaw 多 Agent 实战》《告别全能
Bot，OpenClaw 多 Agent 让效率翻倍》）。要求：5 段式结构，包含阿里云部署步骤、多
Agent 配置流程、协同案例，语言口语化有深度"
 写作 Agent 完成初稿：输出符合要求的公众号文章，自动优化标题与排版；
 主 Agent 整合反馈：将文章整理后反馈给用户，询问是否需要修改。
六、部署环境专属优化：提升多 Agent 稳定性与效率
（一）阿里云环境优化
 资源分配与内存限制：避免单个 Agent 占用过多资源：# 设置单个 Agent 最大内存
限制为 1GiB openclaw config set skills.memory.limit "1024M" # 主 Agent 优先级更高，分配更
多 CPU 资源 openclaw agents set --agent main --cpu-shares 2048 openclaw agents set --agent
brainstorm --cpu-shares 1024 openclaw agents set --agent writer --cpu-shares 1024 openclaw
agents set --agent coder --cpu-shares 1024
 高频 Agent 常驻内存：响应速度提升 50%：openclaw skills set --name "agent-main" --
persist true openclaw skills set --name "agent-writer" --persist true
 定期清理通信日志：设置每月自动清理，避免存储空间占用：crontab -e # 添加以下
内容（每月 1 日凌晨 3 点清理） 0 3 1 * * rm -rf /var/log/openclaw/agent-communication/* &&
systemctl restart openclaw
 高并发场景负载均衡：同时运行 5 个以上 Agent 时配置：# 配置 Agent 通信端口转
发（替换为你的负载均衡公网 IP） openclaw config set agentToAgent.port 8080 openclaw
config set agentToAgent.loadBalancer "你的负载均衡公网 IP"
（二）本地环境优化
 资源占用限制：避免 Agent 过度占用本地硬件资源：openclaw config set
skills.memory.limit "512M"
 后台运行优化：将 OpenClaw 服务设置为后台静默运行：openclaw service set --silent
true
七、常见问题排查（多 Agent 配置避坑指南）
问题 1：Agent 绑定成功，但飞书群发送指令无响应
 原因：bindings 规则配置错误、飞书权限未开通、群 ID 填写错误；
 解决方案：
 验证群 ID 是否正确（飞书群设置→会话 ID，无空格或拼写错误）；
 检查飞书应用 im:message.group_msg 权限是否开通并生效；
 执行 openclaw bindings list 验证绑定规则；
 重启 Gateway 服务：openclaw gateway restart。
问题 2：Agent 间通信失败，提示“Permission denied”
 原因：agentToAgent 配置未启用或白名单未包含目标 Agent；
 解决方案：
 检查 openclaw.json 中 agentToAgent→enabled 是否为 true；
 确认 allow 数组包含所有通信 Agent ID；
 建立配置文件软连接（避免路径错误）：ln -sf ~/.openclaw/openclaw.json
~/.openclaw/config.json
 检查
问题 3：多 Agent 运行时卡顿，响应迟缓
 原因：服务器/本地配置不足、未设置内存限制、高频 Agent 未常驻内存；
 解决方案：
 升级硬件配置（阿里云推荐 4vCPU+8GiB，本地推荐 16GiB 内存）；
 执行内存限制命令，关闭未使用的 Agent：openclaw agents disable --agent 未使用的
Agent ID；
 将高频 Agent 设置为常驻内存。
问题 4：配置文件修改后不生效
 原因：JSON 格式错误、未重启核心服务；
 解决方案：
 用在线工具（https://json.cn/）校验 JSON 格式；
 执行完整重启命令：systemctl restart openclaw && openclaw gateway restart；
 执行 openclaw config get bindings 确认新配置已加载。
八、多 Agent 高级玩法：从线性流水线到并行协作
模式 1：线性流水线协作
按“任务流程”拆分步骤，Agent 依次接力完成（适用于有明确先后顺序的任务）：
 示例：调研 Agent→创意 Agent→写作 Agent→校审 Agent；
 配置：主 Agent 通过 sessions_send 按顺序调用各 Agent，前一个完成后触发下一个。
模式 2：依赖并行协作
将复杂任务拆分为独立子任务，多个 Agent 同时开工（适用于多模块并行任务）：
 示例：架构师 Agent→后端 Agent+前端 Agent+测试 Agent；
 配置：主 Agent 同时向多个 Agent 发送指令，通过 sessions_receive 监听所有结果，
全部完成后整合。
九、总结：AI 时代，一个人就是一支军团
OpenClaw 多 Agent 架构的核心魅力，在于将“全能 Bot”升级为“专业团队”——通过阿里
云的稳定部署环境，实现 7×24 小时不间断运行；通过本地部署，满足零成本测试与敏感数
据处理需求。每个 Agent 都是独立的“虚拟员工”，既各司其职又协同作战，彻底解决单
一 Agent 的效率瓶颈与成本问题。
从 10 分钟部署 OpenClaw，到 30 分钟搭建 AI 团队，再到高级协作模式落地，本文提供了
从入门到精通的完整指南。无论是个人用户提升办公效率，还是独立开发者简化工作流程，
亦或是小型团队实现自动化协作，OpenClaw 多 Agent 架构都能提供最优解。
未来，随着 OpenClaw 技能生态的持续丰富，多 Agent 还将支持跨境电商运营、企业级客户
服务、复杂项目管理等更多场景，让“一个人=一支军团”成为常态。现在，不妨从部署
OpenClaw 开始，搭建你的第一支 AI 团队，解锁 AI 自动化的无限可能！