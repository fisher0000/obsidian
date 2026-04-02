# 飞书知识库同步配置

## 任务说明
自动将本地知识库文件夹同步到飞书云盘

## 配置信息
- **本地路径**: `D:\WT\Github\obsidian\知识库`
- **飞书云盘**: `https://j0eukrlohu.feishu.cn/drive/folder/Ofu0fS87fl5SHwdTZSmcmXoQnse`
- **同步时间**: 工作日每天早晨 9:00
- **同步脚本**: `D:\WT\Github\obsidian\sync_knowledge_base.ps1`

## 文件夹映射关系

| 本地文件夹 | 飞书文件夹Token |
|-----------|----------------|
| ICH | MadJfDDtYldc8zdDXiycZnqunoc |
| FDA | VBuzfII5FltYy4dDqc8cMKIunFf |
| EMA | CQtbf6MBwlUd6kdBHI6cvmNMngf |
| NMPA CFDA CFDI | GRZwfHxW6lfdJFdsWfbcaPOnnTI |
| 研究专题 | GTELfptFVlvft5ddVvdcCh1Fn0c |

## 定时任务设置

### Windows 任务计划程序配置

任务名称: `FeishuKnowledgeBaseSync`
触发器: 每天 9:00，仅工作日
操作: 启动程序
程序: `powershell.exe`
参数: `-ExecutionPolicy Bypass -File "D:\WT\Github\obsidian\sync_knowledge_base.ps1"`

## 注意事项

1. **飞书API限制**: 当前飞书云盘API不支持直接文件上传，需要通过其他方式实现
2. **同步策略**: 建议采用增量同步，仅上传修改过的文件
3. **日志记录**: 同步日志保存在 `D:\WT\Github\obsidian\sync_log.txt`

## 待解决问题

- [ ] 飞书文件上传API的实现方式
- [ ] 文件冲突处理策略
- [ ] 删除同步（本地删除后云端是否同步删除）
