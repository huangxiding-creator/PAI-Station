.class Lio/minio/MinioAsyncClient$1$1;
.super Ljava/lang/Object;
.source "MinioAsyncClient.java"

# interfaces
.implements Ljava/util/Iterator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/minio/MinioAsyncClient$1;->iterator()Ljava/util/Iterator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Iterator<",
        "Lio/minio/Result<",
        "Lio/minio/messages/DeleteError;",
        ">;>;"
    }
.end annotation


# instance fields
.field private completed:Z

.field private error:Lio/minio/Result;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lio/minio/Result<",
            "Lio/minio/messages/DeleteError;",
            ">;"
        }
    .end annotation
.end field

.field private errorIterator:Ljava/util/Iterator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Iterator<",
            "Lio/minio/messages/DeleteError;",
            ">;"
        }
    .end annotation
.end field

.field private objectIter:Ljava/util/Iterator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Iterator<",
            "Lio/minio/messages/DeleteObject;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$1:Lio/minio/MinioAsyncClient$1;


# direct methods
.method constructor <init>(Lio/minio/MinioAsyncClient$1;)V
    .locals 1
    .param p1, "this$1"    # Lio/minio/MinioAsyncClient$1;

    .line 1118
    iput-object p1, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1119
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    .line 1120
    iput-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->errorIterator:Ljava/util/Iterator;

    .line 1121
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/minio/MinioAsyncClient$1$1;->completed:Z

    .line 1122
    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    iget-object v0, v0, Lio/minio/MinioAsyncClient$1;->val$args:Lio/minio/RemoveObjectsArgs;

    invoke-virtual {v0}, Lio/minio/RemoveObjectsArgs;->objects()Ljava/lang/Iterable;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    iput-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->objectIter:Ljava/util/Iterator;

    return-void
.end method

.method private declared-synchronized populate()V
    .locals 11

    monitor-enter p0

    .line 1136
    :try_start_0
    iget-boolean v0, p0, Lio/minio/MinioAsyncClient$1$1;->completed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 1137
    monitor-exit p0

    return-void

    .line 1141
    :cond_0
    const/4 v0, 0x1

    :try_start_1
    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    .line 1142
    .local v1, "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    :goto_0
    iget-object v2, p0, Lio/minio/MinioAsyncClient$1$1;->objectIter:Ljava/util/Iterator;

    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    const/16 v3, 0x3e8

    if-ge v2, v3, :cond_1

    .line 1143
    iget-object v2, p0, Lio/minio/MinioAsyncClient$1$1;->objectIter:Ljava/util/Iterator;

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/minio/messages/DeleteObject;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 1146
    .end local p0    # "this":Lio/minio/MinioAsyncClient$1$1;
    :cond_1
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    iput-boolean v2, p0, Lio/minio/MinioAsyncClient$1$1;->completed:Z

    .line 1147
    iget-boolean v2, p0, Lio/minio/MinioAsyncClient$1$1;->completed:Z
    :try_end_1
    .catch Lio/minio/errors/ErrorResponseException; {:try_start_1 .. :try_end_1} :catch_a
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/security/InvalidKeyException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Lio/minio/errors/InvalidResponseException; {:try_start_1 .. :try_end_1} :catch_6
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_5
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Lio/minio/errors/ServerException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v2, :cond_2

    monitor-exit p0

    return-void

    .line 1148
    :cond_2
    const/4 v10, 0x0

    .line 1150
    .local v10, "response":Lio/minio/DeleteObjectsResponse;
    :try_start_2
    iget-object v2, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    iget-object v2, v2, Lio/minio/MinioAsyncClient$1;->this$0:Lio/minio/MinioAsyncClient;

    iget-object v3, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    iget-object v3, v3, Lio/minio/MinioAsyncClient$1;->val$args:Lio/minio/RemoveObjectsArgs;

    .line 1152
    invoke-virtual {v3}, Lio/minio/RemoveObjectsArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    iget-object v4, v4, Lio/minio/MinioAsyncClient$1;->val$args:Lio/minio/RemoveObjectsArgs;

    .line 1153
    invoke-virtual {v4}, Lio/minio/RemoveObjectsArgs;->region()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    iget-object v5, v5, Lio/minio/MinioAsyncClient$1;->val$args:Lio/minio/RemoveObjectsArgs;

    .line 1156
    invoke-virtual {v5}, Lio/minio/RemoveObjectsArgs;->bypassGovernanceMode()Z

    move-result v7

    iget-object v5, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    iget-object v5, v5, Lio/minio/MinioAsyncClient$1;->val$args:Lio/minio/RemoveObjectsArgs;

    .line 1157
    invoke-virtual {v5}, Lio/minio/RemoveObjectsArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v8

    iget-object v5, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    iget-object v5, v5, Lio/minio/MinioAsyncClient$1;->val$args:Lio/minio/RemoveObjectsArgs;

    .line 1158
    invoke-virtual {v5}, Lio/minio/RemoveObjectsArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v9

    .line 1151
    const/4 v6, 0x1

    move-object v5, v1

    invoke-virtual/range {v2 .. v9}, Lio/minio/MinioAsyncClient;->deleteObjectsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;ZZLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    .line 1159
    invoke-virtual {v2}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/minio/DeleteObjectsResponse;
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lio/minio/errors/ErrorResponseException; {:try_start_2 .. :try_end_2} :catch_a
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_2 .. :try_end_2} :catch_9
    .catch Lio/minio/errors/InternalException; {:try_start_2 .. :try_end_2} :catch_8
    .catch Ljava/security/InvalidKeyException; {:try_start_2 .. :try_end_2} :catch_7
    .catch Lio/minio/errors/InvalidResponseException; {:try_start_2 .. :try_end_2} :catch_6
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Lio/minio/errors/ServerException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v10, v2

    .line 1164
    goto :goto_1

    .line 1162
    :catch_0
    move-exception v2

    .line 1163
    .local v2, "e":Ljava/util/concurrent/ExecutionException;
    :try_start_3
    iget-object v3, p0, Lio/minio/MinioAsyncClient$1$1;->this$1:Lio/minio/MinioAsyncClient$1;

    iget-object v3, v3, Lio/minio/MinioAsyncClient$1;->this$0:Lio/minio/MinioAsyncClient;

    invoke-virtual {v3, v2}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1165
    .end local v2    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_1
    invoke-virtual {v10}, Lio/minio/DeleteObjectsResponse;->result()Lio/minio/messages/DeleteResult;

    move-result-object v2

    invoke-virtual {v2}, Lio/minio/messages/DeleteResult;->errorList()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_3

    .line 1166
    invoke-virtual {v10}, Lio/minio/DeleteObjectsResponse;->result()Lio/minio/messages/DeleteResult;

    move-result-object v2

    invoke-virtual {v2}, Lio/minio/messages/DeleteResult;->errorList()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    iput-object v2, p0, Lio/minio/MinioAsyncClient$1$1;->errorIterator:Ljava/util/Iterator;

    .line 1167
    invoke-direct {p0}, Lio/minio/MinioAsyncClient$1$1;->setError()V

    .line 1168
    iput-boolean v0, p0, Lio/minio/MinioAsyncClient$1$1;->completed:Z

    .line 1181
    .end local v1    # "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .end local v10    # "response":Lio/minio/DeleteObjectsResponse;
    :cond_3
    goto :goto_3

    .line 1160
    .restart local v1    # "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .restart local v10    # "response":Lio/minio/DeleteObjectsResponse;
    :catch_1
    move-exception v2

    .line 1161
    .local v2, "e":Ljava/lang/InterruptedException;
    new-instance v3, Ljava/lang/RuntimeException;

    invoke-direct {v3, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v3
    :try_end_3
    .catch Lio/minio/errors/ErrorResponseException; {:try_start_3 .. :try_end_3} :catch_a
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_3 .. :try_end_3} :catch_9
    .catch Lio/minio/errors/InternalException; {:try_start_3 .. :try_end_3} :catch_8
    .catch Ljava/security/InvalidKeyException; {:try_start_3 .. :try_end_3} :catch_7
    .catch Lio/minio/errors/InvalidResponseException; {:try_start_3 .. :try_end_3} :catch_6
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_5
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_3 .. :try_end_3} :catch_4
    .catch Lio/minio/errors/ServerException; {:try_start_3 .. :try_end_3} :catch_3
    .catch Lio/minio/errors/XmlParserException; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1170
    .end local v1    # "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .end local v2    # "e":Ljava/lang/InterruptedException;
    .end local v10    # "response":Lio/minio/DeleteObjectsResponse;
    :catch_2
    move-exception v1

    goto :goto_2

    :catch_3
    move-exception v1

    goto :goto_2

    :catch_4
    move-exception v1

    goto :goto_2

    :catch_5
    move-exception v1

    goto :goto_2

    :catch_6
    move-exception v1

    goto :goto_2

    :catch_7
    move-exception v1

    goto :goto_2

    :catch_8
    move-exception v1

    goto :goto_2

    :catch_9
    move-exception v1

    goto :goto_2

    :catch_a
    move-exception v1

    .line 1179
    .local v1, "e":Ljava/lang/Exception;
    :goto_2
    :try_start_4
    new-instance v2, Lio/minio/Result;

    invoke-direct {v2, v1}, Lio/minio/Result;-><init>(Ljava/lang/Exception;)V

    iput-object v2, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    .line 1180
    iput-boolean v0, p0, Lio/minio/MinioAsyncClient$1$1;->completed:Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1182
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_3
    monitor-exit p0

    return-void

    .line 1135
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private setError()V
    .locals 3

    .line 1125
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    .line 1126
    :goto_0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->errorIterator:Ljava/util/Iterator;

    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1127
    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->errorIterator:Ljava/util/Iterator;

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/DeleteError;

    .line 1128
    .local v0, "deleteError":Lio/minio/messages/DeleteError;
    const-string v1, "NoSuchVersion"

    invoke-virtual {v0}, Lio/minio/messages/DeleteError;->code()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1129
    new-instance v1, Lio/minio/Result;

    invoke-direct {v1, v0}, Lio/minio/Result;-><init>(Ljava/lang/Object;)V

    iput-object v1, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    .line 1130
    goto :goto_1

    .line 1132
    .end local v0    # "deleteError":Lio/minio/messages/DeleteError;
    :cond_0
    goto :goto_0

    .line 1133
    :cond_1
    :goto_1
    return-void
.end method


# virtual methods
.method public hasNext()Z
    .locals 1

    .line 1186
    nop

    :goto_0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    if-nez v0, :cond_0

    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->errorIterator:Ljava/util/Iterator;

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lio/minio/MinioAsyncClient$1$1;->completed:Z

    if-nez v0, :cond_0

    .line 1187
    invoke-direct {p0}, Lio/minio/MinioAsyncClient$1$1;->populate()V

    goto :goto_0

    .line 1190
    :cond_0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->errorIterator:Ljava/util/Iterator;

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lio/minio/MinioAsyncClient$1$1;->setError()V

    .line 1191
    :cond_1
    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    return v0

    .line 1192
    :cond_2
    iget-boolean v0, p0, Lio/minio/MinioAsyncClient$1$1;->completed:Z

    if-eqz v0, :cond_3

    const/4 v0, 0x0

    return v0

    .line 1194
    :cond_3
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->errorIterator:Ljava/util/Iterator;

    .line 1195
    invoke-virtual {p0}, Lio/minio/MinioAsyncClient$1$1;->hasNext()Z

    move-result v0

    return v0
.end method

.method public next()Lio/minio/Result;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lio/minio/Result<",
            "Lio/minio/messages/DeleteError;",
            ">;"
        }
    .end annotation

    .line 1200
    invoke-virtual {p0}, Lio/minio/MinioAsyncClient$1$1;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1202
    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    if-eqz v0, :cond_0

    .line 1203
    iget-object v0, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    .line 1204
    .local v0, "error":Lio/minio/Result;, "Lio/minio/Result<Lio/minio/messages/DeleteError;>;"
    const/4 v1, 0x0

    iput-object v1, p0, Lio/minio/MinioAsyncClient$1$1;->error:Lio/minio/Result;

    .line 1205
    return-object v0

    .line 1209
    .end local v0    # "error":Lio/minio/Result;, "Lio/minio/Result<Lio/minio/messages/DeleteError;>;"
    :cond_0
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0

    .line 1200
    :cond_1
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public bridge synthetic next()Ljava/lang/Object;
    .locals 1

    .line 1118
    invoke-virtual {p0}, Lio/minio/MinioAsyncClient$1$1;->next()Lio/minio/Result;

    move-result-object v0

    return-object v0
.end method

.method public remove()V
    .locals 1

    .line 1214
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method
