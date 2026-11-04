.class public Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;
.super Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;
.source "SequenceUploadTask.java"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<",
        "Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;",
        "Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;",
        ">;",
        "Ljava/util/concurrent/Callable<",
        "Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;",
        ">;"
    }
.end annotation


# instance fields
.field private mAlreadyUploadIndex:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private mCRC64RecordFile:Ljava/io/File;

.field private mFirstPartSize:J

.field private mRecordFile:Ljava/io/File;

.field private mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;Lcom/alibaba/sdk/android/oss/network/ExecutionContext;Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;)V
    .locals 1
    .param p1, "request"    # Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;
    .param p3, "context"    # Lcom/alibaba/sdk/android/oss/network/ExecutionContext;
    .param p4, "apiOperation"    # Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;",
            "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<",
            "Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;",
            "Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;",
            ">;",
            "Lcom/alibaba/sdk/android/oss/network/ExecutionContext;",
            "Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;",
            ")V"
        }
    .end annotation

    .line 66
    .local p2, "completedCallback":Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;, "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;>;"
    invoke-direct {p0, p4, p1, p2, p3}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;-><init>(Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;Lcom/alibaba/sdk/android/oss/network/ExecutionContext;)V

    .line 58
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    .line 67
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->instance(Landroid/content/Context;)Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    .line 68
    return-void
.end method


# virtual methods
.method protected abortThisUpload()V
    .locals 4

    .line 398
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 399
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v1, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    .line 400
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v2, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-direct {v0, v1, v2, v3}, Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 401
    .local v0, "abort":Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->abortMultipartUpload(Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;)Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;->waitUntilFinished()V

    .line 403
    .end local v0    # "abort":Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;
    :cond_0
    return-void
.end method

.method protected checkException()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;,
            Lcom/alibaba/sdk/android/oss/ClientException;
        }
    .end annotation

    .line 362
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 363
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->deleteUploadOnCancelling()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 364
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->abortThisUpload()V

    .line 365
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    if-eqz v0, :cond_4

    .line 366
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    goto/16 :goto_3

    .line 369
    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartETags:Ljava/util/List;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_4

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCheckCRC64:Z

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 370
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 371
    .local v0, "maps":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/sdk/android/oss/model/PartETag;

    .line 372
    .local v2, "eTag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getCRC64()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 373
    .end local v2    # "eTag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    goto :goto_0

    .line 374
    :cond_1
    const/4 v1, 0x0

    .line 376
    .local v1, "oot":Ljava/io/ObjectOutputStream;
    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v3, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 377
    .local v2, "filePath":Ljava/lang/String;
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCRC64RecordFile:Ljava/io/File;

    .line 378
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCRC64RecordFile:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_2

    .line 379
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCRC64RecordFile:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->createNewFile()Z

    .line 381
    :cond_2
    new-instance v3, Ljava/io/ObjectOutputStream;

    new-instance v4, Ljava/io/FileOutputStream;

    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCRC64RecordFile:Ljava/io/File;

    invoke-direct {v4, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v3, v4}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v1, v3

    .line 382
    invoke-virtual {v1, v0}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 386
    .end local v2    # "filePath":Ljava/lang/String;
    goto :goto_1

    :catchall_0
    move-exception v2

    goto :goto_2

    .line 383
    :catch_0
    move-exception v2

    .line 384
    .local v2, "e":Ljava/io/IOException;
    :try_start_1
    invoke-static {v2}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 386
    .end local v2    # "e":Ljava/io/IOException;
    if-eqz v1, :cond_4

    .line 387
    :goto_1
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V

    goto :goto_3

    .line 386
    :goto_2
    if-eqz v1, :cond_3

    .line 387
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V

    .line 389
    :cond_3
    throw v2

    .line 393
    .end local v0    # "maps":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v1    # "oot":Ljava/io/ObjectOutputStream;
    :cond_4
    :goto_3
    invoke-super {p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->checkException()V

    .line 394
    return-void
.end method

.method protected bridge synthetic doMultipartUpload()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;,
            Lcom/alibaba/sdk/android/oss/ClientException;,
            Ljava/lang/InterruptedException;
        }
    .end annotation

    .line 54
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->doMultipartUpload()Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;

    move-result-object v0

    return-object v0
.end method

.method protected doMultipartUpload()Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/alibaba/sdk/android/oss/ClientException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;,
            Ljava/lang/InterruptedException;
        }
    .end annotation

    .line 201
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    .line 203
    .local v0, "tempUploadedLength":J
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->checkCancel()V

    .line 208
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartAttr:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    .line 209
    .local v2, "readByte":I
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartAttr:[I

    const/4 v4, 0x1

    aget v3, v3, v4

    .line 211
    .local v3, "partNumber":I
    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_4

    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_4

    .line 212
    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    iget-wide v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mFileLength:J

    cmp-long v4, v4, v6

    if-gtz v4, :cond_3

    .line 216
    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mFirstPartSize:J

    int-to-long v6, v2

    cmp-long v4, v4, v6

    if-nez v4, :cond_2

    .line 220
    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    .line 222
    .local v4, "revertUploadedLength":J
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v6, v7}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->getStringValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 223
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v6, v7}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->getStringValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    .line 226
    :cond_0
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mProgressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    if-eqz v6, :cond_1

    .line 227
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mProgressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    iget-wide v10, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mFileLength:J

    move-wide v8, v4

    invoke-interface/range {v6 .. v11}, Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;->onProgress(Ljava/lang/Object;JJ)V

    .line 230
    :cond_1
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v6, v7}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->removeKey(Ljava/lang/String;)V

    goto :goto_0

    .line 217
    .end local v4    # "revertUploadedLength":J
    :cond_2
    new-instance v4, Lcom/alibaba/sdk/android/oss/ClientException;

    const-string v5, "The part size setting is inconsistent with before"

    invoke-direct {v4, v5}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 213
    :cond_3
    new-instance v4, Lcom/alibaba/sdk/android/oss/ClientException;

    const-string v5, "The uploading file is inconsistent with before"

    invoke-direct {v4, v5}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 233
    :cond_4
    :goto_0
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_1
    if-ge v4, v3, :cond_8

    .line 235
    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    if-eqz v5, :cond_5

    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    add-int/lit8 v6, v4, 0x1

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-interface {v5, v6}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 236
    goto :goto_2

    .line 240
    :cond_5
    add-int/lit8 v5, v3, -0x1

    if-ne v4, v5, :cond_6

    .line 241
    iget-wide v5, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mFileLength:J

    sub-long/2addr v5, v0

    long-to-int v2, v5

    .line 243
    :cond_6
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "upload part readByte : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 244
    move v5, v2

    .line 245
    .local v5, "byteCount":I
    move v6, v4

    .line 246
    .local v6, "readIndex":I
    int-to-long v7, v5

    add-long/2addr v0, v7

    .line 247
    invoke-virtual {p0, v6, v5, v3}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->uploadPart(III)V

    .line 249
    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadException:Ljava/lang/Exception;

    if-eqz v7, :cond_7

    .line 250
    goto :goto_3

    .line 233
    .end local v5    # "byteCount":I
    .end local v6    # "readIndex":I
    :cond_7
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 254
    .end local v4    # "i":I
    :cond_8
    :goto_3
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->checkException()V

    .line 256
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->completeMultipartUploadResult()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;

    move-result-object v4

    .line 257
    .local v4, "completeResult":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;
    const/4 v5, 0x0

    .line 258
    .local v5, "result":Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;
    if-eqz v4, :cond_9

    .line 259
    new-instance v6, Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;

    invoke-direct {v6, v4}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;-><init>(Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;)V

    move-object v5, v6

    .line 261
    :cond_9
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    if-eqz v6, :cond_a

    .line 262
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 264
    :cond_a
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCRC64RecordFile:Ljava/io/File;

    if-eqz v6, :cond_b

    .line 265
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCRC64RecordFile:Ljava/io/File;

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 267
    :cond_b
    return-object v5
.end method

.method protected initMultipartUploadId()V
    .locals 18
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/alibaba/sdk/android/oss/ClientException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;
        }
    .end annotation

    .line 73
    move-object/from16 v1, p0

    const/4 v2, 0x0

    .line 75
    .local v2, "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->isEmptyString(Ljava/lang/String;)Z

    move-result v0

    const/4 v3, 0x0

    if-nez v0, :cond_e

    .line 76
    const/4 v4, 0x0

    .line 77
    .local v4, "fileMd5":Ljava/lang/String;
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadUri:Landroid/net/Uri;

    if-eqz v0, :cond_2

    .line 78
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget-object v5, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadUri:Landroid/net/Uri;

    const-string v6, "r"

    invoke-virtual {v0, v5, v6}, Landroid/content/ContentResolver;->openFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;

    move-result-object v5

    .line 80
    .local v5, "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :try_start_0
    invoke-virtual {v5}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->calculateMd5Str(Ljava/io/FileDescriptor;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 82
    .end local v4    # "fileMd5":Ljava/lang/String;
    .local v0, "fileMd5":Ljava/lang/String;
    if-eqz v5, :cond_0

    .line 83
    invoke-virtual {v5}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 86
    .end local v5    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :cond_0
    move-object v4, v0

    goto :goto_0

    .line 82
    .end local v0    # "fileMd5":Ljava/lang/String;
    .restart local v4    # "fileMd5":Ljava/lang/String;
    .restart local v5    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :catchall_0
    move-exception v0

    if-eqz v5, :cond_1

    .line 83
    invoke-virtual {v5}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 85
    :cond_1
    throw v0

    .line 87
    .end local v5    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :cond_2
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadFilePath:Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->calculateMd5Str(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v4, v0

    .line 89
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v5, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v5, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v5}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v5, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v5, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    .line 90
    invoke-virtual {v5}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v5, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v5, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v5}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getPartSize()J

    move-result-wide v5

    invoke-static {v5, v6}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v5, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCheckCRC64:Z

    if-eqz v5, :cond_3

    const-string v5, "-crc64"

    goto :goto_1

    :cond_3
    const-string v5, ""

    :goto_1
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "-sequence"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .line 89
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->calculateMd5Str([B)Ljava/lang/String;

    move-result-object v5

    .line 91
    .local v5, "recordFileName":Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v6, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v6, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 93
    .local v6, "recordPath":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    .line 94
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 95
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v7, Ljava/io/FileReader;

    iget-object v8, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    invoke-direct {v7, v8}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 96
    .local v0, "br":Ljava/io/BufferedReader;
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v7

    iput-object v7, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    .line 97
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    .line 98
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "sequence [initUploadId] - Found record file, uploadid: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 101
    .end local v0    # "br":Ljava/io/BufferedReader;
    :cond_4
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->isEmptyString(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_c

    .line 102
    iget-boolean v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCheckCRC64:Z

    if-eqz v0, :cond_5

    .line 103
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v7, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v7, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 104
    .local v7, "filePath":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v8, v0

    .line 105
    .local v8, "crc64Record":Ljava/io/File;
    invoke-virtual {v8}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 106
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v8}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    move-object v9, v0

    .line 107
    .local v9, "fs":Ljava/io/FileInputStream;
    new-instance v0, Ljava/io/ObjectInputStream;

    invoke-direct {v0, v9}, Ljava/io/ObjectInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v10, v0

    .line 110
    .local v10, "ois":Ljava/io/ObjectInputStream;
    :try_start_1
    invoke-virtual {v10}, Ljava/io/ObjectInputStream;->readObject()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    move-object v2, v0

    .line 111
    invoke-virtual {v8}, Ljava/io/File;->delete()Z
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 115
    goto :goto_2

    :catchall_1
    move-exception v0

    goto :goto_3

    .line 112
    :catch_0
    move-exception v0

    .line 113
    .local v0, "e":Ljava/lang/ClassNotFoundException;
    :try_start_2
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 115
    .end local v0    # "e":Ljava/lang/ClassNotFoundException;
    nop

    .line 116
    :goto_2
    invoke-virtual {v10}, Ljava/io/ObjectInputStream;->close()V

    .line 117
    invoke-virtual {v8}, Ljava/io/File;->delete()Z

    .line 118
    goto :goto_4

    .line 116
    :goto_3
    invoke-virtual {v10}, Ljava/io/ObjectInputStream;->close()V

    .line 117
    invoke-virtual {v8}, Ljava/io/File;->delete()Z

    .line 118
    throw v0

    .line 122
    .end local v7    # "filePath":Ljava/lang/String;
    .end local v8    # "crc64Record":Ljava/io/File;
    .end local v9    # "fs":Ljava/io/FileInputStream;
    .end local v10    # "ois":Ljava/io/ObjectInputStream;
    :cond_5
    :goto_4
    const/4 v0, 0x0

    .line 123
    .local v0, "isTruncated":Z
    const/4 v7, 0x0

    move v8, v7

    move v7, v0

    .line 126
    .end local v0    # "isTruncated":Z
    .local v7, "isTruncated":Z
    .local v8, "nextPartNumberMarker":I
    :goto_5
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;

    iget-object v9, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v9, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v9}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v9

    iget-object v10, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v10, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v10}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v10

    iget-object v11, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-direct {v0, v9, v10, v11}, Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object v9, v0

    .line 127
    .local v9, "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    if-lez v8, :cond_6

    .line 128
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v9, v0}, Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;->setPartNumberMarker(Ljava/lang/Integer;)V

    .line 131
    :cond_6
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    invoke-virtual {v0, v9, v3}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->listParts(Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;)Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;

    move-result-object v10

    .line 135
    .local v10, "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    :try_start_3
    invoke-virtual {v10}, Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;->getResult()Lcom/alibaba/sdk/android/oss/model/OSSResult;

    move-result-object v0

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ListPartsResult;

    .line 136
    .local v0, "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ListPartsResult;->isTruncated()Z

    move-result v11

    move v7, v11

    .line 137
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ListPartsResult;->getNextPartNumberMarker()I

    move-result v11

    move v8, v11

    .line 138
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ListPartsResult;->getParts()Ljava/util/List;

    move-result-object v11

    .line 140
    .local v11, "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_6
    invoke-interface {v11}, Ljava/util/List;->size()I

    move-result v13

    if-ge v12, v13, :cond_9

    .line 141
    invoke-interface {v11, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lcom/alibaba/sdk/android/oss/model/PartSummary;

    .line 142
    .local v13, "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    new-instance v14, Lcom/alibaba/sdk/android/oss/model/PartETag;

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getPartNumber()I

    move-result v15

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getETag()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v14, v15, v3}, Lcom/alibaba/sdk/android/oss/model/PartETag;-><init>(ILjava/lang/String;)V

    move-object v3, v14

    .line 143
    .local v3, "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v14

    invoke-virtual {v3, v14, v15}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setPartSize(J)V

    .line 145
    if-eqz v2, :cond_7

    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v14

    if-lez v14, :cond_7

    .line 146
    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v14

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-interface {v2, v14}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_7

    .line 147
    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v14

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-interface {v2, v14}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/Long;

    invoke-virtual {v14}, Ljava/lang/Long;->longValue()J

    move-result-wide v14

    invoke-virtual {v3, v14, v15}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setCRC64(J)V

    .line 151
    :cond_7
    iget-object v14, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v14, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 152
    iget-wide v14, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v16

    add-long v14, v14, v16

    iput-wide v14, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    .line 153
    iget-object v14, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getPartNumber()I

    move-result v15

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v15

    invoke-interface {v14, v15}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 154
    if-nez v12, :cond_8

    .line 155
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v14

    iput-wide v14, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mFirstPartSize:J
    :try_end_3
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_3 .. :try_end_3} :catch_1

    .line 140
    .end local v3    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .end local v13    # "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    :cond_8
    add-int/lit8 v12, v12, 0x1

    const/4 v3, 0x0

    goto :goto_6

    .line 168
    .end local v0    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    .end local v11    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .end local v12    # "i":I
    :cond_9
    goto :goto_7

    .line 165
    :catch_1
    move-exception v0

    .line 166
    .local v0, "e":Lcom/alibaba/sdk/android/oss/ClientException;
    const/4 v3, 0x0

    .line 167
    .end local v7    # "isTruncated":Z
    .local v3, "isTruncated":Z
    throw v0

    .line 158
    .end local v0    # "e":Lcom/alibaba/sdk/android/oss/ClientException;
    .end local v3    # "isTruncated":Z
    .restart local v7    # "isTruncated":Z
    :catch_2
    move-exception v0

    .line 159
    .local v0, "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    const/4 v3, 0x0

    .line 160
    .end local v7    # "isTruncated":Z
    .restart local v3    # "isTruncated":Z
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/ServiceException;->getStatusCode()I

    move-result v7

    const/16 v11, 0x194

    if-ne v7, v11, :cond_b

    .line 161
    const/4 v7, 0x0

    iput-object v7, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    .line 168
    .end local v0    # "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    move v7, v3

    .line 169
    .end local v3    # "isTruncated":Z
    .restart local v7    # "isTruncated":Z
    :goto_7
    invoke-virtual {v10}, Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;->waitUntilFinished()V

    .line 171
    .end local v9    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v10    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    if-nez v7, :cond_a

    goto :goto_8

    :cond_a
    const/4 v3, 0x0

    goto/16 :goto_5

    .line 163
    .end local v7    # "isTruncated":Z
    .restart local v0    # "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    .restart local v3    # "isTruncated":Z
    .restart local v9    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v10    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    :cond_b
    throw v0

    .line 174
    .end local v0    # "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    .end local v3    # "isTruncated":Z
    .end local v8    # "nextPartNumberMarker":I
    .end local v9    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v10    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    :cond_c
    :goto_8
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_e

    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    move-result v0

    if-eqz v0, :cond_d

    goto :goto_9

    .line 175
    :cond_d
    new-instance v0, Lcom/alibaba/sdk/android/oss/ClientException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Can\'t create file at path: "

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, "\nPlease make sure the directory exist!"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 180
    .end local v4    # "fileMd5":Ljava/lang/String;
    .end local v5    # "recordFileName":Ljava/lang/String;
    .end local v6    # "recordPath":Ljava/lang/String;
    :cond_e
    :goto_9
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->isEmptyString(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_f

    .line 181
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;

    iget-object v3, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v3, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    .line 182
    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v3

    iget-object v4, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v4, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v4

    iget-object v5, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v5, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v5}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getMetadata()Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;

    move-result-object v5

    invoke-direct {v0, v3, v4, v5}, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;)V

    .line 183
    .local v0, "init":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;
    const/4 v3, 0x1

    iput-boolean v3, v0, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;->isSequential:Z

    .line 184
    iget-object v3, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    const/4 v4, 0x0

    invoke-virtual {v3, v0, v4}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->initMultipartUpload(Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;)Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;

    move-result-object v3

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;->getResult()Lcom/alibaba/sdk/android/oss/model/OSSResult;

    move-result-object v3

    check-cast v3, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;

    .line 186
    .local v3, "initResult":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;
    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;->getUploadId()Ljava/lang/String;

    move-result-object v4

    iput-object v4, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    .line 188
    iget-object v4, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    if-eqz v4, :cond_f

    .line 189
    new-instance v4, Ljava/io/BufferedWriter;

    new-instance v5, Ljava/io/FileWriter;

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRecordFile:Ljava/io/File;

    invoke-direct {v5, v6}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    invoke-direct {v4, v5}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .line 190
    .local v4, "bw":Ljava/io/BufferedWriter;
    iget-object v5, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 191
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->close()V

    .line 195
    .end local v0    # "init":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;
    .end local v3    # "initResult":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;
    .end local v4    # "bw":Ljava/io/BufferedWriter;
    :cond_f
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    iget-object v3, v1, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->setUploadId(Ljava/lang/String;)V

    .line 196
    return-void
.end method

.method protected processException(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "e"    # Ljava/lang/Exception;

    .line 408
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadException:Ljava/lang/Exception;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadException:Ljava/lang/Exception;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 409
    :cond_0
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadException:Ljava/lang/Exception;

    .line 411
    :cond_1
    invoke-static {p1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    .line 412
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 413
    iget-boolean v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mIsCancel:Z

    if-nez v0, :cond_2

    .line 414
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mIsCancel:Z

    .line 417
    :cond_2
    return-void
.end method

.method public uploadPart(III)V
    .locals 18
    .param p1, "readIndex"    # I
    .param p2, "byteCount"    # I
    .param p3, "partNumber"    # I

    .line 272
    move-object/from16 v7, p0

    move/from16 v8, p1

    move/from16 v9, p2

    const/4 v1, 0x0

    .line 273
    .local v1, "raf":Ljava/io/RandomAccessFile;
    const/4 v2, 0x0

    .line 274
    .local v2, "inputStream":Ljava/io/InputStream;
    const/4 v3, 0x0

    .line 275
    .local v3, "bufferedInputStream":Ljava/io/BufferedInputStream;
    const/4 v4, 0x0

    .line 278
    .local v4, "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :try_start_0
    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0
    :try_end_0
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_0 .. :try_end_0} :catch_8
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    if-eqz v0, :cond_3

    .line 347
    if-eqz v1, :cond_0

    .line 348
    :try_start_1
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_0

    .line 353
    :catch_0
    move-exception v0

    goto :goto_1

    .line 349
    :cond_0
    :goto_0
    if-eqz v2, :cond_1

    .line 350
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 351
    :cond_1
    if-eqz v3, :cond_2

    .line 352
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 354
    .local v0, "e":Ljava/io/IOException;
    :goto_1
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    goto :goto_3

    .line 355
    .end local v0    # "e":Ljava/io/IOException;
    :cond_2
    :goto_2
    nop

    .line 279
    :goto_3
    return-void

    .line 282
    :cond_3
    :try_start_2
    iget v0, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRunPartTaskCount:I

    const/4 v5, 0x1

    add-int/2addr v0, v5

    iput v0, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRunPartTaskCount:I

    .line 284
    invoke-virtual/range {p0 .. p3}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->preUploadPart(III)V

    .line 285
    int-to-long v10, v8

    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getPartSize()J

    move-result-wide v12

    mul-long/2addr v10, v12

    .line 286
    .local v10, "skip":J
    new-array v0, v9, [B

    .line 288
    .local v0, "partContent":[B
    iget-object v6, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadUri:Landroid/net/Uri;

    const/4 v12, 0x0

    if-eqz v6, :cond_4

    .line 289
    iget-object v6, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    iget-object v13, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadUri:Landroid/net/Uri;

    invoke-virtual {v6, v13}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v6

    move-object v2, v6

    .line 290
    new-instance v6, Ljava/io/BufferedInputStream;

    invoke-direct {v6, v2}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v3, v6

    .line 291
    invoke-virtual {v3, v10, v11}, Ljava/io/BufferedInputStream;->skip(J)J

    .line 292
    invoke-virtual {v3, v0, v12, v9}, Ljava/io/BufferedInputStream;->read([BII)I

    move-object v12, v1

    move-object v13, v2

    move-object v14, v3

    goto :goto_4

    .line 294
    :cond_4
    new-instance v6, Ljava/io/RandomAccessFile;

    iget-object v13, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadFile:Ljava/io/File;

    const-string v14, "r"

    invoke-direct {v6, v13, v14}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v1, v6

    .line 296
    invoke-virtual {v1, v10, v11}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 297
    invoke-virtual {v1, v0, v12, v9}, Ljava/io/RandomAccessFile;->readFully([BII)V
    :try_end_2
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_2 .. :try_end_2} :catch_8
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_6
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-object v12, v1

    move-object v13, v2

    move-object v14, v3

    .line 300
    .end local v1    # "raf":Ljava/io/RandomAccessFile;
    .end local v2    # "inputStream":Ljava/io/InputStream;
    .end local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .local v12, "raf":Ljava/io/RandomAccessFile;
    .local v13, "inputStream":Ljava/io/InputStream;
    .local v14, "bufferedInputStream":Ljava/io/BufferedInputStream;
    :goto_4
    :try_start_3
    new-instance v1, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;

    iget-object v2, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v2, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    .line 301
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v2

    iget-object v3, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v3, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v3

    iget-object v6, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    add-int/lit8 v15, v8, 0x1

    invoke-direct {v1, v2, v3, v6, v15}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    :try_end_3
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_3 .. :try_end_3} :catch_5
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move-object v15, v1

    .line 302
    .end local v4    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .local v15, "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :try_start_4
    invoke-virtual {v15, v0}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setPartContent([B)V

    .line 303
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->calculateBase64Md5([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v15, v1}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setMd5Digest(Ljava/lang/String;)V

    .line 304
    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v1, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getCRC64()Ljava/lang/Enum;

    move-result-object v1

    invoke-virtual {v15, v1}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setCRC64(Ljava/lang/Enum;)V

    .line 305
    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    invoke-virtual {v1, v15}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->syncUploadPart(Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;)Lcom/alibaba/sdk/android/oss/model/UploadPartResult;

    move-result-object v1

    move-object/from16 v16, v1

    .line 307
    .local v16, "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    new-instance v1, Lcom/alibaba/sdk/android/oss/model/PartETag;

    invoke-virtual {v15}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->getPartNumber()I

    move-result v2

    invoke-virtual/range {v16 .. v16}, Lcom/alibaba/sdk/android/oss/model/UploadPartResult;->getETag()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Lcom/alibaba/sdk/android/oss/model/PartETag;-><init>(ILjava/lang/String;)V

    move-object v6, v1

    .line 308
    .local v6, "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    int-to-long v1, v9

    invoke-virtual {v6, v1, v2}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setPartSize(J)V

    .line 309
    iget-boolean v1, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCheckCRC64:Z

    if-eqz v1, :cond_5

    .line 310
    invoke-virtual/range {v16 .. v16}, Lcom/alibaba/sdk/android/oss/model/UploadPartResult;->getClientCRC()Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    invoke-virtual {v6, v1, v2}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setCRC64(J)V

    .line 313
    :cond_5
    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v1, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 314
    iget-wide v1, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    int-to-long v3, v9

    add-long/2addr v1, v3

    iput-wide v1, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    .line 316
    invoke-virtual {v7, v6}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->uploadPartFinish(Lcom/alibaba/sdk/android/oss/model/PartETag;)V

    .line 318
    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v1

    if-nez v1, :cond_9

    .line 323
    iget-object v2, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    iget-wide v3, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    move-object/from16 v17, v6

    .end local v6    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .local v17, "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    iget-wide v5, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mFileLength:J

    move-object/from16 v1, p0

    invoke-virtual/range {v1 .. v6}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->onProgressCallback(Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;JJ)V
    :try_end_4
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_4 .. :try_end_4} :catch_3
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 347
    .end local v0    # "partContent":[B
    .end local v10    # "skip":J
    .end local v16    # "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    .end local v17    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    if-eqz v12, :cond_6

    .line 348
    :try_start_5
    invoke-virtual {v12}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_5

    .line 353
    :catch_1
    move-exception v0

    goto :goto_6

    .line 349
    :cond_6
    :goto_5
    if-eqz v13, :cond_7

    .line 350
    invoke-virtual {v13}, Ljava/io/InputStream;->close()V

    .line 351
    :cond_7
    if-eqz v14, :cond_8

    .line 352
    invoke-virtual {v14}, Ljava/io/BufferedInputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_7

    .line 354
    .local v0, "e":Ljava/io/IOException;
    :goto_6
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    .line 356
    .end local v0    # "e":Ljava/io/IOException;
    goto/16 :goto_10

    .line 355
    :cond_8
    :goto_7
    goto/16 :goto_10

    .line 320
    .local v0, "partContent":[B
    .restart local v6    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .restart local v10    # "skip":J
    .restart local v16    # "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    :cond_9
    move-object/from16 v17, v6

    .end local v6    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .restart local v17    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    :try_start_6
    new-instance v1, Lcom/alibaba/sdk/android/oss/TaskCancelException;

    const-string v2, "sequence upload task cancel"

    invoke-direct {v1, v2}, Lcom/alibaba/sdk/android/oss/TaskCancelException;-><init>(Ljava/lang/String;)V

    .line 321
    .local v1, "e":Lcom/alibaba/sdk/android/oss/TaskCancelException;
    new-instance v2, Lcom/alibaba/sdk/android/oss/ClientException;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/TaskCancelException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-direct {v2, v3, v1, v4}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;Ljava/lang/Boolean;)V

    .end local v12    # "raf":Ljava/io/RandomAccessFile;
    .end local v13    # "inputStream":Ljava/io/InputStream;
    .end local v14    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .end local v15    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .end local p1    # "readIndex":I
    .end local p2    # "byteCount":I
    .end local p3    # "partNumber":I
    throw v2
    :try_end_6
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_6 .. :try_end_6} :catch_3
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 346
    .end local v0    # "partContent":[B
    .end local v1    # "e":Lcom/alibaba/sdk/android/oss/TaskCancelException;
    .end local v10    # "skip":J
    .end local v16    # "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    .end local v17    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .restart local v12    # "raf":Ljava/io/RandomAccessFile;
    .restart local v13    # "inputStream":Ljava/io/InputStream;
    .restart local v14    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .restart local v15    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .restart local p1    # "readIndex":I
    .restart local p2    # "byteCount":I
    .restart local p3    # "partNumber":I
    :catchall_0
    move-exception v0

    move-object v5, v0

    move-object v1, v12

    move-object v2, v13

    move-object v3, v14

    move-object v4, v15

    goto/16 :goto_11

    .line 343
    :catch_2
    move-exception v0

    move-object v1, v12

    move-object v2, v13

    move-object v3, v14

    move-object v4, v15

    goto :goto_8

    .line 325
    :catch_3
    move-exception v0

    move-object v1, v12

    move-object v2, v13

    move-object v3, v14

    move-object v4, v15

    goto :goto_d

    .line 346
    .end local v15    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .restart local v4    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :catchall_1
    move-exception v0

    move-object v5, v0

    move-object v1, v12

    move-object v2, v13

    move-object v3, v14

    goto/16 :goto_11

    .line 343
    :catch_4
    move-exception v0

    move-object v1, v12

    move-object v2, v13

    move-object v3, v14

    goto :goto_8

    .line 325
    :catch_5
    move-exception v0

    move-object v1, v12

    move-object v2, v13

    move-object v3, v14

    goto :goto_d

    .line 346
    .end local v12    # "raf":Ljava/io/RandomAccessFile;
    .end local v13    # "inputStream":Ljava/io/InputStream;
    .end local v14    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .local v1, "raf":Ljava/io/RandomAccessFile;
    .restart local v2    # "inputStream":Ljava/io/InputStream;
    .restart local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    :catchall_2
    move-exception v0

    move-object v5, v0

    goto/16 :goto_11

    .line 343
    :catch_6
    move-exception v0

    .line 344
    .local v0, "e":Ljava/lang/Exception;
    :goto_8
    :try_start_7
    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->processException(Ljava/lang/Exception;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 347
    .end local v0    # "e":Ljava/lang/Exception;
    if-eqz v1, :cond_a

    .line 348
    :try_start_8
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_9

    .line 353
    :catch_7
    move-exception v0

    goto :goto_a

    .line 349
    :cond_a
    :goto_9
    if-eqz v2, :cond_b

    .line 350
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 351
    :cond_b
    if-eqz v3, :cond_c

    .line 352
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_7

    goto :goto_b

    .line 354
    .local v0, "e":Ljava/io/IOException;
    :goto_a
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    .line 356
    .end local v0    # "e":Ljava/io/IOException;
    goto :goto_c

    .line 355
    :cond_c
    :goto_b
    nop

    .line 357
    :goto_c
    move-object v12, v1

    move-object v13, v2

    move-object v14, v3

    move-object v15, v4

    goto :goto_10

    .line 325
    :catch_8
    move-exception v0

    .line 327
    .local v0, "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    :goto_d
    :try_start_9
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/ServiceException;->getStatusCode()I

    move-result v5

    const/16 v6, 0x199

    if-eq v5, v6, :cond_d

    .line 328
    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->processException(Ljava/lang/Exception;)V

    goto :goto_e

    .line 330
    :cond_d
    new-instance v5, Lcom/alibaba/sdk/android/oss/model/PartETag;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->getPartNumber()I

    move-result v6

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/ServiceException;->getPartEtag()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v5, v6, v10}, Lcom/alibaba/sdk/android/oss/model/PartETag;-><init>(ILjava/lang/String;)V

    .line 331
    .local v5, "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->getPartContent()[B

    move-result-object v6

    array-length v6, v6

    int-to-long v10, v6

    invoke-virtual {v5, v10, v11}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setPartSize(J)V

    .line 332
    iget-boolean v6, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mCheckCRC64:Z

    if-eqz v6, :cond_e

    .line 333
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->getPartContent()[B

    move-result-object v6

    .line 334
    .local v6, "partContent":[B
    new-instance v10, Ljava/io/ByteArrayInputStream;

    invoke-direct {v10, v6}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 335
    .local v10, "byteArrayInputStream":Ljava/io/ByteArrayInputStream;
    new-instance v11, Ljava/util/zip/CheckedInputStream;

    new-instance v12, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;

    invoke-direct {v12}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;-><init>()V

    invoke-direct {v11, v10, v12}, Ljava/util/zip/CheckedInputStream;-><init>(Ljava/io/InputStream;Ljava/util/zip/Checksum;)V

    .line 337
    .local v11, "checkedInputStream":Ljava/util/zip/CheckedInputStream;
    invoke-virtual {v11}, Ljava/util/zip/CheckedInputStream;->getChecksum()Ljava/util/zip/Checksum;

    move-result-object v12

    invoke-interface {v12}, Ljava/util/zip/Checksum;->getValue()J

    move-result-wide v12

    invoke-virtual {v5, v12, v13}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setCRC64(J)V

    .line 340
    .end local v6    # "partContent":[B
    .end local v10    # "byteArrayInputStream":Ljava/io/ByteArrayInputStream;
    .end local v11    # "checkedInputStream":Ljava/util/zip/CheckedInputStream;
    :cond_e
    iget-object v6, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 341
    iget-wide v10, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    int-to-long v12, v9

    add-long/2addr v10, v12

    iput-wide v10, v7, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    .line 347
    .end local v0    # "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    .end local v5    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    :goto_e
    if-eqz v1, :cond_f

    .line 348
    :try_start_a
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_f

    .line 353
    :catch_9
    move-exception v0

    goto :goto_a

    .line 349
    :cond_f
    :goto_f
    if-eqz v2, :cond_10

    .line 350
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 351
    :cond_10
    if-eqz v3, :cond_c

    .line 352
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_9

    goto :goto_b

    .line 357
    .end local v1    # "raf":Ljava/io/RandomAccessFile;
    .end local v2    # "inputStream":Ljava/io/InputStream;
    .end local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .end local v4    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .restart local v12    # "raf":Ljava/io/RandomAccessFile;
    .restart local v13    # "inputStream":Ljava/io/InputStream;
    .restart local v14    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .restart local v15    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :goto_10
    return-void

    .line 347
    .end local v12    # "raf":Ljava/io/RandomAccessFile;
    .end local v13    # "inputStream":Ljava/io/InputStream;
    .end local v14    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .end local v15    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .restart local v1    # "raf":Ljava/io/RandomAccessFile;
    .restart local v2    # "inputStream":Ljava/io/InputStream;
    .restart local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .restart local v4    # "uploadPartRequest":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :goto_11
    if-eqz v1, :cond_11

    .line 348
    :try_start_b
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_12

    .line 353
    :catch_a
    move-exception v0

    goto :goto_13

    .line 349
    :cond_11
    :goto_12
    if-eqz v2, :cond_12

    .line 350
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 351
    :cond_12
    if-eqz v3, :cond_13

    .line 352
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_a

    goto :goto_14

    .line 354
    .local v0, "e":Ljava/io/IOException;
    :goto_13
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    goto :goto_15

    .line 355
    .end local v0    # "e":Ljava/io/IOException;
    :cond_13
    :goto_14
    nop

    .line 356
    :goto_15
    throw v5
.end method

.method protected uploadPartFinish(Lcom/alibaba/sdk/android/oss/model/PartETag;)V
    .locals 9
    .param p1, "partETag"    # Lcom/alibaba/sdk/android/oss/model/PartETag;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 421
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 422
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 423
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadId:Ljava/lang/String;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->setStringValue(Ljava/lang/String;Ljava/lang/String;)V

    .line 424
    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    iget-wide v5, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mUploadedLength:J

    iget-wide v7, p0, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->mFileLength:J

    move-object v3, p0

    invoke-virtual/range {v3 .. v8}, Lcom/alibaba/sdk/android/oss/internal/SequenceUploadTask;->onProgressCallback(Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;JJ)V

    .line 427
    :cond_0
    return-void
.end method
