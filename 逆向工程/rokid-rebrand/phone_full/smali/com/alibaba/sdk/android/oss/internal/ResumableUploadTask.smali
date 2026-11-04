.class public Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;
.super Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;
.source "ResumableUploadTask.java"

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
.field private exceptionTerminationMode:Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;

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

    .line 58
    .local p2, "completedCallback":Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;, "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;>;"
    invoke-direct {p0, p4, p1, p2, p3}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;-><init>(Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;Lcom/alibaba/sdk/android/oss/network/ExecutionContext;)V

    .line 49
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    .line 59
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->instance(Landroid/content/Context;)Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    .line 60
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getExceptionTerminationMode()Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->exceptionTerminationMode:Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;

    .line 61
    return-void
.end method


# virtual methods
.method protected abortThisUpload()V
    .locals 4

    .line 339
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 340
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v1, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    .line 341
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v2, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-direct {v0, v1, v2, v3}, Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 342
    .local v0, "abort":Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->abortMultipartUpload(Lcom/alibaba/sdk/android/oss/model/AbortMultipartUploadRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;)Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;->waitUntilFinished()V

    .line 344
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

    .line 303
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 304
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->deleteUploadOnCancelling()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 305
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->abortThisUpload()V

    .line 306
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    if-eqz v0, :cond_4

    .line 307
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    goto/16 :goto_3

    .line 310
    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartETags:Ljava/util/List;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_4

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCheckCRC64:Z

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 311
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 312
    .local v0, "maps":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/sdk/android/oss/model/PartETag;

    .line 313
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

    .line 314
    .end local v2    # "eTag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    goto :goto_0

    .line 315
    :cond_1
    const/4 v1, 0x0

    .line 317
    .local v1, "oot":Ljava/io/ObjectOutputStream;
    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v3, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 318
    .local v2, "filePath":Ljava/lang/String;
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCRC64RecordFile:Ljava/io/File;

    .line 319
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCRC64RecordFile:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_2

    .line 320
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCRC64RecordFile:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->createNewFile()Z

    .line 322
    :cond_2
    new-instance v3, Ljava/io/ObjectOutputStream;

    new-instance v4, Ljava/io/FileOutputStream;

    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCRC64RecordFile:Ljava/io/File;

    invoke-direct {v4, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v3, v4}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v1, v3

    .line 323
    invoke-virtual {v1, v0}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 327
    .end local v2    # "filePath":Ljava/lang/String;
    goto :goto_1

    :catchall_0
    move-exception v2

    goto :goto_2

    .line 324
    :catch_0
    move-exception v2

    .line 325
    .local v2, "e":Ljava/io/IOException;
    :try_start_1
    invoke-static {v2}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 327
    .end local v2    # "e":Ljava/io/IOException;
    if-eqz v1, :cond_4

    .line 328
    :goto_1
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V

    goto :goto_3

    .line 327
    :goto_2
    if-eqz v1, :cond_3

    .line 328
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V

    .line 330
    :cond_3
    throw v2

    .line 334
    .end local v0    # "maps":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v1    # "oot":Ljava/io/ObjectOutputStream;
    :cond_4
    :goto_3
    invoke-super {p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->checkException()V

    .line 335
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

    .line 45
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->doMultipartUpload()Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;

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

    .line 219
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadedLength:J

    .line 220
    .local v0, "tempUploadedLength":J
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->checkCancel()V

    .line 223
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartAttr:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    .line 224
    .local v2, "readByte":I
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartAttr:[I

    const/4 v4, 0x1

    aget v3, v3, v4

    .line 226
    .local v3, "partNumber":I
    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_3

    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_3

    .line 227
    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadedLength:J

    iget-wide v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mFileLength:J

    cmp-long v4, v4, v6

    if-gtz v4, :cond_2

    .line 237
    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadedLength:J

    .line 239
    .local v4, "revertUploadedLength":J
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v6, v7}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->getStringValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 240
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v6, v7}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->getStringValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    .line 243
    :cond_0
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mProgressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    if-eqz v6, :cond_1

    .line 244
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mProgressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    iget-wide v10, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mFileLength:J

    move-wide v8, v4

    invoke-interface/range {v6 .. v11}, Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;->onProgress(Ljava/lang/Object;JJ)V

    .line 247
    :cond_1
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v6, v7}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->removeKey(Ljava/lang/String;)V

    goto :goto_0

    .line 228
    .end local v4    # "revertUploadedLength":J
    :cond_2
    new-instance v4, Lcom/alibaba/sdk/android/oss/ClientException;

    const-string v5, "The uploading file is inconsistent with before"

    invoke-direct {v4, v5}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 250
    :cond_3
    :goto_0
    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    iput v4, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRunPartTaskCount:I

    .line 252
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_1
    if-ge v4, v3, :cond_8

    .line 253
    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->exceptionTerminationMode:Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;

    sget-object v6, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;->EXCEPTION:Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;

    if-ne v5, v6, :cond_4

    .line 254
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->checkException()V

    .line 256
    :cond_4
    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    if-eqz v5, :cond_5

    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    add-int/lit8 v6, v4, 0x1

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-interface {v5, v6}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 257
    goto :goto_2

    .line 260
    :cond_5
    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    if-eqz v5, :cond_7

    .line 262
    add-int/lit8 v5, v3, -0x1

    if-ne v4, v5, :cond_6

    .line 263
    iget-wide v5, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mFileLength:J

    sub-long/2addr v5, v0

    long-to-int v2, v5

    .line 265
    :cond_6
    move v5, v2

    .line 266
    .local v5, "byteCount":I
    move v6, v4

    .line 267
    .local v6, "readIndex":I
    int-to-long v7, v5

    add-long/2addr v0, v7

    .line 268
    iget-object v7, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v8, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask$1;

    invoke-direct {v8, p0, v6, v5, v3}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask$1;-><init>(Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;III)V

    invoke-virtual {v7, v8}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    .line 252
    .end local v5    # "byteCount":I
    .end local v6    # "readIndex":I
    :cond_7
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 277
    .end local v4    # "i":I
    :cond_8
    invoke-virtual {p0, v3}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->checkWaitCondition(I)Z

    move-result v4

    if-eqz v4, :cond_9

    .line 278
    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mLock:Ljava/lang/Object;

    monitor-enter v4

    .line 279
    :try_start_0
    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mLock:Ljava/lang/Object;

    invoke-virtual {v5}, Ljava/lang/Object;->wait()V

    .line 280
    monitor-exit v4

    goto :goto_3

    :catchall_0
    move-exception v5

    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v5

    .line 283
    :cond_9
    :goto_3
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->checkException()V

    .line 285
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->completeMultipartUploadResult()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;

    move-result-object v4

    .line 286
    .local v4, "completeResult":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;
    const/4 v5, 0x0

    .line 287
    .local v5, "result":Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;
    if-eqz v4, :cond_a

    .line 288
    new-instance v6, Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;

    invoke-direct {v6, v4}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadResult;-><init>(Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;)V

    move-object v5, v6

    .line 290
    :cond_a
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    if-eqz v6, :cond_b

    .line 291
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 293
    :cond_b
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCRC64RecordFile:Ljava/io/File;

    if-eqz v6, :cond_c

    .line 294
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCRC64RecordFile:Ljava/io/File;

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 297
    :cond_c
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->releasePool()V

    .line 298
    return-object v5
.end method

.method protected initMultipartUploadId()V
    .locals 27
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/alibaba/sdk/android/oss/ClientException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;
        }
    .end annotation

    .line 66
    move-object/from16 v1, p0

    const-string v2, "[initUploadId] -  "

    const/4 v3, 0x0

    .line 68
    .local v3, "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->isEmptyString(Ljava/lang/String;)Z

    move-result v0

    const/4 v4, 0x0

    if-nez v0, :cond_12

    .line 69
    const/4 v5, 0x0

    .line 70
    .local v5, "fileMd5":Ljava/lang/String;
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadUri:Landroid/net/Uri;

    const-string v6, "[initUploadId] - mUploadFilePath : "

    if-eqz v0, :cond_2

    .line 71
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadUri:Landroid/net/Uri;

    invoke-virtual {v6}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 72
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadUri:Landroid/net/Uri;

    const-string v7, "r"

    invoke-virtual {v0, v6, v7}, Landroid/content/ContentResolver;->openFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;

    move-result-object v6

    .line 74
    .local v6, "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :try_start_0
    invoke-virtual {v6}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->calculateMd5Str(Ljava/io/FileDescriptor;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 76
    .end local v5    # "fileMd5":Ljava/lang/String;
    .local v0, "fileMd5":Ljava/lang/String;
    if-eqz v6, :cond_0

    .line 77
    invoke-virtual {v6}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 80
    .end local v6    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :cond_0
    move-object v5, v0

    goto :goto_0

    .line 76
    .end local v0    # "fileMd5":Ljava/lang/String;
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :catchall_0
    move-exception v0

    if-eqz v6, :cond_1

    .line 77
    invoke-virtual {v6}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 79
    :cond_1
    throw v0

    .line 81
    .end local v6    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadFilePath:Ljava/lang/String;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 82
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadFilePath:Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->calculateMd5Str(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v5, v0

    .line 84
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[initUploadId] - mRequest.getPartSize() : "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v6, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getPartSize()J

    move-result-wide v6

    invoke-virtual {v0, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 85
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v6, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v6, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    .line 86
    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v6, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getPartSize()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCheckCRC64:Z

    if-eqz v6, :cond_3

    const-string v6, "-crc64"

    goto :goto_1

    :cond_3
    const-string v6, ""

    :goto_1
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .line 85
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->calculateMd5Str([B)Ljava/lang/String;

    move-result-object v6

    .line 87
    .local v6, "recordFileName":Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v7, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v7, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 90
    .local v7, "recordPath":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    .line 91
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 92
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v8, Ljava/io/FileReader;

    iget-object v9, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    invoke-direct {v8, v9}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v8}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 93
    .local v0, "br":Ljava/io/BufferedReader;
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v8

    iput-object v8, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    .line 94
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    .line 97
    .end local v0    # "br":Ljava/io/BufferedReader;
    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[initUploadId] - mUploadId : "

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v8, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 99
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->isEmptyString(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_10

    .line 100
    iget-boolean v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mCheckCRC64:Z

    if-eqz v0, :cond_5

    .line 101
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v8, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v8, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v8}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getRecordDirectory()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v8, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v8, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 102
    .local v8, "filePath":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v9, v0

    .line 103
    .local v9, "crc64Record":Ljava/io/File;
    invoke-virtual {v9}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 104
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v9}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    move-object v10, v0

    .line 105
    .local v10, "fs":Ljava/io/FileInputStream;
    new-instance v0, Ljava/io/ObjectInputStream;

    invoke-direct {v0, v10}, Ljava/io/ObjectInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v11, v0

    .line 108
    .local v11, "ois":Ljava/io/ObjectInputStream;
    :try_start_1
    invoke-virtual {v11}, Ljava/io/ObjectInputStream;->readObject()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    move-object v3, v0

    .line 109
    invoke-virtual {v9}, Ljava/io/File;->delete()Z
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 113
    goto :goto_2

    :catchall_1
    move-exception v0

    goto :goto_3

    .line 110
    :catch_0
    move-exception v0

    .line 111
    .local v0, "e":Ljava/lang/ClassNotFoundException;
    :try_start_2
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 113
    .end local v0    # "e":Ljava/lang/ClassNotFoundException;
    nop

    .line 114
    :goto_2
    invoke-virtual {v11}, Ljava/io/ObjectInputStream;->close()V

    .line 115
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 116
    goto :goto_4

    .line 114
    :goto_3
    invoke-virtual {v11}, Ljava/io/ObjectInputStream;->close()V

    .line 115
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 116
    throw v0

    .line 120
    .end local v8    # "filePath":Ljava/lang/String;
    .end local v9    # "crc64Record":Ljava/io/File;
    .end local v10    # "fs":Ljava/io/FileInputStream;
    .end local v11    # "ois":Ljava/io/ObjectInputStream;
    :cond_5
    :goto_4
    const/4 v0, 0x0

    .line 121
    .local v0, "isTruncated":Z
    const/4 v8, 0x0

    move v9, v8

    move v8, v0

    .line 125
    .end local v0    # "isTruncated":Z
    .local v8, "isTruncated":Z
    .local v9, "nextPartNumberMarker":I
    :goto_5
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;

    iget-object v10, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v10, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v10}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v10

    iget-object v11, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v11, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v11}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v11

    iget-object v12, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-direct {v0, v10, v11, v12}, Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object v10, v0

    .line 126
    .local v10, "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    if-lez v9, :cond_6

    .line 127
    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v10, v0}, Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;->setPartNumberMarker(Ljava/lang/Integer;)V

    .line 130
    :cond_6
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    invoke-virtual {v0, v10, v4}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->listParts(Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;)Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;

    move-result-object v11

    .line 132
    .local v11, "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    :try_start_3
    invoke-virtual {v11}, Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;->getResult()Lcom/alibaba/sdk/android/oss/model/OSSResult;

    move-result-object v0

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ListPartsResult;

    .line 133
    .local v0, "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ListPartsResult;->isTruncated()Z

    move-result v12
    :try_end_3
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_3 .. :try_end_3} :catch_18
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_3 .. :try_end_3} :catch_17

    move v8, v12

    .line 134
    :try_start_4
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ListPartsResult;->getNextPartNumberMarker()I

    move-result v12
    :try_end_4
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_4 .. :try_end_4} :catch_16
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_4 .. :try_end_4} :catch_15

    move v9, v12

    .line 135
    :try_start_5
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/ListPartsResult;->getParts()Ljava/util/List;

    move-result-object v12

    .line 136
    .local v12, "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    iget-object v13, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartAttr:[I

    const/4 v14, 0x0

    aget v13, v13, v14

    .line 137
    .local v13, "partSize":I
    iget-object v15, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartAttr:[I

    const/16 v16, 0x1

    aget v15, v15, v16

    .line 138
    .local v15, "partTotalNumber":I
    const/16 v17, 0x0

    move/from16 v14, v17

    .local v14, "i":I
    :goto_6
    invoke-interface {v12}, Ljava/util/List;->size()I

    move-result v4

    if-ge v14, v4, :cond_d

    .line 139
    invoke-interface {v12, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/alibaba/sdk/android/oss/model/PartSummary;

    .line 140
    .local v4, "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    move-object/from16 v18, v0

    .end local v0    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    .local v18, "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/PartETag;
    :try_end_5
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_5 .. :try_end_5} :catch_14
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_5 .. :try_end_5} :catch_13

    move-object/from16 v19, v5

    .end local v5    # "fileMd5":Ljava/lang/String;
    .local v19, "fileMd5":Ljava/lang/String;
    :try_start_6
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getPartNumber()I

    move-result v5
    :try_end_6
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_6 .. :try_end_6} :catch_12
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_6 .. :try_end_6} :catch_11

    move-object/from16 v20, v6

    .end local v6    # "recordFileName":Ljava/lang/String;
    .local v20, "recordFileName":Ljava/lang/String;
    :try_start_7
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getETag()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v0, v5, v6}, Lcom/alibaba/sdk/android/oss/model/PartETag;-><init>(ILjava/lang/String;)V

    .line 141
    .local v0, "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v5

    invoke-virtual {v0, v5, v6}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setPartSize(J)V
    :try_end_7
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_7 .. :try_end_7} :catch_10
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_7 .. :try_end_7} :catch_f

    .line 143
    if-eqz v3, :cond_7

    :try_start_8
    invoke-interface {v3}, Ljava/util/Map;->size()I

    move-result v5

    if-lez v5, :cond_7

    .line 144
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v3, v5}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_7

    .line 145
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v3, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Long;

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    invoke-virtual {v0, v5, v6}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setCRC64(J)V
    :try_end_8
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_8 .. :try_end_8} :catch_2
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_8 .. :try_end_8} :catch_1

    goto :goto_7

    .line 183
    .end local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .end local v4    # "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    .end local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .end local v13    # "partSize":I
    .end local v14    # "i":I
    .end local v15    # "partTotalNumber":I
    .end local v18    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    :catch_1
    move-exception v0

    move-object/from16 v21, v3

    move-object/from16 v25, v7

    move-object/from16 v24, v10

    goto/16 :goto_b

    .line 176
    :catch_2
    move-exception v0

    move-object/from16 v22, v2

    move-object/from16 v21, v3

    move-object/from16 v25, v7

    move-object/from16 v24, v10

    goto/16 :goto_c

    .line 148
    .restart local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .restart local v4    # "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    .restart local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .restart local v13    # "partSize":I
    .restart local v14    # "i":I
    .restart local v15    # "partTotalNumber":I
    .restart local v18    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    :cond_7
    :goto_7
    :try_start_9
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " part.getPartNumber() : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getPartNumber()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 149
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " part.getSize() : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5
    :try_end_9
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_9 .. :try_end_9} :catch_10
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_9 .. :try_end_9} :catch_f

    move-object v6, v2

    move-object/from16 v21, v3

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .local v21, "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    :try_start_a
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v2

    invoke-virtual {v5, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 152
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getPartNumber()I

    move-result v2
    :try_end_a
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_a .. :try_end_a} :catch_e
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_a .. :try_end_a} :catch_d

    if-ne v2, v15, :cond_8

    move/from16 v2, v16

    goto :goto_8

    :cond_8
    const/4 v2, 0x0

    .line 154
    .local v2, "isTotal":Z
    :goto_8
    const-string v3, " or lastPartSize : "

    const-string v5, " setting is inconsistent with PartSize : "

    move-object/from16 v22, v6

    const-string v6, "current part size "

    if-eqz v2, :cond_a

    :try_start_b
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v23
    :try_end_b
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_b .. :try_end_b} :catch_8
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_b .. :try_end_b} :catch_7

    move-object/from16 v25, v7

    move/from16 v26, v8

    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .local v25, "recordPath":Ljava/lang/String;
    .local v26, "isTruncated":Z
    :try_start_c
    iget-wide v7, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mLastPartSize:J

    cmp-long v7, v23, v7

    if-nez v7, :cond_9

    move/from16 v23, v9

    goto/16 :goto_9

    .line 155
    :cond_9
    new-instance v7, Lcom/alibaba/sdk/android/oss/ClientException;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6
    :try_end_c
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_c .. :try_end_c} :catch_6
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_c .. :try_end_c} :catch_5

    move/from16 v23, v9

    .end local v9    # "nextPartNumberMarker":I
    .local v23, "nextPartNumberMarker":I
    :try_start_d
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v8

    invoke-virtual {v6, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-wide v5, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mLastPartSize:J

    invoke-virtual {v3, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v7, v3}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v11    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    throw v7
    :try_end_d
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_d .. :try_end_d} :catch_4
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_d .. :try_end_d} :catch_3

    .line 183
    .end local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .end local v2    # "isTotal":Z
    .end local v4    # "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    .end local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .end local v13    # "partSize":I
    .end local v14    # "i":I
    .end local v15    # "partTotalNumber":I
    .end local v18    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v11    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    :catch_3
    move-exception v0

    move-object/from16 v24, v10

    move/from16 v9, v23

    move/from16 v8, v26

    goto/16 :goto_b

    .line 176
    :catch_4
    move-exception v0

    move-object/from16 v24, v10

    move/from16 v9, v23

    move/from16 v8, v26

    goto/16 :goto_c

    .line 183
    .end local v23    # "nextPartNumberMarker":I
    .restart local v9    # "nextPartNumberMarker":I
    :catch_5
    move-exception v0

    move/from16 v23, v9

    move-object/from16 v24, v10

    move/from16 v8, v26

    .end local v9    # "nextPartNumberMarker":I
    .restart local v23    # "nextPartNumberMarker":I
    goto/16 :goto_b

    .line 176
    .end local v23    # "nextPartNumberMarker":I
    .restart local v9    # "nextPartNumberMarker":I
    :catch_6
    move-exception v0

    move/from16 v23, v9

    move-object/from16 v24, v10

    move/from16 v8, v26

    .end local v9    # "nextPartNumberMarker":I
    .restart local v23    # "nextPartNumberMarker":I
    goto/16 :goto_c

    .line 183
    .end local v23    # "nextPartNumberMarker":I
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    :catch_7
    move-exception v0

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_b

    .line 176
    .end local v23    # "nextPartNumberMarker":I
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    :catch_8
    move-exception v0

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_c

    .line 154
    .end local v23    # "nextPartNumberMarker":I
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .restart local v2    # "isTotal":Z
    .restart local v4    # "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .restart local v13    # "partSize":I
    .restart local v14    # "i":I
    .restart local v15    # "partTotalNumber":I
    .restart local v18    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    :cond_a
    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    .line 158
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    :goto_9
    if-nez v2, :cond_c

    :try_start_e
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v7
    :try_end_e
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_e .. :try_end_e} :catch_a
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_e .. :try_end_e} :catch_9

    move-object/from16 v24, v10

    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .local v24, "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    int-to-long v9, v13

    cmp-long v7, v7, v9

    if-nez v7, :cond_b

    goto :goto_a

    .line 159
    :cond_b
    :try_start_f
    new-instance v7, Lcom/alibaba/sdk/android/oss/ClientException;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v8

    invoke-virtual {v6, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-wide v5, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mLastPartSize:J

    invoke-virtual {v3, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v7, v3}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    .end local v11    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    throw v7

    .line 183
    .end local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .end local v2    # "isTotal":Z
    .end local v4    # "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    .end local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .end local v13    # "partSize":I
    .end local v14    # "i":I
    .end local v15    # "partTotalNumber":I
    .end local v18    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v11    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    :catch_9
    move-exception v0

    move-object/from16 v24, v10

    move/from16 v9, v23

    move/from16 v8, v26

    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    goto/16 :goto_b

    .line 176
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_a
    move-exception v0

    move-object/from16 v24, v10

    move/from16 v9, v23

    move/from16 v8, v26

    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    goto/16 :goto_c

    .line 158
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .restart local v2    # "isTotal":Z
    .restart local v4    # "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .restart local v13    # "partSize":I
    .restart local v14    # "i":I
    .restart local v15    # "partTotalNumber":I
    .restart local v18    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    :cond_c
    move-object/from16 v24, v10

    .line 172
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :goto_a
    iget-object v3, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 173
    iget-wide v5, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadedLength:J

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getSize()J

    move-result-wide v7

    add-long/2addr v5, v7

    iput-wide v5, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadedLength:J

    .line 174
    iget-object v3, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mAlreadyUploadIndex:Ljava/util/List;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/PartSummary;->getPartNumber()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_f
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_f .. :try_end_f} :catch_c
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_f .. :try_end_f} :catch_b

    .line 138
    nop

    .end local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .end local v2    # "isTotal":Z
    .end local v4    # "part":Lcom/alibaba/sdk/android/oss/model/PartSummary;
    add-int/lit8 v14, v14, 0x1

    move-object/from16 v0, v18

    move-object/from16 v5, v19

    move-object/from16 v6, v20

    move-object/from16 v3, v21

    move-object/from16 v2, v22

    move/from16 v9, v23

    move-object/from16 v10, v24

    move-object/from16 v7, v25

    move/from16 v8, v26

    const/4 v4, 0x0

    goto/16 :goto_6

    .line 183
    .end local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .end local v13    # "partSize":I
    .end local v14    # "i":I
    .end local v15    # "partTotalNumber":I
    .end local v18    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    :catch_b
    move-exception v0

    move/from16 v9, v23

    move/from16 v8, v26

    goto/16 :goto_b

    .line 176
    :catch_c
    move-exception v0

    move/from16 v9, v23

    move/from16 v8, v26

    goto/16 :goto_c

    .line 183
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_d
    move-exception v0

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_b

    .line 176
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_e
    move-exception v0

    move-object/from16 v22, v6

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_c

    .line 183
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_f
    move-exception v0

    move-object/from16 v21, v3

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_b

    .line 176
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_10
    move-exception v0

    move-object/from16 v22, v2

    move-object/from16 v21, v3

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_c

    .line 183
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_11
    move-exception v0

    move-object/from16 v21, v3

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_b

    .line 176
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_12
    move-exception v0

    move-object/from16 v22, v2

    move-object/from16 v21, v3

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_c

    .line 138
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .local v0, "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .restart local v13    # "partSize":I
    .restart local v14    # "i":I
    .restart local v15    # "partTotalNumber":I
    :cond_d
    move-object/from16 v18, v0

    move-object/from16 v22, v2

    move-object/from16 v21, v3

    move-object/from16 v19, v5

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .line 186
    .end local v0    # "result":Lcom/alibaba/sdk/android/oss/model/ListPartsResult;
    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v5    # "fileMd5":Ljava/lang/String;
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v12    # "parts":Ljava/util/List;, "Ljava/util/List<Lcom/alibaba/sdk/android/oss/model/PartSummary;>;"
    .end local v13    # "partSize":I
    .end local v14    # "i":I
    .end local v15    # "partTotalNumber":I
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto/16 :goto_d

    .line 183
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_13
    move-exception v0

    move-object/from16 v21, v3

    move-object/from16 v19, v5

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v5    # "fileMd5":Ljava/lang/String;
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto :goto_b

    .line 176
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_14
    move-exception v0

    move-object/from16 v22, v2

    move-object/from16 v21, v3

    move-object/from16 v19, v5

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move/from16 v26, v8

    move/from16 v23, v9

    move-object/from16 v24, v10

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v5    # "fileMd5":Ljava/lang/String;
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v23    # "nextPartNumberMarker":I
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto :goto_c

    .line 183
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v23    # "nextPartNumberMarker":I
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v9    # "nextPartNumberMarker":I
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_15
    move-exception v0

    move-object/from16 v21, v3

    move-object/from16 v19, v5

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move/from16 v26, v8

    move-object/from16 v24, v10

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v5    # "fileMd5":Ljava/lang/String;
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto :goto_b

    .line 176
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_16
    move-exception v0

    move-object/from16 v22, v2

    move-object/from16 v21, v3

    move-object/from16 v19, v5

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move/from16 v26, v8

    move-object/from16 v24, v10

    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v5    # "fileMd5":Ljava/lang/String;
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v8    # "isTruncated":Z
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    .restart local v26    # "isTruncated":Z
    goto :goto_c

    .line 183
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .end local v26    # "isTruncated":Z
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_17
    move-exception v0

    move-object/from16 v21, v3

    move-object/from16 v19, v5

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move-object/from16 v24, v10

    .line 184
    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v5    # "fileMd5":Ljava/lang/String;
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .local v0, "e":Lcom/alibaba/sdk/android/oss/ClientException;
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    :goto_b
    const/4 v2, 0x0

    .line 185
    .end local v8    # "isTruncated":Z
    .local v2, "isTruncated":Z
    throw v0

    .line 176
    .end local v0    # "e":Lcom/alibaba/sdk/android/oss/ClientException;
    .end local v2    # "isTruncated":Z
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    .restart local v8    # "isTruncated":Z
    .restart local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :catch_18
    move-exception v0

    move-object/from16 v22, v2

    move-object/from16 v21, v3

    move-object/from16 v19, v5

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    move-object/from16 v24, v10

    .line 177
    .end local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v5    # "fileMd5":Ljava/lang/String;
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .end local v10    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .local v0, "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .restart local v25    # "recordPath":Ljava/lang/String;
    :goto_c
    const/4 v2, 0x0

    .line 178
    .end local v8    # "isTruncated":Z
    .restart local v2    # "isTruncated":Z
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/ServiceException;->getStatusCode()I

    move-result v3

    const/16 v4, 0x194

    if-ne v3, v4, :cond_f

    .line 179
    const/4 v3, 0x0

    iput-object v3, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    .line 186
    .end local v0    # "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    move v8, v2

    .line 187
    .end local v2    # "isTruncated":Z
    .restart local v8    # "isTruncated":Z
    :goto_d
    invoke-virtual {v11}, Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;->waitUntilFinished()V

    .line 188
    .end local v11    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    if-nez v8, :cond_e

    move-object/from16 v3, v21

    goto :goto_e

    :cond_e
    move-object/from16 v5, v19

    move-object/from16 v6, v20

    move-object/from16 v3, v21

    move-object/from16 v2, v22

    move-object/from16 v7, v25

    const/4 v4, 0x0

    goto/16 :goto_5

    .line 181
    .end local v8    # "isTruncated":Z
    .restart local v0    # "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    .restart local v2    # "isTruncated":Z
    .restart local v11    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    .restart local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    :cond_f
    throw v0

    .line 99
    .end local v0    # "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    .end local v2    # "isTruncated":Z
    .end local v9    # "nextPartNumberMarker":I
    .end local v11    # "task":Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;, "Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask<Lcom/alibaba/sdk/android/oss/model/ListPartsResult;>;"
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v21    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v24    # "listParts":Lcom/alibaba/sdk/android/oss/model/ListPartsRequest;
    .end local v25    # "recordPath":Ljava/lang/String;
    .restart local v3    # "recordCrc64":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .restart local v5    # "fileMd5":Ljava/lang/String;
    .restart local v6    # "recordFileName":Ljava/lang/String;
    .restart local v7    # "recordPath":Ljava/lang/String;
    :cond_10
    move-object/from16 v19, v5

    move-object/from16 v20, v6

    move-object/from16 v25, v7

    .line 192
    .end local v5    # "fileMd5":Ljava/lang/String;
    .end local v6    # "recordFileName":Ljava/lang/String;
    .end local v7    # "recordPath":Ljava/lang/String;
    .restart local v19    # "fileMd5":Ljava/lang/String;
    .restart local v20    # "recordFileName":Ljava/lang/String;
    .restart local v25    # "recordPath":Ljava/lang/String;
    :goto_e
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_12

    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    move-result v0

    if-eqz v0, :cond_11

    goto :goto_f

    .line 193
    :cond_11
    new-instance v0, Lcom/alibaba/sdk/android/oss/ClientException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Can\'t create file at path: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\nPlease make sure the directory exist!"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 198
    .end local v19    # "fileMd5":Ljava/lang/String;
    .end local v20    # "recordFileName":Ljava/lang/String;
    .end local v25    # "recordPath":Ljava/lang/String;
    :cond_12
    :goto_f
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->isEmptyString(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_13

    .line 199
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;

    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v2, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    .line 200
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v2

    iget-object v4, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v4, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v4

    iget-object v5, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v5, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    invoke-virtual {v5}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->getMetadata()Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;

    move-result-object v5

    invoke-direct {v0, v2, v4, v5}, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;)V

    .line 202
    .local v0, "init":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    const/4 v4, 0x0

    invoke-virtual {v2, v0, v4}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->initMultipartUpload(Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;)Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/OSSAsyncTask;->getResult()Lcom/alibaba/sdk/android/oss/model/OSSResult;

    move-result-object v2

    check-cast v2, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;

    .line 204
    .local v2, "initResult":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;->getUploadId()Ljava/lang/String;

    move-result-object v4

    iput-object v4, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    .line 206
    iget-object v4, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    if-eqz v4, :cond_13

    .line 207
    new-instance v4, Ljava/io/BufferedWriter;

    new-instance v5, Ljava/io/FileWriter;

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRecordFile:Ljava/io/File;

    invoke-direct {v5, v6}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    invoke-direct {v4, v5}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .line 208
    .local v4, "bw":Ljava/io/BufferedWriter;
    iget-object v5, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 209
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->close()V

    .line 213
    .end local v0    # "init":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;
    .end local v2    # "initResult":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;
    .end local v4    # "bw":Ljava/io/BufferedWriter;
    :cond_13
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    check-cast v0, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;

    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest;->setUploadId(Ljava/lang/String;)V

    .line 214
    return-void
.end method

.method protected processException(Ljava/lang/Exception;)V
    .locals 4
    .param p1, "e"    # Ljava/lang/Exception;

    .line 348
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 349
    :try_start_0
    iget v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartExceptionCount:I

    const/4 v2, 0x1

    add-int/2addr v1, v2

    iput v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartExceptionCount:I

    .line 350
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadException:Ljava/lang/Exception;

    .line 351
    invoke-static {p1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    .line 352
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 353
    iget-boolean v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mIsCancel:Z

    if-nez v1, :cond_0

    .line 354
    iput-boolean v2, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mIsCancel:Z

    .line 355
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mLock:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->notify()V

    .line 358
    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->exceptionTerminationMode:Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;

    sget-object v2, Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;->EXCEPTION:Lcom/alibaba/sdk/android/oss/model/ResumableUploadRequest$ExceptionTerminationMode;

    if-eq v1, v2, :cond_1

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartETags:Ljava/util/List;

    .line 359
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    iget v2, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRunPartTaskCount:I

    iget v3, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mPartExceptionCount:I

    sub-int/2addr v2, v3

    if-ne v1, v2, :cond_2

    .line 360
    :cond_1
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->notifyMultipartThread()V

    .line 362
    :cond_2
    monitor-exit v0

    .line 363
    return-void

    .line 362
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method protected uploadPartFinish(Lcom/alibaba/sdk/android/oss/model/PartETag;)V
    .locals 9
    .param p1, "partETag"    # Lcom/alibaba/sdk/android/oss/model/PartETag;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 367
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 368
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 369
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mSp:Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadId:Ljava/lang/String;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadedLength:J

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/oss/common/utils/OSSSharedPreferences;->setStringValue(Ljava/lang/String;Ljava/lang/String;)V

    .line 370
    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    iget-wide v5, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mUploadedLength:J

    iget-wide v7, p0, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->mFileLength:J

    move-object v3, p0

    invoke-virtual/range {v3 .. v8}, Lcom/alibaba/sdk/android/oss/internal/ResumableUploadTask;->onProgressCallback(Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;JJ)V

    .line 373
    :cond_0
    return-void
.end method
