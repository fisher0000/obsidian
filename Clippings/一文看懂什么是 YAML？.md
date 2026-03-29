---
title: "一文看懂什么是 YAML？"
source: "https://www.redhat.com/zh-cn/topics/automation/what-is-yaml"
author:
published:
created: 2026-03-26
description: "YAML 是一种数据序列化语言，通常用于编写配置文件。YAML 是一种流行的编程语言，它的设计初衷就是便于人类阅读和理解。还可以与其他编程语言结合使用。"
tags:
  - "clippings"
---
复制 URL

YAML 是一种人类可读的数据序列化语言，通常用于编写配置文件。业界对 YAML 有不同的看法，有人会说 YAML 不过代表了另一种标记语言，另外一些人认为“YAML ain’t markup language”（“YAML 不是标记语言”），“YAML” 正是这句话的首字母缩写，强调了 YAML 是用于数据而不是文档。

YAML 是一种流行的编程语言，它的设计初衷就是便于人类阅读和理解。它还可以与其他编程语言结合使用。由于 YAML 的灵活性和可访问性， [Ansible®](https://www.redhat.com/zh-cn/technologies/management/ansible/compare-awx-vs-ansible-automation-platform) 使用 YAML 以 的方式创建自动化流程。

[红帽 Ansible 自动化平台：入门指南](https://www.redhat.com/zh-cn/resources/ansible-automation-platform-beginners-guide-ebook?intcmp=RHCTG0250000447891)

YAML 文件使用.yml 或.yaml 扩展名，并遵循特定的语法规则。

YAML 拥有 Perl、C、XML、HTML 和其他编程语言的特性。YAML 也是 JSON 的超集，所以 JSON 文件在 YAML 中有效。

没有通常的格式符号，如大括号、方括号、结束标记或引号。YAML 文件更容易阅读，因为其使用 Python 风格的缩进来确定结构并表示嵌套。为了保持跨系统的可移植性，设计时不允许使用制表符，因此改用空格（字面意义的空格字符）。

注释可以用井号或哈希符号（#）。使用注释始终是最佳实践，因为注释可以用来描述代码的意图。YAML 不支持多行注释，每行都需要以井号字符为后缀。

YAML 初学者的一个常见问题就是“三个短横线是什么意思？”。三个短横线（---）用来表示文档的开始，而三个点（...）表示文档的结束。

下面是一个非常基础的 YAML 文件示例：

```js
#Comment: This is a supermarket list using YAML
#Note that - character represents the list
---
food: 
  - vegetables: tomatoes #first list item
  - fruits: #second list item
      citrics: oranges 
      tropical: bananas
      nuts: peanuts
      sweets: raisins
```

请注意，YAML 文件的结构是映射或列表，遵循层次结构，具体取决于缩进以及定义键值的方式。它以映射来关联键值对。每个键必须是唯一的，而且顺序并不重要。这跟 Python 字典或 Bash 脚本中的变量赋值相似。

YAML 中的映射必须经过解析后才能关闭，然后创建新的映射。新的映射可以通过增加缩进级别或解析之前的映射并新建一个相邻映射来创建。

列表包括以特定顺序列出的值，可以包含任何数量的所需项目。一个列表序列以破折号（-）和空格开始，而缩进则将其与父级分开。我们可以把序列看作是一个 Python 列表或者 Bash 或 Perl 中的数组。一个列表可以嵌入到一个映射中。

在上面提供的示例中，“vegetables”和“fruits”表示属于名为“food”的列表中的部分项目。

YAML 还包含标量，它是以 Unicode 编码的任意数据，可以用作字符串、整数、日期、数字或布尔等值。

在创建 YAML 文件时，需要确保遵循这些语法规则，而且文件必须有效。为此，您可以使用 linter，这是一种验证文件语法的应用。在将 YAML 文件交给应用之前，使用 yamllint 命令可以确保已经创建了一个有效的 YAML 文件。

[初学者 YAML 入门](https://www.redhat.com/sysadmin/yaml-beginners "Yaml 初学者博客")

下面这个简单的 YAML 文件示例是一份学生信息记录，展示了 YAML 的语法规则：

```js
#Comment: Student record
#Describes some characteristics and preferences
---
name: Martin D'vloper #key-value
age: 26
hobbies: 
  - painting #first list item
  - playing_music #second list item
  - cooking #third list item
programming_languages:
  java: Intermediate
  python: Advanced
  javascript: Beginner
favorite_food: 
  - vegetables: tomatoes 
  - fruits: 
      citrics: oranges 
      tropical: bananas
      nuts: peanuts
      sweets: raisins
```

当我们使用 PyYAML 库将此文件转换为 Python 时，您将获得以下数据结构：

```js
[
    {
        "name": "Martin D'vloper",
        "age": 26,
        "hobbies": ["painting", "playing_music", "cooking"],
        "programming_languages": {
            "java": "Intermediate",
            "python": "Advanced",
            "javascript": "Beginner",
        },
        "favorite_food": [
            {"vegetables": "tomatoes"},
            {
                "fruits": {
                    "citrics": "oranges",
                    "tropical": "bananas",
                    "nuts": "peanuts",
                    "sweets": "raisins",
                }
            },
        ],
    }
]
```

[了解 Ansible 学习路径中需要具备的 YAML 基础知识](https://developers.redhat.com/learn/ansible/yaml-essentials-ansible "Developers.redhat.com | Ansible 学习路径中需要具备的 YAML 基础知识")

YAML 最常见的用途之一是创建。相比 JSON，因为 YAML 有更好的可读性，对用户更友好，所以通常建议用 YAML 来编写配置文件，尽管它们在大多数情况下可以互换使用。

除了在 Ansible 中使用之外，YAML 还用于 Kubernetes 资源和部署。

使用 YAML 的一大好处是，YAML 文件可以添加到源代码控制中，比如 Github，这样就可以跟踪和审计变更。

#### Ansible 中的 YAML

主要用来编排 IT 流程。Playbook 是一个 YAML 文件，其中包含 1 个或多个 play，用于定义系统的所需状态。

每个 play 可以运行一个或多个任务，每个任务调用一个 。这些模块用来完成 Ansible 中的自动化任务。Ansible 模块可用任何能返回 JSON 的语言编写，如 Ruby、Python 或 bash。

Ansible Playbook 由映射和列表组成。要创建一个 playbook，首先要创建一个 YAML 列表，命名 play，然后按顺序列出任务。记住，缩进并不是逻辑继承的标志。要把每一行看作是一种 YAML 数据类型（列表或映射）。

通过使用 YAML 模板，Ansible 用户可以对重复性任务进行编程，使任务自动完成，而不需要学习高级编程语言。开发人员还可以使用 [ansible-lint 命令](https://www.redhat.com/zh-cn/technologies/management/ansible/development-tools) （Ansible Playbook 的 YAML linter）来识别错误，确保在运行的关键阶段不会发生错误。

随着 [Ansible Lightspeed 与生成式人工智能服务 IBM Watson Code Assistant](https://www.redhat.com/zh-cn/technologies/management/ansible/ansible-lightspeed) 的推出，开发人员可以更高效地创建 Ansible 自动化内容。用户可以使用简单的英语输入任务请求，并获得针对自动化任务简洁且合规的 YAML 代码建议，然后用于创建 Ansible Playbook。

#### 用于 Kubernetes 的 YAML

基于定义的预期状态和实际状态工作。Kubernetes 对象代表集群的状态，并会告知 Kubernetes 您希望工作负载进入何种状态。Kubernetes 资源（如 Pod、对象和部署）可以使用 YAML 文件来创建。

当创建一个 Kubernetes 对象时，需要包括规范以定义对象的预期状态。 可用来创建对象。对 API 的请求包括 JSON 格式的对象规范，但大多数情况下会以 YAML 文件的形式向 kubectl 提供所需信息。Kubectl 在发出 API 请求时将该文件转换成 YAML。

在创建并定义了对象后，Kubernetes 会确保该对象始终存在。

开发人员或系统管理员利用提交到 Kubernetes API 的 YAML 或 JSON 文件来指定预期状态。Kubernetes 使用控制器来分析新预期状态和集群实际状态之间的差别。

[获取企业级 Kubernetes 简介](https://www.redhat.com/zh-cn/engage/introduction-enterprise-kubernetes-s-202003040257 "SOLP：企业级 Kubernetes 简介")

[红帽 Ansible 自动化平台](https://www.redhat.com/zh-cn/technologies/management/ansible) 支持人类可读 YAML 自动化语言，使整个企业的用户能够共享、审查和管理自动化内容。它包括实施企业级自动化所需的所有工具，包括 playbook 和分析。另外，它允许用户通过可视化控制面板、基于职能角色的访问控制等功能来集中管理和控制自己的 IT 基础架构，从而降低运维的复杂性。

借助红帽订阅，您可以获得经认证的内容、可靠的合作伙伴生态系统、托管管理服务的访问权限，以及生命周期技术支持，让您的团队能够在整个企业中创建、管理和扩展自动化。红帽已成功服务数千客户，积累了能提供专业洞察和指导的宝贵经验。

[了解有关 Ansible 自动化平台的更多信息](https://www.redhat.com/zh-cn/technologies/management/ansible)

[红帽 OpenShift](https://www.redhat.com/zh-cn/technologies/cloud-computing/openshift) 是用于企业的 Kubernetes。它汇集了所有相关的先进技术，旨在将 Kubernetes 打造成为可供企业使用的强大平台，这些技术包括：镜像仓库、联网、遥测、安全防护、自动化和服务。

借助红帽 OpenShift 的可扩展性以及控制和编排功能，开发人员可以构建新的容器化应用、对其进行托管并在云端加以部署，从而轻松快速地将各种奇思妙想转变为新业务。

[进一步了解 OpenShift](https://www.redhat.com/zh-cn/technologies/cloud-computing/openshift "产品 | 红帽 OpenShift")

## 所有红帽产品试用

我们的免费试用服务可让您亲身体验红帽的产品功能，为获得认证做好准备，或评估某个产品是否适合您的企业组织。

[LinkedIn](https://www.linkedin.com/company/red-hat) [YouTube](https://www.youtube.com/user/RedHatVideos) [Facebook](https://www.facebook.com/RedHat/) [X](https://twitter.com/RedHat)

### 平台

- [红帽 AI](https://www.redhat.com/zh-cn/products/ai)
- [红帽企业 Linux](https://www.redhat.com/zh-cn/technologies/linux-platforms/enterprise-linux)
- [红帽 OpenShift](https://www.redhat.com/zh-cn/technologies/cloud-computing/openshift)
- [红帽 Ansible 自动化平台](https://www.redhat.com/zh-cn/technologies/management/ansible)
- [查看所有产品](https://www.redhat.com/zh-cn/technologies/all-products)

### 工具

- [培训和认证](https://www.redhat.com/zh-cn/services/training-and-certification)
- [我的帐户](https://www.redhat.com/wapps/ugc/protected/personalInfo.html)
- [客户支持](https://access.redhat.com/)
- [开发者资源](https://developers.redhat.com/)
- [查找合作伙伴](https://catalog.redhat.com/partners)
- [红帽生态系统目录](https://catalog.redhat.com/)
- [文档](https://docs.redhat.com/zh_hans)

### 试用购买与出售

- [产品试用中心](https://www.redhat.com/zh-cn/products/trials)
- [红帽商店](https://www.redhat.com/en/store)
- [在线购买（日本）](https://www.redhat.com/en/about/japan-buy)
- [控制台](https://www.redhat.com/zh-cn/hybrid-cloud-console)

### 联系我们

- [联系销售人员](https://www.redhat.com/zh-cn/contact/sales)
- [联系客户服务](https://www.redhat.com/zh-cn/contact/customer-service)
- [联系培训部门](https://www.redhat.com/zh-cn/services/training-and-certification/contact-us)
- [社交媒体](https://www.redhat.com/zh-cn/about/social)

### 关于红帽

红帽是开放混合云技术的领导者，为企业变革性 IT 和人工智能 (AI) 应用提供一致、全面的基础。作为深受 [《财富》500 强企业信赖的顾问](https://www.redhat.com/zh-cn/about/company) ，红帽提供云、开发人员、Linux、自动化和应用平台技术，以及 [屡获殊荣](https://access.redhat.com/recognition) 的服务。

- [公司介绍](https://www.redhat.com/zh-cn/about/company)
- [企业文化](https://www.redhat.com/zh-cn/about/our-culture)
- [客户成功案例](https://www.redhat.com/zh-cn/success-stories)
- [行业分析师关系](https://www.redhat.com/zh-cn/about/analysts)
- [新闻中心](https://www.redhat.com/zh-cn/about/newsroom)
- [开源承诺](https://www.redhat.com/zh-cn/about/open-source)
- [社会责任](https://www.redhat.com/zh-cn/about/community-social-responsibility)
- [加入红帽](https://www.redhat.com/zh-cn/jobs)
- [关于红帽](https://www.redhat.com/zh-cn/about/company)
- [加入红帽](https://www.redhat.com/zh-cn/jobs)
- [活动](https://www.redhat.com/zh-cn/events)
- [全球办事处](https://www.redhat.com/zh-cn/about/office-locations)
- [联系红帽](https://www.redhat.com/zh-cn/contact)
- [红帽博客](https://www.redhat.com/zh-cn/blog)
- [红帽的包容性](https://www.redhat.com/zh-cn/about/our-culture/inclusion)
- [红帽周边产品](https://coolstuff.redhat.com/)
- [红帽全球峰会](https://www.redhat.com/en/summit)
© 2026 Red Hat | 京ICP备09066747号
- [隐私声明](https://www.redhat.com/zh-cn/about/privacy-policy)
- [使用条款](https://www.redhat.com/zh-cn/about/terms-use)
- [方针政策概览](https://www.redhat.com/zh-cn/about/all-policies-guidelines)
- [数字可访问性声明](https://www.redhat.com/zh-cn/about/digital-accessibility)