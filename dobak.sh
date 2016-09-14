#!/bin/bash

database=blog
mysqlusername=blogRoot
mysqlpassword=blogRoot,123

#生成备份sql语句
echo $mysqlpassword |  nice -n 19 mysqldump -u$mysqlusername -p$mysqlpassword  --database $database  > $database-$(date +%Y%m%d).sql
    
# 将生成的SQL文件压缩
nice -n 19 tar zPcf $database-$(date +%Y%m%d).sql.tar.gz $database-$(date +%Y%m%d).sql
    
# 删除7天之前的备份数据
find . -mtime +7 -name "*.sql.tar.gz" -exec rm -rf {} \;

# 删除生成的SQL文件
rm -rf ./*.sql

git add .
git commit -m "$(date +%Y%m%d)"
git push


