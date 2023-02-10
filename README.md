- elastic 裝 es 的, 先執行 start.sh 建好 esdata 永存目錄 , 在使用 docker-compose up -d 啟動就可 , PS: 5601,9200 port 防火牆要開
- filebeat 你放到你要收集的機器上 , 異動 .env
   1.  ES_SERVER:  設定 elasetic 機器的 ip
   2.  SVC: 收集的服務名稱
   3. LOG_PATH: 收集 log 的位置
- filebeat 啟動使用它目錄下的 ./start.sh , 記得改一下 docker-compose up -d , 主要使用 gen_template.sh 來建立 template.json

建好後可以看一下 policy 的 warm phase 和 cold phase 設定的回收時間 , 他是自動建立後, 會依超過 cold 的天數就自動刪除

如要重建 policy 和 template
1. 先刪 data streames 和 template 才可以刪 policy
