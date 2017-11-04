##Access默认的日志格式为例分析：

> 本文作者： icattlecoder  
  本文链接： https://segmentfault.com/a/1190000000489528 ->   
  
$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"

各字段的含义分别是：

1. $remote_addr 请求者IP
1. $remote_user HTTP授权用户，如果不使用Http-based认证方式，其值为空
1. [$time_local] 服务器时间戳
1. "$request" HTTP请求类型(如GET，POST等)+HTTP请求路径(不含参数)+HTTP协议版本
1. $status 服务器返回的状态码(如200，404，5xx等)
1. $body_bytes_sent 服务器响应报文大小，单位byte
1. "$http_referer" referer字段值
1. "$http_user_agent" User Agent字段

以下列举常用的日志分析命令  
根据状态码进行请求次数排序  
`cat access.log | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -r`

输出样例：
```text
210433 200
  38587 302
  17571 304
   4544 502
   2616 499
   1144 500
    706 404
    355 504
    355 301
    252 000
      9 403
      6 206
      2 408
      2 400
```

或者使用awk:  
`awk '{print $9}' access.log | sort | uniq -c | sort -r`

上例显示有704次404请求，接下来是如何找到这些请求的URL
`awk '($9 ~ /404/)' access.log | awk '{print $7}' | sort | uniq -c | sort -r`

输出样列：  
```php
21 /members/katrinakp/activity/2338/
19 /blogger-to-wordpress/robots.txt
14 /rtpanel/robots.txt
```

接下来考虑如果找到这些请求的IP地址，使用命令：  
`awk -F\" '($2 ~ "/wp-admin/install.php"){print $1}' access.log | awk '{print $1}' | sort | uniq -c | sort -r`

输出样例：
```php
14 50.133.11.248
12 97.106.26.244
11 108.247.254.37
10 173.22.165.123
```

php后缀的404请求（通常是嗅探）  
`awk '($9 ~ /404/)' access.log | awk -F\" '($2 ~ "^GET .*\.php")' | awk '{print $7}' | sort | uniq -c | sort -r | head -n 20`  

按URL的请求数排序  
`awk -F\" '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -r`

url包含XYZ:  
`awk -F\" '($2 ~ "ref"){print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -r`

