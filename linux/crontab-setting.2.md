## Crontab 定时任务设置

<table>
    <tr>
        <th>功能</th>
        <th>命令</th>
    </tr>
    <tr>
        <td>编辑定时任务</td>
        <td>crontab -e</td>
    </tr>
    <tr>
        <td>查看定时任务列表</td>
        <td>crontab -l</td>
    </tr>
    <tr>
        <td>重启定时任务</td>
        <td>service cron restart</td>
    </tr>    
</table>

##### 配置定时任务日志

1. 系统日志配置 vim /etc/rsyslog.d/50-default.conf
1. 打开定时任务日志 cron.*  /var/log/cron.log

        
