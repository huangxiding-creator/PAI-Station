---
title: 扣子短视频提取 skills 资料包
source: https://100agents.feishu.cn/wiki/GboLw69zfiDHqOkrIMEchPnAnce
node_token: GboLw69zfiDHqOkrIMEchPnAnce
doc_token: SFdvdOq7LowHVRx2Ofpc4py5nGb
revision: 35
fetched: 2026-10-15
---

# 扣子短视频提取 skills 资料包

我是古德白，这个就是我在短视频分享的价值600万的短视频二创工作流的 skill 复刻版。我建议先复制开发文档，然后放到 coze skills 开发界面 里面，让他照着去开发。这个更容易操作一些，那么也可以尝试导入这个代码包，但这个方法我没试过，反正目前扣子的限制很多，我也不知道如何是官方的导入。但是聊天框有一个添加附件导入，可以测试一下，看看是不是有效。

## 一 代码包

<figure view-type="Card"><source name="video-to-audio.skill" size="564005" token="Ej09bP5JAoYeXzxmkcwchZ73nxe"/></figure>

## 二 开发文档

````Markdown
# Video-to-Audio Skill 实现要点总结

## 项目概述

本项目实现了一个从视频URL提取音频的Skill，支持抖音、TikTok等短视频平台。核心思路是利用TikTokDownloader开源库的API模式，直接获取音频文件下载地址，实现快速高效的音频提取。

## 核心技术选型

### 1. 依赖TikTokDownloader开源库

**选择理由**：
- TikTokDownloader是一个成熟的开源项目，专门用于抖音/TikTok视频下载
- 已处理了反爬、签名、加密等复杂问题
- 提供API模式，可以通过HTTP接口调用

**集成方式**：
```bash
# 克隆项目
git clone https://github.com/JoeanAmier/TikTokDownloader.git

# 安装依赖
cd TikTokDownloader
pip install -r requirements.txt

# 启动API模式
python main.py
# 选择 7 - Web API 模式
# API服务运行在 http://127.0.0.1:5555
```

**关键配置点**：
- **Cookie配置**：必须在 `settings.json` 中配置有效的Cookie（sessionid、enter_pc_once）
- **API端点**：`http://127.0.0.1:5555/douyin/detail`
- **请求格式**：POST请求，JSON格式

### 2. 不使用ffmpeg，直接下载MP3

**关键技术点**：
- TikTokDownloader API返回的数据中包含 `music_url` 字段
- 这是音频文件的直接下载链接，无需下载视频再提取
- 音频质量更高（192kbps vs 64kbps）
- 速度更快（2秒 vs 46秒）

**API响应示例**：
```json
{
  "message": "获取数据成功！",
  "data": {
    "id": "7580546317039537743",
    "desc": "视频标题",
    "music_url": "https://sf6-cdn-tos.douyinstatic.com/obj/ies-music/xxx.mp3",
    "duration": "00:09:44"
  }
}
```

## 核心流程

### 完整处理流程

```
用户输入（URL或分享文本）
    ↓
解析短链接，提取视频ID
    ↓
调用TikTokDownloader API获取视频信息
    ↓
从API响应中提取music_url
    ↓
直接下载音频文件（MP3）
    ↓
返回音频文件路径
```

### 步骤详解

#### 步骤1：解析视频URL

**问题**：用户输入的可能是短链接或分享文本
**解决方案**：
- 使用httpx发起GET请求，自动跟随重定向
- 从最终URL中提取视频ID
- 支持从抖音分享文本中提取URL（正则匹配）

**示例**：
- 输入：`https://v.douyin.com/TvftFlSRlVk/`
- 重定向后：`https://www.douyin.com/video/7580546317039537743/...`
- 提取视频ID：`7580546317039537743`

#### 步骤2：调用TikTokDownloader API

**API调用细节**：
- **请求方法**：POST
- **Content-Type**：`application/json`
- **请求体**：
  ```json
  {
    "detail_id": "7580546317039537743",
    "cookie": "enter_pc_once=1; sessionid=xxx",
    "proxy": ""  // 必须是空字符串，不能是None
  }
  ```

**关键注意点**：
- `proxy` 参数必须传递空字符串 `""`，不能传递 `None`，否则会返回422错误
- Cookie可以从TikTokDownloader的settings.json自动读取
- API成功响应的message是 `"获取数据成功！"`

#### 步骤3：提取音频URL

**数据解析**：
```python
# 从API响应中提取music_url
if "music_url" in detail:
    audio_url = detail["music_url"]
```

**优势**：
- 直接获取原始音频文件，无需二次处理
- 音质更好（192kbps）
- 文件更小（仅音频，无视频轨道）

#### 步骤4：下载音频文件

**下载实现**：
- 使用httpx异步下载
- 添加必要的请求头（User-Agent、Referer）
- 支持代理配置
- 带进度显示

**关键代码结构**：
```python
async with httpx.AsyncClient(proxy=proxy_config, timeout=60.0) as client:
    async with client.stream("GET", audio_url, headers=headers) as response:
        # 流式下载，避免内存占用过大
        async for chunk in response.aiter_bytes(chunk_size=8192):
            f.write(chunk)
```

**注意点**：
- 使用 `stream` 方法避免大文件占用内存
- 设置合理的超时时间（60秒）
- 处理网络异常和重试逻辑

## 重点注意事项

### 1. TikTokDownloader API的配置

**必须正确配置的项**：

1. **Cookie配置**
   - 位置：`TikTokDownloader/settings.json`
   - 必需字段：`sessionid`、`enter_pc_once`
   - 获取方式：浏览器登录抖音后，从开发者工具中复制
   - 注意：Cookie会过期，需要定期更新

2. **API启动**
   - 必须选择 "7 - Web API" 模式
   - 默认端口：5555
   - 可以通过 `--port` 参数修改

3. **代理配置**
   - 如果需要代理，在settings.json中配置 `proxy` 字段
   - 或通过脚本参数 `--proxy` 传入

### 2. httpx的使用细节

**版本问题**：
- 使用httpx 0.28.0或更高版本
- proxy参数名在不同版本有变化：
  - 旧版本：`proxies` 字典
  - 新版本（0.28+）：`proxy` 字符串

**示例**：
```python
# 正确方式（httpx 0.28+）
proxy_config = {"all://": "http://127.0.0.1:7890"} if proxy else None
async with httpx.AsyncClient(proxy=proxy_config) as client:
    pass
```

### 3. 错误处理

**常见错误及处理**：

1. **422 Unprocessable Entity**
   - 原因：proxy参数传了None而非空字符串
   - 解决：`proxy = proxy if proxy else ""`

2. **获取数据失败**
   - 原因：Cookie无效或过期
   - 解决：重新获取Cookie并更新settings.json

3. **连接API失败**
   - 原因：TikTokDownloader API未启动
   - 解决：检查API服务是否运行

### 4. 文件管理

**临时文件处理**：
- 使用 `tempfile.mkdtemp()` 创建临时目录
- 命名规范：`video_to_audio_<timestamp>`
- 音频文件：`audio_<timestamp>.mp3`
- 下载完成后，音频文件保留供用户使用
- 用户需手动复制或处理音频文件

### 5. 依赖管理

**Python依赖**：
```
httpx>=0.28.0      # HTTP客户端
aiofiles>=24.1.0   # 异步文件操作
rich>=13.0.0       # 美化输出和进度条
```

**系统依赖**：
- 无需ffmpeg
- 无需其他系统工具

## 复刻本项目的关键点

### 1. 环境准备

```bash
# 1. 安装Python依赖
pip install httpx aiofiles rich

# 2. 克隆并配置TikTokDownloader
git clone https://github.com/JoeanAmier/TikTokDownloader.git
cd TikTokDownloader
pip install -r requirements.txt

# 3. 配置Cookie
# 编辑settings.json，添加cookie字段

# 4. 启动API
python main.py
# 选择 7 - Web API
```

### 2. 核心代码结构

**必须实现的功能**：

1. **URL解析函数**
   - 输入：视频URL或分享文本
   - 输出：视频ID

2. **API调用函数**
   - 输入：视频ID、Cookie、代理
   - 输出：API响应数据

3. **音频URL提取函数**
   - 输入：API响应数据
   - 输出：音频下载URL（music_url）

4. **下载函数**
   - 输入：音频URL、输出路径、代理
   - 输出：是否成功

5. **Cookie加载函数**
   - 输入：settings.json路径
   - 输出：Cookie字符串

### 3. 参数设计

**命令行参数**：
```
--url          (必需) 视频URL或分享文本
--cookie       (可选) Cookie字符串
--proxy        (可选) 代理地址
--api-url      (可选) API地址
--settings     (可选) settings.json路径
```

**优先级逻辑**：
- Cookie：命令行参数 > settings.json > 空
- Proxy：命令行参数 > settings.json > 空
- API URL：命令行参数 > 默认值

### 4. 输出格式

**标准输出**：
- 只输出音频文件的完整路径
- 格式：`/tmp/video_to_audio_xxx/audio_xxx.mp3`
- 便于后续脚本或程序捕获使用

**详细输出**：
- 使用rich库美化输出
- 显示处理步骤和进度
- 错误信息使用红色高亮
- 成功信息使用绿色高亮

### 5. 测试验证

**测试清单**：
- [ ] URL解析功能（短链接、分享文本）
- [ ] API调用功能（有Cookie、无Cookie）
- [ ] 音频下载功能（直接下载、代理下载）
- [ ] 错误处理（网络错误、API错误、Cookie过期）
- [ ] 输出格式（文件路径正确、音频可播放）

**测试视频**：
- 使用真实抖音视频进行完整测试
- 验证音频时长与视频一致
- 验证音频质量（比特率、采样率）

## 技术难点与解决方案

### 1. 短链接解析

**难点**：抖音使用短链接，需要解析后才能获取视频ID

**解决方案**：
- 使用httpx自动跟随重定向
- 从最终URL中提取视频ID
- 支持正则匹配分享文本中的URL

### 2. API签名问题

**难点**：抖音API需要签名，直接调用会被拒绝

**解决方案**：
- 依赖TikTokDownloader，它已处理签名问题
- 不直接调用抖音API，而是通过TikTokDownloader的API

### 3. Cookie管理

**难点**：Cookie需要定期更新，且格式严格

**解决方案**：
- 从TikTokDownloader的settings.json统一管理
- 支持命令行参数覆盖
- 提供清晰的获取Cookie指南

### 4. 错误诊断

**难点**：网络请求可能失败，需要清晰的错误提示

**解决方案**：
- 区分不同错误类型（连接错误、API错误、下载错误）
- 提供具体的解决建议
- 使用rich库美化错误输出

## 优化建议

### 已实现的优化

1. **直接下载音频**：不下载视频，速度提升23倍
2. **异步下载**：使用httpx异步下载，提高效率
3. **流式下载**：避免大文件占用内存
4. **进度显示**：使用rich的进度条，提升用户体验

### 未来可能的优化

1. **批量下载**：支持从文件列表批量提取音频
2. **格式转换**：支持转换为其他音频格式（MP3、AAC、FLAC等）
3. **质量选择**：支持选择不同音质的下载
4. **缓存机制**：缓存API响应，减少重复请求
5. **断点续传**：支持大文件断点续传

## 参考资源

### 开源项目
- TikTokDownloader: https://github.com/JoeanAmier/TikTokDownloader

### 文档
- httpx文档: https://www.python-httpx.org/
- rich文档: https://rich.readthedocs.io/

### API接口
- TikTokDownloader API: `http://127.0.0.1:5555/docs`（启动后访问）

## 总结

本项目的核心价值在于：
1. **高效**：直接下载音频，无需视频处理，速度快23倍
2. **简洁**：依赖开源库，避免重复造轮子
3. **实用**：满足从视频提取音频的核心需求
4. **可维护**：代码结构清晰，易于扩展和优化

复刻本项目时，重点把握：
- TikTokDownloader的API集成方式
- music_url的获取和使用
- httpx的异步下载实现
- Cookie的管理和配置
- 错误处理和用户提示

````
