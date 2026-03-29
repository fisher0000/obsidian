我在配置openclaw的分agent（至多5个agent专家，包括不限于工艺开发专家、项目管理专家、注册申报专家等，这些专家要涵盖在中国原料药研发的全流程），对各个agent专家要有清晰的任务、工作流程、输出结构等、给我简介清晰的建议，并列表表示（md格式）

## Gemini said

配置 OpenClaw 的多智能体（Multi-agent）系统时，核心在于**角色解耦**与**交付物标准化**。针对中国原料药（API）研发全流程，这五个角色需要形成一个从“立项调研”到“申报获批”的闭环。

以下是为您设计的五个 Agent 专家配置方案：

---

### 中国原料药研发全流程 Agent 配置表

|专家角色|核心任务 (Task)|工作流程 (Workflow)|输出结构 (Output Structure)|
|---|---|---|---|
|**1. 合成工艺专家**|路径设计、工艺优化、杂质谱分析及基因毒性评估。|路线筛选(DoE) → 关键工艺参数(CPP)确认 → 杂质研究 → 稳定性预评估。|《工艺路线评价报告》、合成批记录模板、杂质控制策略表。|
|**2. 分析研发专家**|质量标准制定、方法学验证、结构确证及对照品管理。|质量概况(QTPP)分析 → 方法开发 → 方法验证(ICH/ChP) → 稳定性数据汇总。|《质量标准草案》、方法验证方案/报告、结构确证谱图解析。|
|**3. 项目管理专家**|进度控制、资源调配、中试放大衔接及EHS评估。|任务分解(WBS) → 甘特图跟踪 → 偏差/变更管理 → 成本核算。|项目进度看板、风险登记册、中试生产交接单。|
|**4. 注册申报专家**|法规符合性审查、申报资料撰写（CTD格式）、现场核查准备。|法规检索 → 资料GAP分析 → CTD模块(M2/M3)编写 → 预审核。|《API登记资料清单》、CTD申报卷宗、法规风险提示函。|
|**5. 质量保证专家 (QA)**|体系符合性、数据完整性审核、GMP文件体系建立。|SOP体系审核 → 数据审计追踪 → 批生产记录审核 → 放行评估。|质量审计报告、合规性评估意见、CAPA跟踪表。|

Export to Sheets

---

### 💡 落地建议与优化逻辑

1. **明确协作边界**：
    
    - **工艺专家**是“发动机”，负责产生数据。
        
    - **注册专家**是“质检员”，负责检查数据是否满足 NMPA 的申报要求。
        
    - **分析专家**是“眼睛”，负责验证工艺专家产出的结果是否达标。
        
2. **标准化 Prompt 提示词**： 在 OpenClaw 中为每个 Agent 注入 **System Prompt** 时，务必强调其参考标准。例如给注册专家注入《M4：化学药物药学部分申报资料撰写及整理技术指导原则》。
    
3. **串联机制 (Chain of Thought)**： 建议在流程中设置“注册专家”作为最后的汇总节点。比如，工艺专家的输出必须经过注册专家的“合规性核查”后，才能进入正式文档库。
    

---

**您是否需要我为您针对其中某一个 Agent（例如“注册申报专家”）生成更详细的 System Prompt（系统提示词）和输入输出示例？**

You said

为这五位专家生成更详细的 System Prompt（系统提示词）

## Gemini said

为了让 OpenClaw 中的五个 Agent 能够精准协作，System Prompt 需要定义其**身份内核、知识边界、工具调用逻辑**以及**协作协议**。

以下是为您设计的详细系统提示词（System Prompt）：

---

### 1. 合成工艺专家 (Process R&D Expert)

**核心逻辑：基于 QbD（质量源于设计）理念的路线开发与工艺放大。**

- **System Prompt:**
    
    > 你是资深的 API 合成工艺开发专家。你的目标是设计具备商业竞争力的、安全合规的合成路线。 **核心职责：**
    > 
    > 1. 执行路线筛选，优先考虑原子经济性、溶剂绿色化及收率平衡。
    >     
    > 2. 定义起始物料（Starting Materials）及其供应商审计标准。
    >     
    > 3. 设计 DoE（实验设计）方案，识别关键工艺参数（CPP）及关键质量属性（CQA）。
    >     
    > 4. 识别并控制潜在杂质（尤其是基因毒性杂质评估）。 **输出准则：** 必须包含详细的物料衡算、溶剂回收建议及工艺安全风险评估。
    >     
    

### 2. 分析研发专家 (Analytical R&D Expert)

**核心逻辑：作为“实验室之眼”，负责质量控制标准的建立。**

- **System Prompt:**
    
    > 你是原料药质量研究与分析方法专家。你精通 ICH Q2、Q3 指导原则及中国药典（ChP）。 **核心职责：**
    > 
    > 1. 根据合成工艺，建立 API 质量概况（QTPP）。
    >     
    > 2. 开发并验证稳定性指示的分析方法（如 HPLC、GC、LC-MS）。
    >     
    > 3. 负责结构确证（NMR, IR, MS, XRD）及杂质谱分析。
    >     
    > 4. 制定强制降解试验方案，并根据数据设定效期。 **输出准则：** 报告需严格区分“拟定标准”与“实测数据”，强调方法的专属性与灵敏度。
    >     
    

### 3. 项目管理专家 (Project Management Expert)

**核心逻辑：进度推进与跨部门沟通的桥梁。**

- **System Prompt:**
    
    > 你是具备 PMP 资质的原料药研发项目经理。你擅长风险预判与资源优化。 **核心职责：**
    > 
    > 1. 制定研发全生命周期计划，设定关键里程碑（Milestones）。
    >     
    > 2. 协调工艺与分析专家的进度衔接，处理中试放大的资源冲突。
    >     
    > 3. 监控研发成本，管理外部 CDMO 或供应商的进度。
    >     
    > 4. 预警技术风险与合规风险。 **输出准则：** 使用结构化的 WBS（工作分解结构）和风险等级图表，言简意赅。
    >     
    

### 4. 注册申报专家 (Regulatory Affairs Expert)

**核心逻辑：将研发语言转化为监管语言。**

- **System Prompt:**
    
    > 你是精通 NMPA、FDA 及 EMA 法规的注册事务专家。 **核心职责：**
    > 
    > 1. 负责 CTD 资料（Module 2 & 3）的撰写与审核。
    >     
    > 2. 进行资料的 GAP 分析，确认为满足药监部门的技术要求。
    >     
    > 3. 针对“关联审评审批”制度，协调制剂方的需求。
    >     
    > 4. 评估工艺变更对申报状态的影响（补充申请 vs 备案）。 **输出准则：** 资料必须符合 M4 指导原则，术语统一，逻辑严密，具备极高的法规说服力。
    >     
    

### 5. 质量保证专家 (QA/Compliance Expert)

**核心逻辑：捍卫数据完整性与 GMP 合规底线。**

- **System Prompt:**
    
    > 你是 API 研发质量保证专家，负责 GMP 质量管理体系的落地与数据完整性审计。 **核心职责：**
    > 
    > 1. 审核所有实验原始记录，确保符合 ALCOA+ 原则。
    >     
    > 2. 审批偏差（Deviation）及变更控制（Change Control）。
    >     
    > 3. 负责现场核查（Pre-Approval Inspection）的模拟自查。
    >     
    > 4. 审核批生产记录（BMR）与放行标准。 **输出准则：** 你的回复应具有“挑剔性”，重点关注数据追溯性，结论必须包含“通过/不通过/需整改”的明确评价。
    >     
    

---

### 💡 如何在 OpenClaw 中调用这些 Prompt？

1. **角色关联**：在 OpenClaw 的配置文件中，将以上 Prompt 分别填入对应 Agent 的 `System_Message` 字段。
    
2. **约束输入**：在 Prompt 末尾增加一条约束：“_若你的回答需要其他专家的支持，请明确指出。例如：[需要分析专家提供杂质限度数据]_”。
    
3. 1. **角色关联**：在 OpenClaw 的配置文件中，将以上 Prompt 分别填入对应 Agent 的 `System_Message` 字段。
    
4. **约束输入**：在 Prompt 末尾增加一条约束：“_若你的回答需要其他专家的支持，请明确指出。例如：[需要分析专家提供杂质限度数据]_”。
        

**您是否需要我为您编写一段 OpenClaw 的 JSON 格式配置代码，以便直接导入系统？**

You said

是的，给我JSON 格式配置代码

## Gemini said

为了方便您直接导入 OpenClaw，我为您准备了一个标准的 JSON 配置模板。该配置定义了五个 Agent 的**身份（Role）**、**核心能力（Skills）以及交互约束**。

您可以根据 OpenClaw 具体版本的 schema 微调字段名（如 `system_prompt` 或 `instruction`）。

JSON

```
{
  "project_name": "API_R&D_Expert_Cluster",
  "version": "1.0",
  "agents": [
    {
      "id": "agent_synthesis",
      "role": "合成工艺专家",
      "system_prompt": "你是一位拥有20年原料药研发经验的合成工艺专家。职责：1. 设计符合原子经济性的合成路径。2. 基于QbD原则识别CPP和CQA。3. 评估起始物料(SM)的合法性与杂质谱。4. 提供DoE实验设计方案。输出要求：技术方案需包含详细的收率预测、溶剂分类及潜在EHS风险分析。",
      "tools": ["chemical_database_search", "synthetic_pathway_generator"],
      "temperature": 0.4
    },
    {
      "id": "agent_analytical",
      "role": "分析研发专家",
      "system_prompt": "你是一位精通ICH Q2和中国药典(ChP)的分析方法专家。职责：1. 制定API质量标准(Draft Specification)。2. 设计方法学验证(Validation)方案。3. 解释NMR/MS/XRD等结构确证数据。4. 评估强制降解试验结果。输出要求：所有建议必须符合合规性，并明确区分专属性、准确度和精密度要求。",
      "tools": ["analytical_method_database", "spectrum_interpreter"],
      "temperature": 0.2
    },
    {
      "id": "agent_pm",
      "role": "项目管理专家",
      "system_prompt": "你是具备PMP资质的API研发项目经理。职责：1. 编制项目WBS计划与甘特图。2. 协调合成与分析任务的交接。3. 监控研发关键路径与资源分配。4. 进行项目风险登记与预警。输出要求：必须以结构化列表呈现，明确任务前置关系、责任人及截止日期。",
      "tools": ["gantt_chart_generator", "risk_matrix_tool"],
      "temperature": 0.5
    },
    {
      "id": "agent_regulatory",
      "role": "注册申报专家",
      "system_prompt": "你是一位深谙NMPA关联审评审批制度的RA专家。职责：1. 按照M4(CTD)格式组织申报资料。2. 进行研发数据的GAP分析。3. 审核工艺描述与批记录的一致性。4. 评估工艺变更的注册分类。输出要求：语言专业且严谨，结论需引用具体的法规章节（如《药品注册管理办法》）。",
      "tools": ["nmpa_regulations_search", "ctd_template_manager"],
      "temperature": 0.3
    },
    {
      "id": "agent_qa",
      "role": "质量保证专家",
      "system_prompt": "你是一位坚持数据完整性(ALCOA+原则)的QA专家。职责：1. 审计实验原始记录与审计追踪。2. 批准研发阶段的偏差与变更控制。3. 确保中试环境符合GMP预审要求。4. 审核批放行报告。输出要求：作风严谨，必须指出潜在的合规风险点，并给出CAPA建议。",
      "tools": ["compliance_checker", "audit_log_analyzer"],
      "temperature": 0.1
    }
  ],
  "collaboration_logic": {
    "workflow": "Sequential_with_Feedback",
    "coordinator": "agent_pm",
    "constraints": "每个专家的产出必须经过agent_qa或agent_regulatory的逻辑合规性校验。合成专家的路线变更必须通知分析专家重新评估杂质谱。"
  }
}
```

---

### 🚀 配置说明与使用技巧

- **温度值 (Temperature) 设置**：
    
    - **QA与分析专家**：设置为 **0.1-0.2**。他们需要极高的准确性和严谨性，不容许“幻觉”。
        
    - **合成专家**：设置为 **0.4**。在设计新路线时需要一定的创造力。
        
    - **项目管理**：设置为 **0.5**。平衡进度与资源的调度需要一定的灵活性。
        
- **协作逻辑**： 在 OpenClaw 中，建议将 **项目管理专家 (agent_pm)** 设置为协调者（Coordinator），由它根据用户的输入分发任务给合成或注册专家。
    

**下一步，您是否需要我针对某个特定的原料药品种（例如“阿托伐他汀钙”），演示这五个 Agent 是如何进行第一轮对话交互的？**

You said

提示词直接写入agent.md文件以后，是否还需要进行JSON 配置

## Gemini said

这取决于你所使用的 OpenClaw 具体版本或底层框架的**加载机制**，但通常情况下：**`.md` 文件负责“灵魂”（Prompt 内容），而 `JSON` 文件负责“骨架”（系统调用逻辑）。**

简单直接的回答是：**建议保留 JSON 或类似的配置文件**。以下是深度解析：

---

### 1. 为什么有了 `.md` 还需要 `JSON`？

在 OpenClaw 或类似的多智能体框架中，它们各司其职：

- **`.md` 文件（Agent 提示词库）**：
    
    - **作用**：定义 Agent 的性格、专业知识、回复风格。
        
    - **优点**：易于阅读和长文本编辑。你刚才看到的详细 System Prompt 适合放在这里。
        
- **`JSON` 文件（系统配置文件）**：
    
    - **作用**：定义 Agent 的**物理属性**。
        
    - **关键参数**：
        
        - **`model_endpoint`**：这个专家用 GPT-4o 还是 DeepSeek-V3？
            
        - **`temperature`**：QA 专家需要低随机性（0.1），合成专家需要高创造性（0.5）。
            
        - **`tools/plugins`**：这个 Agent 拥有调用外部数据库（如药监局官网、SciFinder）的权限吗？
            
        - **`path`**：告诉系统，这个 Agent 的灵魂在哪个 `.md` 文件里。
            

---

### 2. 推荐的目录结构（最佳实践）

为了让系统既整洁又高效，建议采用以下结构：

Plaintext

```
/OpenClaw_Project
  ├── /agents_prompts        <-- 存放你的 .md 文件
  │     ├── synthesis.md
  │     ├── analytical.md
  │     └── regulatory.md
  └── config.json            <-- 存放 JSON 配置文件，指向 md 文件
```

---

### 3. 如何在 JSON 中引用 .md 文件？

如果你已经写好了 `.md`，你的 JSON 配置应该修改为**引用模式**（示例）：

JSON

```
{
  "agent_id": "agent_regulatory",
  "name": "注册申报专家",
  "prompt_src": "./agents_prompts/regulatory.md",  // 引用路径
  "llm_config": {
    "model": "gpt-4-turbo",
    "temperature": 0.2
  },
  "connectivity": ["agent_synthesis", "agent_qa"] // 允许与其沟通的专家
}
```

---

### 4. 避坑指南：如果你只用 `.md`

有些轻量化框架支持直接读取目录下的 `.md` 并自动生成 Agent。但这样会存在以下风险：

1. **无法精细化控制**：所有的 Agent 都会共用一个默认的 LLM 参数（比如温度值）。这会导致 QA 专家变得“胡言乱语”，或合成专家变得“过于死板”。
    
2. **工具权限缺失**：`.md` 无法定义 Agent 如何调用 Python 脚本或搜索工具，这在原料药研发（需要查法规、算物料平衡）中是致命的。
    

---

### 💡 总结建议

1. **文案归 `.md`**：保持提示词的可读性。
    
2. **逻辑归 `JSON`**：定义连接、模型选择和工具。
    

**既然您已经有了 Prompt 和 JSON 框架，是否需要我为您写一个 Python 脚本示例，演示如何自动加载这些 `.md` 提示词并启动 OpenClaw Agent 组？**

You said

是的，请继续

## Gemini said

为了让你的 OpenClaw 能够自动加载刚才定义的 `.md` 提示词，并结合 `JSON` 配置运行，我为你编写了一个高兼容性的 Python 启动脚本示例。

这个脚本的核心逻辑是：**读取配置 -> 注入 Markdown 内容 -> 实例化多智能体集群**。

---

### 1. 目录准备

请确保你的文件夹结构如下：

Plaintext

```
/OpenClaw_API_Project
  ├── config.json             (存放 Agent 逻辑配置)
  ├── /prompts                (存放 5 个 .md 提示词文件)
  │     ├── synthesis.md
  │     ├── analytical.md
  │     └── ...等
  └── main.py                 (下方的启动脚本)
```

---

### 2. Python 自动化加载脚本 (`main.py`)

Python

```
import json
import os
from openclaw import Agent, Agency  # 假设你使用的是标准 OpenClaw 类库

def load_agent_configs(config_path, prompt_dir):
    with open(config_path, 'r', encoding='utf-8') as f:
        config_data = json.load(f)
    
    agent_instances = []
    
    for agent_cfg in config_data['agents']:
        # 1. 拼接 md 文件路径 (假设文件名与 id 对应)
        md_path = os.path.join(prompt_dir, f"{agent_cfg['id'].replace('agent_', '')}.md")
        
        # 2. 读取 Markdown 中的 System Prompt
        if os.path.exists(md_path):
            with open(md_path, 'r', encoding='utf-8') as md_f:
                system_message = md_f.read()
        else:
            # 如果没找到 md，回退到 JSON 中的简易 prompt
            system_message = agent_cfg.get('system_prompt', "You are a helpful assistant.")
        
        # 3. 实例化 Agent
        new_agent = Agent(
            id=agent_cfg['id'],
            name=agent_cfg['role'],
            system_message=system_message,
            temperature=agent_cfg.get('temperature', 0.3),
            tools=agent_cfg.get('tools', [])
        )
        agent_instances.append(new_agent)
        print(f"✅ 已加载专家: {agent_cfg['role']}")

    return agent_instances, config_data.get('collaboration_logic', {})

# --- 启动流程 ---
if __name__ == "__main__":
    # 加载配置
    agents, logic = load_agent_configs('config.json', './prompts')
    
    # 组建专家组 (Agency)
    api_agency = Agency(
        agents=agents,
        shared_instructions=logic.get('constraints', "按照原料药研发合规性要求协作。")
    )
    
    # 测试交互：模拟一个原料药立项指令
    user_input = "我们要启动‘恩格列净’原料药的研发，请合成专家先给出初版路径，并由QA评估合规风险。"
    
    print("\n🚀 正在启动 API 研发专家集群...\n" + "-"*30)
    # api_agency.run(user_input) # 取消注释以正式运行
```

---

### 3. 关键细节：如何优化 `.md` 内容

在你的 `synthesis.md` 等文件中，建议采用以下格式，以便 LLM 更好地解析：

Markdown

```
# Role: 合成工艺专家
## Context: 
中国原料药研发环境，需符合 NMPA 关联审评审批要求。

## Rules:
- 必须考虑原子经济性。
- 严禁使用 I 类溶剂（如苯）。
- 杂质分析需符合 ICH Q3A。

## Output Format:
1. 路线简述
2. 关键物料清单
3. 风险预判
```

---

### 4. 下一步：集成外部工具（Tools）

原料药研发 Agent 仅仅靠“说话”是不够的，你可能需要在 JSON 的 `tools` 字段中真正实现以下功能：

- **`chemical_search`**: 调用 PubChem API 查询化合物性质。
    
- **`reg_search`**: 爬取或检索 CDE（药品审评中心）的指导原则 PDF。
    
- **`calc_yield`**: 一个简单的 Python 函数，用于根据投料量准确计算理论产率。
    

---

### 💬 最后的建议

既然你已经进入了代码实施阶段：

1. **版本控制**：API 研发的 SOP 经常变动，建议将 `prompts` 文件夹纳入 Git 管理。
    
2. **安全围栏**：在 `QA 专家` 的提示词里加入“强制校验”逻辑，即无论合成专家说什么，QA 必须寻找漏洞。
    

**您是否需要我为您针对“注册申报专家”写一个能直接调用 CDE 法规库检索的自定义 Tool 示例代码？**