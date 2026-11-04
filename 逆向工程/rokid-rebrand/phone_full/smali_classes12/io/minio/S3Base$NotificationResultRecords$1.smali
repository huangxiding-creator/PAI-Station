.class Lio/minio/S3Base$NotificationResultRecords$1;
.super Ljava/lang/Object;
.source "S3Base.java"

# interfaces
.implements Lio/minio/CloseableIterator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/minio/S3Base$NotificationResultRecords;->closeableIterator()Lio/minio/CloseableIterator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lio/minio/CloseableIterator<",
        "Lio/minio/Result<",
        "Lio/minio/messages/NotificationRecords;",
        ">;>;"
    }
.end annotation


# instance fields
.field isClosed:Z

.field records:Lio/minio/messages/NotificationRecords;

.field recordsString:Ljava/lang/String;

.field final synthetic this$0:Lio/minio/S3Base$NotificationResultRecords;


# direct methods
.method constructor <init>(Lio/minio/S3Base$NotificationResultRecords;)V
    .locals 1
    .param p1, "this$0"    # Lio/minio/S3Base$NotificationResultRecords;

    .line 1537
    iput-object p1, p0, Lio/minio/S3Base$NotificationResultRecords$1;->this$0:Lio/minio/S3Base$NotificationResultRecords;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1538
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    .line 1539
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->records:Lio/minio/messages/NotificationRecords;

    .line 1540
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->isClosed:Z

    return-void
.end method


# virtual methods
.method public close()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1544
    iget-boolean v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->isClosed:Z

    if-nez v0, :cond_0

    .line 1546
    const/4 v0, 0x1

    :try_start_0
    iget-object v1, p0, Lio/minio/S3Base$NotificationResultRecords$1;->this$0:Lio/minio/S3Base$NotificationResultRecords;

    iget-object v1, v1, Lio/minio/S3Base$NotificationResultRecords;->response:Lokhttp3/Response;

    invoke-virtual {v1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->close()V

    .line 1547
    iget-object v1, p0, Lio/minio/S3Base$NotificationResultRecords$1;->this$0:Lio/minio/S3Base$NotificationResultRecords;

    iget-object v1, v1, Lio/minio/S3Base$NotificationResultRecords;->scanner:Ljava/util/Scanner;

    invoke-virtual {v1}, Ljava/util/Scanner;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1549
    iput-boolean v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->isClosed:Z

    .line 1550
    goto :goto_0

    .line 1549
    :catchall_0
    move-exception v1

    iput-boolean v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->isClosed:Z

    .line 1550
    throw v1

    .line 1552
    :cond_0
    :goto_0
    return-void
.end method

.method public hasNext()Z
    .locals 1

    .line 1576
    invoke-virtual {p0}, Lio/minio/S3Base$NotificationResultRecords$1;->populate()Z

    move-result v0

    return v0
.end method

.method public next()Lio/minio/Result;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lio/minio/Result<",
            "Lio/minio/messages/NotificationRecords;",
            ">;"
        }
    .end annotation

    .line 1581
    iget-boolean v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->isClosed:Z

    if-nez v0, :cond_3

    .line 1582
    iget-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-virtual {p0}, Lio/minio/S3Base$NotificationResultRecords$1;->populate()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1587
    :cond_1
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lio/minio/S3Base$NotificationResultRecords$1;->this$0:Lio/minio/S3Base$NotificationResultRecords;

    iget-object v1, v1, Lio/minio/S3Base$NotificationResultRecords;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    iget-object v2, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    const-class v3, Lio/minio/messages/NotificationRecords;

    invoke-virtual {v1, v2, v3}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readValue(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/messages/NotificationRecords;

    iput-object v1, p0, Lio/minio/S3Base$NotificationResultRecords$1;->records:Lio/minio/messages/NotificationRecords;

    .line 1588
    new-instance v1, Lio/minio/Result;

    iget-object v2, p0, Lio/minio/S3Base$NotificationResultRecords$1;->records:Lio/minio/messages/NotificationRecords;

    invoke-direct {v1, v2}, Lio/minio/Result;-><init>(Ljava/lang/Object;)V
    :try_end_0
    .catch Lcom/fasterxml/jackson/databind/JsonMappingException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lcom/fasterxml/jackson/core/JsonParseException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1596
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    .line 1597
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->records:Lio/minio/messages/NotificationRecords;

    .line 1588
    return-object v1

    .line 1596
    :catchall_0
    move-exception v1

    goto :goto_0

    .line 1593
    :catch_0
    move-exception v1

    .line 1594
    .local v1, "e":Ljava/io/IOException;
    :try_start_1
    new-instance v2, Lio/minio/Result;

    invoke-direct {v2, v1}, Lio/minio/Result;-><init>(Ljava/lang/Exception;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1596
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    .line 1597
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->records:Lio/minio/messages/NotificationRecords;

    .line 1594
    return-object v2

    .line 1591
    .end local v1    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v1

    .line 1592
    .local v1, "e":Lcom/fasterxml/jackson/core/JsonParseException;
    :try_start_2
    new-instance v2, Lio/minio/Result;

    invoke-direct {v2, v1}, Lio/minio/Result;-><init>(Ljava/lang/Exception;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1596
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    .line 1597
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->records:Lio/minio/messages/NotificationRecords;

    .line 1592
    return-object v2

    .line 1589
    .end local v1    # "e":Lcom/fasterxml/jackson/core/JsonParseException;
    :catch_2
    move-exception v1

    .line 1590
    .local v1, "e":Lcom/fasterxml/jackson/databind/JsonMappingException;
    :try_start_3
    new-instance v2, Lio/minio/Result;

    invoke-direct {v2, v1}, Lio/minio/Result;-><init>(Ljava/lang/Exception;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1596
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    .line 1597
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->records:Lio/minio/messages/NotificationRecords;

    .line 1590
    return-object v2

    .line 1596
    .end local v1    # "e":Lcom/fasterxml/jackson/databind/JsonMappingException;
    :goto_0
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    .line 1597
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->records:Lio/minio/messages/NotificationRecords;

    .line 1598
    throw v1

    .line 1583
    :cond_2
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0

    .line 1581
    :cond_3
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public bridge synthetic next()Ljava/lang/Object;
    .locals 1

    .line 1537
    invoke-virtual {p0}, Lio/minio/S3Base$NotificationResultRecords$1;->next()Lio/minio/Result;

    move-result-object v0

    return-object v0
.end method

.method public populate()Z
    .locals 4

    .line 1555
    iget-boolean v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->isClosed:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 1556
    :cond_0
    iget-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    return v2

    .line 1558
    :cond_1
    iget-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->this$0:Lio/minio/S3Base$NotificationResultRecords;

    iget-object v0, v0, Lio/minio/S3Base$NotificationResultRecords;->scanner:Ljava/util/Scanner;

    invoke-virtual {v0}, Ljava/util/Scanner;->hasNext()Z

    move-result v0

    const-string v3, ""

    if-eqz v0, :cond_2

    .line 1559
    iget-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->this$0:Lio/minio/S3Base$NotificationResultRecords;

    iget-object v0, v0, Lio/minio/S3Base$NotificationResultRecords;->scanner:Ljava/util/Scanner;

    invoke-virtual {v0}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    .line 1560
    iget-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1563
    :cond_2
    iget-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lio/minio/S3Base$NotificationResultRecords$1;->recordsString:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_0

    .line 1571
    :cond_3
    return v2

    .line 1565
    :cond_4
    :goto_0
    :try_start_0
    invoke-virtual {p0}, Lio/minio/S3Base$NotificationResultRecords$1;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1568
    goto :goto_1

    .line 1566
    :catch_0
    move-exception v0

    .line 1567
    .local v0, "e":Ljava/io/IOException;
    iput-boolean v2, p0, Lio/minio/S3Base$NotificationResultRecords$1;->isClosed:Z

    .line 1569
    .end local v0    # "e":Ljava/io/IOException;
    :goto_1
    return v1
.end method
