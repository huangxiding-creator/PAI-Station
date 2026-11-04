.class public abstract Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;
.super Ljava/lang/Object;
.source "BaseMultipartUploadTask.java"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<Request:",
        "Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;",
        "Result:",
        "Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;",
        ">",
        "Ljava/lang/Object;",
        "Ljava/util/concurrent/Callable<",
        "TResult;>;"
    }
.end annotation


# instance fields
.field protected final CPU_SIZE:I

.field protected final KEEP_ALIVE_TIME:I

.field protected final MAX_CORE_POOL_SIZE:I

.field protected final MAX_IMUM_POOL_SIZE:I

.field protected final MAX_QUEUE_SIZE:I

.field protected final PART_SIZE_ALIGN_NUM:I

.field protected mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

.field protected mCheckCRC64:Z

.field protected mCompletedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<",
            "TRequest;TResult;>;"
        }
    .end annotation
.end field

.field protected mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

.field protected mFileLength:J

.field protected mIsCancel:Z

.field protected mLastPartSize:J

.field protected mLock:Ljava/lang/Object;

.field protected mPartAttr:[I

.field protected mPartETags:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/oss/model/PartETag;",
            ">;"
        }
    .end annotation
.end field

.field protected mPartExceptionCount:I

.field protected mPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

.field protected mProgressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback<",
            "TRequest;>;"
        }
    .end annotation
.end field

.field protected mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TRequest;"
        }
    .end annotation
.end field

.field protected mRunPartTaskCount:I

.field protected mUploadException:Ljava/lang/Exception;

.field protected mUploadFile:Ljava/io/File;

.field protected mUploadFilePath:Ljava/lang/String;

.field protected mUploadId:Ljava/lang/String;

.field protected mUploadUri:Landroid/net/Uri;

.field protected mUploadedLength:J


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;Lcom/alibaba/sdk/android/oss/network/ExecutionContext;)V
    .locals 16
    .param p1, "operation"    # Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;
    .param p4, "context"    # Lcom/alibaba/sdk/android/oss/network/ExecutionContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;",
            "TRequest;",
            "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<",
            "TRequest;TResult;>;",
            "Lcom/alibaba/sdk/android/oss/network/ExecutionContext;",
            ")V"
        }
    .end annotation

    .line 80
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    .local p2, "request":Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;, "TRequest;"
    .local p3, "completedCallback":Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;, "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<TRequest;TResult;>;"
    move-object/from16 v0, p0

    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    .line 50
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v1

    const/4 v2, 0x2

    mul-int/2addr v1, v2

    iput v1, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->CPU_SIZE:I

    .line 51
    iget v1, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->CPU_SIZE:I

    const/4 v3, 0x5

    if-ge v1, v3, :cond_0

    iget v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->CPU_SIZE:I

    :cond_0
    iput v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->MAX_CORE_POOL_SIZE:I

    .line 52
    iget v1, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->CPU_SIZE:I

    iput v1, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->MAX_IMUM_POOL_SIZE:I

    .line 53
    const/16 v1, 0xbb8

    iput v1, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->KEEP_ALIVE_TIME:I

    .line 54
    const/16 v1, 0x1388

    iput v1, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->MAX_QUEUE_SIZE:I

    .line 55
    const/16 v3, 0x1000

    iput v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->PART_SIZE_ALIGN_NUM:I

    .line 57
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    iput-object v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartETags:Ljava/util/List;

    .line 58
    new-instance v3, Ljava/lang/Object;

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    iput-object v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mLock:Ljava/lang/Object;

    .line 68
    const-wide/16 v3, 0x0

    iput-wide v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadedLength:J

    .line 69
    const/4 v3, 0x0

    iput-boolean v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCheckCRC64:Z

    .line 73
    new-array v2, v2, [I

    iput-object v2, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartAttr:[I

    .line 81
    move-object/from16 v2, p1

    iput-object v2, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    .line 82
    move-object/from16 v4, p2

    iput-object v4, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    .line 83
    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getProgressCallback()Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    move-result-object v5

    iput-object v5, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mProgressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    .line 84
    move-object/from16 v5, p3

    iput-object v5, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCompletedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    .line 85
    move-object/from16 v6, p4

    iput-object v6, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    .line 86
    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getCRC64()Ljava/lang/Enum;

    move-result-object v7

    sget-object v8, Lcom/alibaba/sdk/android/oss/model/OSSRequest$CRC64Config;->YES:Lcom/alibaba/sdk/android/oss/model/OSSRequest$CRC64Config;

    if-ne v7, v8, :cond_1

    const/4 v3, 0x1

    :cond_1
    iput-boolean v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCheckCRC64:Z

    .line 88
    iget v3, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->MAX_CORE_POOL_SIZE:I

    .line 89
    .local v3, "maxCorePoolSize":I
    iget v7, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->MAX_IMUM_POOL_SIZE:I

    .line 90
    .local v7, "maximunPoolSize":I
    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getThreadNum()Ljava/lang/Integer;

    move-result-object v8

    if-eqz v8, :cond_2

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getThreadNum()Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-lez v8, :cond_2

    .line 91
    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getThreadNum()Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v3

    .line 92
    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getThreadNum()Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v7

    .line 94
    :cond_2
    new-instance v15, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v13, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v14, Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-direct {v14, v1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    new-instance v1, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$1;

    invoke-direct {v1, v0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$1;-><init>(Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;)V

    const-wide/16 v11, 0xbb8

    move-object v8, v15

    move v9, v3

    move v10, v7

    move-object v2, v15

    move-object v15, v1

    invoke-direct/range {v8 .. v15}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    iput-object v2, v0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 100
    return-void
.end method


# virtual methods
.method protected abstract abortThisUpload()V
.end method

.method public call()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 150
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->checkInitData()V

    .line 151
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->initMultipartUploadId()V

    .line 152
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->doMultipartUpload()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;

    move-result-object v1

    .line 154
    .local v1, "result":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;, "TResult;"
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCompletedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    if-eqz v2, :cond_0

    .line 155
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCompletedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-interface {v2, v3, v1}, Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;->onSuccess(Lcom/alibaba/sdk/android/oss/model/OSSRequest;Lcom/alibaba/sdk/android/oss/model/OSSResult;)V
    :try_end_0
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 157
    :cond_0
    return-object v1

    .line 163
    .end local v1    # "result":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;, "TResult;"
    :catch_0
    move-exception v1

    .line 165
    .local v1, "e":Ljava/lang/Exception;
    instance-of v2, v1, Lcom/alibaba/sdk/android/oss/ClientException;

    if-eqz v2, :cond_1

    .line 166
    move-object v2, v1

    check-cast v2, Lcom/alibaba/sdk/android/oss/ClientException;

    .local v2, "temp":Lcom/alibaba/sdk/android/oss/ClientException;
    goto :goto_0

    .line 168
    .end local v2    # "temp":Lcom/alibaba/sdk/android/oss/ClientException;
    :cond_1
    new-instance v2, Lcom/alibaba/sdk/android/oss/ClientException;

    invoke-virtual {v1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v1}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 170
    .restart local v2    # "temp":Lcom/alibaba/sdk/android/oss/ClientException;
    :goto_0
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCompletedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    if-eqz v3, :cond_2

    .line 171
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCompletedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-interface {v3, v4, v2, v0}, Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;->onFailure(Lcom/alibaba/sdk/android/oss/model/OSSRequest;Lcom/alibaba/sdk/android/oss/ClientException;Lcom/alibaba/sdk/android/oss/ServiceException;)V

    .line 173
    :cond_2
    throw v2

    .line 158
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v2    # "temp":Lcom/alibaba/sdk/android/oss/ClientException;
    :catch_1
    move-exception v1

    .line 159
    .local v1, "e":Lcom/alibaba/sdk/android/oss/ServiceException;
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCompletedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    if-eqz v2, :cond_3

    .line 160
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCompletedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-interface {v2, v3, v0, v1}, Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;->onFailure(Lcom/alibaba/sdk/android/oss/model/OSSRequest;Lcom/alibaba/sdk/android/oss/ClientException;Lcom/alibaba/sdk/android/oss/ServiceException;)V

    .line 162
    :cond_3
    throw v1
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 47
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->call()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;

    move-result-object v0

    return-object v0
.end method

.method protected ceilPartSize(J)J
    .locals 4
    .param p1, "partSize"    # J

    .line 426
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    const-wide/16 v0, 0xfff

    add-long/2addr v0, p1

    const-wide/16 v2, 0x1000

    div-long/2addr v0, v2

    mul-long/2addr v0, v2

    .line 427
    .end local p1    # "partSize":J
    .local v0, "partSize":J
    return-wide v0
.end method

.method protected checkCancel()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/alibaba/sdk/android/oss/ClientException;
        }
    .end annotation

    .line 133
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0

    if-nez v0, :cond_0

    .line 137
    return-void

    .line 134
    :cond_0
    new-instance v0, Lcom/alibaba/sdk/android/oss/TaskCancelException;

    const-string v1, "multipart cancel"

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/oss/TaskCancelException;-><init>(Ljava/lang/String;)V

    .line 135
    .local v0, "e":Lcom/alibaba/sdk/android/oss/TaskCancelException;
    new-instance v1, Lcom/alibaba/sdk/android/oss/ClientException;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/TaskCancelException;->getMessage()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-direct {v1, v2, v0, v3}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;Ljava/lang/Boolean;)V

    throw v1
.end method

.method protected checkException()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;,
            Lcom/alibaba/sdk/android/oss/ClientException;
        }
    .end annotation

    .line 361
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    if-eqz v0, :cond_3

    .line 362
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->releasePool()V

    .line 363
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    instance-of v0, v0, Ljava/io/IOException;

    if-nez v0, :cond_2

    .line 365
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    instance-of v0, v0, Lcom/alibaba/sdk/android/oss/ServiceException;

    if-nez v0, :cond_1

    .line 367
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    instance-of v0, v0, Lcom/alibaba/sdk/android/oss/ClientException;

    if-eqz v0, :cond_0

    .line 368
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    check-cast v0, Lcom/alibaba/sdk/android/oss/ClientException;

    throw v0

    .line 370
    :cond_0
    new-instance v0, Lcom/alibaba/sdk/android/oss/ClientException;

    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    .line 371
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    invoke-direct {v0, v1, v2}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 372
    .local v0, "clientException":Lcom/alibaba/sdk/android/oss/ClientException;
    throw v0

    .line 366
    .end local v0    # "clientException":Lcom/alibaba/sdk/android/oss/ClientException;
    :cond_1
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    check-cast v0, Lcom/alibaba/sdk/android/oss/ServiceException;

    throw v0

    .line 364
    :cond_2
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadException:Ljava/lang/Exception;

    check-cast v0, Ljava/io/IOException;

    throw v0

    .line 375
    :cond_3
    return-void
.end method

.method protected checkInitData()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/alibaba/sdk/android/oss/ClientException;
        }
    .end annotation

    .line 178
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getUploadFilePath()Ljava/lang/String;

    move-result-object v0

    const-wide/16 v1, 0x0

    const/4 v3, 0x1

    if-eqz v0, :cond_0

    .line 179
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getUploadFilePath()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadFilePath:Ljava/lang/String;

    .line 180
    iput-wide v1, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadedLength:J

    .line 181
    new-instance v0, Ljava/io/File;

    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadFilePath:Ljava/lang/String;

    invoke-direct {v0, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadFile:Ljava/io/File;

    .line 182
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    goto :goto_4

    .line 184
    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getUploadUri()Landroid/net/Uri;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 185
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getUploadUri()Landroid/net/Uri;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadUri:Landroid/net/Uri;

    .line 186
    const/4 v0, 0x0

    .line 188
    .local v0, "mUploadFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :try_start_0
    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadUri:Landroid/net/Uri;

    const-string v6, "r"

    invoke-virtual {v4, v5, v6}, Landroid/content/ContentResolver;->openFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;

    move-result-object v4

    move-object v0, v4

    .line 189
    invoke-virtual {v0}, Landroid/os/ParcelFileDescriptor;->getStatSize()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 194
    if-eqz v0, :cond_1

    .line 195
    :try_start_1
    invoke-virtual {v0}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 197
    :catch_0
    move-exception v4

    .line 198
    .local v4, "e":Ljava/io/IOException;
    invoke-static {v4}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    .line 200
    .end local v4    # "e":Ljava/io/IOException;
    goto :goto_4

    .line 199
    :cond_1
    :goto_0
    goto :goto_4

    .line 193
    :catchall_0
    move-exception v1

    goto :goto_1

    .line 190
    :catch_1
    move-exception v1

    .line 191
    .local v1, "e":Ljava/io/IOException;
    :try_start_2
    new-instance v2, Lcom/alibaba/sdk/android/oss/ClientException;

    invoke-virtual {v1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-direct {v2, v4, v1, v3}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;Ljava/lang/Boolean;)V

    .end local v0    # "mUploadFileDescriptor":Landroid/os/ParcelFileDescriptor;
    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 194
    .end local v1    # "e":Ljava/io/IOException;
    .restart local v0    # "mUploadFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :goto_1
    if-eqz v0, :cond_2

    .line 195
    :try_start_3
    invoke-virtual {v0}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_2

    .line 197
    :catch_2
    move-exception v2

    .line 198
    .local v2, "e":Ljava/io/IOException;
    invoke-static {v2}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    goto :goto_3

    .line 199
    .end local v2    # "e":Ljava/io/IOException;
    :cond_2
    :goto_2
    nop

    .line 200
    :goto_3
    throw v1

    .line 202
    .end local v0    # "mUploadFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :cond_3
    :goto_4
    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    cmp-long v0, v4, v1

    if-eqz v0, :cond_6

    .line 206
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartAttr:[I

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->checkPartSize([I)V

    .line 208
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getPartSize()J

    move-result-wide v0

    .line 209
    .local v0, "partSize":J
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartAttr:[I

    aget v2, v2, v3

    .line 211
    .local v2, "partNumber":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[checkInitData] - partNumber : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 212
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[checkInitData] - partSize : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 215
    if-le v2, v3, :cond_5

    const-wide/32 v3, 0x19000

    cmp-long v3, v0, v3

    if-ltz v3, :cond_4

    goto :goto_5

    .line 216
    :cond_4
    new-instance v3, Lcom/alibaba/sdk/android/oss/ClientException;

    const-string v4, "Part size must be greater than or equal to 100KB!"

    invoke-direct {v3, v4}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 218
    :cond_5
    :goto_5
    return-void

    .line 203
    .end local v0    # "partSize":J
    .end local v2    # "partNumber":I
    :cond_6
    new-instance v0, Lcom/alibaba/sdk/android/oss/ClientException;

    const-string v1, "file length must not be 0"

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected checkPartSize([I)V
    .locals 14
    .param p1, "partAttr"    # [I

    .line 398
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getPartSize()J

    move-result-wide v0

    .line 399
    .local v0, "partSize":J
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[checkPartSize] - mFileLength : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 400
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[checkPartSize] - partSize : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 401
    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    div-long/2addr v4, v0

    .line 402
    .local v4, "partNumber":J
    iget-wide v6, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    rem-long/2addr v6, v0

    const-wide/16 v8, 0x0

    cmp-long v2, v6, v8

    const-wide/16 v6, 0x1

    if-eqz v2, :cond_0

    .line 403
    add-long/2addr v4, v6

    .line 405
    :cond_0
    const/16 v2, 0x1388

    .line 406
    .local v2, "MAX_PART_NUM":I
    cmp-long v10, v4, v6

    if-nez v10, :cond_1

    .line 407
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    goto :goto_1

    .line 408
    :cond_1
    int-to-long v10, v2

    cmp-long v10, v4, v10

    if-lez v10, :cond_3

    .line 409
    iget-wide v10, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    add-int/lit8 v12, v2, -0x1

    int-to-long v12, v12

    div-long/2addr v10, v12

    .line 410
    .end local v0    # "partSize":J
    .local v10, "partSize":J
    invoke-virtual {p0, v10, v11}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->ceilPartSize(J)J

    move-result-wide v0

    .line 411
    .end local v10    # "partSize":J
    .restart local v0    # "partSize":J
    iget-wide v10, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    div-long/2addr v10, v0

    .line 412
    .end local v4    # "partNumber":J
    .local v10, "partNumber":J
    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    rem-long/2addr v4, v0

    cmp-long v4, v4, v8

    if-eqz v4, :cond_2

    goto :goto_0

    :cond_2
    move-wide v6, v8

    :goto_0
    add-long v4, v10, v6

    .line 414
    .end local v10    # "partNumber":J
    .restart local v4    # "partNumber":J
    :cond_3
    :goto_1
    const/4 v6, 0x0

    long-to-int v7, v0

    aput v7, p1, v6

    .line 415
    long-to-int v6, v4

    const/4 v7, 0x1

    aput v6, p1, v7

    .line 416
    iget-object v6, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    long-to-int v7, v0

    int-to-long v10, v7

    invoke-virtual {v6, v10, v11}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->setPartSize(J)V

    .line 418
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[checkPartSize] - partNumber : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 419
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    long-to-int v6, v0

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 421
    iget-wide v6, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J

    rem-long/2addr v6, v0

    .line 422
    .local v6, "lastPartSize":J
    cmp-long v3, v6, v8

    if-nez v3, :cond_4

    move-wide v8, v0

    goto :goto_2

    :cond_4
    move-wide v8, v6

    :goto_2
    iput-wide v8, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mLastPartSize:J

    .line 423
    return-void
.end method

.method protected checkWaitCondition(I)Z
    .locals 1
    .param p1, "partNum"    # I

    .line 378
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ne v0, p1, :cond_0

    .line 379
    const/4 v0, 0x0

    return v0

    .line 381
    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method protected completeMultipartUploadResult()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/alibaba/sdk/android/oss/ClientException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;
        }
    .end annotation

    .line 313
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    const/4 v0, 0x0

    .line 314
    .local v0, "completeResult":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_5

    .line 315
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartETags:Ljava/util/List;

    new-instance v2, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;

    invoke-direct {v2, p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;-><init>(Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;)V

    invoke-static {v1, v2}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 328
    new-instance v1, Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;

    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    .line 329
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadId:Ljava/lang/String;

    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartETags:Ljava/util/List;

    invoke-direct {v1, v2, v3, v4, v5}, Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)V

    .line 330
    .local v1, "complete":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getCallbackParam()Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 331
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getCallbackParam()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;->setCallbackParam(Ljava/util/Map;)V

    .line 333
    :cond_0
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getCallbackVars()Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 334
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getCallbackVars()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;->setCallbackVars(Ljava/util/Map;)V

    .line 336
    :cond_1
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getMetadata()Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;

    move-result-object v2

    if-eqz v2, :cond_4

    .line 337
    new-instance v2, Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;

    invoke-direct {v2}, Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;-><init>()V

    .line 338
    .local v2, "metadata":Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;
    iget-object v3, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getMetadata()Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;

    move-result-object v3

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;->getRawMetadata()Ljava/util/Map;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 339
    .local v4, "key":Ljava/lang/String;
    const-string/jumbo v5, "x-oss-storage-class"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 340
    iget-object v5, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v5}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getMetadata()Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;

    move-result-object v5

    invoke-virtual {v5}, Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;->getRawMetadata()Ljava/util/Map;

    move-result-object v5

    invoke-interface {v5, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v2, v4, v5}, Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;->setHeader(Ljava/lang/String;Ljava/lang/Object;)V

    .line 342
    .end local v4    # "key":Ljava/lang/String;
    :cond_2
    goto :goto_0

    .line 343
    :cond_3
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;->setMetadata(Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;)V

    .line 346
    .end local v2    # "metadata":Lcom/alibaba/sdk/android/oss/model/ObjectMetadata;
    :cond_4
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getCRC64()Ljava/lang/Enum;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;->setCRC64(Ljava/lang/Enum;)V

    .line 347
    iget-object v2, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    invoke-virtual {v2, v1}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->syncCompleteMultipartUpload(Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;)Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;

    move-result-object v0

    .line 349
    .end local v1    # "complete":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;
    :cond_5
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadedLength:J

    .line 350
    return-object v0
.end method

.method protected abstract doMultipartUpload()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;,
            Lcom/alibaba/sdk/android/oss/ClientException;,
            Ljava/lang/InterruptedException;
        }
    .end annotation
.end method

.method protected abstract initMultipartUploadId()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/alibaba/sdk/android/oss/ClientException;,
            Lcom/alibaba/sdk/android/oss/ServiceException;
        }
    .end annotation
.end method

.method protected notifyMultipartThread()V
    .locals 1

    .line 388
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mLock:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->notify()V

    .line 389
    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartExceptionCount:I

    .line 390
    return-void
.end method

.method protected onProgressCallback(Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;JJ)V
    .locals 7
    .param p2, "currentSize"    # J
    .param p4, "totalSize"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TRequest;JJ)V"
        }
    .end annotation

    .line 438
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    .local p1, "request":Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;, "TRequest;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mProgressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    if-eqz v0, :cond_0

    .line 439
    iget-object v1, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mProgressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    move-object v2, p1

    move-wide v3, p2

    move-wide v5, p4

    invoke-interface/range {v1 .. v6}, Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;->onProgress(Ljava/lang/Object;JJ)V

    .line 441
    :cond_0
    return-void
.end method

.method protected preUploadPart(III)V
    .locals 0
    .param p1, "readIndex"    # I
    .param p2, "byteCount"    # I
    .param p3, "partNumber"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 142
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    return-void
.end method

.method protected abstract processException(Ljava/lang/Exception;)V
.end method

.method protected releasePool()V
    .locals 1

    .line 354
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    if-eqz v0, :cond_0

    .line 355
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/BlockingQueue;->clear()V

    .line 356
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->shutdown()V

    .line 358
    :cond_0
    return-void
.end method

.method protected uploadPart(III)V
    .locals 19
    .param p1, "readIndex"    # I
    .param p2, "byteCount"    # I
    .param p3, "partNumber"    # I

    .line 222
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    move-object/from16 v7, p0

    move/from16 v8, p1

    move/from16 v9, p2

    const/4 v1, 0x0

    .line 223
    .local v1, "raf":Ljava/io/RandomAccessFile;
    const/4 v2, 0x0

    .line 224
    .local v2, "inputStream":Ljava/io/InputStream;
    const/4 v3, 0x0

    .line 227
    .local v3, "bufferedInputStream":Ljava/io/BufferedInputStream;
    :try_start_0
    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 228
    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/BlockingQueue;->clear()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_6

    .line 290
    if-eqz v1, :cond_0

    .line 291
    :try_start_1
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_0

    .line 296
    :catch_0
    move-exception v0

    goto :goto_1

    .line 292
    :cond_0
    :goto_0
    if-eqz v3, :cond_1

    .line 293
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V

    .line 294
    :cond_1
    if-eqz v2, :cond_2

    .line 295
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 297
    .local v0, "e":Ljava/io/IOException;
    :goto_1
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    goto :goto_3

    .line 298
    .end local v0    # "e":Ljava/io/IOException;
    :cond_2
    :goto_2
    nop

    .line 229
    :goto_3
    return-void

    .line 232
    :cond_3
    :try_start_2
    iget-object v4, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mLock:Ljava/lang/Object;

    monitor-enter v4
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_6

    .line 233
    :try_start_3
    iget v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRunPartTaskCount:I

    const/4 v5, 0x1

    add-int/2addr v0, v5

    iput v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRunPartTaskCount:I

    .line 234
    monitor-exit v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_5

    .line 236
    :try_start_4
    invoke-virtual/range {p0 .. p3}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->preUploadPart(III)V

    .line 238
    new-array v0, v9, [B

    move-object v10, v0

    .line 239
    .local v10, "partContent":[B
    int-to-long v11, v8

    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getPartSize()J

    move-result-wide v13

    mul-long/2addr v11, v13

    .line 240
    .local v11, "skip":J
    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadUri:Landroid/net/Uri;

    const/4 v4, 0x0

    if-eqz v0, :cond_4

    .line 241
    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget-object v6, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadUri:Landroid/net/Uri;

    invoke-virtual {v0, v6}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v0

    move-object v2, v0

    .line 242
    new-instance v0, Ljava/io/BufferedInputStream;

    invoke-direct {v0, v2}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v3, v0

    .line 243
    invoke-virtual {v3, v11, v12}, Ljava/io/BufferedInputStream;->skip(J)J

    .line 244
    invoke-virtual {v3, v10, v4, v9}, Ljava/io/BufferedInputStream;->read([BII)I

    move-object v13, v1

    move-object v14, v2

    move-object v15, v3

    goto :goto_4

    .line 246
    :cond_4
    new-instance v0, Ljava/io/RandomAccessFile;

    iget-object v6, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadFile:Ljava/io/File;

    const-string v13, "r"

    invoke-direct {v0, v6, v13}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v1, v0

    .line 248
    invoke-virtual {v1, v11, v12}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 249
    invoke-virtual {v1, v10, v4, v9}, Ljava/io/RandomAccessFile;->readFully([BII)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3
    .catchall {:try_start_4 .. :try_end_4} :catchall_6

    move-object v13, v1

    move-object v14, v2

    move-object v15, v3

    .line 252
    .end local v1    # "raf":Ljava/io/RandomAccessFile;
    .end local v2    # "inputStream":Ljava/io/InputStream;
    .end local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .local v13, "raf":Ljava/io/RandomAccessFile;
    .local v14, "inputStream":Ljava/io/InputStream;
    .local v15, "bufferedInputStream":Ljava/io/BufferedInputStream;
    :goto_4
    :try_start_5
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;

    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    .line 253
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getObjectKey()Ljava/lang/String;

    move-result-object v2

    iget-object v3, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadId:Ljava/lang/String;

    add-int/lit8 v4, v8, 0x1

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    move-object v6, v0

    .line 254
    .local v6, "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    invoke-virtual {v6, v10}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setPartContent([B)V

    .line 255
    invoke-static {v10}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->calculateBase64Md5([B)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setMd5Digest(Ljava/lang/String;)V

    .line 256
    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;->getCRC64()Ljava/lang/Enum;

    move-result-object v0

    invoke-virtual {v6, v0}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setCRC64(Ljava/lang/Enum;)V

    .line 257
    iget-object v0, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mApiOperation:Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;

    invoke-virtual {v0, v6}, Lcom/alibaba/sdk/android/oss/internal/InternalRequestOperation;->syncUploadPart(Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;)Lcom/alibaba/sdk/android/oss/model/UploadPartResult;

    move-result-object v0

    move-object/from16 v16, v0

    .line 259
    .local v16, "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    iget-object v3, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mLock:Ljava/lang/Object;

    monitor-enter v3
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    .line 260
    :try_start_6
    new-instance v0, Lcom/alibaba/sdk/android/oss/model/PartETag;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->getPartNumber()I

    move-result v1

    invoke-virtual/range {v16 .. v16}, Lcom/alibaba/sdk/android/oss/model/UploadPartResult;->getETag()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/alibaba/sdk/android/oss/model/PartETag;-><init>(ILjava/lang/String;)V

    .line 261
    .local v0, "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    int-to-long v1, v9

    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setPartSize(J)V

    .line 262
    iget-boolean v1, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mCheckCRC64:Z
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    if-eqz v1, :cond_5

    .line 263
    :try_start_7
    invoke-virtual/range {v16 .. v16}, Lcom/alibaba/sdk/android/oss/model/UploadPartResult;->getClientCRC()Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/oss/model/PartETag;->setCRC64(J)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_5

    .line 284
    .end local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    :catchall_0
    move-exception v0

    move-object/from16 v17, v3

    move-object/from16 v18, v6

    goto/16 :goto_a

    .line 266
    .restart local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    :cond_5
    :goto_5
    :try_start_8
    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 267
    iget-wide v1, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadedLength:J
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    move-object/from16 v18, v6

    .end local v6    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .local v18, "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    int-to-long v5, v9

    add-long/2addr v1, v5

    :try_start_9
    iput-wide v1, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadedLength:J

    .line 269
    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->uploadPartFinish(Lcom/alibaba/sdk/android/oss/model/PartETag;)V

    .line 271
    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mContext:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 272
    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    iget v2, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRunPartTaskCount:I

    iget v4, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartExceptionCount:I

    sub-int/2addr v2, v4

    if-eq v1, v2, :cond_6

    move-object/from16 v17, v3

    goto :goto_6

    .line 273
    :cond_6
    new-instance v1, Lcom/alibaba/sdk/android/oss/TaskCancelException;

    const-string v2, "multipart cancel"

    invoke-direct {v1, v2}, Lcom/alibaba/sdk/android/oss/TaskCancelException;-><init>(Ljava/lang/String;)V

    .line 275
    .local v1, "e":Lcom/alibaba/sdk/android/oss/TaskCancelException;
    new-instance v2, Lcom/alibaba/sdk/android/oss/ClientException;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/oss/TaskCancelException;->getMessage()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x1

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    invoke-direct {v2, v4, v1, v5}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;Ljava/lang/Boolean;)V

    .end local v10    # "partContent":[B
    .end local v11    # "skip":J
    .end local v13    # "raf":Ljava/io/RandomAccessFile;
    .end local v14    # "inputStream":Ljava/io/InputStream;
    .end local v15    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .end local v16    # "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    .end local v18    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .end local p1    # "readIndex":I
    .end local p2    # "byteCount":I
    .end local p3    # "partNumber":I
    throw v2

    .line 278
    .end local v1    # "e":Lcom/alibaba/sdk/android/oss/TaskCancelException;
    .restart local v10    # "partContent":[B
    .restart local v11    # "skip":J
    .restart local v13    # "raf":Ljava/io/RandomAccessFile;
    .restart local v14    # "inputStream":Ljava/io/InputStream;
    .restart local v15    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .restart local v16    # "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    .restart local v18    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .restart local p1    # "readIndex":I
    .restart local p2    # "byteCount":I
    .restart local p3    # "partNumber":I
    :cond_7
    iget-object v1, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartETags:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    iget v2, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mPartExceptionCount:I

    sub-int v2, p3, v2

    if-ne v1, v2, :cond_8

    .line 279
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->notifyMultipartThread()V

    .line 281
    :cond_8
    iget-object v2, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mRequest:Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;

    iget-wide v4, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mUploadedLength:J

    iget-wide v8, v7, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->mFileLength:J
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    move-object/from16 v1, p0

    move-object/from16 v17, v3

    move-wide v3, v4

    move-wide v5, v8

    :try_start_a
    invoke-virtual/range {v1 .. v6}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->onProgressCallback(Lcom/alibaba/sdk/android/oss/model/MultipartUploadRequest;JJ)V

    .line 284
    .end local v0    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    :goto_6
    monitor-exit v17
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    .line 290
    .end local v10    # "partContent":[B
    .end local v11    # "skip":J
    .end local v16    # "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    .end local v18    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    if-eqz v13, :cond_9

    .line 291
    :try_start_b
    invoke-virtual {v13}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_7

    .line 296
    :catch_1
    move-exception v0

    goto :goto_8

    .line 292
    :cond_9
    :goto_7
    if-eqz v15, :cond_a

    .line 293
    invoke-virtual {v15}, Ljava/io/BufferedInputStream;->close()V

    .line 294
    :cond_a
    if-eqz v14, :cond_b

    .line 295
    invoke-virtual {v14}, Ljava/io/InputStream;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_1

    goto :goto_9

    .line 297
    .local v0, "e":Ljava/io/IOException;
    :goto_8
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    .line 299
    .end local v0    # "e":Ljava/io/IOException;
    goto :goto_10

    .line 298
    :cond_b
    :goto_9
    goto :goto_10

    .line 284
    .restart local v10    # "partContent":[B
    .restart local v11    # "skip":J
    .restart local v16    # "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    .restart local v18    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :catchall_1
    move-exception v0

    move-object/from16 v17, v3

    goto :goto_a

    .end local v18    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .restart local v6    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :catchall_2
    move-exception v0

    move-object/from16 v17, v3

    move-object/from16 v18, v6

    .end local v6    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .restart local v18    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :goto_a
    :try_start_c
    monitor-exit v17
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    .end local v13    # "raf":Ljava/io/RandomAccessFile;
    .end local v14    # "inputStream":Ljava/io/InputStream;
    .end local v15    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .end local p1    # "readIndex":I
    .end local p2    # "byteCount":I
    .end local p3    # "partNumber":I
    :try_start_d
    throw v0
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_2
    .catchall {:try_start_d .. :try_end_d} :catchall_4

    .restart local v13    # "raf":Ljava/io/RandomAccessFile;
    .restart local v14    # "inputStream":Ljava/io/InputStream;
    .restart local v15    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .restart local p1    # "readIndex":I
    .restart local p2    # "byteCount":I
    .restart local p3    # "partNumber":I
    :catchall_3
    move-exception v0

    goto :goto_a

    .line 289
    .end local v10    # "partContent":[B
    .end local v11    # "skip":J
    .end local v16    # "uploadPartResult":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    .end local v18    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    :catchall_4
    move-exception v0

    move-object v4, v0

    move-object v1, v13

    move-object v2, v14

    move-object v3, v15

    goto :goto_11

    .line 286
    :catch_2
    move-exception v0

    move-object v1, v13

    move-object v2, v14

    move-object v3, v15

    goto :goto_b

    .line 234
    .end local v13    # "raf":Ljava/io/RandomAccessFile;
    .end local v14    # "inputStream":Ljava/io/InputStream;
    .end local v15    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .local v1, "raf":Ljava/io/RandomAccessFile;
    .restart local v2    # "inputStream":Ljava/io/InputStream;
    .restart local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    :catchall_5
    move-exception v0

    :try_start_e
    monitor-exit v4
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_5

    .end local v1    # "raf":Ljava/io/RandomAccessFile;
    .end local v2    # "inputStream":Ljava/io/InputStream;
    .end local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .end local p1    # "readIndex":I
    .end local p2    # "byteCount":I
    .end local p3    # "partNumber":I
    :try_start_f
    throw v0
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_3
    .catchall {:try_start_f .. :try_end_f} :catchall_6

    .line 289
    .restart local v1    # "raf":Ljava/io/RandomAccessFile;
    .restart local v2    # "inputStream":Ljava/io/InputStream;
    .restart local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .restart local p1    # "readIndex":I
    .restart local p2    # "byteCount":I
    .restart local p3    # "partNumber":I
    :catchall_6
    move-exception v0

    move-object v4, v0

    goto :goto_11

    .line 286
    :catch_3
    move-exception v0

    .line 287
    .local v0, "e":Ljava/lang/Exception;
    :goto_b
    :try_start_10
    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->processException(Ljava/lang/Exception;)V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_6

    .line 290
    .end local v0    # "e":Ljava/lang/Exception;
    if-eqz v1, :cond_c

    .line 291
    :try_start_11
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_c

    .line 296
    :catch_4
    move-exception v0

    goto :goto_d

    .line 292
    :cond_c
    :goto_c
    if-eqz v3, :cond_d

    .line 293
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V

    .line 294
    :cond_d
    if-eqz v2, :cond_e

    .line 295
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_11
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_4

    goto :goto_e

    .line 297
    .local v0, "e":Ljava/io/IOException;
    :goto_d
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    .line 299
    .end local v0    # "e":Ljava/io/IOException;
    goto :goto_f

    .line 298
    :cond_e
    :goto_e
    nop

    .line 300
    :goto_f
    move-object v13, v1

    move-object v14, v2

    move-object v15, v3

    .end local v1    # "raf":Ljava/io/RandomAccessFile;
    .end local v2    # "inputStream":Ljava/io/InputStream;
    .end local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .restart local v13    # "raf":Ljava/io/RandomAccessFile;
    .restart local v14    # "inputStream":Ljava/io/InputStream;
    .restart local v15    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    :goto_10
    return-void

    .line 290
    .end local v13    # "raf":Ljava/io/RandomAccessFile;
    .end local v14    # "inputStream":Ljava/io/InputStream;
    .end local v15    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    .restart local v1    # "raf":Ljava/io/RandomAccessFile;
    .restart local v2    # "inputStream":Ljava/io/InputStream;
    .restart local v3    # "bufferedInputStream":Ljava/io/BufferedInputStream;
    :goto_11
    if-eqz v1, :cond_f

    .line 291
    :try_start_12
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_12

    .line 296
    :catch_5
    move-exception v0

    goto :goto_13

    .line 292
    :cond_f
    :goto_12
    if-eqz v3, :cond_10

    .line 293
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V

    .line 294
    :cond_10
    if-eqz v2, :cond_11

    .line 295
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_12} :catch_5

    goto :goto_14

    .line 297
    .restart local v0    # "e":Ljava/io/IOException;
    :goto_13
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logThrowable2Local(Ljava/lang/Throwable;)V

    goto :goto_15

    .line 298
    .end local v0    # "e":Ljava/io/IOException;
    :cond_11
    :goto_14
    nop

    .line 299
    :goto_15
    throw v4
.end method

.method protected uploadPartFinish(Lcom/alibaba/sdk/android/oss/model/PartETag;)V
    .locals 0
    .param p1, "partETag"    # Lcom/alibaba/sdk/android/oss/model/PartETag;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 145
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask<TRequest;TResult;>;"
    return-void
.end method
