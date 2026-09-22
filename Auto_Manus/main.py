#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Manus矩阵任务调度自动化脚本
功能：
1. 登录账号（包含人机验证暂停处理）
2. 自动到最近第一个对话，判断任务状态
3. 根据任务状态执行相应操作：
   - 中断任务：点击继续
   - 已完成任务：下载前三个文件
4. 继续下一个账号
"""

import time
import logging
import configparser
from pathlib import Path
from typing import Dict
from DrissionPage import Chromium
from DrissionPage.common import Keys

class ManusAutomation:
    """Manus矩阵任务调度自动化操作类"""

    def __init__(self, config_file: str = "config.ini"):
        """
        初始化
        Args:
            config_file: 配置文件路径
        """
        self.config = configparser.ConfigParser()
        self.config.read(config_file, encoding='utf-8')

        # 初始化日志
        self.init_logging()

        # 初始化配置
        self.init_config()

        self.page = None

    def find_element(self, selector: str, element_name: str = ""):
        """
        查找元素 - 留空白供手动实现
        Args:
            selector: 元素选择器
            element_name: 元素名称（用于日志）
        Returns:
            找到的元素或None
        """
        if not selector:
            self.logger.warning(f"元素选择器为空: {element_name}")
            return None

        element = self.page.ele(selector, timeout=5)
        if element:
            self.logger.info(f"找到元素 {element_name}: {selector}")
            return element
        else:
            self.logger.warning(f"未找到元素 {element_name}: {selector}")
            return None





    def smart_wait_for_element(self, selector: str, timeout: int = 10, element_name: str = "") -> bool:
        """
        智能等待元素出现
        Args:
            selector: 元素选择器
            timeout: 超时时间
            element_name: 元素名称（用于日志）
        Returns:
            bool: 是否找到元素
        """
        try:
            element = self.page.ele(selector, timeout=timeout)
            if element:
                self.logger.info(f"找到元素 {element_name}: {selector}")
                return True
            else:
                self.logger.warning(f"超时未找到元素 {element_name}: {selector}")
                return False
        except Exception as e:
            self.logger.error(f"查找元素 {element_name} 时出错: {e}")
            return False

    def auto_handle_captcha(self) -> bool:
        """
        自动处理人机验证 - 针对Cloudflare“确认您是真人”智能等待版本
        Returns:
            bool: 是否成功处理了验证
        """
        try:
            self.logger.info("开始智能等待并检测“确认您是真人”验证...")
            
            # 首先检查是否已经可以进入下一步（验证已通过）
            password_input = self.page.ele('@placeholder=输入密码', timeout=1)
            if password_input:
                self.logger.info("检测到密码输入框，人机验证已通过")
                return True

            # Cloudflare验证特定选择器（根据截图分析）
            cloudflare_selectors = [
                # 直接文本匹配
                'text=确认您是真人',
                'text=确认你是真人',
                'text=Verify you are human',
                'text=I am human',
                
                # Cloudflare特定选择器
                'input[type="checkbox"][value="on"]',  # Cloudflare复选框
                '.cf-turnstile input[type="checkbox"]',
                '.cf-turnstile-wrapper input',
                '[data-sitekey] input[type="checkbox"]',
                
                # 通用验证选择器
                'label:确认您是真人',
                'button:确认您是真人',
                '[role="checkbox"]',
                '.checkbox input',
                'input[name="cf-turnstile-response"]',
                
                # iframe中的选择器
                'iframe[src*="challenges.cloudflare"]',
                'iframe[src*="turnstile"]'
            ]
            
            # 智能等待机制 - 最多等待30秒
            max_wait_time = 30
            check_interval = 2  # 每2秒检查一次
            attempts = max_wait_time // check_interval
            
            # 检测并处理人机验证 - 强化版本，彻底解决Cloudflare验证
            self.logger.info("启动强化版Cloudflare验证处理...")
            captcha_handled = False
            max_captcha_attempts = 8  # 增加到8次尝试
            
            for attempt in range(max_captcha_attempts):
                self.logger.info(f"第{attempt+1}次验证处理尝试")
                
                # 方法1：优先检查密码框（验证成功的标志）
                password_input = self.page.ele('@placeholder=输入密码', timeout=1)
                if password_input:
                    self.logger.info("✅ 检测到密码输入框，验证已通过")
                    captcha_handled = True
                    break
                
                # 方法2：检查并点击继续按钮
                continue_btn = self.page.ele('text=继续', timeout=2)
                if continue_btn:
                    self.logger.info("发现继续按钮，点击继续")
                    continue_btn.click()
                    time.sleep(3)
                    continue
                
                # 方法3：全面JavaScript搜索和处理
                try:
                    js_result = self.page.run_js("""
                    (function() {
                        console.log('开始全面验证检测...');
                        
                        // 1. 检查页面是否包含验证文本
                        var pageText = document.body.innerText || document.body.textContent || '';
                        var hasVerification = pageText.includes('确认您是真人') || 
                                            pageText.includes('确认你是真人') || 
                                            pageText.includes('Verify you are human') ||
                                            pageText.includes('I am human');
                        
                        if (!hasVerification) {
                            console.log('页面暂未包含验证文本');
                            return false;
                        }
                        
                        console.log('页面包含验证文本，开始查找验证元素...');
                        
                        // 2. 查找所有可能的验证元素
                        var allElements = document.querySelectorAll('*');
                        var foundElement = false;
                        
                        for (var i = 0; i < allElements.length; i++) {
                            var el = allElements[i];
                            var text = el.textContent || el.value || el.placeholder || el.title || '';
                            
                            // 检查是否包含验证相关文本
                            if (text.includes('确认您是真人') || 
                                text.includes('确认你是真人') || 
                                text.includes('Verify you are human') ||
                                text.includes('I am human')) {
                                
                                console.log('找到验证元素:', el.tagName, text.substring(0, 30));
                                
                                // 检查元素是否可见可点击
                                if (el.offsetParent !== null) {
                                    try {
                                        // 滚动到元素
                                        el.scrollIntoView({behavior: 'smooth', block: 'center'});
                                        
                                        // 等待一下再点击
                                        setTimeout(function() {
                                            try {
                                                el.click();
                                                console.log('已点击验证元素');
                                            } catch (e) {
                                                console.log('点击失败:', e);
                                            }
                                        }, 500);
                                        
                                        foundElement = true;
                                        break;
                                    } catch (e) {
                                        console.log('处理验证元素失败:', e);
                                    }
                                }
                            }
                        }
                        
                        // 3. 如果没找到文本元素，尝试查找input复选框
                        if (!foundElement) {
                            var checkboxes = document.querySelectorAll('input[type="checkbox"]');
                            console.log('查找到', checkboxes.length, '个复选框');
                            
                            for (var j = 0; j < checkboxes.length; j++) {
                                var checkbox = checkboxes[j];
                                if (checkbox.offsetParent !== null && !checkbox.disabled) {
                                    try {
                                        checkbox.scrollIntoView({behavior: 'smooth'});
                                        setTimeout(function() {
                                            checkbox.click();
                                            console.log('已点击复选框');
                                        }, 300);
                                        foundElement = true;
                                        break;
                                    } catch (e) {
                                        console.log('点击复选框失败:', e);
                                    }
                                }
                            }
                        }
                        
                        // 4. 尝试点击所有可见的label元素
                        if (!foundElement) {
                            var labels = document.querySelectorAll('label');
                            for (var k = 0; k < labels.length; k++) {
                                var label = labels[k];
                                if (label.offsetParent !== null) {
                                    try {
                                        label.click();
                                        console.log('已点击label元素');
                                        foundElement = true;
                                        break;
                                    } catch (e) {
                                        console.log('点击label失败:', e);
                                    }
                                }
                            }
                        }
                        
                        return foundElement;
                    })()
                    """)
                    
                    if js_result:
                        self.logger.info("✅ JavaScript成功处理了验证元素")
                        time.sleep(4)  # 等待验证完成
                        
                        # 检查是否成功
                        password_input = self.page.ele('@placeholder=输入密码', timeout=3)
                        if password_input:
                            self.logger.info("🎉 验证成功！检测到密码输入框")
                            captcha_handled = True
                            break
                    
                except Exception as js_e:
                    self.logger.warning(f"JavaScript验证处理失败: {js_e}")
                
                # 方法4：DrissionPage原生方法
                verification_selectors = [
                    'text=确认您是真人',
                    'text=确认你是真人', 
                    'text=Verify you are human',
                    'text=I am human',
                    'input[type="checkbox"]',
                    'label',
                    '[role="checkbox"]',
                    '.cf-turnstile',
                    '.cloudflare-challenge'
                ]
                
                for selector in verification_selectors:
                    try:
                        elements = self.page.eles(selector, timeout=1)
                        if elements:
                            self.logger.info(f"找到 {len(elements)} 个 {selector} 元素")
                            for element in elements:
                                try:
                                    element.click()
                                    self.logger.info(f"已点击 {selector} 元素")
                                    time.sleep(2)
                                    
                                    # 检查是否成功
                                    password_input = self.page.ele('@placeholder=输入密码', timeout=2)
                                    if password_input:
                                        self.logger.info("🎉 验证成功！")
                                        captcha_handled = True
                                        break
                                except Exception:
                                    continue
                            if captcha_handled:
                                break
                    except Exception:
                        continue
                
                if captcha_handled:
                    break
                    
                # 方法5：iframe处理
                try:
                    iframes = self.page.eles('tag:iframe', timeout=1)
                    for iframe in iframes:
                        try:
                            # 直接点击iframe
                            iframe.click()
                            self.logger.info("已点击iframe")
                            time.sleep(2)
                            
                            password_input = self.page.ele('@placeholder=输入密码', timeout=2)
                            if password_input:
                                self.logger.info("🎉 通过iframe验证成功！")
                                captcha_handled = True
                                break
                        except Exception:
                            continue
                    
                    if captcha_handled:
                        break
                        
                except Exception:
                    pass
                
                # 等待后重试
                time.sleep(3)
            
            self.logger.warning(f"等待 {max_wait_time} 秒后仍未找到验证元素")
            return False
            
        except Exception as e:
            self.logger.error(f"人机验证处理过程出错: {e}")
            return False
    
    def _check_captcha_success(self, original_selector: str) -> bool:
        """
        检查人机验证是否成功
        Args:
            original_selector: 原始选择器
        Returns:
            bool: 验证是否成功
        """
        try:
            # 检查原始元素是否消失
            if not self.page.ele(original_selector, timeout=1):
                return True
            
            # 检查是否出现成功标识
            success_indicators = [
                'text=验证成功',
                'text=验证通过',
                'text=Verification successful',
                '@@class=verified',
                '@@class=success',
                '.recaptcha-checkbox-checked'
            ]
            
            for indicator in success_indicators:
                if self.page.ele(indicator, timeout=1):
                    return True
            
            return False
            
        except Exception:
            return False
    
    def _handle_iframe_captcha(self, selectors: list) -> bool:
        """
        处理iframe中的人机验证
        Args:
            selectors: 选择器列表
        Returns:
            bool: 是否处理成功
        """
        try:
            iframes = self.page.eles('tag:iframe', timeout=3)
            if iframes:
                self.logger.info(f"找到 {len(iframes)} 个iframe")
                for i, iframe in enumerate(iframes):
                    try:
                        self.logger.debug(f"检查第 {i+1} 个iframe")
                        
                        # 特别处理reCAPTCHA iframe
                        iframe_src = iframe.attr('src') or ''
                        if 'recaptcha' in iframe_src.lower():
                            self.logger.info("检测到reCAPTCHA iframe")
                            return self._handle_recaptcha_iframe(iframe)
                        
                        # 处理一般iframe
                        iframe_doc = iframe.doc
                        if iframe_doc:
                            for selector in selectors[:10]:  # 只检查前10个主要选择器
                                captcha_element = iframe_doc.ele(selector, timeout=1)
                                if captcha_element:
                                    self.logger.info(f"在iframe中检测到人机验证: {selector}")
                                    captcha_element.click()
                                    self.logger.info("已自动点击iframe中的人机验证")
                                    time.sleep(3)
                                    return True
                    except Exception as iframe_e:
                        self.logger.debug(f"处理iframe {i+1} 时出错: {iframe_e}")
                        continue
            else:
                self.logger.debug("未找到iframe元素")
                
            return False
            
        except Exception as e:
            self.logger.debug(f"检查iframe时出错: {e}")
            return False
    
    def _handle_recaptcha_iframe(self, iframe) -> bool:
        """
        专门处理reCAPTCHA iframe
        Args:
            iframe: iframe元素
        Returns:
            bool: 是否处理成功
        """
        try:
            self.logger.info("处理reCAPTCHA验证...")
            
            # reCAPTCHA特定选择器
            recaptcha_selectors = [
                '.recaptcha-checkbox-border',
                '.recaptcha-checkbox',
                '#recaptcha-anchor',
                '[role="checkbox"]',
                '.rc-anchor-checkbox'
            ]
            
            iframe_doc = iframe.doc
            if iframe_doc:
                for selector in recaptcha_selectors:
                    try:
                        checkbox = iframe_doc.ele(selector, timeout=2)
                        if checkbox:
                            self.logger.info(f"找到reCAPTCHA复选框: {selector}")
                            checkbox.click()
                            self.logger.info("已点击reCAPTCHA复选框")
                            time.sleep(3)
                            return True
                    except Exception:
                        continue
                        
            return False
            
        except Exception as e:
            self.logger.error(f"处理reCAPTCHA时出错: {e}")
            return False
        
    def init_config(self):
        """初始化配置"""
        # 基本设置
        self.login_url = self.config.get('settings', 'login_url')
        self.download_folder = Path(self.config.get('settings', 'download_folder'))
        self.download_folder.mkdir(exist_ok=True)
        self.max_download_files = self.config.getint('settings', 'max_download_files')
        self.min_result_files = self.config.getint('settings', 'min_result_files')
        self.refresh_trigger_text = self.config.get('settings', 'refresh_trigger_text')

        # 等待时间
        self.wait_times = {
            'page_load': self.config.getint('wait_times', 'page_load'),
            'after_click': self.config.getint('wait_times', 'after_click'),
            'between_accounts': self.config.getint('wait_times', 'between_accounts'),
            'download_interval': self.config.getint('wait_times', 'download_interval')
        }

        # 账号列表 - 从配置的账号文件读取
        self.accounts = []
        account_file = self.config.get('settings', 'account_file')
        try:
            with open(account_file, 'r', encoding='utf-8') as f:
                for line_num, line in enumerate(f, 1):
                    line = line.strip()
                    if line and not line.startswith('#'):  # 跳过空行和注释行
                        account_info = line.split('|')
                        if len(account_info) >= 2:
                            self.accounts.append({
                                'email': account_info[0].strip(),
                                'password': account_info[1].strip(),
                                'description': f"账号{line_num}"
                            })
                        else:
                            self.logger.warning(f"{account_file} 第{line_num}行格式错误: {line}")

            if not self.accounts:
                self.logger.error(f"未从{account_file}中读取到任何有效账号")
            else:
                self.logger.info(f"从{account_file}中读取到 {len(self.accounts)} 个账号")

        except FileNotFoundError:
            self.logger.error(f"未找到{account_file}文件，请创建该文件并添加账号信息")
            # 如果文件不存在，尝试从配置文件读取（兼容旧版本）
            for key in self.config['accounts']:
                if key.startswith('account'):
                    account_info = self.config.get('accounts', key).split('|')
                    if len(account_info) >= 3:
                        self.accounts.append({
                            'email': account_info[0],
                            'password': account_info[1],
                            'description': account_info[2]
                        })
        except Exception as e:
            self.logger.error(f"读取{account_file}文件时出错: {e}")

        # 提示词配置
        self.continue_prompt = self.config.get('prompts', 'continue_prompt')
        self.improve_prompt = self.config.get('prompts', 'improve_prompt')
        self.create_docx_prompt = self.config.get('prompts', 'create_docx_prompt')
        self.organize_prompt = self.config.get('prompts', 'organize_prompt')
        

    def init_logging(self):
        """初始化日志"""
        from datetime import datetime

        # 生成按日期命名的日志文件
        current_date = datetime.now().strftime('%y%m%d')
        log_file = f"{current_date}manus_automation.log"

        # 如果配置文件中有自定义日志文件名，则使用配置的前缀
        try:
            config_log_file = self.config.get('settings', 'log_file')
            if config_log_file and config_log_file != 'manus_automation.log':
                # 提取配置文件中的前缀（去掉.log扩展名）
                log_prefix = config_log_file.replace('.log', '')
                log_file = f"{current_date}{log_prefix}.log"
        except:
            pass  # 使用默认的日志文件名格式

        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file, encoding='utf-8'),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)
        self.logger.info(f"日志文件: {log_file}")
        
    def init_browser(self):
        """初始化浏览器"""
        self.page = Chromium().latest_tab
        self.page.set.download_path(str(self.download_folder))
        self.logger.info("浏览器初始化成功")
        return True
    
    def login(self, email: str, password: str) -> bool:
        """
        登录账号 - 优化版本，集成自动人机验证处理
        Args:
            email: 邮箱
            password: 密码
        Returns:
            bool: 登录是否成功
        """
        self.logger.info(f"开始登录账号: {email}")

        try:
            # 访问登录页面
            self.page.get(self.login_url)
            time.sleep(2)
            
            # 输入邮箱
            email_input = self.page.ele('#email', timeout=10)
            if email_input:
                email_input.clear()
                email_input.input(email)
                self.logger.info("已输入邮箱")
            else:
                self.logger.error("未找到邮箱输入框")
                return False
            
            time.sleep(1)
            
            # 启动API监听
            target_url = "https://api.manus.im/session.v1.SessionService/ListSessions"
            self.logger.info(f"开始监听接口: {target_url}")
            self.page.listen.start(target_url)
            
            # 检测并处理人机验证 - 改进的处理流程
            captcha_handled = False
            max_captcha_attempts = 5  # 增加尝试次数
            
            for attempt in range(max_captcha_attempts):
                self.logger.info(f"第{attempt+1}次检查人机验证状态")
                
                # 首先检查是否已经可以进入密码输入阶段（验证可能已经通过）
                password_input = self.page.ele('@placeholder=输入密码', timeout=2)
                if password_input:
                    self.logger.info("检测到密码输入框，人机验证可能已通过")
                    captcha_handled = True
                    break
                
                # 检查是否有继续按钮需要点击
                continue_btn = self.page.ele('text=继续', timeout=2)
                if continue_btn:
                    self.logger.info("检测到继续按钮，可能需要先点击")
                    continue_btn.click()
                    time.sleep(2)
                    continue
                
                # 等待页面加载完成
                time.sleep(2)
                
                # 尝试自动处理人机验证
                if self.auto_handle_captcha():
                    self.logger.info("人机验证处理成功")
                    captcha_handled = True
                    break
                
                # 短暂等待后重试
                time.sleep(3)
            
            if not captcha_handled:
                self.logger.warning("自动人机验证失败，需要人工处理")
                # 系统蜂鸣提示音
                import winsound
                winsound.Beep(1000, 500)
                print('----------需要人工验证登录，请完成验证后继续------------')

            # 等待密码输入框出现并输入密码
            password_attempts = 0
            max_password_attempts = 30  # 最多等待30次，每次2秒
            
            while password_attempts < max_password_attempts:
                password_input = self.page.ele('@placeholder=输入密码', timeout=2)
                if password_input:
                    password_input.clear()
                    password_input.input(password)
                    self.logger.info("已输入密码")
                    break
                else:
                    # 尝试点击继续按钮
                    continue_btn = self.page.ele('text=继续', timeout=1)
                    if continue_btn:
                        continue_btn.click()
                        self.logger.info("点击了继续按钮")
                    time.sleep(2)
                    password_attempts += 1
            
            if password_attempts >= max_password_attempts:
                self.logger.error("等待密码输入框超时")
                return False
            
            # 点击最终的继续按钮
            final_continue_btn = self.page.ele('text=继续', timeout=5)
            if final_continue_btn:
                final_continue_btn.click()
                self.logger.info("点击了最终继续按钮")
            else:
                self.logger.error("未找到最终继续按钮")
                return False

            # 等待登录完成 - 优化的超时处理
            login_timeout = 60  # 最多等待60秒
            start_time = time.time()
            
            while time.time() - start_time < login_timeout:
                try:
                    # 等待数据包，超时时间3秒
                    packet = self.page.listen.wait(timeout=3)

                    if packet and not packet.is_failed:
                        self.logger.info(f"捕获到数据包: {packet.url}")

                        # 解析响应数据
                        response_data = packet.response.body
                        if isinstance(response_data, dict):
                            # 检查是否是会话列表响应
                            if 'sessions' in response_data:
                                sessions = response_data.get('sessions', [])

                                # 如果会话为0个，跳过这个账号
                                if len(sessions) == 0:
                                    self.logger.info("该账号没有会话，跳过处理")
                                    return False

                                # 获取第一个任务会话的uid
                                first_session = sessions[0]
                                session_uid = first_session.get('uid')

                                if session_uid:
                                    # 检查并关闭广告
                                    if self.page.ele(self.refresh_trigger_text, timeout=3):
                                        self.logger.info(f"检测到'{self.refresh_trigger_text}'广告，自动关闭广告")
                                        self.page.refresh()
                                        time.sleep(3)
                                    
                                    # 拼接会话URL并访问
                                    time.sleep(self.wait_times['page_load'])
                                    session_url = f"https://manus.im/app/{session_uid}"
                                    self.logger.info(f"访问第一个任务会话: {session_url}")
                                    self.page.get(session_url)
                                    time.sleep(6)  # 减少等待时间
                                    return True
                                else:
                                    self.logger.error("未找到会话uid")
                                    return False

                except Exception as e:
                    self.logger.debug(f"监听过程中的异常: {e}")
                    continue
                    
        except Exception as e:
            self.logger.error(f"登录过程中出现错误: {e}")
            return False
        finally:
            # 确保停止监听
            try:
                self.page.listen.stop()
            except:
                pass
    
        self.logger.error("登录失败，超时或仍在登录页面")
        return False
    
    def find_latest_conversation(self) -> bool:
        """
        找到最近的第一个对话 - 已在登录方法中处理
        Returns:
            bool: 是否找到对话
        """
        self.logger.info("会话已获取并访问")
        return True
    
    def check_task_status(self) -> str:
        """
        检查任务状态 - 优化版本，提高检测效率
        Returns:
            str: 'interrupted' 中断, 'completed' 已完成, 'waiting_reply' 等待回复, 'unknown' 未知
        """
        self.logger.info("检查任务状态...")

        try:
            # 检查Manus是否正在工作及升级，是则自动退出
            working_selectors = [
                'Manus 正在思考',
                '@@tag()=button@@text()=升级'
            ]
            
            for selector in working_selectors:
                if self.page.ele(selector, timeout=2):
                    self.logger.info("Manus正在工作或需要升级，将自动退出")
                    return 'unknown'

            # 检查任务是否需要继续及继承并继续
            continue_selectors = [
                '@@tag()=button@@text()=继续',
                '@@tag()=button@@text()=继承并继续',
                'Manus 已停止，因为上下文过长，请开始一个新的对话'
            ]
            
            for selector in continue_selectors:
                if self.page.ele(selector, timeout=2):
                    self.logger.info("Manus任务暂停，将自动继续")
                    return 'interrupted'

            # 检查是否等待用户回复
            if self.page.ele('Manus 将在你回复后继续工作', timeout=2):
                self.logger.info("Manus在等待用户回复，将自动回复")
                return 'waiting_reply'

            # 检查任务是否已完成
            completed_selectors = [
                'text=查看此任务中的所有文件',
                'Manus 已完成'
            ]
            
            for selector in completed_selectors:
                if self.page.ele(selector, timeout=2):
                    self.logger.info("Manus任务已完成，将自动下载成果")
                    return 'completed'

            # 检查是否发生内部服务器错误
            error_selectors = [
                '发生了内部服务器错误。请稍后再试',
                '终止任务并退还积分',
                '@@tag()=button@@text()=重置电脑'
            ]
            
            for selector in error_selectors:
                if self.page.ele(selector, timeout=2):
                    self.logger.warning("账号故障，需要人工干预……")
                    
                    # 查找再次尝试按钮
                    retry_button = self.page.ele('@@tag()=button@@text()=再次尝试', timeout=2)
                    if retry_button:
                        retry_button.click()
                        self.logger.info("已点击再次尝试按钮")
                        time.sleep(3)
                        return 'interrupted'  # 返回中断状态，继续监控
                    else:
                        self.logger.error("未找到再次尝试按钮")
                        return 'unknown'

            # 检查是否积分耗尽，要求升级
            if self.page.ele('请升级您的套餐以获取更多积分。', timeout=2):
                self.logger.info("Manus没有可用积分，自动退出")
                return 'topup'

            # 如果都没有检测到，输出页面文本用于调试
            self.logger.warning("无法确定任务状态")
            return 'unknown'
            
        except Exception as e:
            self.logger.error(f"检查任务状态时出错: {e}")
            return 'unknown'

    def _get_unique_filename(self, file_path):
        """
        获取唯一的文件名，如果文件已存在则添加括号数字
        Args:
            file_path: Path对象，原始文件路径
        Returns:
            Path对象，唯一的文件路径
        """
        if not file_path.exists():
            return file_path

        # 分离文件名和扩展名
        stem = file_path.stem  # 文件名（不含扩展名）
        suffix = file_path.suffix  # 扩展名
        parent = file_path.parent  # 父目录

        # 从1开始尝试添加数字
        counter = 1
        while True:
            new_name = f"{stem}({counter}){suffix}"
            new_path = parent / new_name
            if not new_path.exists():
                return new_path
            counter += 1

    def _wait_and_download_files(self):
        """
        等待文件列表API响应并下载前3个文件
        """
        try:
            # 等待API响应，最多等待10秒
            packet = self.page.listen.wait(timeout=10)

            if packet and not packet.is_failed:
                self.logger.info(f"捕获到文件列表API响应: {packet.url}")
                time.sleep(2)

                # 解析响应数据
                response_data = packet.response.body
                if isinstance(response_data, dict) and 'data' in response_data:
                    files = response_data['data'].get('files', [])
                    self.logger.info(f"获取到 {len(files)} 个文件")

                    
                    # 下载前3个文件
                    download_count = min(3, len(files))
                    success_count = 0

                    for i in range(download_count):
                        file_info = files[i]
                        filename = file_info.get('displayFilename', f'file_{i+1}')

                        # 获取下载URL或文件内容
                        raw_files = file_info.get('raw', [])
                        if raw_files and len(raw_files) > 0:
                            raw_file = raw_files[0]
                            download_url = raw_file.get('url')

                            if download_url:
                                # 检查文件名是否需要重命名
                                original_path = self.download_folder / filename
                                unique_path = self._get_unique_filename(original_path)
                                unique_filename = unique_path.name

                                self.logger.info(f"开始下载第 {i+1} 个文件: {unique_filename}")

                                try:
                                    # 使用DrissionPage下载文件
                                    self.page.download(download_url, str(self.download_folder), unique_filename)
                                    success_count += 1
                                    self.logger.info(f"文件 {unique_filename} 下载成功")
                                except Exception as e:
                                    self.logger.error(f"文件 {unique_filename} 下载失败: {e}")

                                time.sleep(self.wait_times['download_interval'])
                            else:
                                # 如果没有URL，尝试获取文件内容
                                file_content = raw_file.get('fileContent')
                                file_name = raw_file.get('filename', filename)

                                if file_content:
                                    # 检查文件名是否需要重命名
                                    original_path = self.download_folder / file_name
                                    unique_path = self._get_unique_filename(original_path)

                                    self.logger.info(f"开始写入第 {i+1} 个文件内容: {unique_path.name}")

                                    try:
                                        with open(unique_path, 'w', encoding='utf-8') as f:
                                            f.write(file_content)

                                        success_count += 1
                                        self.logger.info(f"文件 {unique_path.name} 写入成功")
                                    except Exception as e:
                                        self.logger.error(f"文件 {unique_path.name} 写入失败: {e}")

                                    time.sleep(self.wait_times['download_interval'])
                                else:
                                    self.logger.warning(f"文件 {filename} 既没有下载URL也没有文件内容")
                        else:
                            self.logger.warning(f"文件 {filename} 没有raw数据")

                    self.logger.info(f"文件下载完成，成功下载 {success_count}/{download_count} 个文件")

                    # 检查下载的文件中是否包含docx格式文件
                    has_docx = False
                    downloaded_filenames = []

                    # 收集已下载的文件名
                    for i in range(min(download_count, len(files))):
                        file_info = files[i]
                        filename = file_info.get('displayFilename', f'file_{i+1}')

                        # 检查是否有URL下载的文件
                        raw_files = file_info.get('raw', [])
                        if raw_files and len(raw_files) > 0:
                            raw_file = raw_files[0]
                            if raw_file.get('url'):
                                # 使用displayFilename
                                downloaded_filenames.append(filename)
                            else:
                                # 使用raw中的filename
                                file_name = raw_file.get('filename', filename)
                                downloaded_filenames.append(file_name)

                    # 检查是否有docx文件
                    for filename in downloaded_filenames:
                        if filename.lower().endswith('.docx'):
                            has_docx = True
                            break

                    self.logger.info(f"下载的文件: {downloaded_filenames}")
                    self.logger.info(f"是否包含docx文件: {has_docx}")

                    # 如果没有docx文件，发送生成docx文件的提示词
                    if not has_docx:
                        self.logger.warning("未生成docx成果，将自动发送生成docx指令...")
                        self.page.actions.key_down(Keys.ESCAPE)  # 从Keys获取按键
                        self.page.actions.key_up(Keys.ESCAPE)  # 从Keys获取按键

                        self.logger.info("已关闭文件列表窗口")

                        # 查找提示词输入框，自动发送生成docx文件指令
                        input_box = self.page.ele('@placeholder=发送消息给 Manus')
                        if input_box:
                            # 输入提示词
                            input_box.clear()
                            time.sleep(1)
                            input_box.input(self.create_docx_prompt)
                            self.logger.info(f"已输入生成docx提示词: {self.create_docx_prompt}")

                            # 查找发送按钮
                            send_button = self.page.ele("tag=button",index=-1)
                            if send_button:
                                send_button.click()
                                self.logger.info("已点击发送按钮")
                                time.sleep(3)  # 等待发送完成
                                self.logger.info("已发送生成docx指令")
                                return True
                            else:
                                self.logger.error("未找到发送按钮")
                                return False
                        else:
                            self.logger.error("未找到输入框")
                            return False

                    # """
                    # 从成果文件数量判断成果质量
                    if len(files) < self.min_result_files:
                        self.logger.warning(f"文件数量太少，成果质量不满足要求...")
                        self.page.actions.key_down(Keys.ESCAPE)  # 从Keys获取按键
                        self.page.actions.key_up(Keys.ESCAPE)  # 从Keys获取按键

                        self.logger.info("已关闭文件列表窗口")

                        # 查找提示词输入框，自动发送改进成果质量指令
                        input_box = self.page.ele('@placeholder=发送消息给 Manus')
                        if input_box:
                            # 输入提示词
                            input_box.clear()
                            time.sleep(1)
                            input_box.input(self.improve_prompt)
                            self.logger.info(f"已输入提示词: {self.improve_prompt}")

                            # 查找发送按钮
                            send_button = self.page.ele("tag=button",index=-1)
                            if send_button:
                                send_button.click()
                                self.logger.info("已点击发送按钮")
                                time.sleep(3)  # 等待发送完成
                                self.logger.info("已自动发送成果改进指令")
                                return True
                            else:
                                self.logger.error("未找到发送按钮")
                                return False
                            
                        if len(files) >= self.min_result_files:
                            self.logger.warning(f"文件数量满足要求，成果质量还需提升...")
                            self.page.actions.key_down(Keys.ESCAPE)  # 从Keys获取按键
                            self.page.actions.key_up(Keys.ESCAPE)  # 从Keys获取按键

                            self.logger.info("已关闭文件列表窗口")

                            # 查找提示词输入框，自动发送改进成果质量指令
                            input_box = self.page.ele('@placeholder=发送消息给 Manus')
                            if input_box:
                                # 输入提示词
                                input_box.clear()
                                time.sleep(1)
                                input_box.input(self.organize_prompt)
                                self.logger.info(f"已输入提示词: {self.organize_prompt}")

                                # 查找发送按钮
                                send_button = self.page.ele("tag=button",index=-1)
                                if send_button:
                                    send_button.click()
                                    self.logger.info("已点击发送按钮")
                                    time.sleep(3)  # 等待发送完成
                                    self.logger.info("已自动发送成果改进指令")
                                    return True
                                else:
                                    self.logger.error("未找到发送按钮")
                                    return False

                    # """

                else:
                    self.logger.error("API响应格式不正确")
            else:
                self.logger.error("未能获取到文件列表API响应")

        except Exception as e:
            self.logger.error(f"等待文件列表API响应时出错: {e}")
        finally:
            # 停止监听
            self.page.listen.stop()

    def handle_interrupted_task(self) -> bool:
        """
        处理中断的任务 - 优化版本
        Returns:
            bool: 是否处理成功
        """
        self.logger.info("处理中断的任务...")
        
        try:
            # 查找继续及继承并继续按钮
            continue_selectors = [
                '@@tag()=button@@text()=继续',
                '@@tag()=button@@text()=继承并继续'
            ]
            
            for selector in continue_selectors:
                continue_button = self.page.ele(selector, timeout=5)
                if continue_button:
                    continue_button.click()
                    self.logger.info(f"已自动点击继续按钮: {selector}")
                    time.sleep(2)  # 减少等待时间
                    return True
            
            self.logger.error("未找到继续按钮")
            return False
            
        except Exception as e:
            self.logger.error(f"处理中断任务时出错: {e}")
            return False

    def handle_waiting_reply_task(self) -> bool:
        """
        处理等待回复的任务 - 优化版本
        Returns:
            bool: 是否处理成功
        """
        self.logger.info("处理等待回复的任务...")

        try:
            # 查找提示词输入框
            input_selectors = [
                '@placeholder=发送消息给 Manus',
                'textarea[placeholder*="发送"]',
                'input[placeholder*="消息"]'
            ]
            
            input_box = None
            for selector in input_selectors:
                input_box = self.page.ele(selector, timeout=3)
                if input_box:
                    break
            
            if input_box:
                # 输入提示词
                input_box.clear()
                time.sleep(0.5)
                input_box.input(self.continue_prompt)
                self.logger.info(f"已输入提示词: {self.continue_prompt[:50]}...")

                # 查找发送按钮
                send_selectors = [
                    "tag=button",  # 最后一个按钮
                    'button[type="submit"]',
                    'text=发送'
                ]
                
                for selector in send_selectors:
                    if selector == "tag=button":
                        send_button = self.page.ele(selector, index=-1)  # 最后一个按钮
                    else:
                        send_button = self.page.ele(selector, timeout=2)
                    
                    if send_button:
                        send_button.click()
                        self.logger.info("已点击发送按钮")
                        time.sleep(2)  # 等待发送完成
                        return True
                
                self.logger.error("未找到发送按钮")
                return False
            else:
                self.logger.error("未找到输入框")
                return False
                
        except Exception as e:
            self.logger.error(f"处理等待回复任务时出错: {e}")
            return False

    def handle_improve_task(self) -> bool:
        """
        处理成果质量不满足要求的任务
        Returns:
            bool: 是否处理成功
        """
        self.logger.info("处理成果质量不满足要求的任务...")

        # 查找提示词输入框
        input_box = self.page.ele('@placeholder=发送消息给 Manus')
        if input_box:
            # 输入提示词
            input_box.clear()
            time.sleep(1)
            input_box.input(self.improve_prompt)
            self.logger.info(f"已输入提示词: {self.improve_prompt}")

            # 查找发送按钮
            send_button = self.page.ele("tag=button",index=-1)
            if send_button:
                send_button.click()
                self.logger.info("已点击发送按钮")
                time.sleep(3)  # 等待发送完成
                return True
            else:
                self.logger.error("未找到发送按钮")
                return False    
        else:
            self.logger.error("未找到输入框")
            return False

    def handle_completed_task(self) -> bool:
        """
        处理已完成的任务
        Returns:
            bool: 是否处理成功
        """
        self.logger.info("处理已完成的任务...")

        # 查找"查看此任务中的所有文件"按钮
        file_buttons = self.page.eles('text=查看此任务中的所有文件', timeout=10)
        if file_buttons:
            # 取最后一个按钮
            last_button = file_buttons[-1]
            self.logger.info(f"找到 {len(file_buttons)} 个文件按钮，将点击最后一个")

            # 监听文件列表API
            api_url = "https://api.manus.im/api/chat/getSessionFilesV2"
            self.logger.info(f"开始监听文件列表API: {api_url}")
            self.page.listen.start(api_url)

            # 点击按钮
            last_button.click()
            self.logger.info("已点击查看成果文件按钮")

            # 等待API响应并下载文件
            self._wait_and_download_files()

            return True
        else:
            self.logger.warning("任务已完成，但未找到成果文件按钮…")
            
            return True
    
    def download_files(self) -> bool:
        """
        下载前几个文件
        Returns:
            bool: 是否下载成功
        """
        self.logger.info("开始下载文件…")

        # TODO: 查找下载链接 - 需要手动实现
        download_links_selector = ""  # 在这里填写下载链接的选择器

        if download_links_selector:
            download_links = self.page.eles(download_links_selector, timeout=5)
        else:
            download_links = []

        if not download_links:
            self.logger.error("未找到下载链接，请检查选择器")
            return False


        # 下载前几个文件
        download_count = min(self.max_download_files, len(download_links))
        success_count = 0

        for i in range(download_count):
            link = download_links[i]
            self.logger.info(f"下载第 {i+1} 个文件...")

            # 使用DrissionPage的下载功能
            mission = link.click.to_download(str(self.download_folder))
            if mission:
                mission.wait()  # 等待下载完成
                success_count += 1
                self.logger.info(f"第 {i+1} 个文件下载完成")
            else:
                self.logger.error(f"第 {i+1} 个文件下载失败")

            time.sleep(self.wait_times['download_interval'])

        self.logger.info(f"文件下载完成，成功下载 {success_count}/{download_count} 个文件")
        return success_count > 0


        # 从成果文件数量判断成果质量，不满足时自动发送继续工作指令
        if len(download_links) < self.min_result_files:
            self.logger.warning(f"总共len(download_links)个成果文件，成果质量堪忧，将自动发送改进指令")
            self.logger.info("处理成果质量不满足要求的任务...")
        # 刷新页面，关闭任务文件窗口
        # self.page.refresh()
        # time.sleep(2)

        # 查找提示词输入框
        input_box = self.page.ele('@placeholder=发送消息给 Manus')
        if input_box:
            # 输入提示词
            input_box.clear()
            time.sleep(1)
            input_box.input(self.continue_prompt)
            self.logger.info(f"已输入提示词: {self.continue_prompt}")

            # 查找发送按钮
            send_button = self.page.ele("@@tag=button@@style=transform: scale(1); transition: transform 100ms ease-in-out;")
        if not send_button:
            send_button = self.page.ele('text=发送', timeout=2)
            if send_button:
                send_button.click()
                self.logger.info("已点击发送按钮")
                time.sleep(3)  # 等待发送完成
                self.logger.info("已发送成果改进指令")
                return True
            else:
                self.logger.error("未找到发送按钮")
                return False
        else:
            self.logger.error("未找到输入框")
            return False
    
    def logout(self):
        # input("请手动退出登录...")
        """退出登录"""
        self.logger.info("退出登录...")

        # TODO: 查找退出按钮 - 需要手动实现
        logout_button_selector = ""  # 在这里填写退出按钮的选择器

        if logout_button_selector:
            logout_btn = self.find_element(logout_button_selector, "退出按钮")
            if logout_btn:
                logout_btn.click()
                self.logger.info("点击退出按钮")
                time.sleep(self.wait_times['after_click'])
                return

        # 如果没有退出按钮或找不到，清除缓存
        self.page.clear_cache()
        self.logger.info("清除缓存完成")
    
    def process_account(self, account: Dict) -> bool:
        """
        处理单个账号 - 优化版本，提高效率和稳定性
        Args:
            account: 账号信息
        Returns:
            bool: 是否处理成功
        """
        self.logger.info(f"开始处理账号: {account['email']} ({account['description']})")

        try:
            # 登录
            if not self.login(account['email'], account['password']):
                self.logger.error(f"账号 {account['email']} 登录失败")
                return False

            # 查找最近对话
            if not self.find_latest_conversation():
                self.logger.error(f"账号 {account['email']} 未找到对话")
                return False

            # 任务处理循环 - 最多尝试多次
            max_attempts = 5
            for attempt in range(max_attempts):
                self.logger.info(f"第 {attempt + 1} 次检查任务状态")
                
                # 检查任务状态
                status = self.check_task_status()
                self.logger.info(f"任务状态: {status}")

                success = False
                
                if status == 'interrupted':
                    # 处理中断任务
                    success = self.handle_interrupted_task()
                    if success:
                        # 中断任务处理后继续监控
                        time.sleep(3)
                        continue
                        
                elif status == 'completed':
                    # 处理完成任务
                    success = self.handle_completed_task()
                    break  # 完成任务后退出循环
                    
                elif status == 'waiting_reply':
                    # 处理等待回复任务
                    success = self.handle_waiting_reply_task()
                    if success:
                        # 回复后继续监控
                        time.sleep(3)
                        continue
                        
                elif status == 'topup':
                    # 账号积分耗尽，需要充值
                    self.logger.info(f"账号 {account['email']} 需要充值")
                    success = True
                    break
                    
                else:
                    # 处理其它任务状态
                    self.logger.info(f"账号 {account['email']} 任务调度需要人工干预")
                    # 系统蜂鸣提示音
                    import winsound
                    winsound.Beep(1000, 500)
                    print('----------任务调度需要人工干预------------')
                    success = True
                    break

                if not success:
                    self.logger.warning(f"第 {attempt + 1} 次处理失败，稍后重试")
                    time.sleep(5)  # 等待一下再重试

            # 退出登录
            self.logout()

            self.logger.info(f"账号 {account['email']} 处理完成，结果: {'成功' if success else '失败'}")
            return success
            
        except Exception as e:
            self.logger.error(f"处理账号 {account['email']} 时出现异常: {e}")
            try:
                self.logout()
            except:
                pass
            return False
    
    def run(self):
        """运行自动化脚本 - 优化版本"""
        self.logger.info("**********************************")
        self.logger.info("总包Manus-任务调度自动化脚本 v2.0")
        self.logger.info("功能：")
        self.logger.info("1.批量自动登录Manus账号（集成自动人机验证）")
        self.logger.info("2.自动判断第一个任务的状态")
        self.logger.info("3.根据任务状态执行相应操作：")
        self.logger.info("- 中断：自动领取积分继续执行")
        self.logger.info("- 等待回复：自动发送指令继续执行")
        self.logger.info("- 已完成：自动下载成果文件保存本地")
        self.logger.info("4.智能错误重试和优化的用户体验")
        self.logger.info("@总包千问 专用 Email：51817@qq.com")
        self.logger.info("**********************************")
        self.logger.info("开始运行：总包Manus-任务调度自动化脚本 v2.0")

        try:
            # 初始化浏览器
            if not self.init_browser():
                self.logger.error("浏览器初始化失败")
                return
            
            # 检查账号列表
            if not self.accounts:
                self.logger.error("没有可用的账号，请检查账号文件")
                return
                
            self.logger.info(f"共找到 {len(self.accounts)} 个账号待处理")
            
            # 任务序号
            task_id = 0
            successful_accounts = 0
            failed_accounts = 0

            # 处理每个账号
            for account in self.accounts:
                task_id += 1
                
                print(f"----------当前任务进度: {task_id}/{len(self.accounts)}------------")
                self.logger.info(f"----------当前任务进度: {task_id}/{len(self.accounts)}------------")
                
                try:
                    success = self.process_account(account)
                    if success:
                        successful_accounts += 1
                    else:
                        failed_accounts += 1
                        
                except Exception as e:
                    self.logger.error(f"处理账号 {account['email']} 时发生异常: {e}")
                    failed_accounts += 1
                
                # 账号间等待（最后一个账号不等待）
                if task_id < len(self.accounts):
                    wait_time = self.wait_times['between_accounts']
                    self.logger.info(f"等待 {wait_time} 秒后处理下一个账号...")
                    time.sleep(wait_time)

            # 输出最终统计
            self.logger.info("\n" + "="*50)
            self.logger.info("任务完成统计：")
            self.logger.info(f"总账号数: {len(self.accounts)}")
            self.logger.info(f"成功处理: {successful_accounts}")
            self.logger.info(f"处理失败: {failed_accounts}")
            self.logger.info(f"成功率: {successful_accounts/len(self.accounts)*100:.1f}%")
            self.logger.info("="*50)

            self.logger.info("所有Manus账号任务调度完成")
            self.logger.info("任务调度结束，请关闭谷歌浏览器")
            
            # 结束提示音
            try:
                import winsound
                winsound.Beep(800, 300)  # 低音调提示结束
                time.sleep(0.1)
                winsound.Beep(1000, 300)
                time.sleep(0.1)
                winsound.Beep(1200, 500)
            except:
                pass
                
        except KeyboardInterrupt:
            self.logger.info("用户中断了程序")
        except Exception as e:
            self.logger.error(f"程序运行过程中发生错误: {e}")
        finally:
            # 清理资源
            try:
                if hasattr(self, 'page') and self.page:
                    self.page.listen.stop()
            except:
                pass



def main():
    """主函数"""
    # 创建并运行自动化实例
    automation = ManusAutomation()
    automation.run()

if __name__ == "__main__":
    main()
