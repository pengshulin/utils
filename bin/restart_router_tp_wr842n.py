#!/usr/bin/env python
# coding:utf8
# 重启路由器TP-WR842N
# Peng Shulin <trees_peng@163.com>
import time
from splinter import Browser
import os

def restart(url, username, passwd):
    browser = Browser()
    browser.visit(url)
    time.sleep(1)
    browser.find_by_id('pcPassword').fill(passwd)
    browser.find_by_id('loginBtn').click()
    time.sleep(1)
    with browser.get_iframe('bottomLeftFrame') as iframe:
        iframe.find_link_by_text(u'系统工具').click()
        iframe.find_link_by_text(u'重启路由器').click()
    try:
        with browser.get_iframe('mainFrame') as iframe:
            iframe.find_by_value(u'重启路由器').click()
    except:
        pass
    alert = browser.get_alert()
    #print alert.text
    alert.accept()
    time.sleep(1)
    browser.quit()

if __name__ == '__main__':
    hostname = os.getenv('HOSTNAME','192.168.1.1')
    user = os.getenv('USER', 'admin')
    passwd = os.getenv('PASSWD', 'nopasswd') 
    restart('http://%s'% hostname, user, passwd)


