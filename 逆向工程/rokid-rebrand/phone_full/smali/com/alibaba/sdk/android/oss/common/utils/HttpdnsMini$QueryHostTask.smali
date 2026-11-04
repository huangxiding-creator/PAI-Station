.class Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;
.super Ljava/lang/Object;
.source "HttpdnsMini.java"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "QueryHostTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/concurrent/Callable<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field private hasRetryed:Z

.field private hostName:Ljava/lang/String;

.field final synthetic this$0:Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;Ljava/lang/String;)V
    .locals 1
    .param p1, "this$0"    # Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;
    .param p2, "hostToQuery"    # Ljava/lang/String;

    .line 124
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->this$0:Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 122
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->hasRetryed:Z

    .line 125
    iput-object p2, p0, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->hostName:Ljava/lang/String;

    .line 126
    return-void
.end method


# virtual methods
.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 120
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->call()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public call()Ljava/lang/String;
    .locals 22

    .line 130
    move-object/from16 v1, p0

    const-string v2, "203.107.1.1"

    .line 131
    .local v2, "chooseServerAddress":Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "https://"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "/"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "181345"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "/d?host="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v3, v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->hostName:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 132
    .local v3, "resolveUrl":Ljava/lang/String;
    const/4 v4, 0x0

    .line 133
    .local v4, "in":Ljava/io/InputStream;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[httpdnsmini] - buildUrl: "

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 135
    :try_start_0
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    move-object v6, v0

    .line 136
    .local v6, "conn":Ljava/net/HttpURLConnection;
    const/16 v0, 0x2710

    invoke-virtual {v6, v0}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 137
    invoke-virtual {v6, v0}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 138
    invoke-virtual {v6}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    const/16 v7, 0xc8

    if-eq v0, v7, :cond_0

    .line 139
    :try_start_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[httpdnsmini] - responseCodeNot 200, but: "

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v6}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v7

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object/from16 v16, v2

    move-object/from16 v21, v3

    goto/16 :goto_4

    .line 178
    .end local v6    # "conn":Ljava/net/HttpURLConnection;
    :catchall_0
    move-exception v0

    move-object/from16 v16, v2

    move-object/from16 v21, v3

    move-object v2, v0

    goto/16 :goto_8

    .line 172
    :catch_0
    move-exception v0

    move-object/from16 v16, v2

    move-object/from16 v21, v3

    goto/16 :goto_6

    .line 141
    .restart local v6    # "conn":Ljava/net/HttpURLConnection;
    :cond_0
    :try_start_2
    invoke-virtual {v6}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    move-object v4, v0

    .line 142
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v7, Ljava/io/InputStreamReader;

    const-string v8, "UTF-8"

    invoke-direct {v7, v4, v8}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v0, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    move-object v7, v0

    .line 143
    .local v7, "streamReader":Ljava/io/BufferedReader;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object v8, v0

    .line 145
    .local v8, "sb":Ljava/lang/StringBuilder;
    :goto_0
    invoke-virtual {v7}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object v9, v0

    .local v9, "line":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 146
    :try_start_3
    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 148
    :cond_1
    :try_start_4
    new-instance v0, Lorg/json/JSONObject;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v0, v10}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    move-object v10, v0

    .line 149
    .local v10, "json":Lorg/json/JSONObject;
    const-string v0, "host"

    invoke-virtual {v10, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v11, v0

    .line 150
    .local v11, "host":Ljava/lang/String;
    const-string/jumbo v0, "ttl"

    invoke-virtual {v10, v0}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v12

    .line 151
    .local v12, "ttl":J
    const-string v0, "ips"

    invoke-virtual {v10, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    move-object v14, v0

    .line 152
    .local v14, "ips":Lorg/json/JSONArray;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "[httpdnsmini] - ips:"

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v14}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 153
    if-eqz v11, :cond_6

    if-eqz v14, :cond_6

    invoke-virtual {v14}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_6

    .line 154
    const-wide/16 v15, 0x0

    cmp-long v0, v12, v15

    if-nez v0, :cond_2

    .line 157
    const-wide/16 v12, 0x1e

    .line 159
    :cond_2
    new-instance v0, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;

    iget-object v15, v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->this$0:Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;

    invoke-direct {v0, v15}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;-><init>(Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;)V

    move-object v15, v0

    .line 160
    .local v15, "hostObject":Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;
    if-nez v14, :cond_3

    const/4 v0, 0x0

    goto :goto_1

    :cond_3
    const/4 v0, 0x0

    invoke-virtual {v14, v0}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object/from16 v16, v0

    .line 161
    .local v16, "ip":Ljava/lang/String;
    invoke-virtual {v15, v11}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;->setHostName(Ljava/lang/String;)V

    .line 162
    invoke-virtual {v15, v12, v13}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;->setTtl(J)V

    .line 163
    move-object/from16 v5, v16

    .end local v16    # "ip":Ljava/lang/String;
    .local v5, "ip":Ljava/lang/String;
    invoke-virtual {v15, v5}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;->setIp(Ljava/lang/String;)V

    .line 164
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v17
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    const-wide/16 v19, 0x3e8

    move-object/from16 v16, v2

    move-object/from16 v21, v3

    .end local v2    # "chooseServerAddress":Ljava/lang/String;
    .end local v3    # "resolveUrl":Ljava/lang/String;
    .local v16, "chooseServerAddress":Ljava/lang/String;
    .local v21, "resolveUrl":Ljava/lang/String;
    :try_start_5
    div-long v2, v17, v19

    invoke-virtual {v15, v2, v3}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;->setQueryTime(J)V

    .line 165
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[httpdnsmini] - resolve result:"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v15}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 166
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->this$0:Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;->access$000(Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;)Ljava/util/concurrent/ConcurrentMap;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/ConcurrentMap;->size()I

    move-result v0

    const/16 v2, 0x64

    if-ge v0, v2, :cond_4

    .line 167
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->this$0:Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;->access$000(Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini;)Ljava/util/concurrent/ConcurrentMap;

    move-result-object v0

    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->hostName:Ljava/lang/String;

    invoke-interface {v0, v2, v15}, Ljava/util/concurrent/ConcurrentMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 169
    :cond_4
    nop

    .line 179
    if-eqz v4, :cond_5

    .line 180
    :try_start_6
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_2

    .line 182
    :catch_1
    move-exception v0

    move-object v2, v0

    move-object v0, v2

    .line 183
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 184
    .end local v0    # "e":Ljava/io/IOException;
    :cond_5
    :goto_2
    nop

    .line 169
    :goto_3
    return-object v5

    .line 172
    .end local v5    # "ip":Ljava/lang/String;
    .end local v6    # "conn":Ljava/net/HttpURLConnection;
    .end local v7    # "streamReader":Ljava/io/BufferedReader;
    .end local v8    # "sb":Ljava/lang/StringBuilder;
    .end local v9    # "line":Ljava/lang/String;
    .end local v10    # "json":Lorg/json/JSONObject;
    .end local v11    # "host":Ljava/lang/String;
    .end local v12    # "ttl":J
    .end local v14    # "ips":Lorg/json/JSONArray;
    .end local v15    # "hostObject":Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$HostObject;
    :catch_2
    move-exception v0

    goto :goto_6

    .line 153
    .end local v16    # "chooseServerAddress":Ljava/lang/String;
    .end local v21    # "resolveUrl":Ljava/lang/String;
    .restart local v2    # "chooseServerAddress":Ljava/lang/String;
    .restart local v3    # "resolveUrl":Ljava/lang/String;
    .restart local v6    # "conn":Ljava/net/HttpURLConnection;
    .restart local v7    # "streamReader":Ljava/io/BufferedReader;
    .restart local v8    # "sb":Ljava/lang/StringBuilder;
    .restart local v9    # "line":Ljava/lang/String;
    .restart local v10    # "json":Lorg/json/JSONObject;
    .restart local v11    # "host":Ljava/lang/String;
    .restart local v12    # "ttl":J
    .restart local v14    # "ips":Lorg/json/JSONArray;
    :cond_6
    move-object/from16 v16, v2

    move-object/from16 v21, v3

    .line 179
    .end local v2    # "chooseServerAddress":Ljava/lang/String;
    .end local v3    # "resolveUrl":Ljava/lang/String;
    .end local v6    # "conn":Ljava/net/HttpURLConnection;
    .end local v7    # "streamReader":Ljava/io/BufferedReader;
    .end local v8    # "sb":Ljava/lang/StringBuilder;
    .end local v9    # "line":Ljava/lang/String;
    .end local v10    # "json":Lorg/json/JSONObject;
    .end local v11    # "host":Ljava/lang/String;
    .end local v12    # "ttl":J
    .end local v14    # "ips":Lorg/json/JSONArray;
    .restart local v16    # "chooseServerAddress":Ljava/lang/String;
    .restart local v21    # "resolveUrl":Ljava/lang/String;
    :goto_4
    if-eqz v4, :cond_7

    .line 180
    :try_start_7
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_5

    .line 182
    :catch_3
    move-exception v0

    move-object v2, v0

    move-object v0, v2

    .line 183
    .restart local v0    # "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 185
    .end local v0    # "e":Ljava/io/IOException;
    goto :goto_7

    .line 184
    :cond_7
    :goto_5
    goto :goto_7

    .line 178
    .end local v16    # "chooseServerAddress":Ljava/lang/String;
    .end local v21    # "resolveUrl":Ljava/lang/String;
    .restart local v2    # "chooseServerAddress":Ljava/lang/String;
    .restart local v3    # "resolveUrl":Ljava/lang/String;
    :catchall_1
    move-exception v0

    move-object/from16 v16, v2

    move-object/from16 v21, v3

    move-object v2, v0

    .end local v2    # "chooseServerAddress":Ljava/lang/String;
    .end local v3    # "resolveUrl":Ljava/lang/String;
    .restart local v16    # "chooseServerAddress":Ljava/lang/String;
    .restart local v21    # "resolveUrl":Ljava/lang/String;
    goto :goto_8

    .line 172
    .end local v16    # "chooseServerAddress":Ljava/lang/String;
    .end local v21    # "resolveUrl":Ljava/lang/String;
    .restart local v2    # "chooseServerAddress":Ljava/lang/String;
    .restart local v3    # "resolveUrl":Ljava/lang/String;
    :catch_4
    move-exception v0

    move-object/from16 v16, v2

    move-object/from16 v21, v3

    .line 173
    .end local v2    # "chooseServerAddress":Ljava/lang/String;
    .end local v3    # "resolveUrl":Ljava/lang/String;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v16    # "chooseServerAddress":Ljava/lang/String;
    .restart local v21    # "resolveUrl":Ljava/lang/String;
    :goto_6
    :try_start_8
    invoke-static {}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->isEnableLog()Z

    move-result v2

    if-eqz v2, :cond_8

    .line 174
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 175
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    .line 179
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_8
    if-eqz v4, :cond_7

    .line 180
    :try_start_9
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3

    goto :goto_5

    .line 186
    :goto_7
    iget-boolean v0, v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->hasRetryed:Z

    if-nez v0, :cond_9

    .line 187
    const/4 v0, 0x1

    iput-boolean v0, v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->hasRetryed:Z

    .line 188
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/oss/common/utils/HttpdnsMini$QueryHostTask;->call()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 190
    :cond_9
    const/4 v2, 0x0

    return-object v2

    .line 178
    :catchall_2
    move-exception v0

    move-object v2, v0

    .line 179
    :goto_8
    if-eqz v4, :cond_a

    .line 180
    :try_start_a
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_5

    goto :goto_9

    .line 182
    :catch_5
    move-exception v0

    move-object v3, v0

    move-object v0, v3

    .line 183
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_a

    .line 184
    .end local v0    # "e":Ljava/io/IOException;
    :cond_a
    :goto_9
    nop

    .line 185
    :goto_a
    throw v2
.end method
